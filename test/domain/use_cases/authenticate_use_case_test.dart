import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

import 'authenticate_use_case_test.mocks.dart';

MockIden3commRepository iden3commRepository = MockIden3commRepository();
MockGetProofsUseCase getProofsUseCase = MockGetProofsUseCase();
MockGetAuthTokenUseCase getAuthTokenUseCase = MockGetAuthTokenUseCase();
MockGetEnvConfigUseCase getEnvConfigUseCase = MockGetEnvConfigUseCase();
MockGetPackageNameUseCase getPackageNameUseCase = MockGetPackageNameUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase =
    MockGetDidIdentifierUseCase();

AuthenticateUseCase useCase = AuthenticateUseCase(
  iden3commRepository,
  getProofsUseCase,
  getAuthTokenUseCase,
  getEnvConfigUseCase,
  getPackageNameUseCase,
  getDidIdentifierUseCase,
);

// Data
/// I assume [Iden3MessageMapper] has been tested
const issuerMessage =
    '{"id":"06da1153-59a1-4ed9-9d31-c86b5596a48e","thid":"06da1153-59a1-4ed9-9d31-c86b5596a48e","from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","body":{"reason":"test flow","message":"","callbackUrl":"https://verifier.polygonid.me/api/callback?sessionId=483898","scope":[]}}';
final iden3Message =
    Iden3MessageMapper(Iden3MessageTypeMapper()).mapFrom(issuerMessage);
const wrongIssuerMessage =
    '{"id":"06da1153-59a1-4ed9-9d31-c86b5596a48e","thid":"06da1153-59a1-4ed9-9d31-c86b5596a48e","from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","body":{"reason":"test flow","message":"","scope":[]}}';
final wrongIden3Message =
    Iden3MessageMapper(Iden3MessageTypeMapper()).mapFrom(issuerMessage);
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
  message: iden3Message,
  identifier: identifier,
  pushToken: pushToken,
  privateKey: privateKey,
);
AuthenticateParam wrongParam = AuthenticateParam(
  message: wrongIden3Message,
  identifier: identifier,
  pushToken: pushToken,
  privateKey: privateKey,
);

@GenerateMocks([
  Iden3commRepository,
  GetProofsUseCase,
  GetAuthTokenUseCase,
  GetEnvConfigUseCase,
  GetPackageNameUseCase,
  GetDidIdentifierUseCase
])
void main() {
  group(
    "Authenticate",
    () {
      setUp(() {
        // Given
        reset(iden3commRepository);

        when(getProofsUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value([]));

        when(getEnvConfigUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(config));

        when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(did));

        when(getPackageNameUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(package));

        when(iden3commRepository.getAuthResponse(
                identifier: anyNamed('identifier'),
                message: anyNamed('message'),
                scope: anyNamed('scope'),
                pushUrl: anyNamed('pushUrl'),
                pushToken: anyNamed('pushToken'),
                didIdentifier: anyNamed('didIdentifier'),
                packageName: anyNamed('packageName')))
            .thenAnswer((realInvocation) => Future.value(authResponse));

        when(getAuthTokenUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(authToken));

        when(iden3commRepository.authenticate(
          message: anyNamed('message'),
          authToken: anyNamed('authToken'),
        )).thenAnswer((realInvocation) => Future.value());
      });

      test(
        'Given a good param, when I call execute, then I expect that the flow completes without exception',
        () async {
          // When
          await expectLater(useCase.execute(param: param), completes);

          // Then
          var capturedProofs =
              verify(getProofsUseCase.execute(param: captureAnyNamed('param')))
                  .captured
                  .first;
          expect(capturedProofs.message, iden3Message);
          expect(capturedProofs.identifier, identifier);
          expect(capturedProofs.privateKey, privateKey);

          var verifyConfig = verify(
              getEnvConfigUseCase.execute(param: captureAnyNamed('param')));
          expect(verifyConfig.callCount, 3);
          var capturedConfig = verifyConfig.captured;
          expect(capturedConfig[0], PolygonIdConfig.pushUrl);
          expect(capturedConfig[1], PolygonIdConfig.networkName);
          expect(capturedConfig[2], PolygonIdConfig.networkEnv);

          var capturedDid = verify(getDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedDid.identifier, identifier);
          expect(capturedDid.networkName, config);
          expect(capturedDid.networkEnv, config);

          verify(getPackageNameUseCase.execute());

          var capturedAuthResponse = verify(iden3commRepository.getAuthResponse(
                  identifier: captureAnyNamed('identifier'),
                  message: captureAnyNamed('message'),
                  scope: captureAnyNamed('scope'),
                  pushUrl: captureAnyNamed('pushUrl'),
                  pushToken: captureAnyNamed('pushToken'),
                  didIdentifier: captureAnyNamed('didIdentifier'),
                  packageName: captureAnyNamed('packageName')))
              .captured;
          expect(capturedAuthResponse[0], identifier);
          expect(capturedAuthResponse[1], iden3Message);
          expect(capturedAuthResponse[2], []);
          expect(capturedAuthResponse[3], config);
          expect(capturedAuthResponse[4], pushToken);
          expect(capturedAuthResponse[5], did);
          expect(capturedAuthResponse[6], package);

          var capturedAuthToken = verify(
                  getAuthTokenUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedAuthToken.identifier, identifier);
          expect(capturedAuthToken.privateKey, privateKey);
          expect(capturedAuthToken.message, authResponse);

          var capturedAuthenticate = verify(iden3commRepository.authenticate(
            message: captureAnyNamed('message'),
            authToken: captureAnyNamed('authToken'),
          )).captured;
          expect(capturedAuthenticate[0], iden3Message);
          expect(capturedAuthenticate[1], authToken);
        },
      );

      test(
        'Given a param, when I call execute and an error occured, then I expect an exception to be thrown',
        () async {
          // Given
          when(iden3commRepository.getAuthResponse(
                  identifier: anyNamed('identifier'),
                  message: anyNamed('message'),
                  scope: anyNamed('scope'),
                  pushUrl: anyNamed('pushUrl'),
                  pushToken: anyNamed('pushToken'),
                  didIdentifier: anyNamed('didIdentifier'),
                  packageName: anyNamed('packageName')))
              .thenAnswer((realInvocation) => Future.error(exception));

          // When
          await expectLater(useCase.execute(param: param), throwsA(exception));

          // Then
          var capturedProofs =
              verify(getProofsUseCase.execute(param: captureAnyNamed('param')))
                  .captured
                  .first;
          expect(capturedProofs.message, iden3Message);
          expect(capturedProofs.identifier, identifier);
          expect(capturedProofs.privateKey, privateKey);

          var verifyConfig = verify(
              getEnvConfigUseCase.execute(param: captureAnyNamed('param')));
          expect(verifyConfig.callCount, 3);
          var capturedConfig = verifyConfig.captured;
          expect(capturedConfig[0], PolygonIdConfig.pushUrl);
          expect(capturedConfig[1], PolygonIdConfig.networkName);
          expect(capturedConfig[2], PolygonIdConfig.networkEnv);

          var capturedDid = verify(getDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first;
          expect(capturedDid.identifier, identifier);
          expect(capturedDid.networkName, config);
          expect(capturedDid.networkEnv, config);

          verify(getPackageNameUseCase.execute());

          var capturedAuthResponse = verify(iden3commRepository.getAuthResponse(
                  identifier: captureAnyNamed('identifier'),
                  message: captureAnyNamed('message'),
                  scope: captureAnyNamed('scope'),
                  pushUrl: captureAnyNamed('pushUrl'),
                  pushToken: captureAnyNamed('pushToken'),
                  didIdentifier: captureAnyNamed('didIdentifier'),
                  packageName: captureAnyNamed('packageName')))
              .captured;
          expect(capturedAuthResponse[0], identifier);
          expect(capturedAuthResponse[1], iden3Message);
          expect(capturedAuthResponse[2], []);
          expect(capturedAuthResponse[3], config);
          expect(capturedAuthResponse[4], pushToken);
          expect(capturedAuthResponse[5], did);
          expect(capturedAuthResponse[6], package);

          verifyNever(
              getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

          verifyNever(iden3commRepository.authenticate(
            message: captureAnyNamed('message'),
            authToken: captureAnyNamed('authToken'),
          ));
        },
      );
    },
  );
}
