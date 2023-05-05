import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../dtos/hash_dto.dart';

class HashMapper extends Mapper<HashDTO, String> {
  @override
  String mapFrom(HashDTO from) {
    return Uint8ArrayUtils.bytesToBigInt(from.data).toString();
  }

  @override
  HashDTO mapTo(String to) {
    return HashDTO(
      data: Uint8ArrayUtils.bigIntToBytes(BigInt.parse(to)),
    );
  }
}
