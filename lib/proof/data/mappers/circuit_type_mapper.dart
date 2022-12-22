import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';

enum CircuitType { auth, mtp, sig, unknown }

class CircuitTypeMapper extends ToMapper<CircuitType, String> {
  @override
  CircuitType mapTo(String to) {
    switch (to) {
      case "auth":
        return CircuitType.auth;

      case "credentialAtomicQueryMTP":
        return CircuitType.mtp;

      case "credentialAtomicQuerySig":
        return CircuitType.sig;

      default:
        return CircuitType.unknown;
    }
  }
}
