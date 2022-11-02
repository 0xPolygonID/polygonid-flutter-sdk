import 'package:flutter/services.dart';

class LocalProofFilesDataSource {
  Future<List<Uint8List>> loadCircuitFiles(String circuitId) async {
    final circuitDatPath =
        'packages/polygonid_flutter_sdk/lib/assets/auth/$circuitId.dat';
    final circuitProvingKeyPath =
        'packages/polygonid_flutter_sdk/lib/assets/auth/$circuitId.zkey';
    ByteData datFile = await rootBundle.load(circuitDatPath);
    ByteData zkeyFile = await rootBundle.load(circuitProvingKeyPath);

    return [datFile.buffer.asUint8List(), zkeyFile.buffer.asUint8List()];
  }
}
