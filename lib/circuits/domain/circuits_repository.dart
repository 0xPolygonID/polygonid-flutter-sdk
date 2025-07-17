import 'package:polygonid_flutter_sdk/circuits/data/circuits_data_source.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

abstract class CircuitsRepository {
  Future<bool> fileExistsAndValidChecksum({
    required String fileName,
    required String? checksum,
  });

  Future<void> initCircuitsDownloadFromServer({
    required CircuitsToDownloadParam circuitsToDownload,
  });

  Stream<DownloadInfo> circuitsDownloadInfoStream({
    required CircuitsToDownloadParam circuitsToDownload,
  });

  Future<void> cancelCircuitsDownload();

  Future<bool> removeCircuit({required String circuitFileName});
}

class CircuitsRepositoryImpl implements CircuitsRepository {
  final CircuitsDataSource circuitsDataSource;

  CircuitsRepositoryImpl({
    required this.circuitsDataSource,
  });

  @override
  Future<bool> fileExistsAndValidChecksum({
    required String fileName,
    required String? checksum,
  }) async {
    bool exists = await circuitsDataSource.fileExistsAndValidChecksum(
      fileName: fileName,
      checksum: checksum,
    );
    return exists;
  }

  @override
  Future<void> initCircuitsDownloadFromServer({
    required CircuitsToDownloadParam circuitsToDownload,
  }) async {
    String zipPath =
        await circuitsDataSource.getPathForTemporaryZipFileDownload(
      zipFileName: circuitsToDownload.zipFileName,
    );
    // we delete the file if it exists
    await circuitsDataSource.deleteFile(zipPath);
    circuitsToDownload.temporaryZipDownloadPath = zipPath;

    return circuitsDataSource.initStreamedResponseFromServer(
      circuitsToDownload: [circuitsToDownload],
    );
  }

  @override
  Stream<DownloadInfo> circuitsDownloadInfoStream({
    required CircuitsToDownloadParam circuitsToDownload,
  }) async* {
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

        if (circuitsToDownload.temporaryZipDownloadPath == null) {
          continue;
        }
        String pathForZipFileTemp =
            circuitsToDownload.temporaryZipDownloadPath!;
        String pathForZipFile =
            await circuitsDataSource.getPathToCircuitZipFile(
                zipFileName: circuitsToDownload.zipFileName);

        // we get the size of the temp zip file
        int zipFileSize = await circuitsDataSource.zipFileSizeWithRetry(
            pathToFile: pathForZipFileTemp);

        if (zipFileSize == 0) {
          yield DownloadInfo.onError(
              errorMessage: "Temporary zip file missing or inaccessible");
          return;
        }

        totalZipFileSize += zipFileSize;

        // check if circuits inside the zip file are correct
        // and if the checksum is correct
        bool validCircuits =
            await circuitsDataSource.checkAllCircuitsChecksumFromZipDownloaded(
          pathForZipFile: pathForZipFileTemp,
          circuitsToCheck: circuitsToDownload.circuitsWithChecksum,
        );

        if (!validCircuits) {
          yield DownloadInfo.onError(
              errorMessage: "Downloaded files incorrect");
          // we remove zip files
          await circuitsDataSource.deleteFile(pathForZipFileTemp);
          await circuitsDataSource.deleteFile(pathForZipFile);
          return;
        }

        // we remove zip files
        await circuitsDataSource.deleteFile(pathForZipFileTemp);
        await circuitsDataSource.deleteFile(pathForZipFile);

        // check if the downloaded files size are correct
        if (downloadSize != 0 && totalZipFileSize != downloadSize) {
          try {
            // if error we delete the temp file
            if (circuitsToDownload.temporaryZipDownloadPath == null) {
              continue;
            }
            String pathForZipFileTemp =
                circuitsToDownload.temporaryZipDownloadPath!;
            circuitsDataSource.deleteFile(pathForZipFileTemp);
          } catch (_) {}

          yield DownloadInfo.onError(
              errorMessage: "Downloaded files incorrect");
          return;
        }

        yield DownloadInfo.onDone(
          contentLength: downloadSize,
          downloaded: totalZipFileSize,
        );
        return;
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
