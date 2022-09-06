import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

import 'claim_model_state_mapper.dart';

class ClaimModelMapper implements Mapper<ClaimEntity, ClaimModel> {
  ClaimModelStateMapper stateMapper;

  ClaimModelMapper(this.stateMapper);

  @override
  ClaimModel mapFrom(ClaimEntity from) {
    return ClaimModel(
      id: from.id,
      issuer: from.issuer,
      credentialData: CredentialData(), //TODO //CredentialData.fromJson(from.data),
      expiration: from.expiration,
      state: stateMapper.mapFrom(from.state),
      type: from.type,
    );
  }

  @override
  ClaimEntity mapTo(ClaimModel to) {
    return ClaimEntity(
      id: to.id,
      identifier: "",//TODO do we need user identifier for each one?
      issuer: to.issuer!,
      data: to.credentialData.toJson(),
      expiration: to.expiration,
      state: stateMapper.mapTo(to.state),
      type: to.type,
    );
  }
}
