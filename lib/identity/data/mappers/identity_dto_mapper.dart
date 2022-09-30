import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

import '../../domain/entities/identity_entity.dart';
import '../dtos/identity_dto.dart';

class IdentityDTOMapper extends FromMapper<IdentityDTO, IdentityEntity> {
  @override
  IdentityEntity mapFrom(IdentityDTO from) {
    return IdentityEntity(
        privateKey: from.privateKey,
        identifier: from.identifier,
        authClaim: from.authClaim,
        smt: from.smt);
  }
}
