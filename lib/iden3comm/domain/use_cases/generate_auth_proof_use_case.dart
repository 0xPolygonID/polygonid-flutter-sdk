import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

const _tag = "GenerateAuthProofUseCase";

class GenerateAuthProofParam {
  final String genesisDid;
  final String privateKey;
  final BigInt profileNonce;
  final int requestId;
  final String circuitId;
  final String challenge;

  GenerateAuthProofParam({
    required this.genesisDid,
    required this.privateKey,
    required this.profileNonce,
    this.requestId = 0,
    required this.circuitId,
    required this.challenge,
  });
}

class GenerateAuthProofUseCase
    extends FutureUseCase<GenerateAuthProofParam, Iden3commProofEntity> {
  final GetAuthInputsUseCase _getAuthInputsUseCase;
  final ProofRepository _proofRepository;
  final StacktraceManager _stacktraceManager;

  GenerateAuthProofUseCase(
    this._getAuthInputsUseCase,
    this._proofRepository,
    this._stacktraceManager,
  );

  @override
  Future<Iden3commProofEntity> execute({
    required GenerateAuthProofParam param,
  }) async {
    Stopwatch stopwatch = Stopwatch()..start();
    logger().logTimestamp(stopwatch, 'started', tag: _tag);

    try {
      final generateInputsResponse = await _getAuthInputsUseCase.execute(
        param: GetAuthInputsParam(
          challenge: param.challenge,
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          privateKey: param.privateKey,
          encryptionKey: param.privateKey,
          circuitId: CircuitId.fromId(param.circuitId),
        ),
      );

      final authInputs = jsonEncode(generateInputsResponse.inputs);

      logger().logTimestamp(stopwatch, "generateInputsResponse", tag: _tag);

      final optimizedCircuitId =
          generateInputsResponse.circuitId ?? param.circuitId;

      final circuitData = await _proofRepository.loadCircuitFiles(
        optimizedCircuitId,
      );

      logger().logTimestamp(stopwatch, "loadCircuitFiles", tag: _tag);

      final witnessBytes = await _proofRepository.calculateWitness(
        circuitData: circuitData,
        inputs: authInputs,
      );

      logger().logTimestamp(stopwatch, "calculateWitness", tag: _tag);

      final zkProofEntity = await _proofRepository.prove(
        circuitData: circuitData,
        wtnsBytes: witnessBytes,
      );

      logger().logTimestamp(stopwatch, "prove", tag: _tag);

      return Iden3commProofEntity(
        id: param.requestId,
        circuitId: param.circuitId,
        proof: zkProofEntity.proof,
        pubSignals: zkProofEntity.pubSignals,
        publicStatesInfo: generateInputsResponse.publicStatesInfo,
      );
    } catch (e) {
      _stacktraceManager.logError("[GenerateAuthProofUseCase] Exception: $e");
      rethrow;
    }
  }
}
