import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/cancel_circuits_download_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/circuits_already_downloaded_and_checksum_are_valid_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/download_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/remove_circuits_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

abstract class PolygonIdSdkCircuits {
  Stream<DownloadInfo> initCircuitsDownloadAndGetInfoStream({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  });

  Future<bool> circuitsIsAlreadyDownloadedAndChecksumAreValid({
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
  final CircuitsAlreadyDownloadedAndChecksumAreValidUseCase
      _circuitsAlreadyDownloadedAndChecksumAreValidUseCase;
  final CancelCircuitsDownloadUseCase _cancelCircuitsDownloadUseCase;
  final RemoveCircuitsUseCase _removeCircuitsUseCase;

  Circuits(
    this._downloadCircuitsUseCase,
    this._circuitsAlreadyDownloadedAndChecksumAreValidUseCase,
    this._cancelCircuitsDownloadUseCase,
    this._removeCircuitsUseCase,
  );

  @override
  Stream<DownloadInfo> initCircuitsDownloadAndGetInfoStream({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  }) {
    return _downloadCircuitsUseCase.execute(
      param: DownloadCircuitsParam(circuitsToDownload: circuitsToDownload),
    );
  }

  @override
  Future<bool> circuitsIsAlreadyDownloadedAndChecksumAreValid({
    required List<CircuitModel> circuitsToCheck,
  }) {
    return _circuitsAlreadyDownloadedAndChecksumAreValidUseCase.execute(
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
