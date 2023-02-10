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
  Future<String> getPathToCircuitZipFileTemp() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fileName = 'circuits_temp.zip';
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
        "https://circuits.polygonid.me/circuits/v1.0.0/polygonid-keys.zip";

    var request = http.Request('GET', Uri.parse(bucketUrl));

    final http.StreamedResponse response = await http.Client().send(request);
    return response;
  }

  ///
  Future<void> deleteFile(String pathToFile) async {
    try {
      var file = File(pathToFile);
      await file.delete();
    } catch (_) {
      // file not found? no problem, we don't need it
    }
  }

  ///
  void renameFile(String pathTofile, String newPathToFile) {
    var file = File(pathTofile);
    file.renameSync(newPathToFile);
  }

  ///
  void writeZipFile({
    required String pathToFile,
    required List<int> zipBytes,
  }) {
    var file = File(pathToFile);
    file.writeAsBytesSync(
      zipBytes,
      mode: FileMode.append,
    );
  }

  ///
  int zipFileSize({required String pathToFile}) {
    var file = File(pathToFile);
    return file.lengthSync();
  }

  ///
  Future<void> writeCircuitsFileFromZip({
    required String path,
    required String zipPath,
  }) async {
    var zipFile = File(zipPath);
    Uint8List zipBytes = zipFile.readAsBytesSync();
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
