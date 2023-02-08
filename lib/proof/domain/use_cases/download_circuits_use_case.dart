import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class DownloadCircuitsUseCase extends StreamUseCase<void, DownloadInfo> {
  final ProofRepository _proofRepository;

  DownloadCircuitsUseCase(this._proofRepository);

  @override
  Stream<DownloadInfo> execute({void param}) {
    Stream<DownloadInfo> stream = _proofRepository.circuitsDownloadInfoStream;
    _proofRepository.initCircuitsDownloadFromServer();
    return stream;
  }
}
