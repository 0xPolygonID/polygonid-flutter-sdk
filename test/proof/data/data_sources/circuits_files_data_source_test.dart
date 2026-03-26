import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;
import 'package:polygonid_flutter_sdk/circuits/data/circuit_download_service.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import 'circuits_files_data_source_test.mocks.dart';

@GenerateMocks([CircuitRegistry, CircuitDownloadService])
void main() {
  late MockCircuitRegistry mockRegistry;
  late MockCircuitDownloadService mockDownloadService;
  late Directory tempDir;
  late CircuitsFilesDataSource dataSource;

  setUp(() {
    mockRegistry = MockCircuitRegistry();
    mockDownloadService = MockCircuitDownloadService();
    tempDir = Directory.systemTemp.createTempSync('circuits_test_');
    dataSource = CircuitsFilesDataSource(
      tempDir,
      mockRegistry,
      mockDownloadService,
    );
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  // ---------------------------------------------------------------------------
  // loadGraphFile
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

    test('delegates download to CircuitDownloadService for UrlCircuitFileSource', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://example.com/c.zip'),
      );
      // Simulate the service creating the wcd file on disk.
      when(
        mockDownloadService.downloadAndExtractZip(
          circuitId,
          'http://example.com/c.zip',
          forceDownload: anyNamed('forceDownload'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async {
        final dir = Directory(p.join(tempDir.path, circuitId))
          ..createSync(recursive: true);
        File(p.join(dir.path, '$circuitId.wcd')).writeAsBytesSync([5, 6, 7]);
      });

      final bytes = await dataSource.loadGraphFile(circuitId);
      expect(bytes, [5, 6, 7]);
    });

    test('does not call downloadService when wcd is already on disk', () async {
      File(p.join(tempDir.path, '$circuitId.wcd')).writeAsBytesSync([1]);

      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://x', forceDownload: true),
      );

      await dataSource.loadGraphFile(circuitId);

      verifyNever(mockDownloadService.downloadAndExtractZip(
        any, any,
        forceDownload: anyNamed('forceDownload'),
        cancelToken: anyNamed('cancelToken'),
      ));
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
  // getZkeyFilePath
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

    test('delegates download to CircuitDownloadService for UrlCircuitFileSource', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://example.com/c.zip'),
      );
      when(
        mockDownloadService.downloadAndExtractZip(
          circuitId,
          'http://example.com/c.zip',
          forceDownload: anyNamed('forceDownload'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async {
        final dir = Directory(p.join(tempDir.path, circuitId))
          ..createSync(recursive: true);
        File(p.join(dir.path, '$circuitId.zkey')).writeAsBytesSync([9, 8, 7]);
      });

      final path = await dataSource.getZkeyFilePath(circuitId);
      expect(File(path).existsSync(), isTrue);
    });

    test('does not call downloadService when zkey is already on disk', () async {
      File(p.join(tempDir.path, '$circuitId.zkey')).writeAsBytesSync([1, 2, 3]);

      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => UrlCircuitFileSource(zipUrl: 'http://x', forceDownload: true),
      );

      await dataSource.getZkeyFilePath(circuitId);

      verifyNever(mockDownloadService.downloadAndExtractZip(
        any, any,
        forceDownload: anyNamed('forceDownload'),
        cancelToken: anyNamed('cancelToken'),
      ));
    });

    test('throws CircuitNotDownloadedException when no file and no registry entry', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer((_) async => null);

      await expectLater(
        dataSource.getZkeyFilePath(circuitId),
        throwsA(isA<CircuitNotDownloadedException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // canResolveCircuit
  // ---------------------------------------------------------------------------

  group('canResolveCircuit', () {
    const circuitId = 'someCircuit';

    test('returns true when registry resolves a source', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer(
        (_) async => LocalPathCircuitFileSource(directoryPath: '/any'),
      );
      expect(await dataSource.canResolveCircuit(circuitId), isTrue);
    });

    test('returns false when registry returns null', () async {
      when(mockRegistry.resolveCircuit(circuitId)).thenAnswer((_) async => null);
      expect(await dataSource.canResolveCircuit(circuitId), isFalse);
    });
  });
}
