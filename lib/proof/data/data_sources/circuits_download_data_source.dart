import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/circuits_to_download_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/download_response_dto.dart';

@injectable
class CircuitsDownloadDataSource {
  final Dio _client;
  late CancelToken _cancelToken;

  CircuitsDownloadDataSource(this._client);

  StreamController<DownloadResponseDTO> _controller =
      StreamController<DownloadResponseDTO>.broadcast();

  Stream<DownloadResponseDTO> get downloadStream => _controller.stream;

  int _downloadSize = 0;

  /// downloadSize
  int get downloadSize => _downloadSize;

  ///
  Future<void> initStreamedResponseFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  }) async {
    final fileDownloader = FileDownloader();
    _cancelToken = CancelToken();
    _cancelToken.whenCancel.then((_) {
      fileDownloader.cancelTasksWithIds(
          circuitsToDownload.map((i) => i.circuitsName).toList());
    });

    // first we get the file size
    try {
      int totalContentLength = 0;
      for (CircuitsToDownloadParam param in circuitsToDownload) {
        Response headResponse = await _client.head(param.bucketUrl);
        int contentLength =
            int.parse(headResponse.headers.value('content-length') ?? "0");
        totalContentLength += contentLength;
      }
      _downloadSize = totalContentLength;
    } catch (e) {
      _cancelToken.cancel();
      _controller.add(DownloadResponseDTO(
        progress: 0,
        total: 0,
        errorOccurred: true,
        errorMessage: e.toString(),
      ));
      return;
    }

    try {
      final progressList = List.filled(circuitsToDownload.length, 0.0);

      final downloadFutures = <Future>[];
      for (var i = 0; i < circuitsToDownload.length; i++) {
        final param = circuitsToDownload[i];
        final file = File(param.downloadPath!);

        final name = file.uri.pathSegments.last;
        final path = file.path.substring(0, file.path.length - name.length);

        final task = DownloadTask(
          taskId: param.circuitsName,
          url: param.bucketUrl,
          baseDirectory: BaseDirectory.root,
          directory: path,
          filename: name,
        );

        final downloadFuture = fileDownloader.download(
          task,
          onProgress: (progress) {
            // Set individual file download progress
            progressList[i] = progress;

            // Calculate shared progress across all files
            final sharedProgress = progressList.fold(0.0, (a, b) => a + b) /
                circuitsToDownload.length;

            _controller.add(
              DownloadResponseDTO(
                progress: (_downloadSize * sharedProgress).toInt(),
                total: _downloadSize,
              ),
            );
          },
        );

        downloadFutures.add(downloadFuture);
      }

      await Future.wait(downloadFutures);
    } catch (e) {
      _cancelToken.cancel();
      _controller.add(DownloadResponseDTO(
        progress: 0,
        total: 0,
        errorOccurred: true,
        errorMessage: e.toString(),
      ));
      return;
    }
    _controller.add(DownloadResponseDTO(
      progress: 100,
      total: 100,
      done: true,
    ));
  }

  ///
  void cancelDownload() {
    _cancelToken.cancel();
    _controller.add(DownloadResponseDTO(
      progress: 0,
      total: 0,
      errorOccurred: true,
      errorMessage: 'Download cancelled by user',
    ));
  }
}
