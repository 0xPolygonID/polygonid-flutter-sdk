import 'package:polygonid_flutter_sdk/circuits/data/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/circuits_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

class DownloadCircuitsUseCase
    extends StreamUseCase<DownloadCircuitsParam, DownloadInfo> {
  final CircuitsRepository _circuitsRepository;

  DownloadCircuitsUseCase(this._circuitsRepository);

  @override
  Stream<DownloadInfo> execute({required DownloadCircuitsParam param}) async* {
    final missingCircuits = <CircuitsToDownloadParam>[];
    // multiple buckets of circuits to download can be passed
    for (final circuitsToDownload in param.circuitsToDownload) {
      // set the flag to true, if even one circuit is missing, it will be set to false
      // and the bucket will be downloaded from the server
      bool allCircuitsExist = true;
      // check every circuit in the bucket if it exists and has a valid checksum
      for (final circuitFile in circuitsToDownload.circuitsWithChecksum) {
        // check if the circuit exists and has a valid checksum
        final existAndValid =
            await _circuitsRepository.circuitExistsAndValidChecksum(
          circuitFileName: circuitFile.fileName,
          checksum: circuitFile.checksum,
        );

        // if the circuit does not exist or has an invalid checksum, set the flag to false
        // and break the loop
        if (!existAndValid) {
          allCircuitsExist = false;
          break;
        }
      } // end of circuits for loop

      // if the flag is false, add the bucket to the missing circuits list
      if (!allCircuitsExist) {
        missingCircuits.add(circuitsToDownload);
      }
    } // end of buckets for loop
    if (missingCircuits.isEmpty) {
      yield* Stream.value(DownloadInfo.onDone(contentLength: 0, downloaded: 0));
      return;
    }

    // intentionally not awaited
    _circuitsRepository.initCircuitsDownloadFromServer(
      circuitsToDownload: missingCircuits,
    );

    yield* _circuitsRepository.circuitsDownloadInfoStream(
      circuitsToDownload: missingCircuits,
    );
  }
}

class DownloadCircuitsParam {
  List<CircuitsToDownloadParam> circuitsToDownload;

  DownloadCircuitsParam({required this.circuitsToDownload});
}
