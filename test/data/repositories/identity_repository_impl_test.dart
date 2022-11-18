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
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/did_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:web3dart/web3dart.dart';

import 'identity_repository_impl_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => Uint8List(32);

  @override
  List<String> get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const pubKeys = [pubX, pubY];
const privateKey = "thePrivateKey";
const walletPrivateKey = "theWalletPrivateKey";
final bbjjKey = Uint8List(32);
final mockWallet = FakeWallet();
const identifier = "theIdentifier";
const otherIdentifier = "theOtherIdentifier";
const smt = "smt";
const mockDTO = IdentityDTO(identifier: identifier, publicKey: pubKeys);
const mockEntity = IdentityEntity(identifier: identifier, publicKey: pubKeys);
const privateIdentity = PrivateIdentityEntity(
    identifier: identifier, publicKey: pubKeys, privateKey: walletPrivateKey);
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
const nonce = 1;
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
    message: mockAuthRequest.body.message,
    proofs: [],
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

Map<String, dynamic> nonRev = {"name": "Yep"};

const address = "address";
const abiName = "theABIName";
final DeployedContract contract = DeployedContract(
    ContractAbi(abiName, [const ContractFunction('getState', [])], []),
    EthereumAddress(Uint8List.fromList([
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ])));
// Dependencies
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockLibIdentityDataSource libIdentityDataSource = MockLibIdentityDataSource();
MockRemoteIdentityDataSource remoteIdentityDataSource =
    MockRemoteIdentityDataSource();
MockStorageIdentityDataSource storageIdentityDataSource =
    MockStorageIdentityDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();
MockIdentityDTOMapper identityDTOMapper = MockIdentityDTOMapper();
MockRhsNodeMapper rhsNodeMapper = MockRhsNodeMapper();
MockRPCDataSource rpcDataSource = MockRPCDataSource();
MockLocalContractFilesDataSource localContractFilesDataSource =
    MockLocalContractFilesDataSource();
MockStateIdentifierMapper stateIdentifierMapper = MockStateIdentifierMapper();
MockDidMapper didMapper = MockDidMapper();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
  walletDataSource,
  libIdentityDataSource,
  remoteIdentityDataSource,
  storageIdentityDataSource,
  rpcDataSource,
  localContractFilesDataSource,
  hexMapper,
  privateKeyMapper,
  identityDTOMapper,
  rhsNodeMapper,
  stateIdentifierMapper,
  didMapper,
);

@GenerateMocks([
  WalletDataSource,
  LibIdentityDataSource,
  RemoteIdentityDataSource,
  StorageIdentityDataSource,
  RPCDataSource,
  LocalContractFilesDataSource,
  HexMapper,
  PrivateKeyMapper,
  IdentityDTOMapper,
  RhsNodeMapper,
  StateIdentifierMapper,
  DidMapper,
])
void main() {
  group("Create identity", () {
    setUp(() {
      reset(walletDataSource);
      reset(libIdentityDataSource);
      reset(remoteIdentityDataSource);
      reset(storageIdentityDataSource);
      reset(rpcDataSource);
      reset(localContractFilesDataSource);
      reset(hexMapper);
      reset(privateKeyMapper);
      reset(identityDTOMapper);
      reset(rhsNodeMapper);
      reset(stateIdentifierMapper);
      reset(didMapper);

      // Given
      when(privateKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => bbjjKey);

      when(walletDataSource.createWallet(secret: anyNamed('secret')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));

      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));

      when(identityDTOMapper.mapPrivateFrom(any, any))
          .thenAnswer((realInvocation) => privateIdentity);

      when(hexMapper.mapFrom(any))
          .thenAnswer((realInvocation) => walletPrivateKey);

      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) =>
              Future.error(UnknownIdentityException(identifier)));

      when(identityDTOMapper.mapFrom(any))
          .thenAnswer((realInvocation) => mockEntity);
    });

    test(
        "Given a private key, when I call createIdentity, then I expect a PrivateIdentityEntity to be returned",
        () async {
      // When
      expect(
          await repository.createIdentity(secret: privateKey), privateIdentity);

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  secret: captureAnyNamed('secret')))
              .captured
              .first,
          bbjjKey);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var identityMapperCaptured =
          verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
              .captured;
      expect(identityMapperCaptured[0], mockDTO);
      expect(identityMapperCaptured[1], walletPrivateKey);

      var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
      expect(hexMapperVerify.callCount, 2);
      expect(hexMapperVerify.captured[0], mockWallet.privateKey);
      expect(hexMapperVerify.captured[1], mockWallet.privateKey);
    });

    test(
        "Given a private key which is null, when I call createIdentity, then I expect a PrivateIdentityEntity to be returned",
        () async {
      // When
      expect(await repository.createIdentity(secret: null), privateIdentity);

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  secret: captureAnyNamed('secret')))
              .captured
              .first,
          bbjjKey);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var identityMapperCaptured =
          verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
              .captured;
      expect(identityMapperCaptured[0], mockDTO);
      expect(identityMapperCaptured[1], walletPrivateKey);

      var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
      expect(hexMapperVerify.callCount, 2);
      expect(hexMapperVerify.captured[0], mockWallet.privateKey);
      expect(hexMapperVerify.captured[1], mockWallet.privateKey);
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
          .createIdentity(secret: privateKey)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  secret: captureAnyNamed('secret')))
              .captured
              .first,
          bbjjKey);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));

      var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
      expect(hexMapperVerify.callCount, 1);
      expect(hexMapperVerify.captured[0], mockWallet.privateKey);
    });
  });

  group("Get identity", () {
    setUp(() {
      reset(storageIdentityDataSource);
      reset(identityDTOMapper);

      // Given
      when(identityDTOMapper.mapFrom(any))
          .thenAnswer((realInvocation) => mockEntity);

      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(mockDTO));
    });

    test(
        "Given an identifier, when I call getIdentity, then I expect a IdentityEntity to be returned",
        () async {
      // When
      expect(await repository.getIdentity(identifier: identifier), mockEntity);

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);

      expect(verify(identityDTOMapper.mapFrom(captureAny)).captured.first,
          mockDTO);
    });

    test(
        "Given an identifier, when I call getIdentity and an error occurred, then I expect a IdentityException to be thrown",
        () async {
      // Given
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .getIdentity(identifier: identifier)
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

      verifyNever(identityDTOMapper.mapFrom(captureAny));
    });

    test(
        "Given an identifier, when I call getIdentity and the identity doesn't exist, then I expect a UnknownIdentityException to be thrown",
        () async {
      // Given
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) =>
              Future.error(UnknownIdentityException(identifier)));

      // When
      await repository
          .getIdentity(identifier: identifier)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<UnknownIdentityException>());
        expect(error.identifier, identifier);
      });

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);

      verifyNever(identityDTOMapper.mapFrom(captureAny));
    });
  });

  group("Get private identity", () {
    setUp(() {
      reset(walletDataSource);
      reset(libIdentityDataSource);
      reset(storageIdentityDataSource);
      reset(identityDTOMapper);
      reset(hexMapper);

      // Given
      when(walletDataSource.getWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));

      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));

      when(identityDTOMapper.mapPrivateFrom(any, any))
          .thenAnswer((realInvocation) => privateIdentity);

      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(mockDTO));

      when(hexMapper.mapTo(any)).thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given an identifier and a privateKey, when I call getPrivateIdentity, then I expect a PrivateIdentityEntity to be returned",
        () async {
      // When
      expect(
          await repository.getPrivateIdentity(
              identifier: identifier, privateKey: privateKey),
          privateIdentity);

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);

      expect(verify(hexMapper.mapTo(captureAny)).captured.first, privateKey);

      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      expect(
          verify(walletDataSource.getWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);

      var captureDTOMapper =
          verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
              .captured;
      expect(captureDTOMapper[0], mockDTO);
      expect(captureDTOMapper[1], privateKey);
    });

    test(
        "Given an identifier and a privateKey, when I call getPrivateIdentity and an error occurred, then I expect a IdentityException to be returned",
        () async {
      // Given
      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When

      await repository
          .getPrivateIdentity(identifier: identifier, privateKey: privateKey)
          .then((_) => expect(true, false))
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

      expect(verify(hexMapper.mapTo(captureAny)).captured.first, privateKey);

      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      expect(
          verify(walletDataSource.getWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);

      verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));
    });

    test(
        "Given an identifier and a privateKey, when I call getPrivateIdentity and the associated identity identifier is different, then I expect a InvalidPrivateKeyException to be returned",
        () async {
      // Given
      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(otherIdentifier));

      // When
      await repository
          .getPrivateIdentity(identifier: identifier, privateKey: privateKey)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, isA<InvalidPrivateKeyException>());
        expect(error.error.privateKey, privateKey);
      });

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);

      expect(verify(hexMapper.mapTo(captureAny)).captured.first, privateKey);

      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      expect(
          verify(walletDataSource.getWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);

      verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));
    });
  });

  group("Sign message", () {
    setUp(() {
      reset(libIdentityDataSource);
      reset(privateKeyMapper);

      // Given
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
              privateKey: privateKey, message: message),
          signature);

      // Then
      expect(verify(hexMapper.mapTo(captureAny)).captured.first, privateKey);
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
          .signMessage(privateKey: privateKey, message: message)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, exception);
      });

      // Then
      expect(verify(hexMapper.mapTo(captureAny)).captured.first, privateKey);
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
          repository.removeIdentity(
              privateKey: privateKey, identifier: identifier),
          completes);

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
      await expectLater(
          repository.removeIdentity(
              privateKey: privateKey, identifier: identifier),
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

  group("Get Identity State", () {
    setUp(() {
      reset(rpcDataSource);

      // Given
      when(localContractFilesDataSource.loadStateContract(any))
          .thenAnswer((realInvocation) => Future.value(contract));
      when(stateIdentifierMapper.mapTo(any)).thenAnswer((realInvocation) => id);
      when(rpcDataSource.getState(any, any))
          .thenAnswer((realInvocation) => Future.value(state));
    });

    test(
        "Given parameters, when I call getState, then I expect a string to be returned",
        () async {
      // When
      expect(
          await repository.getState(
              identifier: identifier, contractAddress: address),
          state);

      // Then
      expect(
          verify(localContractFilesDataSource.loadStateContract(captureAny))
              .captured
              .first,
          address);
      expect(verify(stateIdentifierMapper.mapTo(captureAny)).captured.first,
          identifier);
      var getStateCaptured =
          verify(rpcDataSource.getState(captureAny, captureAny)).captured;

      expect(getStateCaptured[0], id);
      expect(getStateCaptured[1], contract);
    });

    test(
        "Given parameters, when I call getState and an error occured, then I expect an exception to be thrown",
        () async {
      // Given
      when(rpcDataSource.getState(any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .getState(identifier: identifier, contractAddress: address)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<FetchIdentityStateException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(localContractFilesDataSource.loadStateContract(captureAny))
              .captured
              .first,
          address);
      expect(verify(stateIdentifierMapper.mapTo(captureAny)).captured.first,
          identifier);
      var getStateCaptured =
          verify(rpcDataSource.getState(captureAny, captureAny)).captured;

      expect(getStateCaptured[0], id);
      expect(getStateCaptured[1], contract);
    });
  });

  group("Get State Roots", () {
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
      expect(await repository.getStateRoots(url: url), rhsNodeEntities[0]);

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
          .getStateRoots(url: url)
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

  group("Get non revocation proof", () {
    test(
        "Given parameters, when I call getNonRevProof, then I expect a Map to be returned",
        () async {
      // Given
      when(remoteIdentityDataSource.getNonRevocationProof(any, any, any))
          .thenAnswer((realInvocation) => Future.value(nonRev));

      // When
      expect(
          await repository.getNonRevProof(
              identityState: state, nonce: nonce, baseUrl: url),
          nonRev);

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.getNonRevocationProof(
              captureAny, captureAny, captureAny))
          .captured;

      expect(fetchCaptured[0], state);
      expect(fetchCaptured[1], nonce);
      expect(fetchCaptured[2], url);
    });

    test(
        "Given parameters, when I call getNonRevProof and an error occurred, then I expect a NonRevProofException to be thrown",
        () async {
      // Given
      when(remoteIdentityDataSource.getNonRevocationProof(any, any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .getNonRevProof(identityState: state, nonce: nonce, baseUrl: url)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<NonRevProofException>());
        expect(error.error, exception);
      });

      // Then
      var fetchCaptured = verify(remoteIdentityDataSource.getNonRevocationProof(
              captureAny, captureAny, captureAny))
          .captured;

      expect(fetchCaptured[0], state);
      expect(fetchCaptured[1], nonce);
      expect(fetchCaptured[2], url);
    });
  });
}
