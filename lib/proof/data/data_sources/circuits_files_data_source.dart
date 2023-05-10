import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class CircuitsFilesDataSource {
  final Directory directory;

  CircuitsFilesDataSource(this.directory);

  Future<List<Uint8List>> loadCircuitFiles(String circuitId) async {
    String path = directory.path;

    var circuitDatFileName = '$circuitId.dat';
    var circuitDatFilePath = '$path/$circuitDatFileName';
    var circuitDatFile = File(circuitDatFilePath);

    var circuitZkeyFileName = '$circuitId.zkey';
    var circuitZkeyFilePath = '$path/$circuitZkeyFileName';
    var circuitZkeyFile = File(circuitZkeyFilePath);

    return [
      circuitDatFile.readAsBytesSync(),
      circuitZkeyFile.readAsBytesSync()
    ];
  }

  ///
  Future<bool> circuitsFilesExist() {
    String fileName = 'circuits.zip';
    String path = directory.path;
    var file = File('$path/$fileName');

    return file.exists();
  }

  Future<String> getPathToCircuitZipFile() async {
    String path = directory.path;
    String fileName = 'circuits.zip';

    return '$path/$fileName';
  }

  Future<String> getPathToCircuitZipFileTemp() async {
    String path = directory.path;
    String fileName = 'circuits_temp.zip';

    return '$path/$fileName';
  }

  Future<String> getPath() async {
    return Future.value(directory.path);
  }

  Future<void> deleteFile(String pathToFile) async {
    try {
      var file = File(pathToFile);
      await file.delete();
    } catch (_) {
      // file not found? no problem, we don't need it
    }
  }

  void renameFile(String pathTofile, String newPathToFile) {
    var file = File(pathTofile);
    file.renameSync(newPathToFile);
  }

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

  int zipFileSize({required String pathToFile}) {
    var file = File(pathToFile);
    return file.lengthSync();
  }

  Future<void> writeCircuitsFileFromZip({
    required String path,
    required String zipPath,
  }) async {
    var zipFile = File(zipPath);
    Uint8List zipBytes = zipFile.readAsBytesSync();
    final zipDecoder = getItSdk.get<ZipDecoder>();
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
