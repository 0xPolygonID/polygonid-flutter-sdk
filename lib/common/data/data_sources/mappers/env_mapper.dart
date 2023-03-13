import 'package:polygonid_flutter_sdk/common/domain/entities/env_dto.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

class EnvMapper extends Mapper<Map<String, dynamic>, EnvEntity> {
  @override
  EnvEntity mapFrom(Map<String, dynamic> from) {
    return EnvEntity(
      blockchain: from['blockchain'],
      network: from['network'],
      url: from['url'],
      rdpUrl: from['rdpUrl'],
      rhsUrl: from['rhsUrl'],
      apiKey: from['apiKey'],
      idStateContract: from['idStateContract'],
    );
  }

  @override
  Map<String, dynamic> mapTo(EnvEntity to) {
    return EnvDTO(
      blockchain: to.blockchain,
      network: to.network,
      url: to.url,
      rdpUrl: to.rdpUrl,
      rhsUrl: to.rhsUrl,
      apiKey: to.apiKey,
      idStateContract: to.idStateContract,
    ).toJson();
  }
}
