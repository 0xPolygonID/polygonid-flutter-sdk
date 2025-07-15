import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

class CreatePassportProofParam {
  final String passportData;
  final String dg2Hash;
  final String profileDid;
  final int revocationNonce;
  final String credentialStatusID;
  final String issuerDid;
  final int issuanceDate;
  final String linkNonce;
  final String circuitId;

  CreatePassportProofParam({
    required this.passportData,
    required this.dg2Hash,
    required this.profileDid,
    required this.revocationNonce,
    required this.credentialStatusID,
    required this.issuerDid,
    required this.issuanceDate,
    required this.linkNonce,
    required this.circuitId,
  });
}

class CreatePassportProofUseCase
    extends FutureUseCase<CreatePassportProofParam, ZKProofEntity> {
  final GetEnvUseCase _getEnvUseCase;
  final LibPolygonIdCoreWrapper _libPolygonIdCoreWrapper;
  final ProveUseCase _proveUseCase;
  final CircuitsFilesDataSource _circuitsFilesDataSource;

  CreatePassportProofUseCase(
    this._getEnvUseCase,
    this._libPolygonIdCoreWrapper,
    this._proveUseCase,
    this._circuitsFilesDataSource,
  );

  @override
  Future<ZKProofEntity> execute({
    required CreatePassportProofParam param,
  }) async {
    final env = await _getEnvUseCase.execute();

    final passportInputs = PassportInputsParam(
      passportData: param.passportData,
      dg2Hash: param.dg2Hash,
      credentialSubjectID: param.profileDid,
      revocationNonce: param.revocationNonce,
      credentialStatusID: param.credentialStatusID,
      issuerDid: param.issuerDid,
      issuanceDate: param.issuanceDate,
      linkNonce: param.linkNonce,
      circuitId: param.circuitId,
    );

    final generateInputsResult = await _libPolygonIdCoreWrapper.getProofInputs(
      passportInputs,
      env.config,
    );

    final atomicQueryInputs = json.encode(generateInputsResult.inputs);

    final witnessCalculationData =
        await _circuitsFilesDataSource.loadGraphFile(param.circuitId);
    final zKeyPath =
        await _circuitsFilesDataSource.getZkeyFilePath(param.circuitId);

    final proof = await _proveUseCase.execute(
      param: ProveParam(
        atomicQueryInputs,
        CircuitDataEntity(
          param.circuitId,
          witnessCalculationData,
          zKeyPath,
        ),
      ),
    );

    return proof;
  }
}
