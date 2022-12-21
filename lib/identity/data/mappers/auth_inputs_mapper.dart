import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';

class AuthInputsMapper extends FromMapper<String, Uint8List> {
  @override
  Uint8List mapFrom(String from) {
    return Uint8ArrayUtils.uint8ListfromString(from);
  }
}
