import '../../../credential/data/dtos/claim_info_dto.dart';
import '../../../iden3comm/domain/entities/request/auth/proof_scope_request.dart';

enum AtomicQueryInputsType { mtp, sig, mtponchain, sigonchain }

class AtomicQueryInputsParam {
  final AtomicQueryInputsType type;
  final String id;
  final int profileNonce;
  final int claimSubjectProfileNonce;
  final ClaimInfoDTO credential;
  final ProofScopeRequest request;

  AtomicQueryInputsParam(
    this.type,
    this.id,
    this.profileNonce,
    this.claimSubjectProfileNonce,
    this.credential,
    this.request,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileNonce": profileNonce.toString(),
        "claimSubjectProfileNonce": claimSubjectProfileNonce.toString(),
        "verifiableCredentials": credential.toJson(),
        "request": request.toJson(),
      };
}
