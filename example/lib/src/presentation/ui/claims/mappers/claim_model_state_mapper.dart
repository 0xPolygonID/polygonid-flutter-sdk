import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_state.dart';

class ClaimModelStateMapper implements Mapper<ClaimState, ClaimModelState> {
  @override
  ClaimModelState mapFrom(ClaimState from) {
    switch (from) {
      case ClaimState.expired:
        return ClaimModelState.expired;
      case ClaimState.pending:
        return ClaimModelState.pending;
      case ClaimState.revoked:
        return ClaimModelState.revoked;
      default:
        return ClaimModelState.active;
    }
  }

  @override
  ClaimState mapTo(ClaimModelState to) {
    switch (to) {
      case ClaimModelState.expired:
        return ClaimState.expired;
      case ClaimModelState.pending:
        return ClaimState.pending;
      case ClaimModelState.revoked:
        return ClaimState.revoked;
      default:
        return ClaimState.active;
    }
  }
}
