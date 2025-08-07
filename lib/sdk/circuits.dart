import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/cancel_circuits_download_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/check_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/remove_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

abstract class PolygonIdSdkCircuits {
  Stream<DownloadInfo> initCircuitsDownloadAndGetInfoStream({
    required CircuitsToDownloadParam circuitsToDownload,
  });

  @Deprecated('Use checkCircuits instead')
  Future<bool> circuitsIsAlreadyDownloadedAndChecksumAreValid({
    required List<CircuitModel> circuitsToCheck,
  });

  /// Checks if the circuits are already downloaded and their checksums are valid.
  Future<bool> checkCircuits({
    required List<CircuitModel> circuitsToCheck,
  });

  Future<void> cancelCircuitsDownload();

  Future<bool> removeCircuits({
    required List<String> circuitFileNamesToRemove,
  });
}

@injectable
class Circuits implements PolygonIdSdkCircuits {
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final CheckCircuitsUseCase _checkCircuitsCase;
  final CancelCircuitsDownloadUseCase _cancelCircuitsDownloadUseCase;
  final RemoveCircuitsUseCase _removeCircuitsUseCase;

  Circuits(
    this._downloadCircuitsUseCase,
    this._checkCircuitsCase,
    this._cancelCircuitsDownloadUseCase,
    this._removeCircuitsUseCase,
  );

  @override
  Stream<DownloadInfo> initCircuitsDownloadAndGetInfoStream({
    required CircuitsToDownloadParam circuitsToDownload,
  }) {
    return _downloadCircuitsUseCase.execute(
      param: DownloadCircuitsParam(circuitsToDownload: circuitsToDownload),
    );
  }

  @override
  Future<bool> circuitsIsAlreadyDownloadedAndChecksumAreValid({
    required List<CircuitModel> circuitsToCheck,
  }) {
    return checkCircuits(circuitsToCheck: circuitsToCheck);
  }

  @override
  Future<bool> checkCircuits({
    required List<CircuitModel> circuitsToCheck,
  }) {
    return _checkCircuitsCase.execute(
      param: circuitsToCheck,
    );
  }

  @override
  Future<void> cancelCircuitsDownload() {
    return _cancelCircuitsDownloadUseCase.execute();
  }

  @override
  Future<bool> removeCircuits({
    required List<String> circuitFileNamesToRemove,
  }) {
    return _removeCircuitsUseCase.execute(
      param: circuitFileNamesToRemove,
    );
  }
}
