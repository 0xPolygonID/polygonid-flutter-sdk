import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/jwz_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_response_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../../../iden3comm/data/mappers/gist_proof_mapper.dart'
    as iden3GistProofMapper;
import '../../../identity/data/data_sources/remote_identity_data_source.dart';
import '../../domain/entities/circuit_data_entity.dart';
import '../../domain/entities/proof_entity.dart';
import '../../domain/repositories/proof_repository.dart';
import '../data_sources/lib_pidcore_proof_data_source.dart';
import '../data_sources/local_proof_files_data_source.dart';
import '../data_sources/proof_circuit_data_source.dart';
import '../data_sources/prover_lib_data_source.dart';
import '../data_sources/witness_data_source.dart';
import '../dtos/gist_proof_dto.dart';
import '../dtos/proof_dto.dart';
import '../dtos/witness_param.dart';
import '../mappers/circuit_type_mapper.dart';
import '../mappers/gist_proof_mapper.dart';
import '../mappers/jwz_mapper.dart';

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;
  final LocalProofFilesDataSource _localProofFilesDataSource;
  final ProofCircuitDataSource _proofCircuitDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final CircuitsDownloadDataSource _circuitsDownloadDataSource;
  final RPCDataSource _rpcDataSource;
  final CircuitTypeMapper _circuitTypeMapper;
  final JWZProofMapper _jwzProofMapper;
  final JWZMapper _jwzMapper;
  final AuthProofMapper _authProofMapper;
  final GistProofMapper _gistProofMapper;
  final iden3GistProofMapper.GistProofMapper _iden3GistProofMapper;
  final CircuitsFilesDataSource _circuitsFilesDataSource;

  // FIXME: those mappers shouldn't be used here as they are part of Credential
  final ClaimMapper _claimMapper;
  final RevocationStatusMapper _revocationStatusMapper;

  ProofRepositoryImpl(
    this._witnessDataSource,
    this._proverLibDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._localProofFilesDataSource,
    this._proofCircuitDataSource,
    this._remoteIdentityDataSource,
    this._localContractFilesDataSource,
    this._circuitsDownloadDataSource,
    this._rpcDataSource,
    this._circuitTypeMapper,
    this._jwzProofMapper,
    this._claimMapper,
    this._revocationStatusMapper,
    this._jwzMapper,
    this._authProofMapper,
    this._gistProofMapper,
    this._iden3GistProofMapper,
    this._circuitsFilesDataSource,
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
      Map<String, dynamic>? treeState,
      String? challenge,
      String? signature}) async {
    ClaimDTO credentialDto = _claimMapper.mapTo(claim);
    Map<String, dynamic>? gistProofMap;
    if (gistProof != null) {
      gistProofMap = _iden3GistProofMapper.mapTo(gistProof);
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
    String gistProofSC = await _getGistProofSC(
      identifier: idAsInt,
      contractAddress: contractAddress,
    );

    String gistProof =
        _libPolygonIdCoreProofDataSource.proofFromSC(gistProofSC);

    // remove all quotes from the string values
    final gistProof2 = gistProof.replaceAll("\"", "");

    // now we add quotes to both keys and Strings values
    final quotedString =
        gistProof2.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
      return '"${match.group(0)}"';
    });

    var gistProofJson = jsonDecode(quotedString);

    /// FIXME: repo don't create and manipulate DTO, that's the DS job
    return _gistProofMapper.mapFrom(GistProofDTO(
        root: gistProofJson["root"],
        proof: ProofDTO(
            existence:
                gistProofJson["proof"]["existence"] == "true" ? true : false,
            siblings: (gistProofJson["proof"]["siblings"] as List)
                .map((hash) => HashDTO.fromBigInt(BigInt.parse(hash)))
                .toList(),
            nodeAux: gistProofJson["proof"]["node_aux"] != null
                ? NodeAuxDTO(
                    key: gistProofJson["proof"]["node_aux"]["key"],
                    value: gistProofJson["proof"]["node_aux"]["value"])
                : null)));
  }

  Future<String> _getGistProofSC(
      {required String identifier, required String contractAddress}) {
    return _localContractFilesDataSource
        .loadStateContract(contractAddress)
        .then((contract) => _rpcDataSource
            .getGistProof(identifier, contract)
            .catchError((error) => throw FetchGistProofException(error)));
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
    bool alreadyDownloaded = await circuitsFilesExist();
    if (alreadyDownloaded) {
      _downloadInfoController.add(
        DownloadInfo(
          downloaded: 0,
          contentLength: 0,
          completed: true,
        ),
      );
      return;
    }

    String pathForZipFileTemp =
        await _circuitsFilesDataSource.getPathToCircuitZipFileTemp();
    String pathForZipFile =
        await _circuitsFilesDataSource.getPathToCircuitZipFile();
    String pathForCircuits = await _circuitsFilesDataSource.getPath();

    Stream<DownloadResponseEntity> downloadResponseStream =
        _circuitsDownloadDataSource.downloadStream;

    await _circuitsDownloadDataSource.initStreamedResponseFromServer();

    final int downloadSize = _circuitsDownloadDataSource.downloadSize;

    // We delete eventual temp zip file downloaded before
    _circuitsFilesDataSource.deleteFile(pathForZipFileTemp);

    _downloadInfoController.addStream(
      downloadResponseStream.map((downloadResponse) {
        if (downloadResponse.errorOccurred) {
          return DownloadInfo(
            contentLength: 0,
            downloaded: 0,
            completed: false,
            errorOccurred: true,
            errorMessage: downloadResponse.errorMessage,
          );
        }
        if (downloadResponse.done) {
          // we get the size of the temp zip file
          int zipFileSize = _circuitsFilesDataSource.zipFileSize(
              pathToFile: pathForZipFileTemp);
          logger().i(
              "[Circuits success:] downloadSize -> $downloadSize / zipFileSize -> $zipFileSize");

          if (downloadSize != 0 && zipFileSize != downloadSize) {
            try {
              // if error we delete the temp file
              _circuitsFilesDataSource.deleteFile(pathForZipFileTemp);
            } catch (_) {}

            return DownloadInfo(
              contentLength: downloadSize,
              downloaded: zipFileSize,
              completed: false,
              errorOccurred: true,
              errorMessage: "Downloaded files incorrect",
            );
          }

          _completeWritingFile(
            pathForCircuits: pathForCircuits,
            pathForZipFile: pathForZipFile,
            pathForZipFileTemp: pathForZipFileTemp,
          );

          return DownloadInfo(
            contentLength: downloadSize,
            downloaded: zipFileSize,
            completed: true,
          );
        }

        _circuitsFilesDataSource.writeZipFile(
          pathToFile: pathForZipFileTemp,
          zipBytes: downloadResponse.newBytes,
        );

        // size of the temp zip file
        int zipFileSize = _circuitsFilesDataSource.zipFileSize(
            pathToFile: pathForZipFileTemp);
        return DownloadInfo(
          contentLength: downloadSize,
          downloaded: zipFileSize,
        );
      }),
    );
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
