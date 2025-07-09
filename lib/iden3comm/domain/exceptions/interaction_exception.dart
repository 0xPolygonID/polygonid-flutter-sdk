import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

class InteractionNotFoundException extends PolygonIdSDKException {
  final String id;

  InteractionNotFoundException({
    required this.id,
    required super.errorMessage,
    super.error,
  });
}

class InteractionsNotFoundException extends PolygonIdSDKException {
  InteractionsNotFoundException({
    required super.errorMessage,
    super.error,
  });
}

class InvalidInteractionType extends PolygonIdSDKException {
  final InteractionType type;

  InvalidInteractionType({
    required this.type,
    required super.errorMessage,
    super.error,
  });
}
