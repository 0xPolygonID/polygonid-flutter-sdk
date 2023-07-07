

import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/proof/response/iden3comm_vp_proof_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_vp_proof.dart';

class Iden3commVPProofMapper
    extends Mapper<Iden3commVPProofDTO, Iden3commVPProof> {

  @override
  Iden3commVPProof mapFrom(Iden3commVPProofDTO from) {
    return Iden3commVPProof(
      context: from.context,
      type: from.type,
      verifiableCredential: from.verifiableCredential,
    );
  }

  @override
  Iden3commVPProofDTO mapTo(Iden3commVPProof to) {
      return Iden3commVPProofDTO(
        context: to.context,
        type: to.type,
        verifiableCredential: to.verifiableCredential,
      );

  }
}
