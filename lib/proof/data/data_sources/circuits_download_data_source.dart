import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/download_response_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

@lazySingleton
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
  Future<void> initStreamedResponseFromServer(String downloadPath) async {
    _cancelToken = CancelToken();
    const bucketUrl =
        "https://circuits.polygonid.me/circuits/v1.0.0/polygonid-keys.zip";

    // first we get the file size
    try {
      Response headResponse = await _client.head(bucketUrl);
      int contentLength =
          int.parse(headResponse.headers.value('content-length') ?? "0");
      _downloadSize = contentLength;
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
      Response response = await _client.download(
        bucketUrl,
        downloadPath,
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
