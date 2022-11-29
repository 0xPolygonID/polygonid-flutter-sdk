import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:web3dart/crypto.dart';

class HexMapper extends Mapper<Uint8List, String> {
  @override
  String mapFrom(Uint8List from) {
    return bytesToHex(from).isNotEmpty ? bytesToHex(from) : "0";
  }

  @override
  Uint8List mapTo(String to) {
    return hexToBytes(to);
  }
}
