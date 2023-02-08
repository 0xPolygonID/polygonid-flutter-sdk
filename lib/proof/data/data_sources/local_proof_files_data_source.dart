import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LocalProofFilesDataSource {
  Future<List<Uint8List>> loadCircuitFiles(String circuitId) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    var circuitDatFileName = '$circuitId.dat';
    var circuitDatFilePath = '$path/$circuitDatFileName';
    var circuitDatFile = File(circuitDatFilePath);

    var circuitZkeyFileName = '$circuitId.zkey';
    var circuitZkeyFilePath = '$path/$circuitZkeyFileName';
    var circuitZkeyFile = File(circuitZkeyFilePath);

    return [circuitDatFile.readAsBytesSync(), circuitZkeyFile.readAsBytesSync()];
  }
}
