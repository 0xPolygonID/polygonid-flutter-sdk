import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as pathLib;
import 'package:polygonid_flutter_sdk/circuits/data/circuit_download_service.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

@injectable
class CircuitsFilesDataSource {
  final Directory directory;
  final CircuitRegistry circuitRegistry;
  final CircuitDownloadService _downloadService;

  CircuitsFilesDataSource(
    this.directory,
    this.circuitRegistry,
    this._downloadService,
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
    } catch (_) {} // asset not found – continue to registry

    // Fallback: try registry/resolver
    final source = await circuitRegistry.resolveCircuit(circuitId);
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
    final source = await circuitRegistry.resolveCircuit(circuitId);
    if (source != null) {
      final result = await _resolveZkeyFromSource(circuitId, source);
      if (result != null) return result;
    }

    throw CircuitNotDownloadedException(
      circuit: circuitId,
      errorMessage: 'Circuit $circuitId not downloaded or not found',
    );
  }

  /// Returns `true` if a [CircuitFileSource] can be resolved for [circuitId]
  /// via an explicit registration or the dynamic resolver.
  ///
  /// Used by [ProofRepositoryImpl.isCircuitSupported] to avoid a direct
  /// dependency on [CircuitRegistry].
  Future<bool> canResolveCircuit(String circuitId) async {
    return await circuitRegistry.resolveCircuit(circuitId) != null;
  }

  // --- Legacy helpers (deprecated — to be removed when the
  //     background_downloader-based flow is deleted) ---

  /// @deprecated Use [CircuitDownloadService.extractZipToDirectory] instead.
  @Deprecated('Use CircuitDownloadService.extractZipToDirectory instead')
  Future<void> extractZipToDirectory({
    required String zipFilePath,
    required String outputDirectory,
  }) => _downloadService.extractZipToDirectory(
    zipFilePath: zipFilePath,
    outputDirectory: outputDirectory,
  );

  /// @deprecated Legacy batch-download flow only.
  @Deprecated('Legacy batch-download flow only')
  bool circuitsFilesExist({required String circuitsFileName}) {
    return _zipFile(circuitsFileName).existsSync();
  }

  /// @deprecated Legacy batch-download flow only.
  @Deprecated('Legacy batch-download flow only')
  String getPathToCircuitZipFile({required String circuitsFileName}) {
    return _zipFile(circuitsFileName).path;
  }

  /// @deprecated Legacy batch-download flow only.
  @Deprecated('Legacy batch-download flow only')
  String getPathToCircuitZipFileTemp({required String circuitsFileName}) {
    return _zipFile(circuitsFileName, suffix: '_temp').path;
  }

  /// @deprecated Legacy batch-download flow only.
  @Deprecated('Legacy batch-download flow only')
  String get path => directory.path;

  // --- Private helpers ---

  /// Candidate file names for graph (.wcd) files. `%s` → circuitId.
  static const _graphFallbacks = ['%s.wcd', 'graph.wcd'];

  /// Candidate file names for zkey files.
  static const _zkeyFallbacks = ['%s.zkey', 'circuit_final.zkey'];

  /// Builds the path for a zip file in the base directory.
  File _zipFile(String circuitsFileName, {String suffix = ''}) {
    final name = '${circuitsFileName.trim()}$suffix.zip';
    return File(pathLib.join(directory.path, name));
  }

  /// Searches for a circuit file using standard naming conventions:
  /// 1. `<basePath>/<circuitId>.<ext>`
  /// 2. `<basePath>/<circuitId>/<fallback>` for each fallback pattern
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
      case UrlCircuitFileSource():
        await _downloadService.downloadAndExtractZip(
          circuitId,
          source.zipUrl,
          forceDownload: source.forceDownload,
        );
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
      case UrlCircuitFileSource():
        await _downloadService.downloadAndExtractZip(
          circuitId,
          source.zipUrl,
          forceDownload: source.forceDownload,
        );
        return _readFileIfExists(circuitId, 'zkey', _zkeyFallbacks)?.path;
      case AssetCircuitFileSource(:final zkeyAssetPath):
        if (zkeyAssetPath == null) return null;
        return _copyAssetToCache(circuitId, zkeyAssetPath, 'zkey');
    }
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
