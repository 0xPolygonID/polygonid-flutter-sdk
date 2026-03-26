/// Describes where circuit files (`.wcd` / `.zkey`) can be found.
sealed class CircuitFileSource {
  const CircuitFileSource();
}

/// Circuit files are located in a local directory.
class LocalPathCircuitFileSource extends CircuitFileSource {
  /// Absolute path to the directory containing the circuit files.
  final String directoryPath;

  const LocalPathCircuitFileSource({required this.directoryPath});
}

/// Circuit files are available as a remote zip archive containing both
/// `.wcd` and `.zkey` files.
class UrlCircuitFileSource extends CircuitFileSource {
  /// URL to a `.zip` file that contains the `.wcd` and `.zkey` files.
  final String zipUrl;

  /// When `true`, the zip archive is downloaded and extracted immediately
  /// upon registration via [CircuitRegistry.register] instead of being
  /// fetched lazily the first time the circuit is needed for proof
  /// generation.
  final bool downloadImmediately;

  /// When `true`, re-downloads and re-extracts the zip archive even if the
  /// circuit files are already present on disk. Has no effect unless
  /// [downloadImmediately] is also `true`, or the circuit is fetched lazily.
  final bool forceDownload;

  const UrlCircuitFileSource({
    required this.zipUrl,
    this.downloadImmediately = false,
    this.forceDownload = false,
  });
}

/// Circuit files are bundled as Flutter assets.
class AssetCircuitFileSource extends CircuitFileSource {
  /// Asset path to the `.wcd` graph file (e.g. `assets/myCircuit.wcd`).
  final String wcdAssetPath;

  /// Optional asset path to the `.zkey` file.
  final String? zkeyAssetPath;

  const AssetCircuitFileSource({
    required this.wcdAssetPath,
    this.zkeyAssetPath,
  });
}
