import 'dart:async';

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
    _cancelToken = CancelToken();

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
      for (CircuitsToDownloadParam param in circuitsToDownload) {
        await _client.download(
          param.bucketUrl,
          param.downloadPath,
          deleteOnError: true,
          cancelToken: _cancelToken,
          onReceiveProgress: (received, total) {
            if (total <= 0) {
              _cancelToken.cancel();
              _controller.add(DownloadResponseDTO(
                progress: 0,
                total: 0,
                errorOccurred: true,
                errorMessage: "Error occurred while downloading circuits",
              ));
              return;
            }
            _controller.add(
              DownloadResponseDTO(
                progress: received,
                total: total,
              ),
            );
          },
        );
      }
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
    _controller.close();
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
