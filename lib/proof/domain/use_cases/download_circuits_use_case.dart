import 'dart:async';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class DownloadCircuitsUseCase extends StreamUseCase<void, DownloadInfo> {
  final ProofRepository _proofRepository;

  DownloadCircuitsUseCase(
    this._proofRepository,
  );

  @override
  Stream<DownloadInfo> execute({void param}) async* {
    yield* await _proofRepository.circuitsFilesExist().then((exist) {
      if (exist) {
        return Stream.value(
            DownloadInfo.onDone(contentLength: 0, downloaded: 0));
      }

      _proofRepository.initCircuitsDownloadFromServer();

      return _proofRepository.circuitsDownloadInfoStream;
    });
  }
}
