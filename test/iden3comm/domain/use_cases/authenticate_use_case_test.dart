import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import '../../../common/common_mocks.dart';
import 'authenticate_use_case_test.mocks.dart';

MockIden3commRepository iden3commRepository = MockIden3commRepository();
MockGetIden3commProofsUseCase getIden3commProofsUseCase =
    MockGetIden3commProofsUseCase();
MockGetAuthTokenUseCase getAuthTokenUseCase = MockGetAuthTokenUseCase();
MockGetEnvUseCase getEnvUseCase = MockGetEnvUseCase();
MockGetPackageNameUseCase getPackageNameUseCase = MockGetPackageNameUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();

AuthenticateUseCase useCase = AuthenticateUseCase(
  iden3commRepository,
  getIden3commProofsUseCase,
  getAuthTokenUseCase,
  getEnvUseCase,
  getPackageNameUseCase,
  getCurrentEnvDidIdentifierUseCase,
);

// Data
/// We assume [AuthIden3MessageEntity.fromJson] has been tested
const issuerMessage =
    '{"id":"06da1153-59a1-4ed9-9d31-c86b5596a48e","thid":"06da1153-59a1-4ed9-9d31-c86b5596a48e","from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","body":{"reason":"test flow","message":"","callbackUrl":"https://verifier.polygonid.me/api/callback?sessionId=483898","scope":[]}}';
final authRequest = AuthIden3MessageEntity.fromJson(jsonDecode(issuerMessage));
const identifier = "theIdentifier";
const pushToken = "thePushToken";
const privateKey = "thePrivateKey";
const config = "theConfig";
const did = "theDid";
const package = "thePackage";
const authResponse = "theAuthResponse";
const authToken = "theAuthToken";
const url = "theUrl";
final exception = Exception();

AuthenticateParam param = AuthenticateParam(
  message: authRequest,
  did: identifier,
  pushToken: pushToken,
  privateKey: privateKey,
);

@GenerateMocks([
  Iden3commRepository,
  GetIden3commProofsUseCase,
  GetAuthTokenUseCase,
  GetEnvUseCase,
  GetPackageNameUseCase,
  GetCurrentEnvDidIdentifierUseCase,
])
void main() {
  group(
    "Authenticate",
    () {
      setUp(() {
        // Given
        reset(iden3commRepository);

        when(getIden3commProofsUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value([]));

        when(getEnvUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(CommonMocks.env));

        when(getCurrentEnvDidIdentifierUseCase.execute(
                param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(did));

        when(getPackageNameUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(package));

        when(iden3commRepository.getAuthResponse(
                did: anyNamed('did'),
                request: anyNamed('request'),
                scope: anyNamed('scope'),
                pushUrl: anyNamed('pushUrl'),
                pushToken: anyNamed('pushToken'),
                didIdentifier: anyNamed('didIdentifier'),
                packageName: anyNamed('packageName')))
            .thenAnswer((realInvocation) => Future.value(authResponse));

        when(getAuthTokenUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(authToken));

        when(iden3commRepository.authenticate(
          request: anyNamed('request'),
          authToken: anyNamed('authToken'),
        )).thenAnswer((realInvocation) => Future.value());
      });

      test(
        'Given a good param, when I call execute, then I expect that the flow completes without exception',
        () async {
          // When
          await expectLater(useCase.execute(param: param), completes);

          // Then
          var capturedProofs = verify(getIden3commProofsUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedProofs.message, authRequest);
          expect(capturedProofs.did, identifier);
          expect(capturedProofs.privateKey, privateKey);

          var verifyConfig =
              verify(getEnvUseCase.execute(param: captureAnyNamed('param')));
          expect(verifyConfig.callCount, 1);
          var capturedConfig = verifyConfig.captured;
          expect(capturedConfig[0], null);

          var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedDid.privateKey, privateKey);

          verify(getPackageNameUseCase.execute());

          var capturedAuthResponse = verify(iden3commRepository.getAuthResponse(
                  did: captureAnyNamed('did'),
                  request: captureAnyNamed('request'),
                  scope: captureAnyNamed('scope'),
                  pushUrl: captureAnyNamed('pushUrl'),
                  pushToken: captureAnyNamed('pushToken'),
                  didIdentifier: captureAnyNamed('didIdentifier'),
                  packageName: captureAnyNamed('packageName')))
              .captured;
          expect(capturedAuthResponse[0], identifier);
          expect(capturedAuthResponse[1], authRequest);
          expect(capturedAuthResponse[2], []);
          expect(capturedAuthResponse[3], CommonMocks.url);
          expect(capturedAuthResponse[4], pushToken);
          expect(capturedAuthResponse[5], did);
          expect(capturedAuthResponse[6], package);

          var capturedAuthToken = verify(
                  getAuthTokenUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedAuthToken.did, identifier);
          expect(capturedAuthToken.privateKey, privateKey);
          expect(capturedAuthToken.message, authResponse);

          var capturedAuthenticate = verify(iden3commRepository.authenticate(
            request: captureAnyNamed('request'),
            authToken: captureAnyNamed('authToken'),
          )).captured;
          expect(capturedAuthenticate[0], authRequest);
          expect(capturedAuthenticate[1], authToken);
        },
      );

      test(
        'Given a param, when I call execute and an error occured, then I expect an exception to be thrown',
        () async {
          // Given
          when(iden3commRepository.getAuthResponse(
                  did: anyNamed('did'),
                  request: anyNamed('request'),
                  scope: anyNamed('scope'),
                  pushUrl: anyNamed('pushUrl'),
                  pushToken: anyNamed('pushToken'),
                  didIdentifier: anyNamed('didIdentifier'),
                  packageName: anyNamed('packageName')))
              .thenAnswer((realInvocation) => Future.error(exception));

          // When
          await expectLater(useCase.execute(param: param), throwsA(exception));

          // Then
          var capturedProofs = verify(getIden3commProofsUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedProofs.message, authRequest);
          expect(capturedProofs.did, identifier);
          expect(capturedProofs.privateKey, privateKey);

          var verifyConfig =
              verify(getEnvUseCase.execute(param: captureAnyNamed('param')));
          expect(verifyConfig.callCount, 1);
          var capturedConfig = verifyConfig.captured;
          expect(capturedConfig[0], null);

          var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedDid.privateKey, privateKey);

          verify(getPackageNameUseCase.execute());

          var capturedAuthResponse = verify(iden3commRepository.getAuthResponse(
                  did: captureAnyNamed('did'),
                  request: captureAnyNamed('request'),
                  scope: captureAnyNamed('scope'),
                  pushUrl: captureAnyNamed('pushUrl'),
                  pushToken: captureAnyNamed('pushToken'),
                  didIdentifier: captureAnyNamed('didIdentifier'),
                  packageName: captureAnyNamed('packageName')))
              .captured;
          expect(capturedAuthResponse[0], identifier);
          expect(capturedAuthResponse[1], authRequest);
          expect(capturedAuthResponse[2], []);
          expect(capturedAuthResponse[3], CommonMocks.url);
          expect(capturedAuthResponse[4], pushToken);
          expect(capturedAuthResponse[5], did);
          expect(capturedAuthResponse[6], package);

          verifyNever(
              getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

          verifyNever(iden3commRepository.authenticate(
            request: captureAnyNamed('request'),
            authToken: captureAnyNamed('authToken'),
          ));
        },
      );
    },
  );
}
