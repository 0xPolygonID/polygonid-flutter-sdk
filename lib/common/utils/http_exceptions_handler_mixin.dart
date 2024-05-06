import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';

mixin HttpExceptionsHandlerMixin {
  void throwExceptionOnStatusCode(int statusCode, String responseBody) {
    if (statusCode == 404) {
      // Not found
      throw ItemNotFoundException(
          errorMessage: "statusCode: 404\n$responseBody");
    } else if (statusCode == 500) {
      throw InternalServerErrorException(
          errorMessage: "statusCode: 500\n$responseBody");
    } else if (statusCode == 400) {
      throw BadRequestException(errorMessage: "statusCode: 400\n$responseBody");
    } else if (statusCode == 409) {
      throw ConflictErrorException(
          errorMessage: "statusCode: 409\n$responseBody");
    } else if (statusCode > 400) {
      throw UnknownApiException(
          httpCode: statusCode,
          errorMessage: "statusCode: $statusCode\n$responseBody");
    } else {
      throw NetworkException(
          statusCode: statusCode, errorMessage: responseBody);
    }
  }
}
