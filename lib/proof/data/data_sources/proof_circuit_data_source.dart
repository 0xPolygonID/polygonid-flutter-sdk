import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class ProofCircuitDataSource {
  static const List<CircuitId> _supportedCircuits = [
    CircuitId.authV2,
    CircuitId.authV3,
    CircuitId.authV3_8_32,
    CircuitId.mtp,
    CircuitId.sig,
    CircuitId.mtpOnChain,
    CircuitId.sigOnChain,
    CircuitId.atomicQueryV3,
    CircuitId.atomicQueryV3OnChain,
    CircuitId.atomicQueryV3Stable,
    CircuitId.atomicQueryV3OnChainStable,
    CircuitId.linkedMultiQuery10,
  ];

  Future<bool> isCircuitSupported({required CircuitId circuitId}) {
    return Future.value(_supportedCircuits.contains(circuitId));
  }
}
