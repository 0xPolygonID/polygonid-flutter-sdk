import 'dart:async';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class DownloadCircuitsUseCase
    extends StreamUseCase<DownloadCircuitsParam, DownloadInfo> {
  final ProofRepository _proofRepository;

  DownloadCircuitsUseCase(
    this._proofRepository,
  );

  @override
  Stream<DownloadInfo> execute({required DownloadCircuitsParam param}) async* {
    final missingCircuits = <CircuitsToDownloadParam>[];
    for (final circuit in param.circuitsToDownload) {
      final exist = await _proofRepository.circuitsFilesExist(
        circuitsFileName: circuit.circuitsName,
      );
      if (!exist) {
        missingCircuits.add(circuit);
      }
    }

    if (missingCircuits.isEmpty) {
      yield* Stream.value(DownloadInfo.onDone(contentLength: 0, downloaded: 0));
      return;
    }

    // intentionally not awaited
    _proofRepository.initCircuitsDownloadFromServer(
      circuitsToDownload: missingCircuits,
    );
    yield* _proofRepository.circuitsDownloadInfoStream(
      circuitsToDownload: missingCircuits,
    );
  }
}

class DownloadCircuitsParam {
  List<CircuitsToDownloadParam> circuitsToDownload;

  DownloadCircuitsParam({required this.circuitsToDownload});
}
