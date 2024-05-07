import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

class RemoteClaimDataSource {
  final Client client;
  final StacktraceManager _stacktraceManager;

  RemoteClaimDataSource(
    this.client,
    this._stacktraceManager,
  );

  Future<Map<String, dynamic>> getClaimRevocationStatus(
      String revStatusUrl) async {
    var revStatusUri = Uri.parse(revStatusUrl);
    _stacktraceManager.addTrace(
        "[RemoteClaimDataSource] Getting revocation status from $revStatusUri");
    var revStatusResponse = await client.get(revStatusUri, headers: {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    _stacktraceManager.addTrace(
        "[RemoteClaimDataSource] Revocation status response: ${revStatusResponse.statusCode} ${revStatusResponse.body}");
    if (revStatusResponse.statusCode == 200) {
      String revStatus = (revStatusResponse.body);

      return json.decode(revStatus);
    } else {
      throw NetworkException(
        errorMessage: revStatusResponse.body,
        statusCode: revStatusResponse.statusCode,
      );
    }
  }
}
