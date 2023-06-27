import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/proof/response/iden3comm_proof_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_base_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';

class Iden3commProofMapper
    extends Mapper<Iden3commProofDTO, Iden3commProofEntity> {
  final ZKProofBaseMapper _zkProofBaseMapper;

  Iden3commProofMapper(this._zkProofBaseMapper);

  @override
  Iden3commProofEntity mapFrom(Iden3commProofDTO from) {
    return Iden3commProofEntity(
      id: from.id,
      circuitId: from.circuitId,
      proof: _zkProofBaseMapper.mapFrom(from.proof),
      pubSignals: from.pubSignals,
    );
  }

  @override
  Iden3commProofDTO mapTo(Iden3commProofEntity to) {
    return Iden3commProofDTO(
      id: to.id,
      circuitId: to.circuitId,
      proof: _zkProofBaseMapper.mapTo(to.proof),
      pubSignals: to.pubSignals,
    );
  }
}
