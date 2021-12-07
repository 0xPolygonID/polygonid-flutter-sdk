import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';
import 'http_exceptions.dart';

Future<String> extractJSON(http.Response response) async {
  return response.body;
}

Future<http.Response> get(String baseAddress, String endpoint,
    {Map<String, String?>? queryParameters}) async {
  var response;
  try {
    var uri;
    baseAddress = baseAddress.replaceFirst("https://", "");
    if (queryParameters != null) {
      uri = Uri.https(baseAddress, '$API_VERSION$endpoint', queryParameters);
    } else {
      uri = Uri.https(baseAddress, '$API_VERSION$endpoint');
    }
    response = await http.get(
      uri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    return returnResponseOrThrowException(response);
  } on IOException {
    throw NetworkException();
  } catch (e) {
    print(e);
    return response;
  }
}

Future<http.Response> post(String baseAddress, String endpoint,
    {Map<String, dynamic>? body}) async {
  var response;
  try {
    var uri;
    baseAddress = baseAddress.replaceFirst("https://", "");
    uri = Uri.https(baseAddress, '$API_VERSION$endpoint');
    response = await http.post(
      uri,
      body: json.encode(body),
      headers: {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return returnResponseOrThrowException(response);
  } on IOException {
    throw NetworkException();
  } catch (e) {
    print(e);
    return response;
  }
}

http.Response returnResponseOrThrowException(http.Response response) {
  if (response.statusCode == 404) {
    // Not found
    throw ItemNotFoundException(response.body);
  } else if (response.statusCode == 500) {
    throw InternalServerErrorException(response.body);
  } else if (response.statusCode == 400) {
    String responseBody = response.body;
    throw BadRequestException(responseBody);
  } else if (response.statusCode == 409) {
    throw ConflictErrorException(response.body);
  } else if (response.statusCode > 400) {
    throw UnknownApiException(response.statusCode);
  } else {
    return response;
  }
}
