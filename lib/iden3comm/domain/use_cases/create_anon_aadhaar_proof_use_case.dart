import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/self_issuance/self_issued_credential_params.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

class CreateAnonAadhaarProofParam {
  final String qrData;
  final int timeNow;
  final String profileDid;
  final SelfIssuedCredentialParams selfIssuedCredentialParams;
  final String circuitId;

  CreateAnonAadhaarProofParam({
    required this.qrData,
    required this.timeNow,
    required this.profileDid,
    required this.selfIssuedCredentialParams,
    required this.circuitId,
  });
}

class CreateAnonAadhaarProofUseCase
    extends FutureUseCase<CreateAnonAadhaarProofParam, ZKProofEntity> {
  final GetEnvUseCase _getEnvUseCase;
  final LibPolygonIdCoreWrapper _libPolygonIdCoreWrapper;
  final ProveUseCase _proveUseCase;
  final CircuitsFilesDataSource _circuitsFilesDataSource;

  CreateAnonAadhaarProofUseCase(
    this._getEnvUseCase,
    this._libPolygonIdCoreWrapper,
    this._proveUseCase,
    this._circuitsFilesDataSource,
  );

  @override
  Future<ZKProofEntity> execute({
    required CreateAnonAadhaarProofParam param,
  }) async {
    final env = await _getEnvUseCase.execute();

    final anonAadhaarInputs =
        AnonAadhaarInputsParam.fromSelfIssuedCredentialParams(
      qrData: param.qrData,
      timeNow: param.timeNow,
      credentialSubjectID: param.profileDid,
      params: param.selfIssuedCredentialParams,
    );

    final generateInputsResult = await _libPolygonIdCoreWrapper.getProofInputs(
      anonAadhaarInputs,
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
