import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/proof/response/iden3comm_proof_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/zkproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

class ZKProofBaseMapper extends Mapper<ZKProofBaseDTO, ZKProofBaseEntity> {
  @override
  ZKProofBaseEntity mapFrom(ZKProofBaseDTO from) {
    return ZKProofBaseEntity(
      piA: from.piA,
      piB: from.piB,
      piC: from.piC,
      protocol: from.protocol,
      curve: from.curve,
    );
  }

  @override
  ZKProofBaseDTO mapTo(ZKProofBaseEntity to) {
    return ZKProofBaseDTO(
      piA: to.piA,
      piB: to.piB,
      piC: to.piC,
      protocol: to.protocol,
      curve: to.curve,
    );
  }
}
