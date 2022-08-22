import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';

import '../dtos/fetch_claim_response_dto_test.dart';
import 'remote_claim_data_source_test.mocks.dart';

// Data
const token = "theToken";
const url = "theUrl";
const issuer = "theIssuer";
const identifier = "theIdentifier";
Response response = Response(mockFetchClaim, 200);
Response errorResponse = Response(mockFetchClaim, 444);
Response otherTypeResponse = Response(mockOtherTypeFetchClaim, 200);

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final claim = ClaimDTO(
    id: fetchClaimDTO.credential.id,
    issuer: fetchClaimDTO.from,
    identifier: identifier,
    expiration: fetchClaimDTO.credential.expiration,
    type: fetchClaimDTO.credential.credentialSubject.type,
    credential: fetchClaimDTO.credential);
final exception = Exception();

// Dependencies
MockClient client = MockClient();

// Tested instance
RemoteClaimDataSource dataSource = RemoteClaimDataSource(client);

@GenerateMocks([Client])
void main() {
  group("Fetch claim", () {
    test(
        "Given parameters, when I call fetchClaim, then I expect a Claim to be returned",
        () async {
      // Given
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(response));

      // When
      expect(
          await dataSource.fetchClaim(
              token: token, url: url, identifier: identifier),
          claim);

      // Then
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(captured[0], Uri.parse(url));
      expect(captured[1], token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });

    test(
        "Given parameters, when I call fetchClaim and a server error occurred, then I expect an NetworkException to be thrown",
        () async {
      // Given
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(errorResponse));

      // When
      await expectLater(
          dataSource.fetchClaim(token: token, url: url, identifier: identifier),
          throwsA(isA<NetworkException>()));

      // Then
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(captured[0], Uri.parse(url));
      expect(captured[1], token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });

    test(
        "Given parameters, when I call fetchClaim and an unsupported FetchClaimResponseType is returned, then I expect an UnsupportedFetchClaimTypeException to be thrown",
        () async {
      // Given
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(otherTypeResponse));

      // When
      await dataSource
          .fetchClaim(token: token, url: url, identifier: identifier)
          .then((_) => expect(true, false)) // Be sure we don't succeed
          .catchError((error) {
        expect(error, (isA<UnsupportedFetchClaimTypeException>()));
        expect(error.error, otherTypeResponse);
      });

      // Then
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(captured[0], Uri.parse(url));
      expect(captured[1], token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });

    test(
        "Given parameters, when I call fetchClaim and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.fetchClaim(token: token, url: url, identifier: identifier),
          throwsA(exception));

      // Then
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(captured[0], Uri.parse(url));
      expect(captured[1], token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });
  });
}
