import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/sign_message_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_proof_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

class GetAuthInputsParam {
  final String challenge;
  final String did;
  final int profileNonce;
  final String privateKey;

  GetAuthInputsParam(
      this.challenge, this.did, this.profileNonce, this.privateKey);
}

class GetAuthInputsUseCase
    extends FutureUseCase<GetAuthInputsParam, Uint8List> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final GetGistProofUseCase _getGistProofUseCase;
  final GetLatestStateUseCase _getLatestStateUseCase;
  final Iden3commRepository _iden3commRepository;
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;

  GetAuthInputsUseCase(
    this._getIdentityUseCase,
    this._getAuthClaimUseCase,
    this._signMessageUseCase,
    this._getGistProofUseCase,
    this._getLatestStateUseCase,
    this._iden3commRepository,
    this._identityRepository,
    this._smtRepository,
  );

  @override
  Future<Uint8List> execute({required GetAuthInputsParam param}) async {
    IdentityEntity identity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: param.did, privateKey: param.privateKey));
    List<String> authClaim =
        await _getAuthClaimUseCase.execute(param: identity.publicKey);
    NodeEntity authClaimNode =
        await _identityRepository.getAuthClaimNode(children: authClaim);

    ProofEntity incProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        type: TreeType.claims,
        did: param.did,
        privateKey: param.privateKey);

    ProofEntity nonRevProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        type: TreeType.revocation,
        did: param.did,
        privateKey: param.privateKey);

    // hash of clatr, revtr, rootr
    Map<String, dynamic> treeState = await _getLatestStateUseCase.execute(
        param:
            GetLatestStateParam(did: param.did, privateKey: param.privateKey));

    GistProofEntity gistProof =
        await _getGistProofUseCase.execute(param: param.did);

    return _signMessageUseCase
        .execute(param: SignMessageParam(param.privateKey, param.challenge))
        .then((signature) => _iden3commRepository.getAuthInputs(
            did: identity.profiles[param.profileNonce] ?? identity.did,
            profileNonce: param.profileNonce,
            challenge: param.challenge,
            authClaim: authClaim,
            identity: identity,
            signature: signature,
            incProof: incProof,
            nonRevProof: nonRevProof,
            gistProof: gistProof,
            treeState: treeState))
        .then((inputs) {
      logger().i("[GetAuthInputsUseCase] Auth inputs: $inputs");

      return inputs;
    }).catchError((error) {
      logger().e("[GetAuthInputsUseCase] Error: $error");

      throw error;
    });
  }
}
