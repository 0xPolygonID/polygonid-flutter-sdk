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
    bool exist = true;
    for (CircuitsToDownloadParam circuitsToDownloadParam
        in param.circuitsToDownloadParam) {
      exist = await _proofRepository.circuitsFilesExist(
        circuitsFileName: circuitsToDownloadParam.circuitsName,
      );
      if (!exist) {
        break;
      }
    }

    if (exist) {
      yield* Stream.value(DownloadInfo.onDone(contentLength: 0, downloaded: 0));
      return;
    }

    _proofRepository.initCircuitsDownloadFromServer(
      circuitsToDownload: param.circuitsToDownloadParam,
    );
    yield* _proofRepository.circuitsDownloadInfoStream(
        circuitsToDownload: param.circuitsToDownloadParam);
  }
}

class DownloadCircuitsParam {
  List<CircuitsToDownloadParam> circuitsToDownloadParam;

  DownloadCircuitsParam({required this.circuitsToDownloadParam});
}
