import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart';

class GetAuthInputsParam {
  final String challenge;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  GetAuthInputsParam(
      this.challenge, this.genesisDid, this.profileNonce, this.privateKey);
}

class GetAuthInputsUseCase
    extends FutureUseCase<GetAuthInputsParam, Uint8List> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final GetGistMTProofUseCase _getGistMTProofUseCase;
  final GetLatestStateUseCase _getLatestStateUseCase;
  final Iden3commRepository _iden3commRepository;
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final StacktraceManager _stacktraceManager;

  GetAuthInputsUseCase(
    this._getIdentityUseCase,
    this._getAuthClaimUseCase,
    this._signMessageUseCase,
    this._getGistMTProofUseCase,
    this._getLatestStateUseCase,
    this._iden3commRepository,
    this._identityRepository,
    this._smtRepository,
    this._stacktraceManager,
  );

  @override
  Future<Uint8List> execute({required GetAuthInputsParam param}) async {
    IdentityEntity identity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: param.genesisDid, privateKey: param.privateKey));

    _stacktraceManager.addTrace("[GetAuthInputsUseCase] Identity: $identity");

    List<String> authClaim =
        await _getAuthClaimUseCase.execute(param: identity.publicKey);
    _stacktraceManager
        .addTrace("[GetAuthInputsUseCase] Auth claim: ${authClaim.toString()}");
    NodeEntity authClaimNode =
        await _identityRepository.getAuthClaimNode(children: authClaim);
    _stacktraceManager.addTrace("[GetAuthInputsUseCase] Auth claim node");

    MTProofEntity incProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        type: TreeType.claims,
        did: param.genesisDid,
        privateKey: param.privateKey);
    _stacktraceManager
        .addTrace("[GetAuthInputsUseCase] Inc proof: ${incProof.toString()}");

    MTProofEntity nonRevProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        type: TreeType.revocation,
        did: param.genesisDid,
        privateKey: param.privateKey);
    _stacktraceManager.addTrace("[GetAuthInputsUseCase] Non rev proof");

    // hash of clatr, revtr, rootr
    Map<String, dynamic> treeState = await _getLatestStateUseCase.execute(
        param: GetLatestStateParam(
            did: param.genesisDid, privateKey: param.privateKey));

    _stacktraceManager
        .addTrace("[GetAuthInputsUseCase] Tree state: ${treeState.toString()}");

    GistMTProofEntity gistProof =
        await _getGistMTProofUseCase.execute(param: param.genesisDid);
    _stacktraceManager
        .addTrace("[GetAuthInputsUseCase] Gist proof: ${gistProof.toString()}");

    return _signMessageUseCase
        .execute(param: SignMessageParam(param.privateKey, param.challenge))
        .then((signature) => _iden3commRepository.getAuthInputs(
            genesisDid: param.genesisDid,
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
      _stacktraceManager
          .addTrace("[GetAuthInputsUseCase] Auth inputs: success");
      return inputs;
    }).catchError((error) {
      logger().e("[GetAuthInputsUseCase] Error: $error");
      _stacktraceManager
          .addTrace("[GetAuthInputsUseCase] Error: ${error.toString()}");
      _stacktraceManager.addError("[GetAuthInputsUseCase] Error: $error");
      throw error;
    });
  }
}
