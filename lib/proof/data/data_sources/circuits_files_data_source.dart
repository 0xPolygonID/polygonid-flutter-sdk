import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as pathLib;
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

@injectable
class CircuitsFilesDataSource {
  final Directory directory;
  final CircuitRegistry circuitRegistry;
  final ZipDecoder _zipDecoder;
  final Dio _client;

  CircuitsFilesDataSource(
    this.directory,
    this.circuitRegistry,
    this._zipDecoder,
    this._client,
  );

  // --- Public API ---

  Future<Uint8List> loadGraphFile(String circuitId) async {
    // Scan the default directory first to preserve backwards compatibility
    final local = _readFileIfExists(circuitId, 'wcd', _graphFallbacks);
    if (local != null) return local.readAsBytesSync();

    // Bundled asset
    try {
      final data = await rootBundle.load('assets/$circuitId.wcd');
      return data.buffer.asUint8List();
    } catch (_) {
      // asset not found – continue to registry
    }

    // Fallback: try registry/resolver
    final source = await _resolveCircuit(circuitId);
    if (source != null) {
      final result = await _loadGraphFromSource(circuitId, source);
      if (result != null) return result;
    }

    throw CircuitNotDownloadedException(
      circuit: circuitId,
      errorMessage:
          'Circuit $circuitId not found at assets path "assets/$circuitId.wcd"',
    );
  }

  Future<String> getZkeyFilePath(String circuitId) async {
    // Scan the default directory first to preserve backwards compatibility
    final local = _readFileIfExists(circuitId, 'zkey', _zkeyFallbacks);
    if (local != null) return local.path;

    // Fallback: try registry/resolver
    final source = await _resolveCircuit(circuitId);
    if (source != null) {
      final result = await _resolveZkeyFromSource(circuitId, source);
      if (result != null) return result;
    }


    throw CircuitNotDownloadedException(
      circuit: circuitId,
      errorMessage: 'Circuit $circuitId not downloaded or not found',
    );
  }

  bool circuitsFilesExist({required String circuitsFileName}) {
    return _zipFile(circuitsFileName).existsSync();
  }

  String getPathToCircuitZipFile({required String circuitsFileName}) {
    return _zipFile(circuitsFileName).path;
  }

  String getPathToCircuitZipFileTemp({required String circuitsFileName}) {
    return _zipFile(circuitsFileName, suffix: '_temp').path;
  }

  String get path => directory.path;

  void deleteFile(String pathToFile) {
    try {
      File(pathToFile).deleteSync();
    } catch (_) {
      // file not found — nothing to clean up
    }
  }

  // --- Private helpers ---

  /// Candidate file names for graph (wcd) files, relative to a circuit folder.
  /// `%s` is replaced with the circuitId.
  static const _graphFallbacks = ['%s.wcd', 'graph.wcd'];

  /// Candidate file names for zkey files, relative to a circuit folder.
  static const _zkeyFallbacks = ['%s.zkey', 'circuit_final.zkey'];

  /// Builds the path for a zip file in the base directory.
  File _zipFile(String circuitsFileName, {String suffix = ''}) {
    final name = '${circuitsFileName.trim()}$suffix.zip';
    return File(pathLib.join(directory.path, name));
  }

  /// Resolves the circuit source from the registry (if available).
  Future<CircuitFileSource?> _resolveCircuit(String circuitId) =>
      circuitRegistry.resolveCircuit(circuitId);

  /// Searches for a file using standard naming conventions:
  /// 1. `<basePath>/$circuitId.<ext>`
  /// 2. `<basePath>/$circuitId/<fallback>` for each fallback pattern
  File? _readFileIfExists(
    String circuitId,
    String ext,
    List<String> subDirFallbacks, {
    String? basePath,
  }) {
    final base = basePath ?? directory.path;
    if (!Directory(base).existsSync()) return null;

    // Rule 1: directly in basePath
    final direct = File(pathLib.join(base, '$circuitId.$ext'));
    if (direct.existsSync()) return direct;

    // Rules 2+: inside a subfolder named circuitId
    final subDir = Directory(pathLib.join(base, circuitId));
    if (!subDir.existsSync()) return null;

    for (final pattern in subDirFallbacks) {
      final file = File(
        pathLib.join(subDir.path, pattern.replaceAll('%s', circuitId)),
      );
      if (file.existsSync()) return file;
    }

    return null;
  }

  // --- Registry-based resolution ---

  Future<Uint8List?> _loadGraphFromSource(
    String circuitId,
    CircuitFileSource source,
  ) async {
    switch (source) {
      case LocalPathCircuitFileSource(:final directoryPath):
        return _readFileIfExists(
          circuitId,
          'wcd',
          _graphFallbacks,
          basePath: directoryPath,
        )?.readAsBytesSync();
      case UrlCircuitFileSource(:final zipUrl):
        await downloadAndExtractZip(circuitId, zipUrl);
        return _readFileIfExists(
          circuitId,
          'wcd',
          _graphFallbacks,
        )?.readAsBytesSync();
      case AssetCircuitFileSource(:final wcdAssetPath):
        final data = await rootBundle.load(wcdAssetPath);
        return data.buffer.asUint8List();
    }
  }

  Future<String?> _resolveZkeyFromSource(
    String circuitId,
    CircuitFileSource source,
  ) async {
    switch (source) {
      case LocalPathCircuitFileSource(:final directoryPath):
        return _readFileIfExists(
          circuitId,
          'zkey',
          _zkeyFallbacks,
          basePath: directoryPath,
        )?.path;
      case UrlCircuitFileSource(:final zipUrl):
        await downloadAndExtractZip(circuitId, zipUrl);
        return _readFileIfExists(circuitId, 'zkey', _zkeyFallbacks)?.path;
      case AssetCircuitFileSource(:final zkeyAssetPath):
        if (zkeyAssetPath == null) return null;
        return _copyAssetToCache(circuitId, zkeyAssetPath, 'zkey');
    }
  }

  /// Extracts entries from [zipFilePath] into [outputDirectory], placing each
  /// file directly in [outputDirectory] (using only the basename of the
  /// archive entry). Directory entries are skipped.
  Future<void> extractZipToDirectory({
    required String zipFilePath,
    required String outputDirectory,
  }) async {
    final archive = _zipDecoder.decodeStream(InputFileStream(zipFilePath));

    for (final archiveFile in archive) {
      if (!archiveFile.isFile) continue;
      final outPath = pathLib.join(
        outputDirectory,
        pathLib.basename(archiveFile.name),
      );
      await File(outPath).create(recursive: true);
      archiveFile.writeContent(OutputFileStream(outPath));
    }
  }

  /// Downloads a zip archive from [zipUrl], extracts it into a subdirectory
  /// named [circuitId] under the base [directory], and deletes the zip.
  ///
  /// Extraction is performed into a temporary directory that is atomically
  /// renamed to the final location once all files have been written. This
  /// prevents a partially-extracted directory (caused by e.g. an app kill or
  /// disk-full condition) from being mistaken for a valid extraction on
  /// subsequent calls.
  Future<void> downloadAndExtractZip(String circuitId, String zipUrl) async {
    final circuitDir = Directory(pathLib.join(directory.path, circuitId));

    // Skip only when the expected circuit files are already present.
    if (_circuitFilesValid(circuitId, circuitDir)) return;

    // If the directory exists but is incomplete, remove it so we start fresh.
    if (circuitDir.existsSync()) {
      circuitDir.deleteSync(recursive: true);
    }

    final zipPath = pathLib.join(directory.path, '$circuitId.zip');
    final tempDir = Directory(
      pathLib.join(directory.path, '${circuitId}_tmp_${DateTime.now().millisecondsSinceEpoch}'),
    );

    try {
      await _client.download(zipUrl, zipPath);

      await tempDir.create(recursive: true);
      await extractZipToDirectory(
        zipFilePath: zipPath,
        outputDirectory: tempDir.path,
      );

      // Validate that the extraction produced the expected files.
      if (!_circuitFilesValid(circuitId, tempDir)) {
        throw CircuitNotDownloadedException(
          circuit: circuitId,
          errorMessage:
              'Extraction of $circuitId produced an incomplete set of files',
        );
      }

      // Atomic rename – safe on the same filesystem.
      await tempDir.rename(circuitDir.path);
    } catch (_) {
      // Clean up partial artefacts so a retry can succeed.
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      if (circuitDir.existsSync()) {
        circuitDir.deleteSync(recursive: true);
      }
      deleteFile(zipPath);
      rethrow;
    }

    // Clean up the zip
    deleteFile(zipPath);
  }

  /// Returns `true` when [dir] contains at least one expected circuit file
  /// (.wcd or .zkey) for the given [circuitId].
  bool _circuitFilesValid(String circuitId, Directory dir) {
    if (!dir.existsSync()) return false;

    for (final pattern in [..._graphFallbacks, ..._zkeyFallbacks]) {
      final file = File(
        pathLib.join(dir.path, pattern.replaceAll('%s', circuitId)),
      );
      if (file.existsSync()) return true;
    }
    return false;
  }

  Future<String> _copyAssetToCache(
    String circuitId,
    String assetPath,
    String ext,
  ) async {
    final cachedFile = File(
      pathLib.join(directory.path, circuitId, '$circuitId.$ext'),
    );
    if (cachedFile.existsSync()) return cachedFile.path;

    final data = await rootBundle.load(assetPath);
    await cachedFile.parent.create(recursive: true);
    await cachedFile.writeAsBytes(data.buffer.asUint8List());
    return cachedFile.path;
  }
}
