import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';

import '../../../common/utils/uint8_list_utils.dart';

class QMapper extends FromMapper<String, String> {
  @override
  String mapFrom(String from) {
    // Sha256
    Uint8List sha = Uint8List.fromList(
        sha256.convert(Uint8ArrayUtils.uint8ListfromString(from)).bytes);

    // Endianness
    BigInt endian = Uint8ArrayUtils.leBuff2int(sha);

    // Check Q
    return endian.qNormalize().toString();
  }
}
