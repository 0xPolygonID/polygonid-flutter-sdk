import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../../common/utils/uint8_list_utils.dart';
import '../../domain/entities/hash_entity.dart';
import '../dtos/hash_dto.dart';

class HashMapper extends Mapper<HashDTO, HashEntity> {
  @override
  HashEntity mapFrom(HashDTO from) {
    return HashEntity(
      data: Uint8ArrayUtils.bytesToBigInt(from.data).toString(),
    );
  }

  @override
  HashDTO mapTo(HashEntity to) {
    return HashDTO(
      data: Uint8ArrayUtils.bigIntToBytes(BigInt.parse(to.data)),
    );
  }
}
