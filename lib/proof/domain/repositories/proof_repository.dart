import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

abstract class ProofRepository {
  Future<bool> isCircuitSupported({required String circuitId});

  Future<CircuitDataEntity> loadCircuitFiles(String circuitId);

  Future<Uint8List> calculateAtomicQueryInputs({
    required String id,
    required BigInt profileNonce,
    required BigInt claimSubjectProfileNonce,
    required ClaimEntity claim,
    required Map<String, dynamic> proofScopeRequest,
    required String circuitId,
    MTProofEntity? incProof,
    MTProofEntity? nonRevProof,
    GistMTProofEntity? gistProof,
    List<String>? authClaim,
    Map<String, dynamic>? treeState,
    String? challenge,
    String? signature,
    Map<String, dynamic>? config,
    String? verifierId,
    String? linkNonce,
    Map<String, dynamic>? scopeParams,
    Map<String, dynamic>? transactionData,
  });

  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  );

  Future<ZKProofEntity> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes);

  Future<GistMTProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress});

  Stream<DownloadInfo> circuitsDownloadInfoStream(
      {required List<CircuitsToDownloadParam> circuitsToDownload});

  Future<bool> circuitsFilesExist({required String circuitsFileName});

  Future<void> initCircuitsDownloadFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  });

  Future<void> cancelDownloadCircuits();
}
