import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

class ZKProofMapper extends FromMapper<Map<String, dynamic>, ZKProofEntity> {
  @override
  ZKProofEntity mapFrom(Map<String, dynamic> from) {
    return ZKProofEntity.fromJson(from);
  }
}
