import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/proof/response/iden3comm_proof_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_vp_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_base_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';

import '../dtos/proof/response/iden3comm_sd_proof_dto.dart';

class Iden3commProofMapper
    extends Mapper<Iden3commProofDTO, Iden3commProofEntity> {
  final ZKProofBaseMapper _zkProofBaseMapper;
  final Iden3commVPProofMapper _iden3commVPProofMapper;

  Iden3commProofMapper(this._zkProofBaseMapper, this._iden3commVPProofMapper);

  @override
  Iden3commProofEntity mapFrom(Iden3commProofDTO from) {
    if (from is Iden3commSDProofDTO) {
      return Iden3commSDProofEntity(
          id: from.id,
          circuitId: from.circuitId,
          proof: _zkProofBaseMapper.mapFrom(from.proof),
          pubSignals: from.pubSignals,
          vp: _iden3commVPProofMapper.mapFrom(from.vp));
    } else {
      return Iden3commProofEntity(
        id: from.id,
        circuitId: from.circuitId,
        proof: _zkProofBaseMapper.mapFrom(from.proof),
        pubSignals: from.pubSignals,
      );
    }
  }

  @override
  Iden3commProofDTO mapTo(Iden3commProofEntity to) {
    if (to is Iden3commSDProofEntity) {
      return Iden3commSDProofDTO(
          id: to.id,
          circuitId: to.circuitId,
          proof: _zkProofBaseMapper.mapTo(to.proof),
          pubSignals: to.pubSignals,
          vp: _iden3commVPProofMapper.mapTo(to.vp));
    } else {
      return Iden3commProofDTO(
        id: to.id,
        circuitId: to.circuitId,
        proof: _zkProofBaseMapper.mapTo(to.proof),
        pubSignals: to.pubSignals,
      );
    }
  }
}
