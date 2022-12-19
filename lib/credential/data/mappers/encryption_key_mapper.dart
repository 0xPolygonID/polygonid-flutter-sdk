import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

class EncryptionKeyMapper extends FromMapper<String,Key>{
  @override
  Key mapFrom(String from) {
    return Key.fromBase16(from);
  }
}