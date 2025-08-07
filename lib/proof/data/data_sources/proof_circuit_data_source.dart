import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class ProofCircuitDataSource {
  static const List<CircuitType> _supportedCircuits = [
    CircuitTypes.mtp,
    CircuitTypes.sig,
    CircuitTypes.mtpOnChain,
    CircuitTypes.sigOnChain,
    CircuitTypes.circuitsV3,
    CircuitTypes.circuitsV3OnChain,
    CircuitTypes.linkedMultiQuery,
  ];

  Future<bool> isCircuitSupported({required CircuitType circuit}) {
    return Future.value(_supportedCircuits.contains(circuit));
  }
}
