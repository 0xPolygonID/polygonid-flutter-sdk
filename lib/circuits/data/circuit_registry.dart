import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';

/// A callback that resolves a [CircuitFileSource] for a given circuit ID
/// at runtime. Return `null` to fall back to the default resolution behavior.
typedef CircuitResolver = Future<CircuitFileSource?> Function(String circuitId);

/// Manages explicit circuit file registrations and an optional dynamic
/// resolver for circuit IDs that are not known ahead of time.
@injectable
class CircuitRegistry {
  final Map<String, CircuitFileSource> _registrations = {};
  CircuitResolver? _resolver;

  CircuitRegistry();

  /// Register a [CircuitFileSource] for the given [circuitId].
  void register(String circuitId, CircuitFileSource source) {
    _registrations[circuitId] = source;
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
