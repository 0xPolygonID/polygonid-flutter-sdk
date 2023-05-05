import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';

enum CircuitType { auth, mtp, sig, mtponchain, sigonchain, unknown }

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

      case "credentialAtomicQueryMTPV2OnChain":
        return CircuitType.mtponchain;

      case "credentialAtomicQuerySigV2OnChain":
        return CircuitType.sigonchain;

      default:
        return CircuitType.unknown;
    }
  }
}
