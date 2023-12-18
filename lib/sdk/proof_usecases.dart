import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/cancel_download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_zkproof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/load_circuit_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

@injectable
class ProofUsecases {
  final CancelDownloadCircuitsUseCase _cancelDownloadCircuitsUseCase;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final GenerateZKProofUseCase _generateZKProofUseCase;
  final GetGistMTProofUseCase _getGistMTProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupportedUseCase;
  final LoadCircuitUseCase _loadCircuitUseCase;
  final ProveUseCase _proveUseCase;

  ProofUsecases(
    this._cancelDownloadCircuitsUseCase,
    this._circuitsFilesExistUseCase,
    this._downloadCircuitsUseCase,
    this._generateZKProofUseCase,
    this._getGistMTProofUseCase,
    this._isProofCircuitSupportedUseCase,
    this._loadCircuitUseCase,
    this._proveUseCase,
  );

  Future<void> cancelDownloadCircuits() {
    return _cancelDownloadCircuitsUseCase.execute();
  }

  Future<bool> circuitsFilesExist() {
    return _circuitsFilesExistUseCase.execute();
  }

  Stream<DownloadInfo> downloadCircuits() {
    return _downloadCircuitsUseCase.execute();
  }

  Future<ZKProofEntity> generateZKProof(GenerateZKProofParam param) {
    return _generateZKProofUseCase.execute(param: param);
  }

  Future<GistMTProofEntity> getGistMTProof(String identifier) {
    return _getGistMTProofUseCase.execute(param: identifier);
  }

  Future<bool> isProofCircuitSupported(String circuitId) {
    return _isProofCircuitSupportedUseCase.execute(param: circuitId);
  }

  Future<CircuitDataEntity> loadCircuit(String circuitId) {
    return _loadCircuitUseCase.execute(param: circuitId);
  }

  Future<ZKProofEntity> prove(ProveParam param) {
    return _proveUseCase.execute(param: param);
  }
}
