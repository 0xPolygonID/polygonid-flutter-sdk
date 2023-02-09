import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';

class DownloadCircuitsUseCase extends StreamUseCase<void, DownloadInfo> {
  final ProofRepository _proofRepository;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;

  DownloadCircuitsUseCase(
    this._proofRepository,
    this._circuitsFilesExistUseCase,
  );

  @override
  Stream<DownloadInfo> execute({void param}) {
    _circuitsFilesExistUseCase.execute().then((value) {
      if (value) {
        // return void stream
        return Stream<void>.value(null);
        return Stream<DownloadInfo>.value(
          DownloadInfo(
            downloaded: 0,
            contentLength: 0,
            completed: true,
          ),
        );
      }
    });

    Stream<DownloadInfo> stream = _proofRepository.circuitsDownloadInfoStream;
    _proofRepository.initCircuitsDownloadFromServer();
    return stream;
  }
}
