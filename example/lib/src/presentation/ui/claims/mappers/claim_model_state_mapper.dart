import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_state.dart';

class ClaimModelStateMapper implements Mapper<CredentialState, ClaimModelState> {
  @override
  ClaimModelState mapFrom(CredentialState from) {
    switch (from) {
      case CredentialState.expired:
        return ClaimModelState.expired;
      case CredentialState.pending:
        return ClaimModelState.pending;
      case CredentialState.revoked:
        return ClaimModelState.revoked;
      default:
        return ClaimModelState.active;
    }
  }

  @override
  CredentialState mapTo(ClaimModelState to) {
    switch (to) {
      case ClaimModelState.expired:
        return CredentialState.expired;
      case ClaimModelState.pending:
        return CredentialState.pending;
      case ClaimModelState.revoked:
        return CredentialState.revoked;
      default:
        return CredentialState.active;
    }
  }
}
