import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';

import '../dtos/identity_dto.dart';

class IdentityDTOMapper extends FromMapper<IdentityDTO, Identity> {
  @override
  Identity mapFrom(IdentityDTO from) {
    return Identity(
        privateKey: from.privateKey,
        identifier: from.identifier,
        authClaim: from.authClaim,
        smt: from.smt);
  }
}
