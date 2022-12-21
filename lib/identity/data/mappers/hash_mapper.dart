import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:web3dart/crypto.dart';

class HashMapper extends FromMapper<String, String> {
  final HexMapper _hexMapper;

  HashMapper(this._hexMapper);

  @override
  String mapFrom(String from) {
    return bytesToInt(_hexMapper.mapTo(from)).toString();
  }
}
