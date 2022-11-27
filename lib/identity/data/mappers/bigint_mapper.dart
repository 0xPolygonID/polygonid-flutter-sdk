import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../../common/utils/uint8_list_utils.dart';

class BigIntMapper extends Mapper<Uint8List, BigInt> {
  @override
  BigInt mapFrom(Uint8List from) {
    return Uint8ArrayUtils.bytesToBigInt(from);
  }

  @override
  Uint8List mapTo(BigInt to) {
    return Uint8ArrayUtils.bigIntToBytes(to);
  }
}
