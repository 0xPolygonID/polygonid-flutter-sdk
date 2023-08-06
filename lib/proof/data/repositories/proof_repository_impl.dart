import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/proof_circuit_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
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
  final StacktraceStreamManager _stacktraceStreamManager;

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
    this._stacktraceStreamManager,
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
  Future<Uint8List> calculateAtomicQueryInputs(
      {required String id,
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
      String? signature}) async {
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

    String? res = await _libPolygonIdCoreProofDataSource
        .getProofInputs(
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
    )
        .catchError((error) {
      _stacktraceStreamManager.addTrace(
          "[calculateAtomicQueryInputs/libPolygonIdCoreProof] exception $error");
      throw NullAtomicQueryInputsException(id);
    });

    if (res.isNotEmpty) {
      Uint8List inputsJsonBytes;
      dynamic inputsJson = json.decode(res);
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

    _stacktraceStreamManager.addTrace(
        "[calculateAtomicQueryInputs/libPolygonIdCoreProof] NullAtomicQueryInputsException");
    throw NullAtomicQueryInputsException(id);
  }

  @override
  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  ) {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: atomicQueryInputs);

    _stacktraceStreamManager.addTrace(
        "[calculateWitness] circuitData.circuitId ${circuitData.circuitId}");
    return _witnessDataSource
        .computeWitness(
            type: _circuitTypeMapper.mapTo(circuitData.circuitId),
            param: witnessParam)
        .then((witness) {
      if (witness == null) {
        _stacktraceStreamManager
            .addTrace("[calculateWitness] NullWitnessException");
        throw NullWitnessException(circuitData.circuitId);
      }

      return witness;
    }).catchError(
      (error) {
        _stacktraceStreamManager.addTrace(
            "[calculateWitness] NullWitnessException $error");
        throw NullWitnessException(circuitData.circuitId);
      },
    );
  }

  @override
  Future<ZKProofEntity> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes) {
    return _proverLibDataSource
        .prove(circuitData.circuitId, circuitData.zKeyFile, wtnsBytes)
        .then((proof) {
      if (proof == null) {
        _stacktraceStreamManager.addTrace("[prove] NullProofException");
        throw NullProofException(circuitData.circuitId);
      }

      return _zkProofMapper.mapFrom(proof);
    }).catchError((error) => throw NullProofException(circuitData.circuitId));
  }

  @override
  Future<bool> isCircuitSupported({required String circuitId}) {
    return Future.value(_circuitTypeMapper.mapTo(circuitId)).then((circuit) =>
        _proofCircuitDataSource.isCircuitSupported(circuit: circuit));
  }

  @override
  Future<GistMTProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress}) async {
    String gistProofSC = await _getGistProofSC(
      identifier: idAsInt,
      contractAddress: contractAddress,
    );

    String gistProof =
        _libPolygonIdCoreProofDataSource.proofFromSC(gistProofSC);

    return _gistMTProofMapper
        .mapFrom(_gistProofDataSource.getGistMTProof(gistProof));
  }

  Future<String> _getGistProofSC(
      {required String identifier, required String contractAddress}) {
    return _localContractFilesDataSource
        .loadStateContract(contractAddress)
        .then((contract) => _rpcDataSource
            .getGistProof(identifier, contract)
            .catchError((error) => throw FetchGistProofException(error)));
  }

  @override
  Stream<DownloadInfo> get circuitsDownloadInfoStream async* {
    String pathForZipFileTemp =
        await _circuitsFilesDataSource.getPathToCircuitZipFileTemp();
    String pathForZipFile =
        await _circuitsFilesDataSource.getPathToCircuitZipFile();
    String pathForCircuits = await _circuitsFilesDataSource.getPath();

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

        // we get the size of the temp zip file
        int zipFileSize = _circuitsFilesDataSource.zipFileSize(
            pathToFile: pathForZipFileTemp);

        if (downloadSize != 0 && zipFileSize != downloadSize) {
          try {
            // if error we delete the temp file
            _circuitsFilesDataSource.deleteFile(pathForZipFileTemp);
          } catch (_) {}

          yield DownloadInfo.onError(
              errorMessage: "Downloaded files incorrect");
        }

        await _completeWritingFile(
          pathForCircuits: pathForCircuits,
          pathForZipFile: pathForZipFile,
          pathForZipFileTemp: pathForZipFileTemp,
        );

        yield DownloadInfo.onDone(
          contentLength: downloadSize,
          downloaded: zipFileSize,
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
  Future<void> initCircuitsDownloadFromServer() {
    return _circuitsFilesDataSource.getPathToCircuitZipFileTemp().then(
        (pathForZipFileTemp) =>
            // We delete eventual temp zip file downloaded before
            _circuitsFilesDataSource.deleteFile(pathForZipFileTemp).then((_) =>
                // Init download
                _circuitsDownloadDataSource
                    .initStreamedResponseFromServer(pathForZipFileTemp)));
  }

  ///
  @override
  Future<bool> circuitsFilesExist() {
    return _circuitsFilesDataSource.circuitsFilesExist();
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
