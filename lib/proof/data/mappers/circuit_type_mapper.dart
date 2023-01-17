import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';

enum CircuitType { auth, mtp, sig, unknown }

class CircuitTypeMapper extends ToMapper<CircuitType, String> {
  @override
  CircuitType mapTo(String to) {
    switch (to) {
      case "authV2":
        return CircuitType.auth;

      case "credentialAtomicQueryMTPV2":
        return CircuitType.mtp;

      case "credentialAtomicQuerySigV2":
        return CircuitType.sig;

      default:
        return CircuitType.unknown;
    }
  }
}
