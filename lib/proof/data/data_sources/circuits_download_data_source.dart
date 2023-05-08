import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/download_response_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class CircuitsDownloadDataSource {
  //final Client _client;
  final Dio _client;
  CancelToken _cancelToken = CancelToken();

  CircuitsDownloadDataSource(this._client);

  StreamController<DownloadResponseDTO> _controller =
      StreamController<DownloadResponseDTO>();

  Stream<DownloadResponseDTO> get downloadStream => _controller.stream;

  int _downloadSize = 0;

  /// downloadSize
  int get downloadSize => _downloadSize;

  ///
  Future<void> initStreamedResponseFromServer(String downloadPath) async {
    const bucketUrl =
        "https://circuits.polygonid.me/circuits/v1.0.0/polygonid-keys.zip";

    // first we get the file size
    Response headResponse = await _client.head(bucketUrl);
    int contentLength =
        int.parse(headResponse.headers.value('content-length') ?? "0");
    _downloadSize = contentLength;

    try {
      Response response = await _client.download(
        bucketUrl,
        downloadPath,
        deleteOnError: true,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          //logger().d("received: $received, total: $total");
          if (total <= 0) {
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
      _controller.add(DownloadResponseDTO(
        progress: 0,
        total: 0,
        errorOccurred: true,
        errorMessage: e.toString(),
      ));
    }
    _controller.add(DownloadResponseDTO(
      progress: 100,
      total: 100,
      done: true,
    ));
    _controller.close();
    _client.close();


    /*Response response = await _client.get(
      bucketUrl,
      options: Options(
        responseType: ResponseType.bytes,
      ),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          _controller.add(DownloadResponseDTO(
            newBytes: Uint8List(0),
            errorOccurred: true,
            errorMessage: "Error occurred while downloading circuits",
          ));
        }
        _controller.add(
          DownloadResponseDTO(
            newBytes: received,
          ),
        );
      },
    );*/
    //var request = Request('GET', Uri.parse(bucketUrl));

    //final StreamedResponse response = await client.send(request);
    /*_downloadSize = response.contentLength ?? 0;

    response.stream.listen(
      (List<int> newBytes) {
        _controller.add(
          DownloadResponseDTO(
            newBytes: newBytes,
          ),
        );
      },
      onDone: () {
        _controller.add(DownloadResponseDTO(
          newBytes: Uint8List(0),
          done: true,
        ));
        _controller.close();
        _client.close();
      },
      onError: (e) {
        _controller.add(DownloadResponseDTO(
          newBytes: Uint8List(0),
          errorOccurred: true,
          errorMessage: e.toString(),
        ));
        _controller.close();
        _client.close();
      },
      cancelOnError: true,
    );*/
  }

  ///
  void cancelDownload() {
    _controller.add(DownloadResponseDTO(
      progress: 0,
      total: 0,
      errorOccurred: true,
      errorMessage: 'Download cancelled by user',
    ));
    _cancelToken.cancel();
    _client.close();
    _controller.close();
  }
}
