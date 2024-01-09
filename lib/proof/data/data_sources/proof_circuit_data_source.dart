import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class ProofCircuitDataSource {
  static const List<CircuitType> _supportedCircuits = [
    CircuitType.mtp,
    CircuitType.sig,
    CircuitType.mtponchain,
    CircuitType.sigonchain,
    CircuitType.circuitsV3,
    CircuitType.circuitsV3onchain,
  ];

  Future<bool> isCircuitSupported({required CircuitType circuit}) {
    return Future.value(_supportedCircuits.contains(circuit));
  }
}
