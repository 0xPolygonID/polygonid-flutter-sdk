import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/claim_entity.dart';

class CredentialStateMapper extends Mapper<String, CredentialState> {
  @override
  CredentialState mapFrom(String from) {
    switch (from) {
      case "expired":
        return CredentialState.expired;
      case "pending":
        return CredentialState.pending;
      case "revoked":
        return CredentialState.revoked;
      default:
        return CredentialState.active;
    }
  }

  @override
  String mapTo(CredentialState to) {
    switch (to) {
      case CredentialState.expired:
        return "expired";
      case CredentialState.pending:
        return "pending";
      case CredentialState.revoked:
        return "revoked";
      default:
        return "";
    }
  }
}
