import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/common/utils/http_exceptions_handler_mixin.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';

class RemoteIdentityDataSource with HttpExceptionsHandlerMixin {
  final Client client;

  RemoteIdentityDataSource(this.client);

  Future<Response> authWithToken(String token, AuthRequest request) async {
    String endpoint = request.body!
        .callbackUrl!; //TODO maybe is not right choice to force null safety

    try {
      var uri = Uri.parse(endpoint);
      Response response = await client.post(
        uri,
        headers: {
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.contentTypeHeader: 'text/plain',
        },
      );

      throwExceptionOnStatusCode(response.statusCode, response.body);
      return response;
    } catch (e) {
      throw Exception();
    }
  }
}
