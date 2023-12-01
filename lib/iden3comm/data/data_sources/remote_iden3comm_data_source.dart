import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/http_exceptions_handler_mixin.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/credential/response/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

class RemoteIden3commDataSource {
  final http.Client client;
  final StacktraceManager _stacktraceManager;

  RemoteIden3commDataSource(
    this.client,
    this._stacktraceManager,
  );

  Future<http.Response> authWithToken({
    required String token,
    required String url,
  }) async {
    return Future.value(Uri.parse(url)).then((uri) {
      _stacktraceManager
          .addTrace("[RemoteIden3commDataSource] authWithToken: $uri");
      return client.post(
        uri,
        body: token,
        headers: {
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.contentTypeHeader: 'text/plain',
          HttpHeaders.acceptCharsetHeader: 'utf-8',
        },
      );
    }).then((response) {
      _stacktraceManager.addTrace(
          "[RemoteIden3commDataSource] authWithToken: ${response.statusCode} ${response.body}");
      if (response.statusCode != 200) {
        logger().d(
            'Auth Error: code: ${response.statusCode} msg: ${response.body}');
        _stacktraceManager.addError(
            'Auth Error: $url response with\ncode: ${response.statusCode}\nmsg: ${response.body}');
        throw NetworkException(response);
      } else {
        return response;
      }
    });
  }

  Future<ClaimDTO> fetchClaim({
    required String authToken,
    required String url,
    required String did,
  }) async {
    _stacktraceManager.addTrace(
        "[RemoteIden3commDataSource] fetchClaim: did:$did\nurl: $url\nauthToken: $authToken");

    Dio dio = Dio();
    Response response = await dio.post(url,
        data: authToken,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptCharsetHeader: 'utf-8',
          },
        ));

    _stacktraceManager.addTrace(
        "[RemoteIden3commDataSource] fetchClaim: ${response.statusCode} ${response.data}");
    if( response.statusCode != 200){
      logger().d(
          'fetchClaim Error: code: ${response.statusCode} msg: ${response.data}');
      _stacktraceManager.addError(
          'fetchClaim Error: $url response with\ncode: ${response.statusCode}\nmsg: ${response.data}');
      throw NetworkException(response);
    }

    FetchClaimResponseDTO fetchResponse =
    FetchClaimResponseDTO.fromJson(json.decode(response.data));

    if (fetchResponse.type != FetchClaimResponseType.issuance) {
      _stacktraceManager.addTrace(
          "[RemoteIden3commDataSource] fetchClaim: UnsupportedFetchClaimTypeException");
      _stacktraceManager.addError(
          "[RemoteIden3commDataSource] fetchClaim: UnsupportedFetchClaimTypeException");
      throw UnsupportedFetchClaimTypeException(response);
    }

    return ClaimDTO(
        id: fetchResponse.credential.id,
        issuer: fetchResponse.from,
        did: did,
        type: fetchResponse.credential.credentialSubject.type,
        expiration: fetchResponse.credential.expirationDate,
        info: fetchResponse.credential);
  }

  Future<Map<String, dynamic>> fetchSchema({required String url}) async {
    try {
      String schemaUrl = url;

      if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
        String fileHash = schemaUrl.replaceFirst("ipfs://", "");
        schemaUrl = "https://ipfs.io/ipfs/$fileHash";
      }

      var schemaUri = Uri.parse(schemaUrl);
      _stacktraceManager.addTrace(
          "[RemoteIden3commDataSource] fetchSchema original url: $url");

      Dio dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      dio.interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(path),
            policy: CachePolicy.refreshForceCache,
            hitCacheOnErrorExcept: [],
            maxStale: const Duration(days: 14),
            priority: CachePriority.high,
          ),
        ),
      );

      var schemaResponse = await dio.get(schemaUri.toString());
      _stacktraceManager.addTrace(
          "[RemoteIden3commDataSource] fetchSchema: ${schemaResponse.statusCode} ${schemaResponse.data}");
      if (schemaResponse.statusCode == 200) {
        Map<String, dynamic> schema = {};
        bool isMap = schemaResponse.data is Map<String, dynamic>;
        if (!isMap) {
          schema = json.decode(schemaResponse.data);
        } else {
          schema = schemaResponse.data;
        }

        return schema;
      } else {
        _stacktraceManager.addTrace(
            "[RemoteIden3commDataSource] fetchSchema: ${schemaResponse.statusCode} ${schemaResponse.data}");
        _stacktraceManager.addError(
            "[RemoteIden3commDataSource] fetchSchema: ${schemaResponse.statusCode} ${schemaResponse.data}");
        throw NetworkException(schemaResponse);
      }
    } catch (error) {
      _stacktraceManager
          .addTrace("[RemoteIden3commDataSource] fetchSchema: $error");
      _stacktraceManager
          .addError("[RemoteIden3commDataSource] fetchSchema: $error");
      throw FetchSchemaException(error);
    }
  }

  ///
  Future<void> cleanSchemaCache() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    await HiveCacheStore(path).clean();
    return;
  }
}
