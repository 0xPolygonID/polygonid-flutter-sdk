import 'gist_proof_dto.dart';
import 'proof_dto.dart';

enum PrepareInputsType { auth, mtp, sig }

class PrepareInputsParam {
  final PrepareInputsType type;
  final String did;
  final int profileNonce;
  final List<String> authClaim;
  final ProofDTO incProof;
  final ProofDTO nonRevProof;
  final GistProofDTO gistProof;
  final Map<String, dynamic> treeState;
  final String challenge;
  final String signature;

  PrepareInputsParam(
    this.type,
    this.did,
    this.profileNonce,
    this.authClaim,
    this.incProof,
    this.nonRevProof,
    this.gistProof,
    this.treeState,
    this.challenge,
    this.signature,
  );
}
