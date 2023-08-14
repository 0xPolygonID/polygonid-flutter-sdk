import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/cancel_download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/tuples.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_zkproof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

abstract class PolygonIdSdkProof {
  Future<ZKProofEntity> prove(
      {required String identifier,
      required BigInt profileNonce,
      required BigInt claimSubjectProfileNonce,
      required ClaimEntity credential,
      required CircuitDataEntity circuitData,
      required Map<String, dynamic> proofScopeRequest,
      List<String>? authClaim,
      MTProofEntity? incProof,
      MTProofEntity? nonRevProof,
      GistMTProofEntity? gistProof,
      Map<String, dynamic>? treeState,
      String? challenge,
      String? signature,
      Map<String, dynamic>? config});

  Stream<DownloadInfo> get initCircuitsDownloadAndGetInfoStream;

  Future<bool> isAlreadyDownloadedCircuitsFromServer();

  Stream<String> proofGenerationStepsStream();

  Future<void> cancelDownloadCircuits();
}

@injectable
class Proof implements PolygonIdSdkProof {
  final GenerateZKProofUseCase generateZKProofUseCase;
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final CancelDownloadCircuitsUseCase _cancelDownloadCircuitsUseCase;
  final StacktraceManager _stacktraceManager;

  Proof(
    this.generateZKProofUseCase,
    this._downloadCircuitsUseCase,
    this._circuitsFilesExistUseCase,
    this._proofGenerationStepsStreamManager,
    this._cancelDownloadCircuitsUseCase,
    this._stacktraceManager,
  );

  @override
  Future<ZKProofEntity> prove(
      {required String identifier,
      required BigInt profileNonce,
      required BigInt claimSubjectProfileNonce,
      required ClaimEntity credential,
      required CircuitDataEntity circuitData,
      required Map<String, dynamic> proofScopeRequest,
      List<String>? authClaim,
      MTProofEntity? incProof,
      MTProofEntity? nonRevProof,
      GistMTProofEntity? gistProof,
      Map<String, dynamic>? treeState,
      String? challenge,
      String? signature,
      Map<String, dynamic>? config}) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Proof.prove called");
    return generateZKProofUseCase.execute(
        param: GenerateZKProofParam(
            identifier,
            profileNonce,
            claimSubjectProfileNonce,
            credential,
            circuitData,
            authClaim,
            incProof,
            nonRevProof,
            gistProof,
            treeState,
            challenge,
            signature,
            proofScopeRequest,
            config));
  }

  ///
  @override
  Future<bool> isAlreadyDownloadedCircuitsFromServer() async {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
        "PolygonIdSdk.Proof.isAlreadyDownloadedCircuitsFromServer called");
    return _circuitsFilesExistUseCase.execute();
  }

  ///
  @override
  Stream<DownloadInfo> get initCircuitsDownloadAndGetInfoStream {
    return _downloadCircuitsUseCase.execute();
  }

  /// Returns a [Stream] of [String] of proof generation steps
  @override
  Stream<String> proofGenerationStepsStream() {
    return _proofGenerationStepsStreamManager.proofGenerationStepsStream;
  }

  /// Cancel the download of circuits
  @override
  Future<void> cancelDownloadCircuits() async {
    _stacktraceManager.clear();
    _stacktraceManager
        .addTrace("PolygonIdSdk.Proof.cancelDownloadCircuits called");
    return _cancelDownloadCircuitsUseCase.execute();
  }
}
