import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:polygonid_flutter_sdk/common/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/local_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/local_proof_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/circuit_type_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/gist_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/jwz_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/jwz_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/proof_circuit_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/rpc_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;
  final LocalProofFilesDataSource _localProofFilesDataSource;
  final ProofCircuitDataSource _proofCircuitDataSource;
  final CircuitsDownloadDataSource _circuitsDownloadDataSource;
  final CircuitTypeMapper _circuitTypeMapper;
  final JWZProofMapper _jwzProofMapper;
  final JWZMapper _jwzMapper;
  final AuthProofMapper _authProofMapper;
  final GistProofMapper _gistProofMapper;
  final LocalProofDataSource _localProofDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final RPCProofDataSource _rpcProofDataSource;

  ProofRepositoryImpl(
    this._witnessDataSource,
    this._proverLibDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._localProofFilesDataSource,
    this._proofCircuitDataSource,
    this._circuitsDownloadDataSource,
    this._localProofDataSource,
    this._localContractFilesDataSource,
    this._rpcProofDataSource,
    this._circuitTypeMapper,
    this._jwzProofMapper,
    this._jwzMapper,
    this._authProofMapper,
    this._gistProofMapper,
  );

  @override
  Future<CircuitDataEntity> loadCircuitFiles(String circuitId) async {
    List<Uint8List> circuitFiles =
        await _localProofFilesDataSource.loadCircuitFiles(circuitId);
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
      required ProofScopeRequest request,
      ProofEntity? incProof,
      ProofEntity? nonRevProof,
      GistProofEntity? gistProof,
      List<String>? authClaim,
      TreeStateEntity? treeState,
      String? challenge,
      String? signature}) async {
    Map<String, dynamic>? gistProofMap;
    if (gistProof != null) {
      gistProofMap = _gistProofMapper.mapTo(gistProof).toJson();
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
          treeState: treeState?.toJson(),
          challenge: challenge,
          signature: signature,
          credential: claim.info,
          request: request,
        )
        .catchError((error) => throw NullAtomicQueryInputsException(id));

    if (res != null && res.isNotEmpty) {
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

    throw NullAtomicQueryInputsException(id);
  }

  @override
  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  ) {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: atomicQueryInputs);

    return _witnessDataSource
        .computeWitness(
            type: _circuitTypeMapper.mapTo(circuitData.circuitId),
            param: witnessParam)
        .then((witness) {
      if (witness == null) {
        throw NullWitnessException(circuitData.circuitId);
      }

      return witness;
    }).catchError((error) => throw NullWitnessException(circuitData.circuitId));
  }

  @override
  Future<JWZProof> prove(CircuitDataEntity circuitData, Uint8List wtnsBytes) {
    return _proverLibDataSource
        .prove(circuitData.circuitId, circuitData.zKeyFile, wtnsBytes)
        .then((proof) {
      if (proof == null) {
        throw NullProofException(circuitData.circuitId);
      }

      return _jwzProofMapper.mapFrom(proof);
    }).catchError((error) => throw NullProofException(circuitData.circuitId));
  }

  @override
  Future<bool> isCircuitSupported({required String circuitId}) {
    return Future.value(_circuitTypeMapper.mapTo(circuitId)).then((circuit) =>
        _proofCircuitDataSource.isCircuitSupported(circuit: circuit));
  }

  @override
  Future<String> encodeJWZ({required JWZEntity jwz}) {
    return Future.value(_jwzMapper.mapFrom(jwz));
  }

  @override
  Future<GistProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress}) async {
    String gistProofSC = await _localContractFilesDataSource
        .loadStateContract(contractAddress)
        .then((contract) => _rpcProofDataSource.getGistProof(idAsInt, contract))
        .catchError((error) => throw FetchGistProofException(error));

    String gistProof =
        _libPolygonIdCoreProofDataSource.proofFromSC(gistProofSC);

    // remove all quotes from the string values
    final gistProof2 = gistProof.replaceAll("\"", "");

    // now we add quotes to both keys and Strings values
    final quotedString =
        gistProof2.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
      return '"${match.group(0)}"';
    });

    Map<String, dynamic> gistProofJson = jsonDecode(quotedString);

    return _gistProofMapper
        .mapFrom(_localProofDataSource.getGistProof(gistProofJson));
  }

  ///
  StreamController<DownloadInfo> _downloadInfoController =
      StreamController.broadcast();

  ///
  @override
  Stream<DownloadInfo> get circuitsDownloadInfoStream =>
      _downloadInfoController.stream;

  ///
  @override
  Future<void> initCircuitsDownloadFromServer() async {
    String pathForZipFileTemp =
        await _circuitsDownloadDataSource.getPathToCircuitZipFileTemp();
    String pathForZipFile =
        await _circuitsDownloadDataSource.getPathToCircuitZipFile();
    String pathForCircuits = await _circuitsDownloadDataSource.getPath();
    http.StreamedResponse serverResponse =
        await _circuitsDownloadDataSource.getStreamedResponseFromServer();

    final int downloadSize = serverResponse.contentLength ?? 0;

    // We delete eventual temp zip file downloaded before
    _circuitsDownloadDataSource.deleteFile(pathForZipFileTemp);

    serverResponse.stream.listen(
      (List<int> newBytes) {
        // we write in a temp zip file
        _circuitsDownloadDataSource.writeZipFile(
          pathToFile: pathForZipFileTemp,
          zipBytes: newBytes,
        );

        // size of the temp zip file
        int zipFileSize = _circuitsDownloadDataSource.zipFileSize(
            pathToFile: pathForZipFileTemp);
        _downloadInfoController.add(DownloadInfo(
          contentLength: downloadSize,
          downloaded: zipFileSize,
        ));
      },
      onDone: () async {
        // we get the size of the temp zip file
        int zipFileSize = _circuitsDownloadDataSource.zipFileSize(
            pathToFile: pathForZipFileTemp);
        logger().i(
            "[Circuits success:] downloadSize -> $downloadSize / zipFileSize -> $zipFileSize");

        if (downloadSize != 0 && zipFileSize != downloadSize) {
          try {
            // if error we delete the temp file
            _circuitsDownloadDataSource.deleteFile(pathForZipFileTemp);
          } catch (_) {}
          _downloadInfoController.addError("Downloaded files incorrect");
          return;
        }

        _circuitsDownloadDataSource.renameFile(
            pathForZipFileTemp, pathForZipFile);
        await _circuitsDownloadDataSource.writeCircuitsFileFromZip(
          zipPath: pathForZipFile,
          path: pathForCircuits,
        );

        _downloadInfoController.add(DownloadInfo(
          contentLength: downloadSize,
          downloaded: zipFileSize,
          completed: true,
        ));
      },
      onError: (e) {
        _circuitsDownloadDataSource.deleteFile(pathForZipFile);
        _downloadInfoController.addError(e);
      },
      cancelOnError: true,
    );
  }

  ///
  @override
  Future<bool> circuitsFilesExist() {
    return _circuitsDownloadDataSource.circuitsFilesExist();
  }
}
