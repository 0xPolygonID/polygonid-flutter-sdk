import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/hash_entity.dart';
import '../dtos/hash_dto.dart';

class HashMapper extends Mapper<HashDTO, HashEntity> {
  @override
  HashEntity mapFrom(HashDTO from) {
    return HashEntity(
      data: from.data,
    );
  }

  @override
  HashDTO mapTo(HashEntity to) {
    return HashDTO(
      data: to.data,
    );
  }
}
