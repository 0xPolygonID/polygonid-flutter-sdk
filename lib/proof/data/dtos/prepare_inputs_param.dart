import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';

enum PrepareInputsType { auth, mtp, sig }

class PrepareInputsParam {
  final PrepareInputsType type;
  final String did;
  final int profileNonce;
  final List<String> authClaim;
  final MTProofEntity incProof;
  final MTProofEntity nonRevProof;
  final GistMTProofEntity gistProof;
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
