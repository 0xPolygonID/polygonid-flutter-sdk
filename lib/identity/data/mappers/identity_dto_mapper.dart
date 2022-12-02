import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import '../../../common/mappers/mapper.dart';
import '../../domain/entities/identity_entity.dart';
import '../dtos/identity_dto.dart';

class IdentityDTOMapper extends Mapper<IdentityDTO, IdentityEntity> {
  @override
  IdentityEntity mapFrom(IdentityDTO from) {
    return IdentityEntity(
      did: from.did,
      publicKey: from.publicKey,
    );
  }

  @override
  IdentityDTO mapTo(IdentityEntity to) {
    return IdentityDTO(
      did: to.did,
      publicKey: to.publicKey,
    );
  }

  PrivateIdentityEntity mapPrivateFrom(
    IdentityDTO from,
    String privateKey,
  ) {
    return PrivateIdentityEntity(
      did: from.did,
      publicKey: from.publicKey,
      privateKey: privateKey,
    );
  }
}
