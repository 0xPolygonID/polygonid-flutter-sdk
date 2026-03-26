import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';

/// A callback that resolves a [CircuitFileSource] for a given circuit ID
/// at runtime. Return `null` to fall back to the default resolution behavior.
typedef CircuitResolver = Future<CircuitFileSource?> Function(String circuitId);

/// A callback that downloads and extracts a zip archive for a circuit.
///
/// [forceDownload] bypasses the on-disk existence check and always
/// re-downloads. [cancelToken] allows the caller to cancel an in-flight
/// download.
typedef CircuitDownloader =
    Future<void> Function(
      String circuitId,
      String zipUrl, {
      bool forceDownload,
      CancelToken? cancelToken,
    });

/// Manages explicit circuit file registrations and an optional dynamic
/// resolver for circuit IDs that are not known ahead of time.
@lazySingleton
class CircuitRegistry {
  final Map<String, CircuitFileSource> _registrations = {};
  CircuitResolver? _resolver;
  CircuitDownloader? _downloader;

  CircuitRegistry();

  /// Inject the downloader that performs zip download + extraction.
  ///
  /// This is called once during SDK initialisation so that [register] can
  /// trigger an immediate download for [UrlCircuitFileSource] sources that
  /// have [UrlCircuitFileSource.downloadImmediately] set to `true`.
  void setDownloader(CircuitDownloader? downloader) {
    _downloader = downloader;
  }

  /// Register a [CircuitFileSource] for the given [circuitId].
  ///
  /// If [source] is a [UrlCircuitFileSource] with
  /// [UrlCircuitFileSource.downloadImmediately] set to `true` and a
  /// downloader has been configured via [setDownloader], the zip archive
  /// is downloaded and extracted immediately — unless the circuit files are
  /// already present on disk (skipped when [UrlCircuitFileSource.forceDownload]
  /// is `false`).
  ///
  /// [cancelToken] can be used to cancel an in-flight download.
  Future<void> register(
    String circuitId,
    CircuitFileSource source, {
    CancelToken? cancelToken,
  }) async {
    _registrations[circuitId] = source;

    if (source is UrlCircuitFileSource &&
        source.downloadImmediately &&
        _downloader != null) {
      await _downloader!(
        circuitId,
        source.zipUrl,
        forceDownload: source.forceDownload,
        cancelToken: cancelToken,
      );
    }
  }

  /// Remove a previously registered circuit file source.
  void unregister(String circuitId) {
    _registrations.remove(circuitId);
  }

  /// Set a callback to dynamically resolve circuit file sources for
  /// unknown circuit IDs at runtime.
  void setCircuitResolver(CircuitResolver? resolver) {
    _resolver = resolver;
  }

  /// Resolve a [CircuitFileSource] for the given [circuitId].
  ///
  /// First checks explicit registrations, then falls back to the
  /// dynamic resolver. Returns `null` if the circuit is not found.
  Future<CircuitFileSource?> resolveCircuit(String circuitId) async {
    final registered = _registrations[circuitId];
    if (registered != null) return registered;

    if (_resolver != null) {
      return _resolver!(circuitId);
    }

    return null;
  }
}
