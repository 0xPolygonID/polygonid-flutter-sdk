import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import '../data_sources/storage_identity_data_source_test.dart';
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
const mockDTO = IdentityDTO(
    privateKey: privateKey, identifier: identifier, authClaim: authClaim);
const mockEntity = Identity(
    privateKey: privateKey, identifier: identifier, authClaim: authClaim);
const message = "theMessage";
const signature = "theSignature";
const circuitId = "1";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitData(circuitId, datFile, zKeyFile);
const token = "token";
var exception = Exception();

// Dependencies
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockLibIdentityDataSource libIdentityDataSource = MockLibIdentityDataSource();
MockStorageIdentityDataSource storageIdentityDataSource =
    MockStorageIdentityDataSource();
MockStorageKeyValueDataSource storageKeyValueDataSource =
    MockStorageKeyValueDataSource();
MockJWZDataSource jwzDataSource = MockJWZDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();
MockIdentityDTOMapper identityDTOMapper = MockIdentityDTOMapper();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
    walletDataSource,
    libIdentityDataSource,
    storageIdentityDataSource,
    storageKeyValueDataSource,
    jwzDataSource,
    hexMapper,
    privateKeyMapper,
    identityDTOMapper);

@GenerateMocks([
  WalletDataSource,
  LibIdentityDataSource,
  StorageIdentityDataSource,
  StorageKeyValueDataSource,
  JWZDataSource,
  HexMapper,
  PrivateKeyMapper,
  IdentityDTOMapper
])
void main() {
  group("Create identity", () {
    setUp(() {
      reset(libIdentityDataSource);
      reset(storageIdentityDataSource);
      reset(hexMapper);
      reset(privateKeyMapper);
      reset(identityDTOMapper);

      // Given
      when(libIdentityDataSource.getAuthClaim(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(authClaim));
      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));
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

  group("Get auth token", () {
    setUp(() {
      // Given
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
    });

    test(
        "Given an identifier, a circuitData and a message to sign, when I call getAuthToken, then I expect an auth token to be returned as a string",
        () async {
      // When
      expect(
          await repository.getAuthToken(
              identifier: identifier,
              circuitData: circuitData,
              message: message),
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
      expect(authCaptured[3], circuitData.circuitId);
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
              identifier: identifier,
              circuitData: circuitData,
              message: message),
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
}
