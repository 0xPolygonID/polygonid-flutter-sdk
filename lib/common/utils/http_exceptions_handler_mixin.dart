import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';

mixin HttpExceptionsHandlerMixin {
  void throwExceptionOnStatusCode(int statusCode, String responseBody) {
    if (statusCode == 404) {
      // Not found
      throw ItemNotFoundException(responseBody);
    } else if (statusCode == 500) {
      throw InternalServerErrorException(responseBody);
    } else if (statusCode == 400) {
      throw BadRequestException(responseBody);
    } else if (statusCode == 409) {
      throw ConflictErrorException(responseBody);
    } else if (statusCode > 400) {
      throw UnknownApiException(statusCode);
    }
  }
}
