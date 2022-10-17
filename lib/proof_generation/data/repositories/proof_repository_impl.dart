import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/identity/libs/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/mappers/proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/exceptions/proof_generation_exceptions.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../../../iden3comm/data/mappers/proof_request_filters_mapper.dart';
import '../../../iden3comm/data/mappers/proof_requests_mapper.dart';
import '../../domain/entities/circuit_data_entity.dart';
import '../../domain/repositories/proof_repository.dart';
import '../data_sources/atomic_query_inputs_data_source.dart';
import '../data_sources/local_files_data_source.dart';
import '../data_sources/proof_circuit_data_source.dart';
import '../data_sources/prover_lib_data_source.dart';
import '../data_sources/witness_data_source.dart';
import '../dtos/witness_param.dart';
import '../mappers/circuit_type_mapper.dart';

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final AtomicQueryInputsDataSource _atomicQueryInputsDataSource;
  final LocalFilesDataSource _localFilesDataSource;
  final ProofCircuitDataSource _proofCircuitDataSource;
  final CircuitTypeMapper _circuitTypeMapper;
  final ProofRequestsMapper _proofRequestsMapper;
  final ProofRequestFiltersMapper _proofRequestFiltersMapper;
  final ProofMapper _proofMapper;

  // FIXME: this mapper shouldn't be used here as it's part of Credential
  final ClaimMapper _claimMapper;

  ProofRepositoryImpl(
      this._witnessDataSource,
      this._proverLibDataSource,
      this._atomicQueryInputsDataSource,
      this._localFilesDataSource,
      this._proofCircuitDataSource,
      this._circuitTypeMapper,
      this._proofRequestsMapper,
      this._proofRequestFiltersMapper,
      this._proofMapper,
      this._claimMapper);

  @override
  Future<CircuitDataEntity> loadCircuitFiles(String circuitId) async {
    List<Uint8List> circuitFiles =
        await _localFilesDataSource.loadCircuitFiles(circuitId);
    CircuitDataEntity circuitDataEntity =
        CircuitDataEntity(circuitId, circuitFiles[0], circuitFiles[1]);
    return circuitDataEntity;
  }

  @override
  Future<Uint8List?> calculateAtomicQueryInputs(
      String challenge,
      ClaimEntity authClaim,
      String circuitId,
      ProofQueryParamEntity queryParam,
      String pubX,
      String pubY,
      String? signature) async {
    ClaimDTO claim = _claimMapper.mapTo(authClaim);
    String? res = await _atomicQueryInputsDataSource.prepareAtomicQueryInputs(
      challenge,
      claim.info,
      circuitId,
      queryParam.field,
      queryParam.values,
      queryParam.operator,
      pubX,
      pubY,
      signature,
    );

    if (res != null) {
      Map<String, dynamic>? inputs = json.decode(res);
      Uint8List inputsJsonBytes =
          Uint8ArrayUtils.uint8ListfromString(json.encode(inputs));

      return inputsJsonBytes;
    }

    return null;
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
  Future<JWZProof> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes) {
    return _proverLibDataSource
        .prover(circuitData.zKeyFile, wtnsBytes)
        .then((proof) {
      if (proof == null) {
        throw NullProofException(circuitData.circuitId);
      }

      return _proofMapper.mapFrom(proof);
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
  Future<List<ProofRequestEntity>> getRequests(
      {required Iden3MessageEntity message}) {
    return Future.value(_proofRequestsMapper.mapFrom(message));
  }
}
