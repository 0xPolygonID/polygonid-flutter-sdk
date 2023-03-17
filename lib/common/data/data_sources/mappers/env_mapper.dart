import 'package:polygonid_flutter_sdk/common/domain/entities/env_dto.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

class EnvMapper extends Mapper<Map<String, dynamic>, EnvEntity> {
  @override
  EnvEntity mapFrom(Map<String, dynamic> from) {
    return EnvEntity(
      blockchain: from['blockchain'],
      network: from['network'],
      web3Url: from['web3Url'],
      web3RdpUrl: from['web3RdpUrl'],
      web3ApiKey: from['web3ApiKey'],
      idStateContract: from['idStateContract'],
      pushUrl: from['pushUrl'],
    );
  }

  @override
  Map<String, dynamic> mapTo(EnvEntity to) {
    return EnvDTO(
      blockchain: to.blockchain,
      network: to.network,
      web3Url: to.web3Url,
      web3RdpUrl: to.web3RdpUrl,
      web3ApiKey: to.web3ApiKey,
      idStateContract: to.idStateContract,
      pushUrl: to.pushUrl,
    ).toJson();
  }
}
