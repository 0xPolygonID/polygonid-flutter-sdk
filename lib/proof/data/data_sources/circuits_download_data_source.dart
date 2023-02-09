import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class CircuitsDownloadDataSource {
  ///
  Future<bool> circuitsFilesExist() async {
    String fileName = 'circuits.zip';
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    var file = File('$path/$fileName');
    return await file.exists();
  }

  ///
  Future<String> getPathToCircuitZipFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fileName = 'circuits.zip';
    return '$path/$fileName';
  }

  ///
  Future<String> getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    return path;
  }

  ///
  Future<http.StreamedResponse> getStreamedResponseFromServer() async {
    const bucketUrl =
        "https://iden3-circuits-bucket.s3.eu-west-1.amazonaws.com/circuits/v0.2.0-beta/polygonid-keys-2.0.0.zip";

    var request = http.Request('GET', Uri.parse(bucketUrl));

    final http.StreamedResponse response = await http.Client().send(request);
    return response;
  }

  ///
  Future<void> deleteFile(String pathToFile) async {
    var file = File(pathToFile);
    await file.delete();
  }

  ///
  Future<void> writeZipFile({
    required String pathToFile,
    required List<int> zipBytes,
  }) async {
    var file = File(pathToFile);
    await file.writeAsBytes(zipBytes);
  }

  ///
  Future<void> writeCircuitsFileFromZip({
    required List<int> zipBytes,
    required String path,
  }) async {
    final zipDecoder = getItSdk.get<ZipDecoder>(instanceName: 'zipDecoder');
    var archive = zipDecoder.decodeBytes(zipBytes);

    for (var file in archive) {
      var filename = '$path/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }
}
