import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:jose_plus/jose.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/collection_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/pinata_gateway_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/protocol_message_type.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_encrypted_issuance_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_issuance_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:web3dart/crypto.dart';

class RemoteIden3commDataSource {
  final Dio dio;
  final StacktraceManager _stacktraceManager;

  RemoteIden3commDataSource(this.dio, this._stacktraceManager);

  Future<Response> authWithToken({
    required String token,
    required String url,
  }) async {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      _stacktraceManager.addError(
        'authWithToken error: url is invalid\nurl: $url',
      );
      throw NetworkException(errorMessage: "url is invalid", statusCode: 0);
    }

    try {
      final response = await dio.post(
        url,
        data: token,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.contentTypeHeader: 'text/plain',
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode != 200) {
        _stacktraceManager.addError(
          'Auth Error: $url response with\ncode: ${response.statusCode}\nmsg: ${response.data}',
        );
        throw NetworkException(
          errorMessage: response.data,
          statusCode: response.statusCode ?? 0,
        );
      } else {
        return response;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        _stacktraceManager.addError(
          'authWithToken error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        throw NetworkException(
          errorMessage:
              "Connection timeout while sending auth token to the requester.",
          statusCode: e.response?.statusCode ?? 0,
        );
      } else {
        _stacktraceManager.addError(
          'authWithToken error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        rethrow;
      }
    } catch (e) {
      logger().e('authWithToken error: $e');
      rethrow;
    }
  }

  Future<CredentialDTO> refreshCredential({
    required String authToken,
    required String url,
    required String profileDid,
    required List<JsonWebKey> keys,
  }) async {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      _stacktraceManager.addError(
        'refreshCredential error: url is invalid\nurl: $url',
      );
      throw NetworkException(errorMessage: "Invalid url", statusCode: 0);
    }

    try {
      final response = await dio.post(
        url,
        data: authToken,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.contentTypeHeader: 'text/plain',
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode != 200) {
        _stacktraceManager.addError(
          'refreshCredential Error: $url response with\ncode: ${response.statusCode}\nmsg: ${response.data}',
          log: true,
        );
        throw NetworkException(
          errorMessage: response.data,
          statusCode: response.statusCode ?? 0,
        );
      } else {
        final type = response.data['type'] as String? ?? 'unknown';

        if (type == ProtocolMessageType.credentialIssuanceResponseMessageType) {
          final message = CredentialIssuanceMessage.fromJson(response.data);
          return CredentialDTO(
            id: message.body.credential.id,
            issuer: message.from,
            did: profileDid,
            type: message.body.credential.credentialSubject.type,
            expiration: message.body.credential.expirationDate,
            info: message.body.credential,
            credentialRawValue: json.encode(response.data),
          );
        } else if (type ==
            ProtocolMessageType.credentialEncryptedIssuanceResponseType) {
          final message = CredentialEncryptedIssuanceResponse.fromJson(
            response.data,
          );
          final requiredKeyIds = message.body.data.recipients
              .map((r) => r.header.keyId!)
              .toList();

          JsonWebKey? eligibleKey = keys.firstWhereOrNull((k) {
            return requiredKeyIds.any((keyId) => keyId.endsWith(k.alias));
          });
          if (eligibleKey == null) {
            _stacktraceManager.addError(
              "[RemoteIden3commDataSource] refreshCredential: No eligible keys found for decryption",
            );
            throw Exception(
              "No eligible keys found for decrypting the credential.",
            );
          }

          final decryptedCred = PolygonIdSdk.I.util.decryptEncryptedCredential(
            response.data,
            [eligibleKey.toJson()],
          );

          final claimDTO = CredentialDTO(
            id: decryptedCred.id,
            issuer: message.from,
            did: profileDid,
            type: decryptedCred.credentialSubject.type,
            expiration: decryptedCred.expirationDate,
            info: decryptedCred,
            credentialRawValue: jsonEncode(response.data),
          );
          logger().i(
            "[RemoteIden3commDataSource] fetchClaim: ${claimDTO.info.toJson()}",
          );
          return claimDTO;
        } else {
          _stacktraceManager.addError(
            "[RemoteIden3commDataSource] fetchClaim: UnsupportedFetchClaimTypeException",
          );
          throw UnsupportedFetchClaimTypeException(
            type: type,
            errorMessage:
                'Unsupported fetch claim type: $type\nShould be ${ProtocolMessageType.credentialIssuanceResponseMessageType}',
          );
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        _stacktraceManager.addError(
          'refreshCredential error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        throw NetworkException(
          errorMessage: "Connection timeout while refreshing credential.",
          statusCode: e.response?.statusCode ?? 0,
        );
      } else {
        _stacktraceManager.addError(
          'refreshCredential error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        rethrow;
      }
    } catch (e) {
      logger().e('refreshCredential error: $e');
      rethrow;
    }
  }

  Future<CredentialDTO> fetchClaim({
    required String authToken,
    required String url,
    required String did,
    required List<JsonWebKey> keys,
  }) async {
    _stacktraceManager.logTrace(
      "[RemoteIden3commDataSource] fetchClaim: did:$did\nurl: $url\nauthToken: $authToken",
    );

    try {
      final response = await dio.post(
        url,
        data: authToken,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.contentTypeHeader: 'text/plain',
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      _stacktraceManager.logTrace(
        "[RemoteIden3commDataSource] fetchClaim: ${response.statusCode} ${response.data}",
      );
      if (response.statusCode == 200) {
        final type =
            (response.data['type'] as Object?)?.toString() ?? 'unknown';

        if (type == ProtocolMessageType.credentialIssuanceResponseMessageType) {
          final message = CredentialIssuanceMessage.fromJson(response.data);
          logger().i(
            "[RemoteIden3commDataSource] fetchClaim: ${message.body.credential.toJson()}",
          );
          final claimDTO = CredentialDTO(
            id: message.body.credential.id,
            issuer: message.from,
            did: did,
            type: message.body.credential.credentialSubject.type,
            expiration: message.body.credential.expirationDate,
            info: message.body.credential,
            credentialRawValue: jsonEncode(response.data),
          );
          logger().i(
            "[RemoteIden3commDataSource] fetchClaim: ${claimDTO.info.toJson()}",
          );
          return claimDTO;
        } else if (type ==
            ProtocolMessageType.credentialEncryptedIssuanceResponseType) {
          final message = CredentialEncryptedIssuanceResponse.fromJson(
            response.data,
          );

          final requiredKeyIds = message.body.data.recipients
              .map((r) => r.header.keyId!)
              .toList();

          JsonWebKey? eligibleKey = keys.firstWhereOrNull((k) {
            return requiredKeyIds.any((keyId) => keyId.endsWith(k.alias));
          });
          if (eligibleKey == null) {
            _stacktraceManager.addError(
              "[RemoteIden3commDataSource] refreshCredential: No eligible keys found for decryption",
            );
            throw Exception(
              "No eligible keys found for decrypting the credential.",
            );
          }

          final decryptedCred = PolygonIdSdk.I.util.decryptEncryptedCredential(
            response.data,
            [eligibleKey.toJson()],
          );

          final claimDTO = CredentialDTO(
            id: decryptedCred.id,
            issuer: message.from,
            did: did,
            type: decryptedCred.credentialSubject.type,
            expiration: decryptedCred.expirationDate,
            info: decryptedCred,
            credentialRawValue: jsonEncode(response.data),
          );
          logger().i(
            "[RemoteIden3commDataSource] fetchClaim: ${claimDTO.info.toJson()}",
          );
          return claimDTO;
        } else {
          _stacktraceManager.addError(
            "[RemoteIden3commDataSource] fetchClaim: UnsupportedFetchClaimTypeException",
          );
          throw UnsupportedFetchClaimTypeException(
            type: type,
            errorMessage:
                'Unsupported fetch claim type: $type\nShould be ${ProtocolMessageType.credentialIssuanceResponseMessageType} or ${ProtocolMessageType.credentialEncryptedIssuanceResponseType}',
          );
        }
      } else {
        _stacktraceManager.logError(
          'fetchClaim Error: $url response with\ncode: ${response.statusCode}\nmsg: ${response.data}',
        );
        throw NetworkException(
          errorMessage: response.data,
          statusCode: response.statusCode ?? 0,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        _stacktraceManager.addError(
          'fetchClaim error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        throw NetworkException(
          errorMessage: "Connection timeout while fetching claim.",
          statusCode: e.response?.statusCode ?? 0,
        );
      } else {
        _stacktraceManager.addError(
          'fetchClaim error: $url response with\ncode: ${e.response?.statusCode}\nmsg: ${e.response?.data}',
        );
        rethrow;
      }
    } catch (e) {
      logger().e('fetchClaim error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchSchema({required String url}) async {
    try {
      String schemaUrl = url;

      if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
        String fileHash = schemaUrl.replaceFirst("ipfs://", "");

        String? pinataGatewayUrl = await PinataGatewayUtils()
            .retrievePinataGatewayUrlFromEnvironment(fileHash: fileHash);

        if (pinataGatewayUrl != null) {
          schemaUrl = pinataGatewayUrl;
        } else {
          schemaUrl = "https://ipfs.io/ipfs/$fileHash";
        }
      }

      var schemaUri = Uri.parse(schemaUrl);
      _stacktraceManager.logTrace(
        "[RemoteIden3commDataSource] fetchSchema original url: $url\nschemaUrl: $schemaUrl",
      );

      Dio dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      dio.interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(path),
            policy: CachePolicy.request,
            maxStale: const Duration(days: 14),
            priority: CachePriority.high,
          ),
        ),
      );

      final schemaResponse = await dio.get(schemaUri.toString());
      _stacktraceManager.logTrace(
        "[RemoteIden3commDataSource] fetchSchema: ${schemaResponse.statusCode} ${schemaResponse.data}",
      );
      if (schemaResponse.statusCode == 200 ||
          schemaResponse.statusCode == 304) {
        Map<String, dynamic> schema = {};
        bool isMap = schemaResponse.data is Map<String, dynamic>;
        if (!isMap) {
          schema = json.decode(schemaResponse.data);
        } else {
          schema = schemaResponse.data;
        }

        return schema;
      } else {
        _stacktraceManager.addError(
          "[RemoteIden3commDataSource] fetchSchema: ${schemaResponse.statusCode} ${schemaResponse.data}",
        );
        throw NetworkException(
          errorMessage: schemaResponse.data.toString(),
          statusCode: schemaResponse.statusCode ?? 0,
        );
      }
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        "[RemoteIden3commDataSource] fetchSchema: $error",
      );
      throw FetchSchemaException(
        error: error,
        errorMessage: 'Error while fetching schema',
      );
    }
  }

  Future<Map<String, dynamic>> fetchDisplayType({required String url}) async {
    try {
      String displayTypeUrl = url;

      if (displayTypeUrl.toLowerCase().startsWith("ipfs://")) {
        String ipfsHash = displayTypeUrl.replaceFirst("ipfs://", "");

        String? pinataGatewayUrl = await PinataGatewayUtils()
            .retrievePinataGatewayUrlFromEnvironment(fileHash: ipfsHash);

        if (pinataGatewayUrl != null) {
          displayTypeUrl = pinataGatewayUrl;
        } else {
          displayTypeUrl = "https://ipfs.io/ipfs/$ipfsHash";
        }
      }

      final displayTypeUri = Uri.parse(displayTypeUrl);
      _stacktraceManager.addTrace(
        "[RemoteIden3commDataSource] fetchDisplayType original url: $url",
      );

      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      dio.interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(path),
            policy: CachePolicy.request,
            maxStale: const Duration(days: 14),
            priority: CachePriority.high,
          ),
        ),
      );

      final response = await dio.get(displayTypeUri.toString());
      _stacktraceManager.addTrace(
        "[RemoteIden3commDataSource] fetchDisplayType: ${response.statusCode} ${response.data}",
      );
      if (response.statusCode == 200 || response.statusCode == 304) {
        Map<String, dynamic> data = {};
        bool isMap = response.data is Map<String, dynamic>;
        if (!isMap) {
          data = json.decode(response.data);
        } else {
          data = response.data;
        }

        return data;
      } else {
        _stacktraceManager.addError(
          "[RemoteIden3commDataSource] fetchDisplayType: ${response.statusCode} ${response.data}",
        );
        throw NetworkException(
          errorMessage: response.data.toString(),
          statusCode: response.statusCode ?? 0,
        );
      }
    } catch (error) {
      _stacktraceManager.addError(
        "[RemoteIden3commDataSource] fetchDisplayType: $error",
      );
      throw FetchDisplayTypeException(
        error: error,
        errorMessage: error.toString(),
      );
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

extension on JsonWebKey {
  String get alias {
    final alg = this['alg'] as String;

    final n = this['n'] as String;
    final e = this['e'] as String;
    final bytes = utf8.encode(n.toString() + e.toString());
    final keccakBytes = keccak256(bytes);
    final keccak = keccakBytes.bytesToHex(include0x: true);

    return "$alg:$keccak";
  }
}
