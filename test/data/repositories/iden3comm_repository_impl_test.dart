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
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/proof_scope_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

import '../data_sources/storage_identity_data_source_test.dart';
import 'iden3comm_repository_impl_test.mocks.dart';
import 'identity_repository_impl_test.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => Uint8List(32);

  @override
  dynamic get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const privateKey = "thePrivateKey";
const walletPrivateKey = "theWalletPrivateKey";
final bjjKey = Uint8List(32);
final mockWallet = FakeWallet();
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const smt = "smt";
const mockDTO = IdentityDTO(
    privateKey: privateKey,
    identifier: identifier,
    authClaim: authClaim,
    smt: smt);
const mockEntity = IdentityEntity(
    privateKey: privateKey,
    identifier: identifier,
    authClaim: authClaim,
    smt: smt);
const message = "theMessage";
const signature = "theSignature";
const circuitId = "1";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(circuitId, datFile, zKeyFile);
const token = "token";
var exception = Exception();
const issuerMessage =
    '{"id":"0b78a480-c710-4bd8-a4fd-454b577ca991","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","thid":"0b78a480-c710-4bd8-a4fd-454b577ca991","body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=867314","reason":"test flow","scope":[]},"from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"}';
final mockAuthRequest = AuthRequest.fromJson(jsonDecode(issuerMessage));
final mockIden3MessageEntity = Iden3MessageMapper(Iden3MessageTypeMapper())
    .mapFrom(Iden3Message.fromJson(jsonDecode(issuerMessage)));

final mockAuthResponse = AuthResponse(
  id: "id",
  thid: mockAuthRequest.thid,
  to: mockAuthRequest.from,
  from: identifier,
  typ: "application/iden3comm-plain-json",
  type: "https://iden3-communication.io/authorization/1.0/response",
  body: AuthBodyResponse(
    message: mockAuthRequest.body?.message,
    proofs: [],
    did_doc: null,
  ),
);

Response errorResponse = Response("body", 450);

// Dependencies
MockRemoteIden3commDataSource remoteIden3commDataSource =
    MockRemoteIden3commDataSource();
MockJWZDataSource jwzDataSource = MockJWZDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockProofScopeDataSource proofScopeDataSource = MockProofScopeDataSource();
MockStorageClaimDataSource storageClaimDataSource =
    MockStorageClaimDataSource();
MockClaimMapper claimMapper = MockClaimMapper();
MockFiltersMapper filtersMapper = MockFiltersMapper();
MockAuthResponseMapper authResponseMapper = MockAuthResponseMapper();

// Tested instance
Iden3commRepository repository = Iden3commRepositoryImpl(
    remoteIden3commDataSource,
    jwzDataSource,
    hexMapper,
    proofScopeDataSource,
    storageClaimDataSource,
    claimMapper,
    filtersMapper,
    authResponseMapper);

@GenerateMocks([
  RemoteIden3commDataSource,
  JWZDataSource,
  HexMapper,
  ProofScopeDataSource,
  StorageClaimDataSource,
  ClaimMapper,
  FiltersMapper,
  AuthResponseMapper,
])
void main() {
  group("Get auth token", () {
    setUp(() {
      // Given
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(identityDTO));

      //when(localFilesDataSource.loadCircuitFiles(any))
      //   .thenAnswer((realInvocation) => Future.value([datFile, zKeyFile]));

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
            identityEntity: mockEntity,
            message: message,
            authData: circuitData,
          ),
          token);

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          mockDTO.privateKey);
      var authCaptured = verify(jwzDataSource.getAuthToken(
              privateKey: captureAnyNamed('privateKey'),
              authClaim: captureAnyNamed('authClaim'),
              message: captureAnyNamed('message'),
              circuitId: captureAnyNamed('circuitId'),
              datFile: captureAnyNamed('datFile'),
              zKeyFile: captureAnyNamed('zKeyFile')))
          .captured;
      expect(authCaptured[0], bbjjKey);
      expect(authCaptured[1], mockDTO.authClaim);
      expect(authCaptured[2], message);
      expect(authCaptured[3], 'auth');
      expect(authCaptured[4], circuitData.datFile);
      expect(authCaptured[5], circuitData.zKeyFile);
    });

    test(
        "Given an identifier, a circuitData and a message to sign, when I call getAuthToken and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(hexMapper.mapTo(any)).thenThrow(exception);

      // When
      await expectLater(
          repository.getAuthToken(
            identityEntity: mockEntity,
            message: message,
            authData: circuitData,
          ),
          throwsA(exception));

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          mockDTO.privateKey);
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
          reset(storageIdentityDataSource);
          //reset(localFilesDataSource);
          reset(remoteIden3commDataSource);

          when(storageIdentityDataSource.getIdentity(
                  identifier: anyNamed('identifier')))
              .thenAnswer((realInvocation) => Future.value(mockDTO));

          //when(localFilesDataSource.loadCircuitFiles(any)).thenAnswer(
          //    (realInvocation) => Future.value([Uint8List(32), Uint8List(32)]));

          when(authResponseMapper.mapFrom(any))
              .thenAnswer((realInvocation) => "authResponseString");

          when(storageIdentityDataSource.getIdentity(
                  identifier: anyNamed('identifier')))
              .thenAnswer((realInvocation) => Future.value(identityDTO));
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
            token: token,
            url: mockAuthRequest.body?.callbackUrl,
          )).thenAnswer(
              (realInvocation) => Future.value(Response("body", 200)));
        },
      );

      test(
        'Given an Identifier and a message (iden3message) when we call Authenticate, we expect that flow ended up without exception',
        () async {
          await expectLater(
            repository.authenticate(
              url: mockAuthRequest.body!.callbackUrl!,
              authToken: token,
            ),
            completes,
          );
        },
      );

      test(
        'Given an Identifier and a message (iden3message) when we call Authenticate, we expect that flow ended up with exception',
        () async {
          when(remoteIden3commDataSource.authWithToken(token: any, url: any))
              .thenThrow(UnknownApiException(450));

          //
          await expectLater(
            repository.authenticate(
              url: mockAuthRequest.body!.callbackUrl!,
              authToken: token,
            ),
            throwsA(isA<UnknownApiException>()),
          );
        },
      );
    },
  );
}
