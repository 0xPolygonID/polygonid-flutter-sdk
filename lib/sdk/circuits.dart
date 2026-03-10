import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_file_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_registry.dart';
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

  /// Register circuit files from a local directory path, URL, or asset.
  ///
  /// This allows the SDK to locate circuit files for the given [circuitId]
  /// without requiring them to be in the default circuits directory.
  void registerCircuitFile(String circuitId, CircuitFileSource source);

  /// Remove a previously registered circuit file source.
  void unregisterCircuitFile(String circuitId);

  /// Set a callback to dynamically resolve circuit file sources for
  /// unknown circuit IDs at runtime.
  ///
  /// The [resolver] is called when the SDK encounters a circuit ID that
  /// has no explicit registration. Return a [CircuitFileSource] to provide
  /// files, or `null` to fall back to the default resolution behavior.
  void setCircuitResolver(CircuitResolver? resolver);
}

@injectable
class Circuits implements PolygonIdSdkCircuits {
  final DownloadCircuitsUseCase _downloadCircuitsUseCase;
  final CheckCircuitsUseCase _checkCircuitsCase;
  final CancelCircuitsDownloadUseCase _cancelCircuitsDownloadUseCase;
  final RemoveCircuitsUseCase _removeCircuitsUseCase;
  final CircuitRegistry _circuitRegistry;

  Circuits(
    this._downloadCircuitsUseCase,
    this._checkCircuitsCase,
    this._cancelCircuitsDownloadUseCase,
    this._removeCircuitsUseCase,
    this._circuitRegistry,
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

  @override
  void registerCircuitFile(String circuitId, CircuitFileSource source) {
    _circuitRegistry.register(circuitId, source);
  }

  @override
  void unregisterCircuitFile(String circuitId) {
    _circuitRegistry.unregister(circuitId);
  }

  @override
  void setCircuitResolver(CircuitResolver? resolver) {
    _circuitRegistry.setCircuitResolver(resolver);
  }
}
