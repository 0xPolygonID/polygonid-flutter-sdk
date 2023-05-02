import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:http/http.dart';

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/download_response_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class CircuitsDownloadDataSource {
  final Client _client;

  CircuitsDownloadDataSource(this._client);

  StreamController<DownloadResponseDTO> _controller =
      StreamController<DownloadResponseDTO>();

  Stream<DownloadResponseDTO> get downloadStream => _controller.stream;

  int _downloadSize = 0;

  /// downloadSize
  int get downloadSize => _downloadSize;

  ///
  Future<void> initStreamedResponseFromServer() async {
    Client client = Client();

    const bucketUrl =
        "https://circuits.polygonid.me/circuits/v1.0.0/polygonid-keys.zip";

    var request = Request('GET', Uri.parse(bucketUrl));

    final StreamedResponse response = await client.send(request);
    _downloadSize = response.contentLength ?? 0;



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
    );
  }

  ///
  void cancelDownload() {
    _controller.add(DownloadResponseDTO(
      newBytes: Uint8List(0),
      errorOccurred: true,
      errorMessage: 'Download cancelled by user',
    ));
    _client.close();
  }
}
