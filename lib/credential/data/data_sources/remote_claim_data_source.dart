import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../common/data/exceptions/network_exceptions.dart';

class RemoteClaimDataSource {
  final Client client;

  RemoteClaimDataSource(this.client);

  Future<Map<String, dynamic>> getClaimRevocationStatus(
      String revStatusUrl) async {
    var revStatusUri = Uri.parse(revStatusUrl);
    var revStatusResponse = await client.get(revStatusUri, headers: {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (revStatusResponse.statusCode == 200) {
      String revStatus = (revStatusResponse.body);

      return json.decode(revStatus);
    } else {
      throw NetworkException(revStatusResponse);
    }
  }
}
