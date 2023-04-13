import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

class InteractionNotFoundException implements Exception {
  final int id;

  InteractionNotFoundException(this.id);
}

class InvalidInteractionType implements Exception {
  final InteractionType type;

  InvalidInteractionType(this.type);
}
