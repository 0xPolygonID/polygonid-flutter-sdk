import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart';

class DownloadCircuitsUseCase
    extends FutureUseCase<void, Stream<DownloadInfo>> {
  final ProofRepository _proofRepository;
  final CircuitsFilesExistUseCase _circuitsFilesExistUseCase;

  DownloadCircuitsUseCase(
    this._proofRepository,
    this._circuitsFilesExistUseCase,
  );

  @override
  Future<Stream<DownloadInfo>> execute({void param}) async {
    bool circuitsFilesExist = await _circuitsFilesExistUseCase.execute();

    if (circuitsFilesExist) {
      return Stream<DownloadInfo>.value(
        DownloadInfo(
          downloaded: 0,
          contentLength: 0,
          completed: true,
        ),
      );
    } else {
      Stream<DownloadInfo> stream = _proofRepository.circuitsDownloadInfoStream;
      _proofRepository.initCircuitsDownloadFromServer();
      return stream;
    }
  }
}
