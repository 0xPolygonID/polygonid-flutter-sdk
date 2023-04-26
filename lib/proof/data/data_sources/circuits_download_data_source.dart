import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class CircuitsDownloadDataSource {


  ///
  Future<http.StreamedResponse> getStreamedResponseFromServer() async {
    const bucketUrl =
        "https://circuits.polygonid.me/circuits/v1.0.0/polygonid-keys.zip";

    var request = http.Request('GET', Uri.parse(bucketUrl));

    final http.StreamedResponse response = await http.Client().send(request);
    return response;
  }






}
