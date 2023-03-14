import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/tuples.dart';
import '../../../common/domain/use_case.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../iden3comm/domain/entities/jwz_proof_entity.dart';
import '../../../identity/domain/entities/did_entity.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../identity/domain/entities/node_entity.dart';
import '../../../identity/domain/use_cases/identity/get_identity_use_case.dart';
import '../../../identity/domain/use_cases/sign_message_use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../entities/gist_proof_entity.dart';
import '../entities/jwz/jwz_proof.dart';
import '../entities/proof_entity.dart';
import '../repositories/proof_repository.dart';
import 'get_gist_proof_use_case.dart';
import 'prove_use_case.dart';

class GenerateProofParam {
  final String did;
  final int profileNonce;
  final int claimSubjectProfileNonce;
  final ClaimEntity credential;
  final ProofScopeRequest request; //FIXME: this is not from proof
  final CircuitDataEntity circuitData;

  /// FIXME: remove nullables
  final String? privateKey;
  final String? challenge;

  GenerateProofParam(
      this.did,
      this.profileNonce,
      this.claimSubjectProfileNonce,
      this.credential,
      this.request,
      this.circuitData,
      this.privateKey,
      this.challenge);
}

class GenerateProofUseCase
    extends FutureUseCase<GenerateProofParam, JWZProofEntity> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final ProofRepository _proofRepository;
  final ProveUseCase _proveUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final GetGistProofUseCase _getGistProofUseCase;
  final GetDidUseCase _getDidUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final GetLatestStateUseCase _getLatestStateUseCase;

  GenerateProofUseCase(
    this._identityRepository,
    this._smtRepository,
    this._proofRepository,
    this._proveUseCase,
    this._getIdentityUseCase,
    this._getAuthClaimUseCase,
    this._getGistProofUseCase,
    this._getDidUseCase,
    this._signMessageUseCase,
    this._getLatestStateUseCase,
  );

  @override
  Future<JWZProofEntity> execute({required GenerateProofParam param}) async {
    List<String>? authClaim;
    ProofEntity? incProof;
    ProofEntity? nonRevProof;
    GistProofEntity? gistProof;
    Map<String, dynamic>? treeState;
    String? signature;
    if (param.request.circuitId == "credentialAtomicQueryMTPV2OnChain" ||
        param.request.circuitId == "credentialAtomicQuerySigV2OnChain") {
      IdentityEntity identity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.did, privateKey: param.privateKey));
      authClaim = await _getAuthClaimUseCase.execute(param: identity.publicKey);
      NodeEntity authClaimNode =
          await _identityRepository.getAuthClaimNode(children: authClaim);

      incProof = await _smtRepository.generateProof(
          key: authClaimNode.hash,
          type: TreeType.claims,
          did: param.did,
          privateKey: param.privateKey!);

      nonRevProof = await _smtRepository.generateProof(
          key: authClaimNode.hash,
          type: TreeType.revocation,
          did: param.did,
          privateKey: param.privateKey!);

      // hash of clatr, revtr, rootr
      treeState = await _getLatestStateUseCase.execute(
          param: GetLatestStateParam(
              did: param.did, privateKey: param.privateKey!));

      gistProof = await _getGistProofUseCase.execute(param: param.did);

      signature = await _signMessageUseCase.execute(
          param: SignMessageParam(param.privateKey!, param.challenge!));
    }

    DidEntity didEntity = await _getDidUseCase.execute(param: param.did);

    // Prepare atomic query inputs
    Uint8List res = await _proofRepository
        .calculateAtomicQueryInputs(
      id: didEntity.identifier,
      profileNonce: param.profileNonce,
      claimSubjectProfileNonce: param.claimSubjectProfileNonce,
      authClaim: authClaim,
      incProof: incProof,
      nonRevProof: nonRevProof,
      gistProof: gistProof,
      treeState: treeState,
      challenge: param.challenge,
      signature: signature,
      claim: param.credential,
      request: param.request,
    )
        .catchError((error) {
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });

    dynamic inputsJson = json.decode(Uint8ArrayUtils.uint8ListToString(res));
    Uint8List atomicQueryInputs =
        Uint8ArrayUtils.uint8ListfromString(json.encode(inputsJson["inputs"]));

    var vpProof;
    if (inputsJson["verifiablePresentation"] != null) {
      vpProof = JWZVPProof.fromJson(inputsJson["verifiablePresentation"]);
    }

    // Prove
    return _proveUseCase
        .execute(param: ProveParam(atomicQueryInputs, param.circuitData))
        .then((proof) {
      logger().i("[GenerateProofUseCase] proof: $proof");

      if (vpProof != null) {
        return JWZSDProofEntity(
            id: param.request.id,
            circuitId: param.circuitData.circuitId,
            proof: proof.proof,
            pubSignals: proof.pubSignals,
            vp: vpProof);
      } else {
        return JWZProofEntity(
          id: param.request.id,
          circuitId: param.circuitData.circuitId,
          proof: proof.proof,
          pubSignals: proof.pubSignals,
        );
      }
    }).catchError((error) {
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });
  }
}
