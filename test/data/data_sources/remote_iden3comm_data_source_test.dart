import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/fetch/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import '../dtos/fetch_claim_response_dto_test.dart';
import 'remote_iden3comm_data_source_test.mocks.dart';

//DATA
const token = "theToken";
const url = "theUrl";
const identifier = "theIdentifier";
Response response = Response(mockFetchClaim, 200);
Response errorResponse = Response(mockFetchClaim, 444);
Response otherTypeResponse = Response(mockOtherTypeFetchClaim, 200);
final exception = Exception();

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final claim = ClaimDTO(
    id: fetchClaimDTO.credential.id,
    issuer: fetchClaimDTO.from,
    did: identifier,
    expiration: fetchClaimDTO.credential.expirationDate,
    type: fetchClaimDTO.credential.credentialSubject.type,
    info: fetchClaimDTO.credential);

//DEPENDENCIES
MockClient client = MockClient();

RemoteIden3commDataSource dataSource = RemoteIden3commDataSource(client);

@GenerateMocks([Client])
void main() {
  group("Authenticate with token", () {
    test(
        "Given token and authRequest, when called authWithToken, then I expect statusCode 200 response",
        () async {
      //
      when(
        client.post(
          any,
          body: anyNamed("body"),
          headers: anyNamed("headers"),
        ),
      ).thenAnswer((realInvocation) => Future.value(response));

      //
      expect(
        await dataSource.authWithToken(
            token: CommonMocks.token, url: CommonMocks.url),
        response,
      );

      //
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(
          captured[0], Uri.parse(Iden3commMocks.authRequest.body.callbackUrl!));
      expect(captured[1], CommonMocks.token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });

    test(
        "Given token and authRequest, when I call authWithToken and a server error occurred with status code 450, then I expect an UnknownApiException to be thrown",
        () async {
      //
      when(
        client.post(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(errorResponse),
      );

      //
      await expectLater(
        dataSource.authWithToken(
            token: CommonMocks.token, url: CommonMocks.url),
        throwsA(isA<UnknownApiException>()),
      );

      //
      var captured = verify(
        client.post(
          captureAny,
          body: captureAnyNamed('body'),
          headers: captureAnyNamed('headers'),
        ),
      ).captured;

      expect(
          captured[0], Uri.parse(Iden3commMocks.authRequest.body.callbackUrl!));
      expect(captured[1], CommonMocks.token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });
  });

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
              authToken: token, url: url, did: identifier),
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
          dataSource.fetchClaim(authToken: token, url: url, did: identifier),
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
          .fetchClaim(authToken: token, url: url, did: identifier)
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
          dataSource.fetchClaim(authToken: token, url: url, did: identifier),
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
