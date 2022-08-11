import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/domain/credential/exceptions/credential_exceptions.dart';

import '../../common/exceptions/network_exceptions.dart';
import '../dtos/claim_dto.dart';

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
        .then((response) {
      if (response.statusCode == 200) {
        FetchClaimResponseDTO fetchResponse =
            FetchClaimResponseDTO.fromJson(json.decode(response.body));

        if (fetchResponse.type == FetchClaimResponseType.issuance) {
          return ClaimDTO(
              issuer: fetchResponse.from,
              identifier: identifier,
              credential: fetchResponse.credential);
        } else {
          throw UnsupportedFetchClaimTypeException(response);
        }
      } else {
        throw NetworkException(response);
      }
    });
  }
}
