import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import '../../../common/zip_test_helper.dart';
import 'circuits_files_data_source_test.mocks.dart';

@GenerateMocks([Dio, CircuitRegistry])
void main() {
  late MockDio mockDio;
  late MockCircuitRegistry mockRegistry;
  late Directory tempDir;
  late CircuitsFilesDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    mockRegistry = MockCircuitRegistry();
    tempDir = Directory.systemTemp.createTempSync('circuits_test_');
    dataSource = CircuitsFilesDataSource(
      tempDir,
      mockRegistry,
      ZipDecoder(),
      mockDio,
    );
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

      await dataSource.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(File(p.join(tempDir.path, circuitId, '$circuitId.wcd')).existsSync(), isTrue);
      expect(File(p.join(tempDir.path, circuitId, '$circuitId.zkey')).existsSync(), isTrue);
    });

    test('skips download when forceDownload=false and circuit files already present', () async {
      // Pre-create the circuit directory with a valid file.
      final circuitDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      File(p.join(circuitDir.path, '$circuitId.wcd')).writeAsBytesSync([]);

      await dataSource.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      verifyNever(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')));
    });

    test('re-downloads when forceDownload=true even if circuit files already present', () async {
      final circuitDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      File(p.join(circuitDir.path, '$circuitId.wcd')).writeAsBytesSync([]);

      stubDownload({'$circuitId.wcd': [1]});
      await dataSource.downloadAndExtractZip(
        circuitId,
        'http://example.com/c.zip',
        forceDownload: true,
      );

      verify(mockDio.download(any, any, cancelToken: anyNamed('cancelToken'))).called(1);
    });

    test('zip file is deleted after successful extraction', () async {
      stubDownload({'$circuitId.wcd': [1]});
      await dataSource.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      expect(File(p.join(tempDir.path, '$circuitId.zip')).existsSync(), isFalse);
    });

    test('temp directory is renamed to final circuit directory (no leftover _tmp_ dir)', () async {
      stubDownload({'$circuitId.wcd': [1]});
      await dataSource.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

      // Final directory exists.
      expect(Directory(p.join(tempDir.path, circuitId)).existsSync(), isTrue);
      // No temp directory left.
      final tempEntries = tempDir
          .listSync()
          .whereType<Directory>()
          .where((d) => p.basename(d.path).contains('_tmp_'));
      expect(tempEntries, isEmpty);
    });

    test('deletes an incomplete circuit directory before re-downloading', () async {
      // Create an incomplete circuit directory (no expected files).
      Directory(p.join(tempDir.path, circuitId)).createSync();

      stubDownload({'$circuitId.wcd': [1]});
      await dataSource.downloadAndExtractZip(circuitId, 'http://example.com/c.zip');

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

      await dataSource.downloadAndExtractZip(
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
        dataSource.downloadAndExtractZip(circuitId, 'http://x'),
        throwsA(isA<DioException>()),
      );

      expect(File(p.join(tempDir.path, '$circuitId.zip')).existsSync(), isFalse);
      expect(Directory(p.join(tempDir.path, circuitId)).existsSync(), isFalse);
    });

    test('rethrows exception and cleans up temp directory on Dio failure', () async {
      stubDownload({}, throws: DioException(requestOptions: RequestOptions(path: '')));

      await expectLater(
        dataSource.downloadAndExtractZip(circuitId, 'http://x'),
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
        dataSource.downloadAndExtractZip(circuitId, 'http://x'),
        throwsA(isA<CircuitNotDownloadedException>()),
      );

      // Both circuit dir and temp dir are cleaned up.
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

      await dataSource.extractZipToDirectory(
        zipFilePath: zipFile.path,
        outputDirectory: outDir.path,
      );

      // Basename-only: subfolder path is stripped.
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

      await dataSource.extractZipToDirectory(
        zipFilePath: zipFile.path,
        outputDirectory: outDir.path,
      );

      expect(outDir.listSync(), isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // loadGraphFile — non-bundle paths
  // ---------------------------------------------------------------------------

  group('loadGraphFile — non-bundle paths', () {
    const circuitId = 'myCircuit';

    test('returns bytes when wcd file exists directly in base directory', () async {
      final wcd = File(p.join(tempDir.path, '$circuitId.wcd'))
        ..writeAsBytesSync([10, 20, 30]);

      final bytes = await dataSource.loadGraphFile(circuitId);
      expect(bytes, wcd.readAsBytesSync());
    });

    test('returns bytes when wcd file exists in circuit subdirectory', () async {
      final subDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      final wcd = File(p.join(subDir.path, '$circuitId.wcd'))
        ..writeAsBytesSync([7, 8, 9]);

      final bytes = await dataSource.loadGraphFile(circuitId);
      expect(bytes, wcd.readAsBytesSync());
    });

    test('falls back to LocalPathCircuitFileSource from registry', () async {
      // Create the file in a custom path.
      final customDir = Directory.systemTemp.createTempSync('custom_');
      addTearDown(() => customDir.deleteSync(recursive: true));
      final wcd = File(p.join(customDir.path, '$circuitId.wcd'))
        ..writeAsBytesSync([1, 2, 3]);

      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => LocalPathCircuitFileSource(directoryPath: customDir.path),
      );

      final bytes = await dataSource.loadGraphFile(circuitId);
      expect(bytes, wcd.readAsBytesSync());
    });

    test('throws CircuitNotDownloadedException when no file and no registry entry', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer((_) async => null);

      await expectLater(
        dataSource.loadGraphFile(circuitId),
        throwsA(isA<CircuitNotDownloadedException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getZkeyFilePath — non-bundle paths
  // ---------------------------------------------------------------------------

  group('getZkeyFilePath — non-bundle paths', () {
    const circuitId = 'myCircuit';

    test('returns path when zkey file exists directly in base directory', () async {
      final zkey = File(p.join(tempDir.path, '$circuitId.zkey'))
        ..writeAsBytesSync([]);
      expect(await dataSource.getZkeyFilePath(circuitId), zkey.path);
    });

    test('returns path when zkey file exists in circuit subdirectory', () async {
      final subDir = Directory(p.join(tempDir.path, circuitId))..createSync();
      final zkey = File(p.join(subDir.path, '$circuitId.zkey'))
        ..writeAsBytesSync([]);
      expect(await dataSource.getZkeyFilePath(circuitId), zkey.path);
    });

    test('falls back to LocalPathCircuitFileSource from registry', () async {
      final customDir = Directory.systemTemp.createTempSync('custom_zkey_');
      addTearDown(() => customDir.deleteSync(recursive: true));
      final zkey = File(p.join(customDir.path, '$circuitId.zkey'))
        ..writeAsBytesSync([]);

      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => LocalPathCircuitFileSource(directoryPath: customDir.path),
      );

      expect(await dataSource.getZkeyFilePath(circuitId), zkey.path);
    });

    test('throws CircuitNotDownloadedException when no file and no registry entry', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer((_) async => null);

      await expectLater(
        dataSource.getZkeyFilePath(circuitId),
        throwsA(isA<CircuitNotDownloadedException>()),
      );
    });

    test('downloads via UrlCircuitFileSource when no local file present', () async {
      stubDownload({'$circuitId.zkey': [9, 8, 7]});
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://example.com/c.zip'),
      );

      final path = await dataSource.getZkeyFilePath(circuitId);
      expect(File(path).existsSync(), isTrue);
    });

    test('uses existing local zkey without consulting registry or downloading', () async {
      // Pre-create a valid zkey file in the base dir.
      File(p.join(tempDir.path, '$circuitId.zkey')).writeAsBytesSync([1, 2, 3]);

      // Even if the registry has a URL source, we must not download.
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://x', forceDownload: true),
      );

      await dataSource.getZkeyFilePath(circuitId);

      verifyNever(mockDio.download(any, any, cancelToken: anyNamed('cancelToken')));
    });
  });
}
