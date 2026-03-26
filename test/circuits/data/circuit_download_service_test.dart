import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;
import 'package:polygonid_flutter_sdk/circuits/data/circuit_download_service.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import '../../common/zip_test_helper.dart';
import 'circuit_download_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late Directory tempDir;
  late CircuitDownloadService service;

  setUp(() {
    mockDio = MockDio();
    tempDir = Directory.systemTemp.createTempSync('circuit_dl_test_');
    service = CircuitDownloadService(tempDir, ZipDecoder(), mockDio);
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  // ---------------------------------------------------------------------------
  // Helper
  // ---------------------------------------------------------------------------

  /// Stubs [mockDio] to write a zip containing [entries] to the savePath arg.
  void stubDownload(Map<String, List<int>> entries, {Exception? throws}) {
    if (throws != null) {
      when(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')))
          .thenThrow(throws);
      return;
    }
    final zipBytes = makeZipBytes(entries);
    when(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')))
        .thenAnswer((inv) async {
      final zipPath = inv.positionalArguments[1] as String;
      await File(zipPath).writeAsBytes(zipBytes);
      return Response(requestOptions: RequestOptions(path: ''));
    });
  }

  // ---------------------------------------------------------------------------
  // downloadAndExtractZip — happy paths
  // ---------------------------------------------------------------------------

  group('downloadAndExtractZip — happy paths', () {
    const circuitId = 'myCircuit';

    test('downloads, extracts, and creates circuit directory with expected files', () async {
      stubDownload({
        '$circuitId.wcd': [1, 2, 3],
        '$circuitId.zkey': [4, 5, 6],
      });

      await service.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(File(p.join(tempDir.path, circuitId, '$circuitId.wcd')).existsSync(), isTrue);
      expect(File(p.join(tempDir.path, circuitId, '$circuitId.zkey')).existsSync(), isTrue);
    });

    test('skips download when forceDownload=false and circuit files already present', () async {
      final circuitDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      File(p.join(circuitDir.path, '$circuitId.wcd')).writeAsBytesSync([]);

      await service.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      verifyNever(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')));
    });

    test('re-downloads when forceDownload=true even if circuit files already present', () async {
      final circuitDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      File(p.join(circuitDir.path, '$circuitId.wcd')).writeAsBytesSync([]);

      stubDownload({'$circuitId.wcd': [1]});
      await service.downloadAndExtractZip(
        circuitId,
        'http://example.com/c.zip',
        forceDownload: true,
      );

      verify(mockDio.download(any, any, cancelToken: anyNamed('cancelToken'))).called(1);
    });

    test('zip file is deleted after successful extraction', () async {
      stubDownload({'$circuitId.wcd': [1]});
      await service.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(File(p.join(tempDir.path, '$circuitId.zip')).existsSync(), isFalse);
    });

    test('temp directory is renamed to final circuit directory (no leftover _tmp_ dir)', () async {
      stubDownload({'$circuitId.wcd': [1]});
      await service.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(Directory(p.join(tempDir.path, circuitId)).existsSync(), isTrue);
      final tempEntries = tempDir
          .listSync()
          .whereType<Directory>()
          .where((d) => p.basename(d.path).contains('_tmp_'));
      expect(tempEntries, isEmpty);
    });

    test('deletes an incomplete circuit directory before re-downloading', () async {
      Directory(p.join(tempDir.path, circuitId)).createSync();

      stubDownload({'$circuitId.wcd': [1]});
      await service.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(File(p.join(tempDir.path, circuitId, '$circuitId.wcd')).existsSync(), isTrue);
    });

    test('forwards cancelToken to Dio.download', () async {
      CancelToken? capturedToken;
      final token = CancelToken();
      when(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')))
          .thenAnswer((inv) async {
        capturedToken = inv.namedArguments[#cancelToken] as CancelToken?;
        final zipPath = inv.positionalArguments[1] as String;
        await File(zipPath).writeAsBytes(makeZipBytes({'$circuitId.wcd': [1]}));
        return Response(requestOptions: RequestOptions(path: ''));
      });

      await service.downloadAndExtractZip(
        circuitId,
        'http://example.com/c.zip',
        cancelToken: token,
      );

      expect(capturedToken, same(token));
    });
  });

  // ---------------------------------------------------------------------------
  // downloadAndExtractZip — error and cleanup
  // ---------------------------------------------------------------------------

  group('downloadAndExtractZip — error and cleanup', () {
    const circuitId = 'myCircuit';

    test('rethrows Dio exception and cleans up zip file', () async {
      stubDownload({}, throws: DioException(requestOptions: RequestOptions(path: '')));

      await expectLater(
        service.downloadAndExtractZip(circuitId, 'http://x'),
        throwsA(isA<DioException>()),
      );

      expect(File(p.join(tempDir.path, '$circuitId.zip')).existsSync(), isFalse);
      expect(Directory(p.join(tempDir.path, circuitId)).existsSync(), isFalse);
    });

    test('rethrows exception and cleans up temp directory on Dio failure', () async {
      stubDownload({}, throws: DioException(requestOptions: RequestOptions(path: '')));

      await expectLater(
        service.downloadAndExtractZip(circuitId, 'http://x'),
        throwsA(isA<DioException>()),
      );

      final leftoverTmp = tempDir
          .listSync()
          .whereType<Directory>()
          .where((d) => p.basename(d.path).contains('_tmp_'));
      expect(leftoverTmp, isEmpty);
    });

    test('throws CircuitNotDownloadedException when zip contains no expected circuit files', () async {
      stubDownload({'readme.txt': [1, 2, 3]});

      await expectLater(
        service.downloadAndExtractZip(circuitId, 'http://x'),
        throwsA(isA<CircuitNotDownloadedException>()),
      );

      expect(Directory(p.join(tempDir.path, circuitId)).existsSync(), isFalse);
      final leftoverTmp = tempDir
          .listSync()
          .whereType<Directory>()
          .where((d) => p.basename(d.path).contains('_tmp_'));
      expect(leftoverTmp, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // extractZipToDirectory
  // ---------------------------------------------------------------------------

  group('extractZipToDirectory', () {
    test('extracts all file entries using only the basename', () async {
      final zipBytes = makeZipBytes({
        'subfolder/circuit.wcd': [1, 2],
        'circuit.zkey': [3, 4],
      });
      final zipFile = File(p.join(tempDir.path, 'test.zip'))
        ..writeAsBytesSync(zipBytes);
      final outDir = Directory(p.join(tempDir.path, 'out'))..createSync();

      await service.extractZipToDirectory(
        zipFilePath: zipFile.path,
        outputDirectory: outDir.path,
      );

      expect(File(p.join(outDir.path, 'circuit.wcd')).existsSync(), isTrue);
      expect(File(p.join(outDir.path, 'circuit.zkey')).existsSync(), isTrue);
    });

    test('does not create subdirectories for archive directory entries', () async {
      final archive = Archive()
        ..addFile(ArchiveFile('emptyDir/', 0, Uint8List(0))..isFile = false);
      final zipBytes = ZipEncoder().encodeBytes(archive);
      final zipFile = File(p.join(tempDir.path, 'direntry.zip'))
        ..writeAsBytesSync(zipBytes);
      final outDir = Directory(p.join(tempDir.path, 'out2'))..createSync();

      await service.extractZipToDirectory(
        zipFilePath: zipFile.path,
        outputDirectory: outDir.path,
      );

      expect(outDir.listSync(), isEmpty);
    });
  });
}
