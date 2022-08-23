import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/claim_entity.dart';

class ClaimStateMapper extends Mapper<String, ClaimState> {
  @override
  ClaimState mapFrom(String from) {
    switch (from) {
      case "expired":
        return ClaimState.expired;
      case "pending":
        return ClaimState.pending;
      case "revoked":
        return ClaimState.revoked;
      default:
        return ClaimState.active;
    }
  }

  @override
  String mapTo(ClaimState to) {
    switch (to) {
      case ClaimState.expired:
        return "expired";
      case ClaimState.pending:
        return "pending";
      case ClaimState.revoked:
        return "revoked";
      default:
        return "";
    }
  }
}
