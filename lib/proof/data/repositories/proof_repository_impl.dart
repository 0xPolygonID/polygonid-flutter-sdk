import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/proof_circuit_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/circuit_type_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/gist_mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/auth_v2/witness_auth.dart';
import 'package:web3dart/contracts.dart';

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;
  final GistMTProofDataSource _gistProofDataSource;
  final ProofCircuitDataSource _proofCircuitDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final CircuitsDownloadDataSource _circuitsDownloadDataSource;
  final RPCDataSource _rpcDataSource;
  final CircuitTypeMapper _circuitTypeMapper;
  final ZKProofMapper _zkProofMapper;
  final AuthProofMapper _authProofMapper;
  final GistMTProofMapper _gistMTProofMapper;
  final CircuitsFilesDataSource _circuitsFilesDataSource;
  final StacktraceManager _stacktraceManager;

  // FIXME: those mappers shouldn't be used here as they are part of Credential
  final ClaimMapper _claimMapper;
  final RevocationStatusMapper _revocationStatusMapper;

  ProofRepositoryImpl(
    this._witnessDataSource,
    this._proverLibDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._gistProofDataSource,
    this._proofCircuitDataSource,
    this._remoteIdentityDataSource,
    this._localContractFilesDataSource,
    this._circuitsDownloadDataSource,
    this._rpcDataSource,
    this._circuitTypeMapper,
    this._zkProofMapper,
    this._claimMapper,
    this._revocationStatusMapper,
    this._authProofMapper,
    this._gistMTProofMapper,
    this._circuitsFilesDataSource,
    this._stacktraceManager,
  );

  @override
  Future<CircuitDataEntity> loadCircuitFiles(String circuitId) async {
    List<Uint8List> circuitFiles =
        await _circuitsFilesDataSource.loadCircuitFiles(circuitId);
    CircuitDataEntity circuitDataEntity =
        CircuitDataEntity(circuitId, circuitFiles[0], circuitFiles[1]);
    return circuitDataEntity;
  }

  @override
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
    Map<String, dynamic>? config,
    String? challenge,
    String? signature,
    String? verifierId,
    String? linkNonce,
    Map<String, dynamic>? scopeParams,
    Map<String, dynamic>? transactionData,
  }) async {
    ClaimDTO credentialDto = _claimMapper.mapTo(claim);
    Map<String, dynamic>? gistProofMap;
    if (gistProof != null) {
      gistProofMap = _gistMTProofMapper.mapTo(gistProof);
    }
    Map<String, dynamic>? incProofMap;
    if (incProof != null) {
      incProofMap = _authProofMapper.mapTo(incProof);
    }

    Map<String, dynamic>? nonRevProofMap;
    if (nonRevProof != null) {
      nonRevProofMap = _authProofMapper.mapTo(nonRevProof);
    }

    _stacktraceManager.addTrace("getProofInputs id: $id");
    _stacktraceManager.addTrace("getProofInputs profileNonce: $profileNonce");
    _stacktraceManager.addTrace(
        "getProofInputs claimSubjectProfileNonce: $claimSubjectProfileNonce");
    _stacktraceManager.addTrace("getProofInputs authClaim: $authClaim");
    _stacktraceManager.addTrace("getProofInputs incProof: $incProofMap");
    _stacktraceManager.addTrace("getProofInputs nonRevProof: $nonRevProofMap");
    _stacktraceManager.addTrace("getProofInputs gistProof: $gistProofMap");
    _stacktraceManager.addTrace("getProofInputs treeState: $treeState");
    _stacktraceManager.addTrace("getProofInputs challenge: $challenge");
    _stacktraceManager.addTrace("getProofInputs signature: $signature");
    _stacktraceManager
        .addTrace("getProofInputs credential: ${credentialDto.info}");
    _stacktraceManager.addTrace("getProofInputs request: $proofScopeRequest");
    _stacktraceManager.addTrace("getProofInputs circuitId: $circuitId");

    String? res;
    try {
      res = await _libPolygonIdCoreProofDataSource.getProofInputs(
        id: id,
        profileNonce: profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        authClaim: authClaim,
        incProof: incProofMap,
        nonRevProof: nonRevProofMap,
        gistProof: gistProofMap,
        treeState: treeState,
        challenge: challenge,
        signature: signature,
        credential: credentialDto.info,
        request: proofScopeRequest,
        circuitId: circuitId,
        config: config,
        verifierId: verifierId,
        linkNonce: linkNonce,
        scopeParams: scopeParams,
        transactionData: transactionData,
      );
    } catch (e) {
      _stacktraceManager.addTrace(
          "[calculateAtomicQueryInputs/libPolygonIdCoreProof] exception $e");
      rethrow;
    }

    if (res.isNotEmpty) {
      _stacktraceManager.addTrace("atomicQueryInputs result: success");
      Uint8List inputsJsonBytes;
      dynamic inputsJson = json.decode(res);
      _stacktraceManager.addTrace("inputJsonType: ${inputsJson.runtimeType}");
      if (inputsJson is Map<String, dynamic>) {
        //Map<String, dynamic> inputs = json.decode(res);
        Uint8List inputsJsonBytes = Uint8ArrayUtils.uint8ListfromString(
            res /*json.encode(inputs["inputs"])*/);
        return inputsJsonBytes;
      } else if (inputsJson is String) {
        Uint8List inputsJsonBytes =
            Uint8ArrayUtils.uint8ListfromString(inputsJson);
        return inputsJsonBytes;
      }
    }

    _stacktraceManager.addTrace(
        "[calculateAtomicQueryInputs/libPolygonIdCoreProof] NullAtomicQueryInputsException");
    throw NullAtomicQueryInputsException(
      id: id,
      errorMessage: "Empty inputs result",
    );
  }

  @override
  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  ) async {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: atomicQueryInputs);

    _stacktraceManager.addTrace(
        "[calculateWitness] circuitData.circuitId ${circuitData.circuitId}");
    CircuitType circuitType = _circuitTypeMapper.mapTo(circuitData.circuitId);
    try {
      Uint8List? witness = await _witnessDataSource.computeWitness(
        type: circuitType,
        param: witnessParam,
      );
      if (witness == null) {
        throw NullWitnessException(
          circuit: circuitType.name,
          errorMessage: "Empty witness result for circuit ${circuitType.name}",
        );
      } else {
        return witness;
      }
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addTrace("[calculateWitness] NullWitnessException");
      throw NullWitnessException(
        circuit: circuitData.circuitId,
        errorMessage:
            "Empty witness result for circuit ${circuitData.circuitId} with error: $error",
        error: error,
      );
    }
  }

  @override
  Future<ZKProofEntity> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes) async {
    try {
      final Map<String, dynamic>? proof = await _proverLibDataSource.prove(
        circuitData.circuitId,
        circuitData.zKeyFile,
        wtnsBytes,
      );

      if (proof == null || proof.isEmpty) {
        _stacktraceManager
            .addTrace("[prove] NullProofException, proof is null");
        throw NullProofException(
          circuit: circuitData.circuitId,
          errorMessage: "Empty proof result",
        );
      }

      final ZKProofEntity zkProof = _zkProofMapper.mapFrom(proof);
      return zkProof;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      throw NullProofException(
        circuit: circuitData.circuitId,
        errorMessage: "Error in _computeProve: $error",
        error: error,
      );
    }
  }

  @override
  Future<bool> isCircuitSupported({required String circuitId}) {
    return Future.value(_circuitTypeMapper.mapTo(circuitId)).then((circuit) =>
        _proofCircuitDataSource.isCircuitSupported(circuit: circuit));
  }

  @override
  Future<GistMTProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress}) async {
    try {
      String gistProofSC = await _getGistProofSC(
        identifier: idAsInt,
        contractAddress: contractAddress,
      );

      String gistProof =
          _libPolygonIdCoreProofDataSource.proofFromSC(gistProofSC);

      return _gistMTProofMapper
          .mapFrom(_gistProofDataSource.getGistMTProof(gistProof));
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      throw FetchGistProofException(
        errorMessage: "Error in getGistProof: $error",
        error: error,
      );
    }
  }

  Future<String> _getGistProofSC(
      {required String identifier, required String contractAddress}) async {
    try {
      DeployedContract contract =
          await _localContractFilesDataSource.loadStateContract(
        contractAddress,
      );
      String gistProof = await _rpcDataSource.getGistProof(
        identifier,
        contract,
      );
      return gistProof;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      throw FetchGistProofException(
        errorMessage: "Error in _getGistProofSC: $error",
        error: error,
      );
    }
  }

  @override
  Stream<DownloadInfo> circuitsDownloadInfoStream(
      {required List<CircuitsToDownloadParam> circuitsToDownload}) async* {
    await for (final downloadResponse
        in _circuitsDownloadDataSource.downloadStream) {
      int progress = downloadResponse.progress;
      int total = downloadResponse.total;

      if (downloadResponse.errorOccurred) {
        yield DownloadInfo.onError(
          errorMessage: downloadResponse.errorMessage,
        );
      }

      if (downloadResponse.done) {
        final int downloadSize = _circuitsDownloadDataSource.downloadSize;

        int totalZipFileSize = 0;

        for (CircuitsToDownloadParam param in circuitsToDownload) {
          if (param.downloadPath == null) {
            continue;
          }
          String pathForZipFileTemp = param.downloadPath!;
          String pathForZipFile = await _circuitsFilesDataSource
              .getPathToCircuitZipFile(circuitsFileName: param.circuitsName);
          String pathForCircuits = await _circuitsFilesDataSource.getPath();

          // we get the size of the temp zip file
          int zipFileSize = _circuitsFilesDataSource.zipFileSize(
              pathToFile: pathForZipFileTemp);

          totalZipFileSize += zipFileSize;

          await _completeWritingFile(
            pathForCircuits: pathForCircuits,
            pathForZipFile: pathForZipFile,
            pathForZipFileTemp: pathForZipFileTemp,
          );
        }

        if (downloadSize != 0 && totalZipFileSize != downloadSize) {
          try {
            // if error we delete the temp file
            for (CircuitsToDownloadParam param in circuitsToDownload) {
              if (param.downloadPath == null) {
                continue;
              }
              String pathForZipFileTemp = param.downloadPath!;
              _circuitsFilesDataSource.deleteFile(pathForZipFileTemp);
            }
          } catch (_) {}

          yield DownloadInfo.onError(
              errorMessage: "Downloaded files incorrect");
        }

        yield DownloadInfo.onDone(
          contentLength: downloadSize,
          downloaded: totalZipFileSize,
        );
      }

      yield DownloadInfo.onProgress(
        contentLength: total,
        downloaded: progress,
      );
    }
  }

  ///
  @override
  Future<void> initCircuitsDownloadFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  }) async {
    for (int i = 0; i < circuitsToDownload.length; i++) {
      CircuitsToDownloadParam param = circuitsToDownload[i];
      String path = await _circuitsFilesDataSource.getPathToCircuitZipFileTemp(
          circuitsFileName: param.circuitsName);
      // we delete the file if it exists
      await _circuitsFilesDataSource.deleteFile(path);
      circuitsToDownload[i].downloadPath = path;
    }
    return _circuitsDownloadDataSource.initStreamedResponseFromServer(
      circuitsToDownload: circuitsToDownload,
    );
  }

  ///
  @override
  Future<bool> circuitsFilesExist({required String circuitsFileName}) {
    return _circuitsFilesDataSource.circuitsFilesExist(
        circuitsFileName: circuitsFileName);
  }

  ///
  Future<void> _completeWritingFile({
    required String pathForZipFileTemp,
    required String pathForZipFile,
    required String pathForCircuits,
  }) async {
    _circuitsFilesDataSource.renameFile(pathForZipFileTemp, pathForZipFile);
    await _circuitsFilesDataSource.writeCircuitsFileFromZip(
      zipPath: pathForZipFile,
      path: pathForCircuits,
    );
  }

  @override
  Future<void> cancelDownloadCircuits() async {
    return _circuitsDownloadDataSource.cancelDownload();
  }
}
