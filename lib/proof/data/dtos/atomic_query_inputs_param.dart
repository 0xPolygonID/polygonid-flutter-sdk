import '../../../credential/data/dtos/claim_info_dto.dart';
import '../../../iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'gist_proof_dto.dart';

enum AtomicQueryInputsType { mtp, sig, mtponchain, sigonchain }

class AtomicQueryInputsParam {
  final AtomicQueryInputsType type;
  final String id;
  final BigInt profileNonce;
  final BigInt claimSubjectProfileNonce;
  final List<String>? authClaim;
  final Map<String, dynamic>? incProof;
  final Map<String, dynamic>? nonRevProof;
  final Map<String, dynamic>? gistProof;
  final Map<String, dynamic>? treeState;
  final String? challenge;
  final String? signature;
  final Map<String, dynamic> credential;
  final Map<String, dynamic> request;

  AtomicQueryInputsParam({
    required this.type,
    required this.id,
    required this.profileNonce,
    required this.claimSubjectProfileNonce,
    this.authClaim,
    this.incProof,
    this.nonRevProof,
    this.treeState,
    this.gistProof,
    this.challenge,
    this.signature,
    required this.credential,
    required this.request,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileNonce": profileNonce.toString(),
        "claimSubjectProfileNonce": claimSubjectProfileNonce.toString(),
        "authClaim": authClaim,
        "authClaimIncMtp": incProof,
        "authClaimNonRevMtp": nonRevProof,
        "gistProof": gistProof,
        "treeState": treeState,
        "challenge": challenge,
        "signature": signature,
        "verifiableCredentials": credential,
        "request": request,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);
}
