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
    Stream<DownloadInfo> stream = _proofRepository.circuitsDownloadInfoStream;
    _proofRepository.circuitsFilesExist().then((exist) {
      if (exist) {
        stream = Stream.fromIterable(
            [DownloadInfo.onDone(contentLength: 0, downloaded: 0)]);
      } else {
        _proofRepository.initCircuitsDownloadFromServer();
      }
    });

    return stream;
  }
}
