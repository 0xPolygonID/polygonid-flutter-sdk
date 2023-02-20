import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../domain/exceptions/credential_exceptions.dart';
import '../dtos/claim_dto.dart';
import '../../../iden3comm/data/dtos/response/fetch/fetch_claim_response_dto.dart';

class RemoteClaimDataSource {
  final Client client;

  RemoteClaimDataSource(this.client);

  Future<Map<String, dynamic>> fetchSchema({required String url}) async {
    try {
      String schemaUrl = url;

      if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
        String fileHash = schemaUrl.toLowerCase().replaceFirst("ipfs://", "");
        schemaUrl = "https://ipfs.io/ipfs/$fileHash";
      }

      var schemaUri = Uri.parse(schemaUrl);
      var schemaResponse = await get(schemaUri);
      if (schemaResponse.statusCode == 200) {
        Map<String, dynamic> schema = json.decode(schemaResponse.body);
        logger().d('schema: $schema');

        return schema;
      } else {
        throw NetworkException(schemaResponse);
      }
    } catch (error) {
      logger().e('schema error: $error');
      throw FetchSchemaException(error);
    }
  }

  Future<Map<String, dynamic>> fetchVocab(
      {required Map<String, dynamic> schema, required String type}) async {
    try {
      Map<String, dynamic>? schemaContext;
      if (schema['@context'] is List) {
        schemaContext = schema['@context'].first;
      } else if (schema['@context'] is Map) {
        schemaContext = schema['@context'];
      }

      if (schemaContext != null &&
          schemaContext[type]["@context"]["poly-vocab"] != null) {
        String vocabId = schemaContext[type]["@context"]["poly-vocab"];
        String vocabUrl = vocabId;
        if (vocabId.toLowerCase().startsWith("ipfs://")) {
          String vocabHash = vocabId.toLowerCase().replaceFirst("ipfs://", "");
          vocabUrl = "https://ipfs.io/ipfs/$vocabHash";
        }
        var vocabUri = Uri.parse(vocabUrl);
        var vocabResponse = await get(vocabUri, headers: {
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.contentTypeHeader: 'application/json',
        });
        if (vocabResponse.statusCode == 200) {
          Map<String, dynamic> vocab = json.decode(vocabResponse.body);
          logger().d('vocab: $vocab');

          return vocab;
        } else {
          throw NetworkException(vocabResponse);
        }
      } else {
        throw UnsupportedSchemaFetchVocabException(schema);
      }
    } catch (error) {
      logger().e('vocab error: $error');
      throw FetchVocabException(error);
    }
  }

  Future<Map<String, dynamic>> getClaimRevocationStatus(
      String revStatusUrl) async {
    var revStatusUri = Uri.parse(revStatusUrl);
    var revStatusResponse = await get(revStatusUri, headers: {
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
