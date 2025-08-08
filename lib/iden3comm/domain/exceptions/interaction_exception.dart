import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

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
