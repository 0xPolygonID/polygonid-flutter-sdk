import 'package:polygonid_flutter_sdk/circuits/data/circuits_data_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

abstract class CircuitsRepository {
  Future<bool> circuitExistsAndValidChecksum({
    required String circuitFileName,
    required String checksum,
  });

  Future<void> initCircuitsDownloadFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  });

  Stream<DownloadInfo> circuitsDownloadInfoStream(
      {required List<CircuitsToDownloadParam> circuitsToDownload});

  Future<void> cancelCircuitsDownload();

  Future<bool> removeCircuit({required String circuitFileName});
}

class CircuitsRepositoryImpl implements CircuitsRepository {
  final CircuitsDataSource circuitsDataSource;

  CircuitsRepositoryImpl({
    required this.circuitsDataSource,
  });

  @override
  Future<bool> circuitExistsAndValidChecksum({
    required String circuitFileName,
    required String checksum,
  }) async {
    bool exists = await circuitsDataSource.circuitExistsAndValidChecksum(
      circuitFileName: circuitFileName,
      checksum: checksum,
    );
    return exists;
  }

  @override
  Future<void> initCircuitsDownloadFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  }) async {
    for (int i = 0; i < circuitsToDownload.length; i++) {
      CircuitsToDownloadParam param = circuitsToDownload[i];

      String zipPath =
          await circuitsDataSource.getPathForTemporaryZipFileDownload(
        zipFileName: param.zipFileName,
      );
      // we delete the file if it exists
      await circuitsDataSource.deleteFile(zipPath);
      circuitsToDownload[i].temporaryZipDownloadPath = zipPath;
    }
    return circuitsDataSource.initStreamedResponseFromServer(
      circuitsToDownload: circuitsToDownload,
    );
  }

  @override
  Stream<DownloadInfo> circuitsDownloadInfoStream(
      {required List<CircuitsToDownloadParam> circuitsToDownload}) async* {
    await for (final downloadResponse in circuitsDataSource.downloadStream) {
      int progress = downloadResponse.progress;
      int total = downloadResponse.total;

      if (downloadResponse.errorOccurred) {
        yield DownloadInfo.onError(
          errorMessage: downloadResponse.errorMessage,
        );
      }

      if (downloadResponse.done) {
        final int downloadSize = circuitsDataSource.downloadSize;

        int totalZipFileSize = 0;

        for (CircuitsToDownloadParam param in circuitsToDownload) {
          if (param.temporaryZipDownloadPath == null) {
            continue;
          }
          String pathForZipFileTemp = param.temporaryZipDownloadPath!;
          String pathForZipFile = await circuitsDataSource
              .getPathToCircuitZipFile(zipFileName: param.zipFileName);

          // we get the size of the temp zip file
          int zipFileSize =
              circuitsDataSource.zipFileSize(pathToFile: pathForZipFileTemp);

          totalZipFileSize += zipFileSize;

          // check if circuits inside the zip file are correct
          // and if the checksum is correct
          bool validCircuits = await circuitsDataSource
              .checkAllCircuitsChecksumFromZipDownloaded(
            pathForZipFile: pathForZipFileTemp,
            circuitsToCheck: param.circuitsWithChecksum,
          );

          if (!validCircuits) {
            yield DownloadInfo.onError(
                errorMessage: "Downloaded files incorrect");
          }

          // we remove zip files
          await circuitsDataSource.deleteFile(pathForZipFileTemp);
          await circuitsDataSource.deleteFile(pathForZipFile);
        }

        // check if the downloaded files size are correct
        if (downloadSize != 0 && totalZipFileSize != downloadSize) {
          try {
            // if error we delete the temp file
            for (CircuitsToDownloadParam param in circuitsToDownload) {
              if (param.temporaryZipDownloadPath == null) {
                continue;
              }
              String pathForZipFileTemp = param.temporaryZipDownloadPath!;
              circuitsDataSource.deleteFile(pathForZipFileTemp);
            }
          } catch (_) {}

          yield DownloadInfo.onError(
              errorMessage: "Downloaded files incorrect");
        }

        yield DownloadInfo.onDone(
          contentLength: downloadSize,
          downloaded: totalZipFileSize,
        );
      }

      yield DownloadInfo.onProgress(
        contentLength: total,
        downloaded: progress,
      );
    }
  }

  @override
  Future<void> cancelCircuitsDownload() async {
    return circuitsDataSource.cancelDownload();
  }

  @override
  Future<bool> removeCircuit({required String circuitFileName}) async {
    return circuitsDataSource.removeCircuitFile(
      circuitFileName: circuitFileName,
    );
  }
}
