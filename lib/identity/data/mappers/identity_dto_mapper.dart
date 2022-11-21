import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import '../../../common/mappers/mapper.dart';
import '../../domain/entities/identity_entity.dart';
import '../dtos/identity_dto.dart';

class IdentityDTOMapper extends Mapper<IdentityDTO, IdentityEntity> {
  @override
  IdentityEntity mapFrom(IdentityDTO from) {
    return IdentityEntity(
      identifier: from.identifier,
      publicKey: from.publicKey,
    );
  }

  @override
  IdentityDTO mapTo(IdentityEntity to) {
    return IdentityDTO(
      identifier: to.identifier,
      publicKey: to.publicKey,
    );
  }

  PrivateIdentityEntity mapPrivateFrom(
    IdentityDTO from,
    String privateKey,
  ) {
    return PrivateIdentityEntity(
      identifier: from.identifier,
      publicKey: from.publicKey,
      privateKey: privateKey,
    );
  }
}
