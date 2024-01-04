import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_vp_proof.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

class GenerateIden3commProofParam {
  final String did;
  final BigInt profileNonce;
  final BigInt claimSubjectProfileNonce;
  final ClaimEntity credential;
  final ProofScopeRequest request;
  final CircuitDataEntity circuitData;

  /// FIXME: remove nullables
  final String? privateKey;
  final String? challenge;

  final String? ethereumUrl;
  final String? stateContractAddr;
  final String? ipfsNodeURL;

  GenerateIden3commProofParam(
    this.did,
    this.profileNonce,
    this.claimSubjectProfileNonce,
    this.credential,
    this.request,
    this.circuitData,
    this.privateKey,
    this.challenge,
    this.ethereumUrl,
    this.stateContractAddr,
    this.ipfsNodeURL,
  );
}

class GenerateIden3commProofUseCase
    extends FutureUseCase<GenerateIden3commProofParam, Iden3commProofEntity> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final ProofRepository _proofRepository;
  final ProveUseCase _proveUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final GetGistMTProofUseCase _getGistMTProofUseCase;
  final GetDidUseCase _getDidUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final GetLatestStateUseCase _getLatestStateUseCase;
  final StacktraceManager _stacktraceManager;

  GenerateIden3commProofUseCase(
    this._identityRepository,
    this._smtRepository,
    this._proofRepository,
    this._proveUseCase,
    this._getIdentityUseCase,
    this._getAuthClaimUseCase,
    this._getGistMTProofUseCase,
    this._getDidUseCase,
    this._signMessageUseCase,
    this._getLatestStateUseCase,
    this._stacktraceManager,
  );

  @override
  Future<Iden3commProofEntity> execute({
    required GenerateIden3commProofParam param,
  }) async {
    List<String>? authClaim;
    MTProofEntity? incProof;
    MTProofEntity? nonRevProof;
    GistMTProofEntity? gistProof;
    Map<String, dynamic>? treeState;
    Map<String, dynamic>? config;
    String? signature;

    logger().i("[GenerateIden3commProofUseCase] claim:");
    logger().i(param.credential.toJson());

    Stopwatch stopwatch = Stopwatch()..start();

    if (param.request.circuitId == "credentialAtomicQueryMTPV2OnChain" ||
        param.request.circuitId == "credentialAtomicQuerySigV2OnChain") {
      //on chain start
      _stacktraceManager.addTrace(
          "[GenerateIden3commProofUseCase] OnChain ${param.request.circuitId}");

      IdentityEntity identity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.did, privateKey: param.privateKey));
      _stacktraceManager.addTrace(
          "[GenerateIden3commProofUseCase] identity: ${identity.did}");
      logger().i(
          "GENERATION PROOF getIdentityUseCase executed in ${stopwatch.elapsed}");

      authClaim = await _getAuthClaimUseCase.execute(param: identity.publicKey);
      logger().i(
          "GENERATION PROOF getAuthClaimUseCase executed in ${stopwatch.elapsed}");

      NodeEntity authClaimNode =
          await _identityRepository.getAuthClaimNode(children: authClaim);

      _stacktraceManager
          .addTrace("[GenerateIden3commProofUseCase] authClaimNode");
      logger().i(
          "GENERATION PROOF getAuthClaimNode executed in ${stopwatch.elapsed}");

      incProof = await _smtRepository.generateProof(
          key: authClaimNode.hash,
          type: TreeType.claims,
          did: param.did,
          privateKey: param.privateKey!);
      _stacktraceManager.addTrace("[GenerateIden3commProofUseCase] incProof");
      logger().i("GENERATION PROOF incProof executed in ${stopwatch.elapsed}");

      nonRevProof = await _smtRepository.generateProof(
          key: authClaimNode.hash,
          type: TreeType.revocation,
          did: param.did,
          privateKey: param.privateKey!);
      _stacktraceManager
          .addTrace("[GenerateIden3commProofUseCase] nonRevProof");
      logger()
          .i("GENERATION PROOF nonRevProof executed in ${stopwatch.elapsed}");

      // hash of clatr, revtr, rootr
      treeState = await _getLatestStateUseCase.execute(
          param: GetLatestStateParam(
              did: param.did, privateKey: param.privateKey!));
      _stacktraceManager.addTrace("[GenerateIden3commProofUseCase] treeState");
      logger().i("GENERATION PROOF treeState executed in ${stopwatch.elapsed}");

      gistProof = await _getGistMTProofUseCase.execute(param: param.did);
      _stacktraceManager.addTrace("[GenerateIden3commProofUseCase] gistProof");
      logger().i("GENERATION PROOF gistProof executed in ${stopwatch.elapsed}");

      signature = await _signMessageUseCase.execute(
          param: SignMessageParam(param.privateKey!, param.challenge!));
      _stacktraceManager.addTrace("[GenerateIden3commProofUseCase] signature");
      //onchain end
      logger().i("GENERATION PROOF signature executed in ${stopwatch.elapsed}");
    }

    if (param.ethereumUrl != null &&
        param.stateContractAddr != null &&
        param.ipfsNodeURL != null) {
      config = AtomicQueryInputsConfigParam(
              ethereumUrl: param.ethereumUrl!,
              stateContractAddr: param.stateContractAddr!,
              ipfsNodeURL: param.ipfsNodeURL!)
          .toJson();
      _stacktraceManager.addTrace(
          "[GenerateIden3commProofUseCase] AtomicQueryInputsConfigParam: success");
    }

    DidEntity didEntity = await _getDidUseCase.execute(param: param.did);
    _stacktraceManager.addTrace(
        "[GenerateIden3commProofUseCase] didEntity: ${didEntity.did}");
    logger().i("GENERATION PROOF didEntity executed in ${stopwatch.elapsed}");

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
      proofScopeRequest: param.request.toJson(),
      circuitId: param.request.circuitId,
      config: config,
    )
        .catchError((error) {
      _stacktraceManager
          .addTrace("[GenerateIden3commProofUseCase] Error: $error");
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });
    _stacktraceManager
        .addTrace("[GenerateIden3commProofUseCase] atomicQueryInputs: success");
    logger().i(
        "GENERATION PROOF calculateAtomicQueryInputs executed in ${stopwatch.elapsed}");

    final inputsString = Uint8ArrayUtils.uint8ListToString(res);
    dynamic inputsJson = json.decode(inputsString);

    _stacktraceManager.addTrace(
      "[GenerateIden3commProofUseCase][MainFlow] atomic inputs JSON:$inputsString",
      log: true,
    );

    Uint8List atomicQueryInputs =
        Uint8ArrayUtils.uint8ListfromString(json.encode(inputsJson["inputs"]));

    var vpProof;
    if (inputsJson["verifiablePresentation"] != null) {
      vpProof = Iden3commVPProof.fromJson(inputsJson["verifiablePresentation"]);
    }

    logger().i('[GenerateIden3commProofUseCase] verifiablePresentation:');
    logger().i(vpProof ?? inputsJson["verifiablePresentation"]);

    logger().i(
        "GENERATION PROOF atomicQueryInputs executed in ${stopwatch.elapsed}");

    // Prove
    return _proveUseCase
        .execute(param: ProveParam(atomicQueryInputs, param.circuitData))
        .then((proof) {
      _stacktraceManager.addTrace(
        "[GenerateIden3commProofUseCase][MainFlow] proof: ${jsonEncode(proof.toJson())}",
        log: true,
      );

      if (vpProof != null) {
        return Iden3commSDProofEntity(
            id: param.request.id,
            circuitId: param.circuitData.circuitId,
            proof: proof.proof,
            pubSignals: proof.pubSignals,
            vp: vpProof);
      } else {
        return Iden3commProofEntity(
          id: param.request.id,
          circuitId: param.circuitData.circuitId,
          proof: proof.proof,
          pubSignals: proof.pubSignals,
        );
      }
    }).catchError((error) {
      _stacktraceManager.addTrace(
          "[GenerateIden3commProofUseCase] proveUseCase Error: $error");
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });
  }
}
