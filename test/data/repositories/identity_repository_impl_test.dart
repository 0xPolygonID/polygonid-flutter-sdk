import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

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
const message = "theMessage";
const signature = "theSignature";
var exception = Exception();

// Dependencies
MockLibIdentityDataSource libIdentityDataSource = MockLibIdentityDataSource();
MockStorageIdentityDataSource storageIdentityDataSource =
    MockStorageIdentityDataSource();
MockStorageKeyValueDataSource storageKeyValueDataSource =
    MockStorageKeyValueDataSource();
MockJWZDataSource jwzDataSource = MockJWZDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
    libIdentityDataSource,
    storageIdentityDataSource,
    storageKeyValueDataSource,
    jwzDataSource,
    hexMapper,
    privateKeyMapper);

@GenerateMocks([
  LibIdentityDataSource,
  StorageIdentityDataSource,
  StorageKeyValueDataSource,
  JWZDataSource,
  HexMapper,
  PrivateKeyMapper
])
void main() {
  group("Create identity", () {
    setUp(() {
      reset(libIdentityDataSource);
      reset(storageIdentityDataSource);
      reset(hexMapper);
      reset(privateKeyMapper);

      // Given
      when(libIdentityDataSource.getAuthClaim(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(authClaim));
      when(libIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));
      when(libIdentityDataSource.createWallet(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) =>
              Future.error(UnknownIdentityException(identifier)));
      when(hexMapper.mapFrom(any))
          .thenAnswer((realInvocation) => walletPrivateKey);
      when(privateKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given a private key, when I call createIdentity, then I expect an identifier to be returned",
        () async {
      // When
      expect(
          await repository.createIdentity(privateKey: privateKey), identifier);

      // Then
      expect(
          verify(libIdentityDataSource.createWallet(
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
          verify(libIdentityDataSource.createWallet(
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
        "Given a private key with an associated Identity already stored, when I call createIdentity, then I expect an identifier to be returned",
        () async {
      // Given
      when(storageIdentityDataSource.getIdentity(
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(mockDTO));

      // When
      expect(await repository.createIdentity(), identifier);

      // Then
      expect(
          verify(libIdentityDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          bbjjKey);
      expect(
          verify(storageIdentityDataSource.getIdentity(
                  identifier: captureAnyNamed('identifier')))
              .captured
              .first,
          identifier);
      var identifierCaptured = verify(libIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      verifyNever(libIdentityDataSource.getAuthClaim(
          pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')));
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
          verify(libIdentityDataSource.createWallet(
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
      when(libIdentityDataSource.signMessage(
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
      var signCaptured = verify(libIdentityDataSource.signMessage(
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
      when(libIdentityDataSource.signMessage(
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
      var signCaptured = verify(libIdentityDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(signCaptured[0], bbjjKey);
      expect(signCaptured[1], message);
    });
  });
}
