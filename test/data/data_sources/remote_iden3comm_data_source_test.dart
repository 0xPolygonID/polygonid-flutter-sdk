import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_request.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import 'remote_iden3comm_data_source_test.mocks.dart';

//DATA

Response response = Response("body", 200);
Response errorResponse = Response("body", 450);

//DEPENDENCIES
MockClient client = MockClient();

RemoteIden3commDataSource dataSource = RemoteIden3commDataSource(client);

@GenerateMocks([Client])
@GenerateNiceMocks([MockSpec<AuthRequest>()])
void main() {
  group("Auhtenticate with token", () {
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
        await dataSource.authWithToken(token: CommonMocks.token, url: CommonMocks.url),
        response,
      );

      //
      var captured = verify(client.post(captureAny,
              body: captureAnyNamed('body'),
              headers: captureAnyNamed('headers')))
          .captured;

      expect(captured[0], Uri.parse(Iden3commMocks.authRequest.body.callbackUrl!));
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
        dataSource.authWithToken(token: CommonMocks.token, url: CommonMocks.url),
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

      expect(captured[0], Uri.parse(Iden3commMocks.authRequest.body.callbackUrl!));
      expect(captured[1], CommonMocks.token);
      expect(captured[2], {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.contentTypeHeader: 'text/plain',
      });
    });
  });
}
