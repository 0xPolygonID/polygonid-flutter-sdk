import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

import 'identity_repository_impl_test.mocks.dart';

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
final bbjjKey = Uint8List(32);
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
const url = "theUrl";
const id = "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"; //"theId";
const state = "theState";
var exception = Exception();
const issuerMessage =
    '{"id":"0b78a480-c710-4bd8-a4fd-454b577ca991","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","thid":"0b78a480-c710-4bd8-a4fd-454b577ca991","body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=867314","reason":"test flow","scope":[]},"from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"}';
final mockAuthRequest = AuthRequest.fromJson(jsonDecode(issuerMessage));

final mockAuthResponse = AuthResponse(
  id: "id",
  thid: mockAuthRequest.thid,
  to: mockAuthRequest.from,
  from: identifier,
  typ: "application/iden3comm-plain-json",
  type: "https://iden3-communication.io/authorization/1.0/response",
  body: AuthBodyResponse(
    message: mockAuthRequest.body?.message,
    scope: [],
    did_doc: null,
  ),
);
final rhsNodeDTOs = [
  const RhsNodeDTO(
      node: RhsNodeItemDTO(
        children: [],
        hash: '',
      ),
      status: ''),
  const RhsNodeDTO(
      node: RhsNodeItemDTO(
        children: [],
        hash: '',
      ),
      status: ''),
];
final rhsNodeEntities = [
  RhsNodeEntity(
    node: {},
    status: '',
    nodeType: RhsNodeType.state,
  ),
  RhsNodeEntity(
    node: {},
    status: '',
    nodeType: RhsNodeType.state,
  ),
];

Response errorResponse = Response("body", 450);

// Dependencies
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockLibIdentityDataSource libIdentityDataSource = MockLibIdentityDataSource();
MockRemoteIdentityDataSource remoteIdentityDataSource =
    MockRemoteIdentityDataSource();
MockStorageIdentityDataSource storageIdentityDataSource =
    MockStorageIdentityDataSource();
MockStorageKeyValueDataSource storageKeyValueDataSource =
    MockStorageKeyValueDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();
MockIdentityDTOMapper identityDTOMapper = MockIdentityDTOMapper();
MockRhsNodeMapper rhsNodeMapper = MockRhsNodeMapper();
//MockSMTStorageRepository smtStorageRepository = MockSMTStorageRepository();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
  walletDataSource,
  libIdentityDataSource,
  remoteIdentityDataSource,
  storageIdentityDataSource,
  storageKeyValueDataSource,
  hexMapper,
  privateKeyMapper,
  identityDTOMapper,
  rhsNodeMapper,
  //smtStorageRepository,
);

@GenerateMocks([
  WalletDataSource,
  LibIdentityDataSource,
  RemoteIdentityDataSource,
  StorageIdentityDataSource,
  StorageKeyValueDataSource,
  HexMapper,
  PrivateKeyMapper,
  IdentityDTOMapper,
  RhsNodeMapper,
  //SMTStorageRepository
])
void main() {
  group("Create identity", () {
    setUp(() {
      reset(libIdentityDataSource);
      reset(storageIdentityDataSource);
      reset(hexMapper);
      reset(privateKeyMapper);
      reset(identityDTOMapper);
      //reset(smtStorageRepository);

      // Given
      when(libIdentityDataSource.getAuthClaim(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(authClaim));

      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));

      when(libIdentityDataSource.createSMT(null /*smtStorageRepository*/))
          .thenAnswer((realInvocation) => Future.value("smt"));

      when(walletDataSource.createWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));

      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) =>
              Future.error(UnknownIdentityException(identifier)));

      when(hexMapper.mapFrom(any))
          .thenAnswer((realInvocation) => walletPrivateKey);

      when(privateKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => bbjjKey);

      when(identityDTOMapper.mapFrom(any))
          .thenAnswer((realInvocation) => mockEntity);
    });

    test(
        "Given a private key, when I call createIdentity, then I expect an identifier to be returned",
        () async {
      // When
      expect(
          await repository.createIdentity(privateKey: privateKey), identifier);

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var authCaptured = verify(libIdentityDataSource.getAuthClaim(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(authCaptured[0], pubX);
      expect(authCaptured[1], pubY);
    });

    test(
        "Given a private key which is null, when I call createIdentity, then I expect an identifier to be returned",
        () async {
      // Given
      when(privateKeyMapper.mapFrom(any)).thenAnswer((realInvocation) => null);

      // When
      expect(await repository.createIdentity(), identifier);

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          null);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var authCaptured = verify(libIdentityDataSource.getAuthClaim(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(authCaptured[0], isA<String>());
      expect(authCaptured[1], isA<String>());
    });

    test(
        "Given a private key, when I call createIdentity and an error occurred, then I expect a IdentityException to be thrown",
        () async {
      // Given
      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .createIdentity(privateKey: privateKey)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      verifyNever(libIdentityDataSource.getAuthClaim(
          pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')));
    });
  });

  group("Sign message", () {
    setUp(() {
      reset(libIdentityDataSource);
      reset(privateKeyMapper);
      reset(storageIdentityDataSource);

      // Given
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(mockDTO));
      when(walletDataSource.signMessage(
              privateKey: anyNamed('privateKey'), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.value(signature));
      when(hexMapper.mapTo(any)).thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given an identifier key and a message, when I call signMessage, then I expect a signature as a String to be returned",
        () async {
      // When
      expect(
          await repository.signMessage(
              identifier: identifier, message: message),
          signature);

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          mockDTO.privateKey);
      var signCaptured = verify(walletDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(signCaptured[0], bbjjKey);
      expect(signCaptured[1], message);
    });

    test(
        "Given an identifier key and a message, when I call signMessage and an error occurred, then I expect an IdentityException to be thrown",
        () async {
      // Given
      when(walletDataSource.signMessage(
              privateKey: anyNamed('privateKey'), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .signMessage(identifier: identifier, message: message)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          mockDTO.privateKey);
      var signCaptured = verify(walletDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(signCaptured[0], bbjjKey);
      expect(signCaptured[1], message);
    });
  });

  group("Remove identity", () {
    test(
        "Given an identifier, when I call removeIdentity, then I expect the process to complete",
        () async {
      // Given
      when(storageIdentityDataSource.removeIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value());

      // When
      await expectLater(
          repository.removeIdentity(identifier: identifier), completes);

      // Then
      expect(
          verify(storageIdentityDataSource.removeIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
    });

    test(
        "Given an identifier, when I call removeIdentity and an error occurred, then I expect an error to be thrown",
        () async {
      // Given
      when(storageIdentityDataSource.removeIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(repository.removeIdentity(identifier: identifier),
          throwsA(exception));

      // Then
      expect(
          verify(storageIdentityDataSource.removeIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
    });
  });

  group("Fetch Identity State", () {
    setUp(() {
      reset(remoteIdentityDataSource);

      // Given
      when(remoteIdentityDataSource.fetchIdentityState(id: anyNamed('id')))
          .thenAnswer((realInvocation) => Future.value(state));
      //when(rhsNodeMapper.mapFrom(any)).thenReturn(rhsNodeEntities[0]);
    });

    test(
        "Given parameters, when I call fetchIdentityState, then I expect a RhsNodeEntity to be returned",
        () async {
      // When
      expect(await repository.fetchIdentityState(id: id), state);

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.fetchIdentityState(
              id: captureAnyNamed('id')))
          .captured;

      expect(fetchCaptured[0], id);

      //expect(verify(rhsNodeMapper.mapFrom(captureAny)).captured.first,
      // rhsNodeDTOs[0]);
    });

    test(
        "Given parameters, when I call fetchStateRoots and an error occurred, then I expect a FetchIdentityStateException to be thrown",
        () async {
      // Given
      when(remoteIdentityDataSource.fetchIdentityState(
        id: anyNamed('id'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .fetchIdentityState(id: id)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<FetchIdentityStateException>());
        expect(error.error, exception);
      });

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.fetchIdentityState(
        id: captureAnyNamed('id'),
      )).captured;

      expect(fetchCaptured[0], id);

      verifyNever(captureAny);
    });
  });

  group("Fetch State Roots", () {
    setUp(() {
      reset(remoteIdentityDataSource);
      reset(rhsNodeMapper);

      // Given
      when(remoteIdentityDataSource.fetchStateRoots(url: anyNamed('url')))
          .thenAnswer((realInvocation) => Future.value(rhsNodeDTOs[0]));
      when(rhsNodeMapper.mapFrom(any)).thenReturn(rhsNodeEntities[0]);
    });

    test(
        "Given parameters, when I call fetchStateRoots, then I expect a RhsNodeEntity to be returned",
        () async {
      // When
      expect(await repository.fetchStateRoots(url: url), rhsNodeEntities[0]);

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.fetchStateRoots(
              url: captureAnyNamed('url')))
          .captured;

      expect(fetchCaptured[0], url);

      expect(verify(rhsNodeMapper.mapFrom(captureAny)).captured.first,
          rhsNodeDTOs[0]);
    });

    test(
        "Given parameters, when I call fetchStateRoots and an error occurred, then I expect a FetchIdentityStateException to be thrown",
        () async {
      // Given
      when(remoteIdentityDataSource.fetchStateRoots(
        url: anyNamed('url'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .fetchStateRoots(url: url)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<FetchStateRootsException>());
        expect(error.error, exception);
      });

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.fetchStateRoots(
        url: captureAnyNamed('url'),
      )).captured;

      expect(fetchCaptured[0], url);

      verifyNever(rhsNodeMapper.mapFrom(captureAny));
    });
  });
}
