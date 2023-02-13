import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_inputs_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/did_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/poseidon_hash_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:web3dart/web3dart.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import '../../common/identity_mocks.dart';
import 'identity_repository_impl_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => CommonMocks.aBytes;

  @override
  List<String> get publicKey => CommonMocks.pubKeys;
}

final mockWallet = FakeWallet();
const otherIdentifier = "theOtherIdentifier";
final mockDTO = IdentityDTO(
  did: CommonMocks.identifier,
  publicKey: CommonMocks.pubKeys,
  profiles: CommonMocks.profiles,
);

final mockAuthResponse = AuthResponse(
  id: "id",
  thid: Iden3commMocks.authRequest.thid,
  to: Iden3commMocks.authRequest.from,
  from: CommonMocks.identifier,
  typ: "application/iden3comm-plain-json",
  type: "https://iden3-communication.io/authorization/1.0/response",
  body: AuthBodyResponse(
    message: Iden3commMocks.authRequest.body.message,
    proofs: [],
    did_doc: null,
  ),
);

final rhsNodeDTOs = [
  RhsNodeDTO(
      node: NodeDTO(
        children: const [],
        hash: HashDTO(data: Uint8List(32)),
        type: NodeTypeDTO.middle,
      ),
      status: ''),
  RhsNodeDTO(
      node: NodeDTO(
        children: const [],
        hash: HashDTO(data: Uint8List(32)),
        type: NodeTypeDTO.leaf,
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
var genesis = '''
{
  "did": "${CommonMocks.id}"
}
''';
var claimChildren = [CommonMocks.id, CommonMocks.id];

// Dependencies
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockRemoteIdentityDataSource remoteIdentityDataSource =
    MockRemoteIdentityDataSource();
MockStorageIdentityDataSource storageIdentityDataSource =
    MockStorageIdentityDataSource();
MockRPCDataSource rpcDataSource = MockRPCDataSource();
MockLocalContractFilesDataSource localContractFilesDataSource =
    MockLocalContractFilesDataSource();
MockLibBabyJubJubDataSource libBabyJubJubDataSource =
    MockLibBabyJubJubDataSource();
MockLibPolygonIdCoreIdentityDataSource libPolygonIdCoreIdentityDataSource =
    MockLibPolygonIdCoreIdentityDataSource();
MockSMTDataSource smtDataSource = MockSMTDataSource();
MockEncryptionDbDataSource encryptionDbDataSource =
    MockEncryptionDbDataSource();
MockDestinationPathDataSource destinationPathDataSource =
    MockDestinationPathDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();
MockIdentityDTOMapper identityDTOMapper = MockIdentityDTOMapper();
MockRhsNodeMapper rhsNodeMapper = MockRhsNodeMapper();
MockStateIdentifierMapper stateIdentifierMapper = MockStateIdentifierMapper();
MockNodeMapper nodeMapper = MockNodeMapper();
MockQMapper qMapper = MockQMapper();
MockEncryptionKeyMapper encryptionKeyMapper = MockEncryptionKeyMapper();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
  walletDataSource,
  remoteIdentityDataSource,
  storageIdentityDataSource,
  rpcDataSource,
  localContractFilesDataSource,
  libBabyJubJubDataSource,
  libPolygonIdCoreIdentityDataSource,
  smtDataSource,
  encryptionDbDataSource,
  destinationPathDataSource,
  hexMapper,
  privateKeyMapper,
  identityDTOMapper,
  rhsNodeMapper,
  stateIdentifierMapper,
  nodeMapper,
  qMapper,
  encryptionKeyMapper,
);

@GenerateMocks([
  WalletDataSource,
  RemoteIdentityDataSource,
  StorageIdentityDataSource,
  RPCDataSource,
  LocalContractFilesDataSource,
  LocalClaimDataSource,
  LibBabyJubJubDataSource,
  LibPolygonIdCoreIdentityDataSource,
  SMTDataSource,
  EncryptionDbDataSource,
  DestinationPathDataSource,
  HexMapper,
  PrivateKeyMapper,
  IdentityDTOMapper,
  RhsNodeMapper,
  StateIdentifierMapper,
  NodeMapper,
  QMapper,
  EncryptionKeyMapper,
])
void main() {
  /// FIXME: skipping fixing, [IdentityRepository.createIdentity] needs refactor
  // group("Create identity", () {
  //   setUp(() {
  //     reset(walletDataSource);
  //     reset(libPolygonIdCoreIdentityDataSource);
  //     reset(storageIdentityDataSource);
  //     reset(localClaimDataSource);
  //     reset(localContractFilesDataSource);
  //     reset(hexMapper);
  //     reset(privateKeyMapper);
  //     reset(identityDTOMapper);
  //     reset(smtDataSource);
  //
  //     // Given
  //     when(privateKeyMapper.mapFrom(any))
  //         .thenAnswer((realInvocation) => CommonMocks.aBytes);
  //
  //     when(walletDataSource.createWallet(
  //             secret: anyNamed('secret'),
  //             accessMessage: anyNamed('accessMessage')))
  //         .thenAnswer((realInvocation) => Future.value(mockWallet));
  //
  //     when(walletDataSource.getWallet(privateKey: anyNamed('privateKey')))
  //         .thenAnswer((realInvocation) => Future.value(mockWallet));
  //
  //     when(identityDTOMapper.mapPrivateFrom(any, any))
  //         .thenAnswer((realInvocation) => IdentityMocks.privateIdentity);
  //
  //     when(hexMapper.mapFrom(any))
  //         .thenAnswer((realInvocation) => CommonMocks.walletPrivateKey);
  //
  //     when(hexMapper.mapTo(any))
  //         .thenAnswer((realInvocation) => mockWallet.privateKey);
  //
  //     when(storageIdentityDataSource.getIdentity(did: anyNamed('did')))
  //         .thenAnswer((realInvocation) =>
  //             Future.error(UnknownIdentityException(CommonMocks.identifier)));
  //
  //     when(identityDTOMapper.mapFrom(any))
  //         .thenAnswer((realInvocation) => IdentityMocks.identity);
  //
  //     when(libPolygonIdCoreIdentityDataSource.calculateGenesisId(any, any, any))
  //         .thenReturn(genesis);
  //
  //     when(localClaimDataSource.getAuthClaim(publicKey: anyNamed('publicKey')))
  //         .thenAnswer((realInvocation) => Future.value(claimChildren));
  //   });
  //
  //   test(
  //       "Given a private key, when I call createIdentity, then I expect a PrivateIdentityEntity to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.createIdentity(
  //             secret: CommonMocks.privateKey,
  //             accessMessage: CommonMocks.config),
  //         IdentityMocks.privateIdentity);
  //
  //     // Then
  //     var createCaptured = verify(walletDataSource.createWallet(
  //             secret: captureAnyNamed('secret'),
  //             accessMessage: captureAnyNamed('accessMessage')))
  //         .captured;
  //     expect(createCaptured[0], CommonMocks.aBytes);
  //     expect(createCaptured[1], CommonMocks.config);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     var identityMapperCaptured =
  //         verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
  //             .captured;
  //     expect(identityMapperCaptured[0], mockDTO);
  //     expect(identityMapperCaptured[1], CommonMocks.walletPrivateKey);
  //
  //     var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
  //     expect(hexMapperVerify.callCount, 2);
  //     expect(hexMapperVerify.captured[0], mockWallet.privateKey);
  //     expect(hexMapperVerify.captured[1], mockWallet.privateKey);
  //   });
  //
  //   test(
  //       "Given a private key which is null, when I call createIdentity, then I expect a PrivateIdentityEntity to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.createIdentity(
  //             secret: null, accessMessage: CommonMocks.config),
  //         IdentityMocks.privateIdentity);
  //
  //     // Then
  //     var createCaptured = verify(walletDataSource.createWallet(
  //             secret: captureAnyNamed('secret'),
  //             accessMessage: captureAnyNamed('accessMessage')))
  //         .captured;
  //     expect(createCaptured[0], CommonMocks.aBytes);
  //     expect(createCaptured[1], CommonMocks.config);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     var identityMapperCaptured =
  //         verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
  //             .captured;
  //     expect(identityMapperCaptured[0], mockDTO);
  //     expect(identityMapperCaptured[1], CommonMocks.walletPrivateKey);
  //
  //     var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
  //     expect(hexMapperVerify.callCount, 2);
  //     expect(hexMapperVerify.captured[0], mockWallet.privateKey);
  //     expect(hexMapperVerify.captured[1], mockWallet.privateKey);
  //   });
  //
  //   test(
  //       "Given a private key, when I call createIdentity and an error occurred, then I expect a IdentityException to be thrown",
  //       () async {
  //     // Given
  //     when(libIdentityDataSource.getIdentifier(
  //             pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await repository
  //         .createIdentity(
  //             secret: CommonMocks.privateKey, accessMessage: CommonMocks.config)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<IdentityException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     var createCaptured = verify(walletDataSource.createWallet(
  //             secret: captureAnyNamed('secret'),
  //             accessMessage: captureAnyNamed('accessMessage')))
  //         .captured;
  //     expect(createCaptured[0], CommonMocks.aBytes);
  //     expect(createCaptured[1], CommonMocks.config);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));
  //
  //     var hexMapperVerify = verify(hexMapper.mapFrom(captureAny));
  //     expect(hexMapperVerify.callCount, 1);
  //     expect(hexMapperVerify.captured[0], mockWallet.privateKey);
  //   });
  // });

  group("Get identity", () {
    setUp(() {
      reset(storageIdentityDataSource);
      reset(identityDTOMapper);

      // Given
      when(identityDTOMapper.mapFrom(any))
          .thenAnswer((realInvocation) => IdentityMocks.identity);

      when(storageIdentityDataSource.getIdentity(did: anyNamed('did')))
          .thenAnswer((realInvocation) => Future.value(mockDTO));
    });

    test(
        "Given an identifier, when I call getIdentity, then I expect a IdentityEntity to be returned",
        () async {
      // When
      expect(await repository.getIdentity(genesisDid: CommonMocks.identifier),
          IdentityMocks.identity);

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  did: captureAnyNamed('did')))
              .captured
              .first,
          CommonMocks.identifier);

      expect(verify(identityDTOMapper.mapFrom(captureAny)).captured.first,
          mockDTO);
    });

    test(
        "Given an identifier, when I call getIdentity and an error occurred, then I expect a IdentityException to be thrown",
        () async {
      // Given
      when(storageIdentityDataSource.getIdentity(did: anyNamed('did')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await repository
          .getIdentity(genesisDid: CommonMocks.identifier)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, CommonMocks.exception);
      });

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  did: captureAnyNamed('did')))
              .captured
              .first,
          CommonMocks.identifier);

      verifyNever(identityDTOMapper.mapFrom(captureAny));
    });

    test(
        "Given an identifier, when I call getIdentity and the identity doesn't exist, then I expect a UnknownIdentityException to be thrown",
        () async {
      // Given
      when(storageIdentityDataSource.getIdentity(did: anyNamed('did')))
          .thenAnswer((realInvocation) =>
              Future.error(UnknownIdentityException(CommonMocks.identifier)));

      // When
      await repository
          .getIdentity(genesisDid: CommonMocks.identifier)
          .then((_) => null)
          .catchError((error) {
        expect(error, isA<UnknownIdentityException>());
        expect(error.did, CommonMocks.identifier);
      });

      // Then
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  did: captureAnyNamed('did')))
              .captured
              .first,
          CommonMocks.identifier);

      verifyNever(identityDTOMapper.mapFrom(captureAny));
    });
  });

  // group("Get private identity", () {
  //   setUp(() {
  //     reset(walletDataSource);
  //     reset(libPolygonIdCoreIdentityDataSource);
  //     reset(storageIdentityDataSource);
  //     reset(identityDTOMapper);
  //     reset(hexMapper);
  //
  //     // Given
  //     when(walletDataSource.getWallet(privateKey: anyNamed('privateKey')))
  //         .thenAnswer((realInvocation) => Future.value(mockWallet));
  //
  //     when(libPolygonIdCoreIdentityDataSource.calculateGenesisId(any, any, any))
  //         .thenReturn(genesis);
  //
  //     when(identityDTOMapper.mapPrivateFrom(any, any))
  //         .thenAnswer((realInvocation) => IdentityMocks.privateIdentity);
  //
  //     when(storageIdentityDataSource.getIdentity(did: anyNamed('did')))
  //         .thenAnswer((realInvocation) => Future.value(mockDTO));
  //
  //     when(hexMapper.mapTo(any))
  //         .thenAnswer((realInvocation) => CommonMocks.aBytes);
  //   });
  //
  //   test(
  //       "Given an identifier and a privateKey, when I call getPrivateIdentity, then I expect a PrivateIdentityEntity to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.getPrivateIdentity(
  //             did: CommonMocks.identifier, privateKey: CommonMocks.privateKey),
  //         IdentityMocks.privateIdentity);
  //
  //     // Then
  //     expect(
  //         verify(storageIdentityDataSource.getIdentity(
  //                 did: captureAnyNamed('did')))
  //             .captured
  //             .first,
  //         CommonMocks.identifier);
  //
  //     expect(verify(hexMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.privateKey);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     expect(
  //         verify(walletDataSource.getWallet(
  //                 privateKey: captureAnyNamed('privateKey')))
  //             .captured
  //             .first,
  //         CommonMocks.aBytes);
  //
  //     var captureDTOMapper =
  //         verify(identityDTOMapper.mapPrivateFrom(captureAny, captureAny))
  //             .captured;
  //     expect(captureDTOMapper[0], mockDTO);
  //     expect(captureDTOMapper[1], CommonMocks.privateKey);
  //   });
  //
  //   test(
  //       "Given an identifier and a privateKey, when I call getPrivateIdentity and an error occurred, then I expect a IdentityException to be returned",
  //       () async {
  //     // Given
  //     when(libIdentityDataSource.getIdentifier(
  //             pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //
  //     await repository
  //         .getPrivateIdentity(
  //             did: CommonMocks.identifier, privateKey: CommonMocks.privateKey)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<IdentityException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     expect(
  //         verify(storageIdentityDataSource.getIdentity(
  //                 did: captureAnyNamed('did')))
  //             .captured
  //             .first,
  //         CommonMocks.identifier);
  //
  //     expect(verify(hexMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.privateKey);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     expect(
  //         verify(walletDataSource.getWallet(
  //                 privateKey: captureAnyNamed('privateKey')))
  //             .captured
  //             .first,
  //         CommonMocks.aBytes);
  //
  //     verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));
  //   });
  //
  //   test(
  //       "Given an identifier and a privateKey, when I call getPrivateIdentity and the associated identity identifier is different, then I expect a InvalidPrivateKeyException to be returned",
  //       () async {
  //     // Given
  //     when(libIdentityDataSource.getIdentifier(
  //             pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
  //         .thenAnswer((realInvocation) => Future.value(otherIdentifier));
  //
  //     // When
  //     await repository
  //         .getPrivateIdentity(
  //             did: CommonMocks.identifier, privateKey: CommonMocks.privateKey)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<IdentityException>());
  //       expect(error.error, isA<InvalidPrivateKeyException>());
  //       expect(error.error.privateKey, CommonMocks.privateKey);
  //     });
  //
  //     // Then
  //     expect(
  //         verify(storageIdentityDataSource.getIdentity(
  //                 did: captureAnyNamed('did')))
  //             .captured
  //             .first,
  //         CommonMocks.identifier);
  //
  //     expect(verify(hexMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.privateKey);
  //
  //     var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
  //             pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
  //         .captured;
  //     expect(identifierCaptured[0], CommonMocks.pubX);
  //     expect(identifierCaptured[1], CommonMocks.pubY);
  //
  //     expect(
  //         verify(walletDataSource.getWallet(
  //                 privateKey: captureAnyNamed('privateKey')))
  //             .captured
  //             .first,
  //         CommonMocks.aBytes);
  //
  //     verifyNever(identityDTOMapper.mapPrivateFrom(captureAny, captureAny));
  //   });
  // });
  //
  // group("Sign message", () {
  //   setUp(() {
  //     reset(libIdentityDataSource);
  //     reset(privateKeyMapper);
  //
  //     // Given
  //     when(walletDataSource.signMessage(
  //             privateKey: anyNamed('privateKey'), message: anyNamed('message')))
  //         .thenAnswer((realInvocation) => Future.value(CommonMocks.signature));
  //     when(hexMapper.mapTo(any))
  //         .thenAnswer((realInvocation) => CommonMocks.aBytes);
  //   });
  //
  //   test(
  //       "Given an identifier key and a message, when I call signMessage, then I expect a signature as a String to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.signMessage(
  //             privateKey: CommonMocks.privateKey, message: CommonMocks.message),
  //         CommonMocks.signature);
  //
  //     // Then
  //     expect(verify(hexMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.privateKey);
  //     var signCaptured = verify(walletDataSource.signMessage(
  //             privateKey: captureAnyNamed('privateKey'),
  //             message: captureAnyNamed('message')))
  //         .captured;
  //     expect(signCaptured[0], CommonMocks.aBytes);
  //     expect(signCaptured[1], CommonMocks.message);
  //   });
  //
  //   test(
  //       "Given an identifier key and a message, when I call signMessage and an error occurred, then I expect an IdentityException to be thrown",
  //       () async {
  //     // Given
  //     when(walletDataSource.signMessage(
  //             privateKey: anyNamed('privateKey'), message: anyNamed('message')))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await repository
  //         .signMessage(
  //             privateKey: CommonMocks.privateKey, message: CommonMocks.message)
  //         .then((_) => null)
  //         .catchError((error) {
  //       expect(error, isA<IdentityException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     expect(verify(hexMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.privateKey);
  //     var signCaptured = verify(walletDataSource.signMessage(
  //             privateKey: captureAnyNamed('privateKey'),
  //             message: captureAnyNamed('message')))
  //         .captured;
  //     expect(signCaptured[0], CommonMocks.aBytes);
  //     expect(signCaptured[1], CommonMocks.message);
  //   });
  // });
  //
  // group("Remove identity", () {
  //   test(
  //       "Given an identifier, when I call removeIdentity, then I expect the process to complete",
  //       () async {
  //     // Given
  //     when(storageIdentityDataSource.removeIdentity(
  //             did: anyNamed('did')))
  //         .thenAnswer((realInvocation) => Future.value());
  //
  //     // When
  //     await expectLater(
  //         repository.removeIdentity(
  //             privateKey: CommonMocks.privateKey, did: CommonMocks.identifier),
  //         completes);
  //
  //     // Then
  //     expect(
  //         verify(storageIdentityDataSource.removeIdentity(
  //                 did: captureAnyNamed('did')))
  //             .captured
  //             .first,
  //         CommonMocks.identifier);
  //   });
  //
  //   test(
  //       "Given an identifier, when I call removeIdentity and an error occurred, then I expect an error to be thrown",
  //       () async {
  //     // Given
  //     when(storageIdentityDataSource.removeIdentity(
  //             did: anyNamed('did')))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await expectLater(
  //         repository.removeIdentity(
  //             privateKey: CommonMocks.privateKey, did: CommonMocks.identifier),
  //         throwsA(CommonMocks.exception));
  //
  //     // Then
  //     expect(
  //         verify(storageIdentityDataSource.removeIdentity(
  //                 did: captureAnyNamed('did')))
  //             .captured
  //             .first,
  //         CommonMocks.identifier);
  //   });
  // });
  //
  // group("Get Identity State", () {
  //   setUp(() {
  //     reset(rpcDataSource);
  //
  //     // Given
  //     when(localContractFilesDataSource.loadStateContract(any))
  //         .thenAnswer((realInvocation) => Future.value(contract));
  //     when(stateIdentifierMapper.mapTo(any))
  //         .thenAnswer((realInvocation) => CommonMocks.id);
  //     when(rpcDataSource.getState(any, any))
  //         .thenAnswer((realInvocation) => Future.value(CommonMocks.state));
  //   });
  //
  //   test(
  //       "Given parameters, when I call getState, then I expect a string to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.getState(
  //             identifier: CommonMocks.identifier, contractAddress: address),
  //         CommonMocks.state);
  //
  //     // Then
  //     expect(
  //         verify(localContractFilesDataSource.loadStateContract(captureAny))
  //             .captured
  //             .first,
  //         address);
  //     expect(verify(stateIdentifierMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.identifier);
  //     var getStateCaptured =
  //         verify(rpcDataSource.getState(captureAny, captureAny)).captured;
  //
  //     expect(getStateCaptured[0], CommonMocks.id);
  //     expect(getStateCaptured[1], contract);
  //   });
  //
  //   test(
  //       "Given parameters, when I call getState and an error occured, then I expect an exception to be thrown",
  //       () async {
  //     // Given
  //     when(rpcDataSource.getState(any, any))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await repository
  //         .getState(
  //             identifier: CommonMocks.identifier, contractAddress: address)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<FetchIdentityStateException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     expect(
  //         verify(localContractFilesDataSource.loadStateContract(captureAny))
  //             .captured
  //             .first,
  //         address);
  //     expect(verify(stateIdentifierMapper.mapTo(captureAny)).captured.first,
  //         CommonMocks.identifier);
  //     var getStateCaptured =
  //         verify(rpcDataSource.getState(captureAny, captureAny)).captured;
  //
  //     expect(getStateCaptured[0], CommonMocks.id);
  //     expect(getStateCaptured[1], contract);
  //   });
  // });
  //
  // group("Get State Roots", () {
  //   setUp(() {
  //     reset(remoteIdentityDataSource);
  //     reset(rhsNodeMapper);
  //
  //     // Given
  //     when(remoteIdentityDataSource.fetchStateRoots(url: anyNamed('url')))
  //         .thenAnswer((realInvocation) => Future.value(rhsNodeDTOs[0]));
  //     when(rhsNodeMapper.mapFrom(any)).thenReturn(rhsNodeEntities[0]);
  //   });
  //
  //   test(
  //       "Given parameters, when I call fetchStateRoots, then I expect a RhsNodeEntity to be returned",
  //       () async {
  //     // When
  //     expect(await repository.getStateRoots(url: CommonMocks.url),
  //         rhsNodeEntities[0]);
  //
  //     // Then
  //     var fetchCaptured = verify(remoteIdentityDataSource.fetchStateRoots(
  //             url: captureAnyNamed('url')))
  //         .captured;
  //
  //     expect(fetchCaptured[0], CommonMocks.url);
  //
  //     expect(verify(rhsNodeMapper.mapFrom(captureAny)).captured.first,
  //         rhsNodeDTOs[0]);
  //   });
  //
  //   test(
  //       "Given parameters, when I call fetchStateRoots and an error occurred, then I expect a FetchIdentityStateException to be thrown",
  //       () async {
  //     // Given
  //     when(remoteIdentityDataSource.fetchStateRoots(
  //       url: anyNamed('url'),
  //     )).thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await repository
  //         .getStateRoots(url: CommonMocks.url)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<FetchStateRootsException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     var fetchCaptured = verify(remoteIdentityDataSource.fetchStateRoots(
  //       url: captureAnyNamed('url'),
  //     )).captured;
  //
  //     expect(fetchCaptured[0], CommonMocks.url);
  //
  //     verifyNever(rhsNodeMapper.mapFrom(captureAny));
  //   });
  // });
  //
  // group("Get non revocation proof", () {
  //   test(
  //       "Given parameters, when I call getNonRevProof, then I expect a Map to be returned",
  //       () async {
  //     // Given
  //     when(remoteIdentityDataSource.getNonRevocationProof(any, any, any))
  //         .thenAnswer((realInvocation) => Future.value(nonRev));
  //
  //     // When
  //     expect(
  //         await repository.getNonRevProof(
  //             identityState: CommonMocks.state,
  //             nonce: CommonMocks.nonce,
  //             baseUrl: CommonMocks.url),
  //         nonRev);
  //
  //     // Then
  //     var fetchCaptured = verify(remoteIdentityDataSource.getNonRevocationProof(
  //             captureAny, captureAny, captureAny))
  //         .captured;
  //
  //     expect(fetchCaptured[0], CommonMocks.state);
  //     expect(fetchCaptured[1], CommonMocks.nonce);
  //     expect(fetchCaptured[2], CommonMocks.url);
  //   });
  //
  //   test(
  //       "Given parameters, when I call getNonRevProof and an error occurred, then I expect a NonRevProofException to be thrown",
  //       () async {
  //     // Given
  //     when(remoteIdentityDataSource.getNonRevocationProof(any, any, any))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await repository
  //         .getNonRevProof(
  //             identityState: CommonMocks.state,
  //             nonce: CommonMocks.nonce,
  //             baseUrl: CommonMocks.url)
  //         .then((_) => expect(true, false))
  //         .catchError((error) {
  //       expect(error, isA<NonRevProofException>());
  //       expect(error.error, CommonMocks.exception);
  //     });
  //
  //     // Then
  //     var fetchCaptured = verify(remoteIdentityDataSource.getNonRevocationProof(
  //             captureAny, captureAny, captureAny))
  //         .captured;
  //
  //     expect(fetchCaptured[0], CommonMocks.state);
  //     expect(fetchCaptured[1], CommonMocks.nonce);
  //     expect(fetchCaptured[2], CommonMocks.url);
  //   });
  // });
  //
  // group("Get challenge", () {
  //   setUp(() {
  //     when(qMapper.mapFrom(any)).thenReturn(CommonMocks.id);
  //     when(hashMapper.mapFrom(any)).thenReturn(CommonMocks.challenge);
  //     when(babyjubjubLibDataSource.getPoseidonHash(any))
  //         .thenAnswer((realInvocation) => Future.value(CommonMocks.hash));
  //   });
  //
  //   test(
  //       "Given a message, when I call getChallenge, then I expect a String to be returned",
  //       () async {
  //     // When
  //     expect(await repository.getChallenge(message: CommonMocks.message),
  //         CommonMocks.challenge);
  //
  //     // Then
  //     expect(verify(qMapper.mapFrom(captureAny)).captured.first,
  //         CommonMocks.message);
  //     expect(verify(hashMapper.mapFrom(captureAny)).captured.first,
  //         CommonMocks.hash);
  //     expect(
  //         verify(babyjubjubLibDataSource.getPoseidonHash(captureAny))
  //             .captured
  //             .first,
  //         CommonMocks.id);
  //   });
  //
  //   test(
  //       "Given a message, when I call getChallenge and an error occurred, then I expect an exception to be thrown",
  //       () async {
  //     // Given
  //     when(babyjubjubLibDataSource.getPoseidonHash(any))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await expectLater(repository.getChallenge(message: CommonMocks.message),
  //         throwsA(CommonMocks.exception));
  //
  //     // Then
  //     expect(verify(qMapper.mapFrom(captureAny)).captured.first,
  //         CommonMocks.message);
  //     verifyNever(hashMapper.mapFrom(captureAny));
  //     expect(
  //         verify(babyjubjubLibDataSource.getPoseidonHash(captureAny))
  //             .captured
  //             .first,
  //         CommonMocks.id);
  //   });
  // });
  //
  // group("Get auth inputs", () {
  //   setUp(() {
  //     when(libIdentityDataSource.getAuthInputs(any, any, any, any))
  //         .thenAnswer((realInvocation) => Future.value(CommonMocks.message));
  //     when(authInputsMapper.mapFrom(any)).thenReturn(CommonMocks.aBytes);
  //   });
  //
  //   test(
  //       "Given parameters, when I call getAuthInputs, then I expect bytes to be returned",
  //       () async {
  //     // When
  //     expect(
  //         await repository.getAuthInputs(
  //             challenge: CommonMocks.challenge,
  //             authClaim: CommonMocks.authClaim,
  //             identity: IdentityMocks.identity,
  //             signature: CommonMocks.signature),
  //         CommonMocks.aBytes);
  //
  //     // Then
  //     var captureGetAuthInputs = verify(libIdentityDataSource.getAuthInputs(
  //             captureAny, captureAny, captureAny, captureAny))
  //         .captured;
  //     expect(captureGetAuthInputs[0], CommonMocks.challenge);
  //     expect(captureGetAuthInputs[1], CommonMocks.authClaim);
  //     expect(captureGetAuthInputs[2], IdentityMocks.identity.publicKey);
  //     expect(captureGetAuthInputs[3], CommonMocks.signature);
  //
  //     expect(verify(authInputsMapper.mapFrom(captureAny)).captured.first,
  //         CommonMocks.message);
  //   });
  //
  //   test(
  //       "Given parameters, when I call getAuthInputs and an error occurred, then I expect an exception to be thrown",
  //       () async {
  //     // Given
  //     when(libIdentityDataSource.getAuthInputs(any, any, any, any))
  //         .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
  //
  //     // When
  //     await expectLater(
  //         repository.getAuthInputs(
  //             challenge: CommonMocks.challenge,
  //             authClaim: CommonMocks.authClaim,
  //             identity: IdentityMocks.identity,
  //             signature: CommonMocks.signature),
  //         throwsA(CommonMocks.exception));
  //
  //     // Then
  //     var captureGetAuthInputs = verify(libIdentityDataSource.getAuthInputs(
  //             captureAny, captureAny, captureAny, captureAny))
  //         .captured;
  //     expect(captureGetAuthInputs[0], CommonMocks.challenge);
  //     expect(captureGetAuthInputs[1], CommonMocks.authClaim);
  //     expect(captureGetAuthInputs[2], IdentityMocks.identity.publicKey);
  //     expect(captureGetAuthInputs[3], CommonMocks.signature);
  //
  //     verifyNever(authInputsMapper.mapFrom(captureAny));
  //   });
  // });
}
