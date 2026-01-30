import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class ProofCircuitDataSource {
  static const List<CircuitId> _supportedCircuits = [
    CircuitIds.mtp,
    CircuitIds.sig,
    CircuitIds.mtpOnChain,
    CircuitIds.sigOnChain,
    CircuitIds.circuitsV3,
    CircuitIds.circuitsV3OnChain,
    CircuitIds.linkedMultiQuery,
  ];

  Future<bool> isCircuitSupported({required CircuitId circuitId}) {
    return Future.value(_supportedCircuits.contains(circuitId));
  }
}
