import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../../../iden3comm/data/mappers/proof_request_filters_mapper.dart';
import '../../../identity/data/data_sources/remote_identity_data_source.dart';
import '../../domain/entities/circuit_data_entity.dart';
import '../../domain/entities/gist_proof_entity.dart';
import '../../domain/repositories/proof_repository.dart';
import '../data_sources/local_proof_files_data_source.dart';
import '../data_sources/proof_circuit_data_source.dart';
import '../data_sources/prover_lib_data_source.dart';
import '../data_sources/witness_data_source.dart';
import '../dtos/gist_proof_dto.dart';
import '../dtos/node_aux_dto.dart';
import '../dtos/proof_dto.dart';
import '../dtos/witness_param.dart';
import '../mappers/circuit_type_mapper.dart';
import '../mappers/gist_proof_mapper.dart';
import '../mappers/jwz_mapper.dart';
import '../mappers/jwz_proof_mapper.dart';

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  //final AtomicQueryInputsDataSource _atomicQueryInputsDataSource;
  final LocalProofFilesDataSource _localProofFilesDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;
  final ProofCircuitDataSource _proofCircuitDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final CircuitTypeMapper _circuitTypeMapper;
  final ProofRequestFiltersMapper _proofRequestFiltersMapper;
  final ProofMapper _proofMapper;
  final GistProofMapper _gistProofMapper;
  final JWZProofMapper _jwzProofMapper;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final JWZMapper _jwzMapper;

  // FIXME: those mappers shouldn't be used here as they are part of Credential
  final ClaimMapper _claimMapper;
  final RevocationStatusMapper _revocationStatusMapper;

  ProofRepositoryImpl(
    this._witnessDataSource,
    this._proverLibDataSource,
    //this._atomicQueryInputsDataSource,
    this._localProofFilesDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._proofCircuitDataSource,
    this._remoteIdentityDataSource,
    this._circuitTypeMapper,
    this._proofRequestFiltersMapper,
    this._proofMapper,
    this._gistProofMapper,
    this._jwzProofMapper,
    this._claimMapper,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._revocationStatusMapper,
    this._jwzMapper,
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
      String challenge,
      ClaimEntity authClaim,
      String circuitId,
      ProofQueryParamEntity queryParam,
      String pubX,
      String pubY,
      String signature,
      Map<String, dynamic> revocationStatus) async {
    ClaimDTO claim = _claimMapper.mapTo(authClaim);
    String?
        res; /*await _atomicQueryInputsDataSource.prepareAtomicQueryInputs(
      challenge,
      claim.info,
      circuitId,
      queryParam.field,
      queryParam.values,
      queryParam.operator,
      _revocationStatusMapper.mapTo(revocationStatus),
      pubX,
      pubY,
      signature,
    );*/

    if (res != null && res.isNotEmpty) {
      Map<String, dynamic>? inputs = json.decode(res);
      Uint8List inputsJsonBytes =
          Uint8ArrayUtils.uint8ListfromString(json.encode(inputs));

      return inputsJsonBytes;
    }

    throw NullAtomicQueryInputsException(circuitId);
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
    });
  }

  @override
  Future<JWZProof> prove(CircuitDataEntity circuitData, Uint8List wtnsBytes) {
    return _proverLibDataSource
        .prove(circuitData.zKeyFile, wtnsBytes)
        .then((proof) {
      if (proof == null) {
        throw NullProofException(circuitData.circuitId);
      }

      return _jwzProofMapper.mapFrom(proof);
    });
  }

  @override
  Future<bool> isCircuitSupported({required String circuitId}) {
    return Future.value(_circuitTypeMapper.mapTo(circuitId)).then((circuit) =>
        _proofCircuitDataSource.isCircuitSupported(circuit: circuit));
  }

  @override
  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request}) {
    return Future.value(_proofRequestFiltersMapper.mapFrom(request));
  }

  @override
  Future<GistProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress}) async {
    String gistProofSC = await _getGistProofSC(
      identifier:
          idAsInt, // "21051438350758615910194871316894294942737671344817514009731719137348227585", //genesis["id"] as big int
      contractAddress:
          contractAddress, //"0x6811f4b44354C29993f8088c4D38B61018C5338d",
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
            .getGistProof(
                identifier /*_stateIdentifierMapper.mapTo(identifier)*/,
                contract)
            .catchError((error) => throw FetchGistProofException(error)));
  }

  Future<String> encodeJWZ({required JWZEntity jwz}) {
    return Future.value(_jwzMapper.mapFrom(jwz));
  }
}
