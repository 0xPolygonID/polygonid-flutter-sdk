import 'package:flutter/services.dart';

class LocalFilesDataSource {
  Future<List<Uint8List>> loadCircuitFiles(String circuitId) async {
    final circuitDatPath = 'assets/auth/$circuitId.dat';
    final circuitProvingKeyPath = 'assets/auth/$circuitId.zkey';
    ByteData datFile = await rootBundle.load(circuitDatPath);
    ByteData zkeyFile = await rootBundle.load(circuitProvingKeyPath);
    return [datFile.buffer.asUint8List(), zkeyFile.buffer.asUint8List()];
  }
}
