import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

import 'iden3comm_repository_impl_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => Uint8List(32);

  @override
  List<String> get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const privateKey = "thePrivateKey";
const publicKey = "thePublicKey";
const walletPrivateKey = "theWalletPrivateKey";
final bbjjKey = Uint8List(32);
final mockWallet = FakeWallet();
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const smt = "smt";
final mockIdentityDTO = IdentityDTO(
  identifier: identifier,
  publicKey: mockWallet.publicKey,
);
final mockIdentityEntity = IdentityEntity(
  identifier: identifier,
  publicKey: mockWallet.publicKey,
);

final mockPrivateIdentityEntity = PrivateIdentityEntity(
  identifier: identifier,
  publicKey: mockWallet.publicKey,
  privateKey: privateKey,
);

const message = "theMessage";
const signature = "theSignature";
const circuitId = "1";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(circuitId, datFile, zKeyFile);
const token = "token";
var exception = Exception();

/// We assume [AuthRequest.fromJson] has been tested
const issuerMessage = '''{
    "id":"0b78a480-c710-4bd8-a4fd-454b577ca991",
    "typ":"application/iden3comm-plain-json",
    "type":"https://iden3-communication.io/authorization/1.0/request",
    "thid":"0b78a480-c710-4bd8-a4fd-454b577ca991",
    "body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=867314","reason":"test flow","scope":[]},
    "from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"
    }''';
final mockAuthRequest = AuthRequest.fromJson(jsonDecode(issuerMessage));
const wrongIssuerMessage =
    '{"id":"06da1153-59a1-4ed9-9d31-c86b5596a48e","thid":"06da1153-59a1-4ed9-9d31-c86b5596a48e","from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","body":{"reason":"test flow","message":"","scope":[]}}';
final wrongAuthRequest = AuthRequest.fromJson(jsonDecode(wrongIssuerMessage));

final mockAuthResponse = AuthResponse(
  id: "id",
  thid: mockAuthRequest.thid,
  to: mockAuthRequest.from,
  from: identifier,
  typ: "application/iden3comm-plain-json",
  type: "https://iden3-communication.io/authorization/1.0/response",
  body: AuthBodyResponse(
    message: mockAuthRequest.body.message,
    proofs: [],
    did_doc: null,
  ),
);

const authResponse = "theAuthResponse";
const pushUrl = "https://push.polygonid.me/api/v1";
const pushToken = "thePushToken";
const didIdentifier = "theDidIdentifier";
const packageName = "thePackageName";

Response errorResponse = Response("body", 450);

// Dependencies
MockRemoteIden3commDataSource remoteIden3commDataSource =
    MockRemoteIden3commDataSource();
MockJWZDataSource jwzDataSource = MockJWZDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockStorageClaimDataSource storageClaimDataSource =
    MockStorageClaimDataSource();
MockAuthResponseMapper authResponseMapper = MockAuthResponseMapper();

// Tested instance
Iden3commRepository repository = Iden3commRepositoryImpl(
    remoteIden3commDataSource, jwzDataSource, hexMapper, authResponseMapper);

@GenerateMocks([
  RemoteIden3commDataSource,
  JWZDataSource,
  HexMapper,
  StorageClaimDataSource,
  AuthResponseMapper
])
void main() {
  group("Get auth token", () {
    setUp(() {
      // Given
      when(jwzDataSource.getAuthToken(
              privateKey: anyNamed('privateKey'),
              authClaim: anyNamed('authClaim'),
              message: anyNamed('message'),
              circuitId: anyNamed('circuitId'),
              datFile: anyNamed('datFile'),
              zKeyFile: anyNamed('zKeyFile')))
          .thenAnswer((realInvocation) => Future.value(token));
      when(hexMapper.mapTo(any)).thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given an identifier, a circuitData and a message to sign, when I call getAuthToken, then I expect an auth token to be returned as a string",
        () async {
      // When
      expect(
          await repository.getAuthToken(
            identity: mockPrivateIdentityEntity,
            message: message,
            authData: circuitData,
            authClaim: authClaim,
          ),
          token);

      expect(
        verify(hexMapper.mapTo(captureAny)).captured.first,
        mockPrivateIdentityEntity.privateKey,
      );

      var authCaptured = verify(jwzDataSource.getAuthToken(
              privateKey: captureAnyNamed('privateKey'),
              authClaim: captureAnyNamed('authClaim'),
              message: captureAnyNamed('message'),
              circuitId: captureAnyNamed('circuitId'),
              datFile: captureAnyNamed('datFile'),
              zKeyFile: captureAnyNamed('zKeyFile')))
          .captured;
      expect(authCaptured[0], bbjjKey);
      expect(authCaptured[1], authClaim);
      expect(authCaptured[2], message);
      expect(authCaptured[3], circuitId);
      expect(authCaptured[4], circuitData.datFile);
      expect(authCaptured[5], circuitData.zKeyFile);
    });

    test(
        "Given an privateIdentityEntity, a circuitData, an authClaim and a message to sign, when I call getAuthToken and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(hexMapper.mapTo(any)).thenThrow(exception);

      // When
      await expectLater(
          repository.getAuthToken(
            identity: mockPrivateIdentityEntity,
            message: message,
            authData: circuitData,
            authClaim: authClaim,
          ),
          throwsA(exception));

      // Then
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          mockPrivateIdentityEntity.privateKey);
      verifyNever(jwzDataSource.getAuthToken(
          privateKey: captureAnyNamed('privateKey'),
          authClaim: captureAnyNamed('authClaim'),
          message: captureAnyNamed('message'),
          circuitId: captureAnyNamed('circuitId'),
          datFile: captureAnyNamed('datFile'),
          zKeyFile: captureAnyNamed('zKeyFile')));
    });
  });

  group(
    "Authenticate",
    () {
      setUp(
        () {
          reset(remoteIden3commDataSource);

          when(authResponseMapper.mapFrom(any))
              .thenAnswer((realInvocation) => "authResponseString");

          when(jwzDataSource.getAuthToken(
                  privateKey: anyNamed('privateKey'),
                  authClaim: anyNamed('authClaim'),
                  message: anyNamed('message'),
                  circuitId: anyNamed('circuitId'),
                  datFile: anyNamed('datFile'),
                  zKeyFile: anyNamed('zKeyFile')))
              .thenAnswer((realInvocation) => Future.value(token));
          when(hexMapper.mapTo(any)).thenAnswer((realInvocation) => bbjjKey);

          when(remoteIden3commDataSource.authWithToken(
            token: anyNamed('token'),
            url: anyNamed('url'),
          )).thenAnswer(
              (realInvocation) => Future.value(Response("body", 200)));
        },
      );

      test(
        'Given an Identifier and a message (iden3message) when we call Authenticate, we expect that flow ended up without exception',
        () async {
          await expectLater(
            repository.authenticate(
              request: mockAuthRequest,
              authToken: token,
            ),
            completes,
          );
        },
      );

      test(
        'Given an Identifier and a message (iden3message) when we call Authenticate and an error is thrown, we expect that flow ended up with exception',
        () async {
          when(remoteIden3commDataSource.authWithToken(
                  token: anyNamed('token'), url: anyNamed('url')))
              .thenThrow(UnknownApiException(450));

          //
          await expectLater(
            repository.authenticate(
              request: mockAuthRequest,
              authToken: token,
            ),
            throwsA(isA<UnknownApiException>()),
          );
        },
      );

      test(
        'Given an Identifier and a message without callback (iden3message) when we call Authenticate and an error is thrown, we expect that flow ended up with a NullAuthenticateCallbackException',
        () async {
          await repository
              .authenticate(
                request: wrongAuthRequest,
                authToken: token,
              )
              .then((_) => expect(true, false))
              .catchError((error) {
            expect(error, isA<NullAuthenticateCallbackException>());
            expect(error.authRequest, wrongAuthRequest);
          });
        },
      );

      test(
          'Given an iden3MessageEntity and an authToken, when we call authenticate a NetworkException is thrown',
          () {
        when(remoteIden3commDataSource.authWithToken(
                token: anyNamed('token'), url: anyNamed('url')))
            .thenAnswer((realInvocation) => Future.value(errorResponse));
        expect(
            repository.authenticate(
              request: mockAuthRequest,
              authToken: token,
            ),
            throwsA(isA<NetworkException>()));
      });
    },
  );

  group("Get Auth Response", () {
    setUp(() {
      reset(authResponseMapper);

      when(authResponseMapper.mapFrom(any)).thenReturn(authResponse);
    });

    test(
        "Given an authRequest, when I call getAuthResponse, then I expect an authResponse to be returned",
        () async {
      // When
      expect(
        await repository.getAuthResponse(
          identifier: identifier,
          request: mockAuthRequest,
          pushUrl: pushUrl,
          scope: [],
          pushToken: pushToken,
          didIdentifier: didIdentifier,
          packageName: packageName,
        ),
        authResponse,
      );

      // Then
      AuthResponse authResponseMapperCaptured =
          verify(authResponseMapper.mapFrom(captureAny)).captured.first;
      expect(authResponseMapperCaptured.thid, mockAuthRequest.thid);
      expect(authResponseMapperCaptured.to, mockAuthRequest.from);
      expect(authResponseMapperCaptured.from, identifier);
    });
  });
}
