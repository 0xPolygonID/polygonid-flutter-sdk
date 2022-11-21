import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/common/utils/http_exceptions_handler_mixin.dart';

import '../../../common/domain/domain_logger.dart';

class RemoteIden3commDataSource with HttpExceptionsHandlerMixin {
  final Client client;

  RemoteIden3commDataSource(this.client);

  Future<Response> authWithToken({
    required String token,
    required String url,
  }) async {
    return Future.value(Uri.parse(url))
        .then((uri) => client.post(
              uri,
              body: token,
              headers: {
                HttpHeaders.acceptHeader: '*/*',
                HttpHeaders.contentTypeHeader: 'text/plain',
              },
            ))
        .then((response) {
      if (response.statusCode != 200) {
        logger().d(
            'Auth Error: code: ${response.statusCode} msg: ${response.body}');
        throwExceptionOnStatusCode(response.statusCode, response.body);
      }
      return response;
    });
  }
}
