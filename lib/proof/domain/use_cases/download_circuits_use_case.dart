import 'dart:async';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';

class DownloadCircuitsUseCase extends StreamUseCase<void, DownloadInfo> {
  final ProofRepository _proofRepository;

  DownloadCircuitsUseCase(
    this._proofRepository,
  );

  @override
  Stream<DownloadInfo> execute({void param}) {
    StreamController<DownloadInfo> streamController =
        StreamController<DownloadInfo>.broadcast();

    _proofRepository.circuitsFilesExist().then((exist) {
      if (exist) {
        streamController
            .add(DownloadInfo.onDone(contentLength: 0, downloaded: 0));
        streamController.close();
      } else {
        _proofRepository.circuitsDownloadInfoStream.listen((event) {
          streamController.add(event);
        }).onDone(() {
          streamController.close();
        });
        _proofRepository.initCircuitsDownloadFromServer();
      }
    });

    return streamController.stream;
  }
}
