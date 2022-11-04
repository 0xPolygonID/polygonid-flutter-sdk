import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

import '../../domain/entities/private_identity_entity.dart';
import '../dtos/private_identity_dto.dart';

class PrivateIdentityDTOMapper
    extends FromMapper<PrivateIdentityDTO, PrivateIdentityEntity> {
  @override
  PrivateIdentityEntity mapFrom(PrivateIdentityDTO from) {
    return PrivateIdentityEntity(
      identifier: from.identifier,
      publicKey: from.publicKey,
      state: from.state,
      privateKey: from.privateKey,
      authClaim: from.authClaim,
    );
  }
}
