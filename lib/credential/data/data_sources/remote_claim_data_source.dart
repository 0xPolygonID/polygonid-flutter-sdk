import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

class RemoteClaimDataSource {
  final Client client;
  final StacktraceManager _stacktraceManager;

  RemoteClaimDataSource(this.client, this._stacktraceManager);

  Future<Map<String, dynamic>> getClaimRevocationStatus(
    String revStatusUrl,
  ) async {
    final revStatusUri = Uri.parse(revStatusUrl);
    _stacktraceManager.addTrace(
      "[RemoteClaimDataSource] Getting revocation status from $revStatusUri",
    );
    final revStatusResponse = await client.get(
      revStatusUri,
      headers: {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    _stacktraceManager.addTrace(
      "[RemoteClaimDataSource] Revocation status response: ${revStatusResponse.statusCode} ${revStatusResponse.body}",
    );

    if (revStatusResponse.statusCode == 200) {
      return json.decode(revStatusResponse.body);
    } else if (revStatusResponse.statusCode == 405) {
      final original = Uri.parse(revStatusUrl);
      final state = original.queryParameters['state'];
      if (state == null || state.isEmpty) {
        throw NetworkException(
          errorMessage: "Missing state parameter for 405 redirect handling",
          statusCode: 405,
        );
      }

      // Build new Uri: move state from query to path.
      final filteredQuery = Map<String, String>.from(original.queryParameters)
        ..remove('state');

      final newUri = Uri(
        scheme: original.scheme,
        userInfo: original.userInfo,
        host: original.host,
        port: original.port,
        pathSegments: [...original.pathSegments, state],
        queryParameters: filteredQuery.isEmpty ? null : filteredQuery,
        // omit if empty
        fragment: original.fragment,
      );

      _stacktraceManager.addTrace(
        "[RemoteClaimDataSource] Retrying with transformed URI $newUri",
      );

      return getClaimRevocationStatus(newUri.toString());
    } else {
      _stacktraceManager.addError(
        "[RemoteClaimDataSource] Error getting revocation status: ${revStatusResponse.statusCode} ${revStatusResponse.body}",
      );
      throw NetworkException(
        errorMessage: revStatusResponse.body,
        statusCode: revStatusResponse.statusCode,
      );
    }
  }
}
