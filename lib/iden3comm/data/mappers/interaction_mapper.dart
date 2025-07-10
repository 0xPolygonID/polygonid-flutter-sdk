import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

/// While it would be better to have the json serialization out of the Domain layer,
/// we are keeping it there for convenience.
class InteractionMapper
    extends Mapper<Map<String, dynamic>, InteractionEntity> {
  @override
  InteractionEntity mapFrom(Map<String, dynamic> from) {
    return InteractionEntity.fromJson(from);
  }

  @override
  Map<String, dynamic> mapTo(InteractionEntity to) {
    return to.toJson();
  }
}
