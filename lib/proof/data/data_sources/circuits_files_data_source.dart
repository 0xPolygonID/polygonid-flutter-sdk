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
  final CircuitRegistry? circuitRegistry;
  final ZipDecoder _zipDecoder;

  CircuitsFilesDataSource(
    this.directory,
    this.circuitRegistry,
    this._zipDecoder,
  );

  // --- Public API ---

  Future<Uint8List> loadGraphFile(String circuitId) async {
    // Try registry/resolver first
    final source = await _resolveCircuit(circuitId);
    if (source != null) {
      final result = await _loadGraphFromSource(circuitId, source);
      if (result != null) return result;
    }

    // Fallback: scan the default directory
    final local = _readFileIfExists(circuitId, 'wcd', _graphFallbacks);
    if (local != null) return local.readAsBytesSync();

    // Last resort: bundled asset
    try {
      final data = await rootBundle.load('assets/$circuitId.wcd');
      return data.buffer.asUint8List();
    } catch (_) {
      throw CircuitNotDownloadedException(
        circuit: circuitId,
        errorMessage:
            'Circuit $circuitId not found at assets path "assets/$circuitId.wcd"',
      );
    }
  }

  Future<String> getZkeyFilePath(String circuitId) async {
    // Try registry/resolver first
    final source = await _resolveCircuit(circuitId);
    if (source != null) {
      final result = await _resolveZkeyFromSource(circuitId, source);
      if (result != null) return result;
    }

    // Fallback: scan the default directory
    final local = _readFileIfExists(circuitId, 'zkey', _zkeyFallbacks);
    if (local != null) return local.path;

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
      circuitRegistry?.resolveCircuit(circuitId) ?? Future.value(null);

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
        await _downloadAndExtractZip(circuitId, zipUrl);
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
        await _downloadAndExtractZip(circuitId, zipUrl);
        return _readFileIfExists(circuitId, 'zkey', _zkeyFallbacks)?.path;
      case AssetCircuitFileSource(:final zkeyAssetPath):
        if (zkeyAssetPath == null) return null;
        return _copyAssetToCache(circuitId, zkeyAssetPath, 'zkey');
    }
  }

  Future<void> _downloadAndExtractZip(String circuitId, String zipUrl) async {
    final circuitDir = Directory(pathLib.join(directory.path, circuitId));

    // Skip if already extracted
    if (circuitDir.existsSync() && circuitDir.listSync().isNotEmpty) return;

    final zipPath = pathLib.join(directory.path, '$circuitId.zip');
    await Dio().download(zipUrl, zipPath);

    final archive = _zipDecoder.decodeStream(InputFileStream(zipPath));

    await circuitDir.create(recursive: true);
    for (final archiveFile in archive) {
      if (!archiveFile.isFile) continue;
      final outPath = pathLib.join(
        circuitDir.path,
        pathLib.basename(archiveFile.name),
      );
      await File(outPath).create(recursive: true);
      archiveFile.writeContent(OutputFileStream(outPath));
    }

    // Clean up the zip
    deleteFile(zipPath);
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
