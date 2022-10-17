import 'package:polygonid_flutter_sdk/proof_generation/data/mappers/circuit_type_mapper.dart';

class ProofCircuitDataSource {
  static const List<CircuitType> _supportedCircuits = [
    CircuitType.mtp,
    CircuitType.sig
  ];

  Future<bool> isCircuitSupported({required CircuitType circuit}) {
    return Future.value(_supportedCircuits.contains(circuit));
  }
}
