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
import 'package:polygonid_flutter_sdk/common/utils/http_exceptions_handler_mixin.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/credential/response/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

class RemoteIden3commDataSource {
  final http.Client client;

  RemoteIden3commDataSource(this.client);

  Future<http.Response> authWithToken({
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
        if (kDebugMode) {
          print(
              'Auth Error: code: ${response.statusCode} msg: ${response.body}');
        }
        logger().d(
            'Auth Error: code: ${response.statusCode} msg: ${response.body}');
        throw NetworkException(response);
      } else {
        return response;
      }
    });
  }

  Future<ClaimDTO> fetchClaim(
      {required String authToken, required String url, required String did}) {
    return Future.value(Uri.parse(url))
        .then((uri) => client.post(
              uri,
              body: authToken,
              headers: {
                HttpHeaders.acceptHeader: '*/*',
                HttpHeaders.contentTypeHeader: 'text/plain',
              },
            ))
        .then((response) {
      if (response.statusCode == 200) {
        FetchClaimResponseDTO fetchResponse =
            FetchClaimResponseDTO.fromJson(json.decode(response.body));

        if (fetchResponse.type == FetchClaimResponseType.issuance) {
          return ClaimDTO(
              id: fetchResponse.credential.id,
              issuer: fetchResponse.from,
              did: did,
              type: fetchResponse.credential.credentialSubject.type,
              expiration: fetchResponse.credential.expirationDate,
              info: fetchResponse.credential);
        } else {
          throw UnsupportedFetchClaimTypeException(response);
        }
      } else {
        logger().d(
            'fetchClaim Error: code: ${response.statusCode} msg: ${response.body}');
        throw NetworkException(response);
      }
    });
  }

  Future<Map<String, dynamic>> fetchSchema({required String url}) async {
    try {
      String schemaUrl = url;

      if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
        String fileHash = schemaUrl.replaceFirst("ipfs://", "");
        schemaUrl = "https://ipfs.io/ipfs/$fileHash";
      }

      var schemaUri = Uri.parse(schemaUrl);

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
      if (schemaResponse.statusCode == 200) {
        Map<String, dynamic> schema = json.decode(schemaResponse.data);

        return schema;
      } else {
        throw NetworkException(schemaResponse);
      }
    } catch (error) {
      throw FetchSchemaException(error);
    }
  }
}
