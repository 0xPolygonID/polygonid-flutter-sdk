import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';

import '../iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import '../proof/domain/entities/circuit_data_entity.dart';

abstract class PolygonIdSdkProof {
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge});

  Future<Stream<DownloadInfo>> get initCircuitsDownloadAndGetInfoStream;

  Future<bool> isAlreadyDownloadedCircuitsFromServer();
}

@injectable
class Proof implements PolygonIdSdkProof {
  final GenerateProofUseCase _proveUseCase;
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;

  Proof(
    this._proveUseCase,
    this._downloadCircuitsUseCase,
    this._circuitsFilesExistUseCase,
  );

  @override
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge}) {
    return _proveUseCase.execute(
        param: GenerateProofParam(did, profileNonce ?? 0, 0, claim, request,
            circuitData, privateKey, challenge));
  }

  ///
  @override
  Future<bool> isAlreadyDownloadedCircuitsFromServer() async {
    return _circuitsFilesExistUseCase.execute();
  }

  ///
  @override
  Future<Stream<DownloadInfo>> get initCircuitsDownloadAndGetInfoStream {
    return _downloadCircuitsUseCase.execute();
  }
}
