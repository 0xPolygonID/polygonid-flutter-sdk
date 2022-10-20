import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../../../credential/data/dtos/credential_dto.dart';
import '../../../credential/data/dtos/revocation_status.dart';
import '../../../identity/data/data_sources/remote_identity_data_source.dart';
import '../../domain/entities/circuit_data_entity.dart';
import '../../domain/repositories/proof_repository.dart';
import '../data_sources/atomic_query_inputs_data_source.dart';
import '../data_sources/local_files_data_source.dart';
import '../data_sources/prover_lib_data_source.dart';
import '../data_sources/witness_data_source.dart';
import '../dtos/witness_param.dart';

enum SupportedCircuits { mtp, sig }

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final AtomicQueryInputsDataSource _atomicQueryInputsDataSource;
  final LocalFilesDataSource _localFilesDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final RemoteClaimDataSource _remoteClaimDataSource;

  ProofRepositoryImpl(
      this._witnessDataSource,
      this._proverLibDataSource,
      this._atomicQueryInputsDataSource,
      this._localFilesDataSource,
      this._remoteIdentityDataSource,
      this._remoteClaimDataSource);

  static const Map<SupportedCircuits, String> _supportedCircuits = {
    SupportedCircuits.mtp: "credentialAtomicQueryMTP",
    SupportedCircuits.sig: "credentialAtomicQuerySig",
  };

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
      CredentialDTO credential,
      String circuitId,
      String key,
      List<int> values,
      int operator,
      String pubX,
      String pubY,
      String? signature) async {
    // revocation status
    final RevocationStatus? claimRevocationStatus = await _remoteClaimDataSource
        .getClaimRevocationStatus(credential, _remoteIdentityDataSource);

    String? res = await _atomicQueryInputsDataSource.prepareAtomicQueryInputs(
      challenge,
      credential,
      circuitId,
      key,
      values,
      operator,
      claimRevocationStatus,
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
  Future<Uint8List?> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  ) async {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: atomicQueryInputs);
    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.mtp]) {
      return await _witnessDataSource.computeWitnessMtp(witnessParam);
    }

    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.sig]) {
      return await _witnessDataSource.computeWitnessSig(witnessParam);
    }

    return null;
  }

  @override
  Future<Map<String, dynamic>?> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes) async {
    Map<String, dynamic>? proofResult =
        await _proverLibDataSource.prover(circuitData.zKeyFile, wtnsBytes);
    return proofResult;
  }
}
