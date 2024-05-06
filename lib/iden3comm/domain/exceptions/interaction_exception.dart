import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';

class InteractionNotFoundException extends PolygonIdSDKException {
  final String id;

  InteractionNotFoundException({
    required this.id,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class InvalidInteractionType extends PolygonIdSDKException {
  final InteractionType type;

  InvalidInteractionType({
    required this.type,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
