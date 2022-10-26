import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../env/sdk_env.dart';
import '../../domain/exceptions/credential_exceptions.dart';
import '../dtos/claim_dto.dart';
import '../dtos/credential_dto.dart';
import '../dtos/credential_proofs/credential_proof_dto.dart';
import '../dtos/fetch_claim_response_dto.dart';
import '../dtos/revocation_status.dart';

class RemoteClaimDataSource {
  final Client client;

  RemoteClaimDataSource(this.client);

  Future<ClaimDTO> fetchClaim(
      {required String token,
      required String url,
      required String identifier}) {
    return Future.value(Uri.parse(url))
        .then((uri) => client.post(
              uri,
              body: token,
              headers: {
                HttpHeaders.acceptHeader: '*/*',
                HttpHeaders.contentTypeHeader: 'text/plain',
              },
            ))
        .then((response) async {
      if (response.statusCode == 200) {
        FetchClaimResponseDTO fetchResponse =
            FetchClaimResponseDTO.fromJson(json.decode(response.body));

        //fetch schema
        Map<String, dynamic>? schema = await fetchSchema(
            url: fetchResponse.credential.credentialSchema.id);
        //fetch vocab
        Map<String, dynamic>? vocab = await fetchVocab(
            schema: schema,
            type: fetchResponse.credential.credentialSubject.type);

        if (fetchResponse.type == FetchClaimResponseType.issuance) {
          return ClaimDTO(
              id: fetchResponse.credential.id,
              issuer: fetchResponse.from,
              identifier: identifier,
              type: fetchResponse.credential.credentialSubject.type,
              expiration: fetchResponse.credential.expiration,
              credential: fetchResponse.credential,
              schema: schema,
              vocab: vocab);
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

  Future<Map<String, dynamic>?> fetchSchema({required String url}) async {
    try {
      //fetch schema and save it
      String schemaId = url;
      String schemaUrl = schemaId;
      if (schemaId.toLowerCase().startsWith("ipfs://")) {
        String fileHash = schemaId.toLowerCase().replaceFirst("ipfs://", "");
        schemaUrl = "https://ipfs.io/ipfs/$fileHash";
      }
      var schemaUri = Uri.parse(schemaUrl);
      var schemaResponse = await get(schemaUri);
      if (schemaResponse.statusCode == 200) {
        Map<String, dynamic>? schema = json.decode(schemaResponse.body);
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

  Future<Map<String, dynamic>?> fetchVocab(
      {required Map<String, dynamic>? schema, required String type}) async {
    try {
      // fetch vocab from schema
      Map<String, dynamic>? schemaContext;
      if (schema!['@context'] is List) {
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
          Map<String, dynamic>? vocab = json.decode(vocabResponse.body);
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

  Future<RevocationStatus?> getClaimRevocationStatus(CredentialDTO credential,
      RemoteIdentityDataSource _remoteIdentityDataSource,
      {bool useRhs = true}) async {
    if (useRhs) {
      if (credential.proofs.isNotEmpty) {
        for (var proof in credential.proofs) {
          if (proof.type == CredentialProofType.bjj) {
            Map<String, dynamic> issuerNonRevProof =
                await _remoteIdentityDataSource.nonRevProof(credential.revNonce,
                    proof.issuer.id, SdkEnv().reverseHashServiceUrl);
            RevocationStatus revStatus =
                RevocationStatus.fromJson(issuerNonRevProof);
            return revStatus;
          }
        }
      }
      return null;
    } else {
      String revStatusUrl = credential.credentialStatus.id;
      var revStatusUri = Uri.parse(revStatusUrl);
      var revStatusResponse = await get(revStatusUri, headers: {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (revStatusResponse.statusCode == 200) {
        String revStatus = (revStatusResponse.body);
        final RevocationStatus claimRevocationStatus =
            RevocationStatus.fromJson(json.decode(revStatus));
        return claimRevocationStatus;
      } else {
        throw NetworkException(revStatusResponse);
      }
    }
  }
}
