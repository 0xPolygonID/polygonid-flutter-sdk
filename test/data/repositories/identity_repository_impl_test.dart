import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/local_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
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
var mockWallet = FakeWallet();
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const message = "theMessage";
const signature = "theSignature";
const result = Identity(
    privateKey: walletPrivateKey, identifier: identifier, authClaim: authClaim);
var exception = Exception();
var identityException = IdentityException(exception);

// Dependencies
MockLocalIdentityDataSource localIdentityDataSource =
    MockLocalIdentityDataSource();
MockHexMapper hexMapper = MockHexMapper();
MockPrivateKeyMapper privateKeyMapper = MockPrivateKeyMapper();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(
    localIdentityDataSource, hexMapper, privateKeyMapper);

@GenerateMocks([LocalIdentityDataSource, HexMapper, PrivateKeyMapper])
void main() {
  group("Get identity", () {
    setUp(() {
      reset(localIdentityDataSource);
      reset(hexMapper);
      reset(privateKeyMapper);

      // Given
      when(localIdentityDataSource.getAuthclaim(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(authClaim));
      when(localIdentityDataSource.getIdentifier(
              pubX: anyNamed('pubX'), pubY: anyNamed('pubY')))
          .thenAnswer((realInvocation) => Future.value(identifier));
      when(localIdentityDataSource.createWallet(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));
      when(hexMapper.mapFrom(any))
          .thenAnswer((realInvocation) => walletPrivateKey);
      when(privateKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given a private key, when I call getIdentity, then I expect an Identity to be returned",
        () async {
      // When
      expect(await repository.createIdentity(privateKey: privateKey), result);

      // Then
      expect(
          verify(localIdentityDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          isA<Uint8List>());
      var identifierCaptured = verify(localIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var authCaptured = verify(localIdentityDataSource.getAuthclaim(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(authCaptured[0], pubX);
      expect(authCaptured[1], pubY);
    });

    test(
        "Given a private key which is null, when I call getIdentity, then I expect an Identity to be returned",
        () async {
      // Given
      when(privateKeyMapper.mapFrom(any)).thenAnswer((realInvocation) => null);

      // When
      expect(await repository.createIdentity(), isA<Identity>());

      // Then
      expect(
          verify(localIdentityDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          null);
      var identifierCaptured = verify(localIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var authCaptured = verify(localIdentityDataSource.getAuthclaim(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(authCaptured[0], isA<String>());
      expect(authCaptured[1], isA<String>());
    });

    test(
        "Given a private key, when I call getIdentity and an error occured, then I expect a IdentityException to be thrown",
        () async {
      // Given
      when(localIdentityDataSource.getIdentifier(
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
          verify(localIdentityDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          isA<Uint8List>());
      var identifierCaptured = verify(localIdentityDataSource.getIdentifier(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(identifierCaptured[0], pubX);
      expect(identifierCaptured[1], pubY);

      var authCaptured = verify(localIdentityDataSource.getAuthclaim(
              pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')))
          .captured;
      expect(authCaptured[0], isA<String>());
      expect(authCaptured[1], isA<String>());
    });
  });

  group("Sign message", () {
    setUp(() {
      reset(localIdentityDataSource);
      reset(privateKeyMapper);

      // Given
      when(localIdentityDataSource.signMessage(
              privateKey: anyNamed('privateKey'), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.value(signature));
      when(hexMapper.mapTo(any)).thenAnswer((realInvocation) => bbjjKey);
    });

    test(
        "Given a private key and a message, when I call signMessage, then I expect a signature as a String to be returned",
        () async {
      // When
      expect(
          await repository.signMessage(
              privateKey: privateKey, message: message),
          signature);

      // Then
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          privateKey);
      var signCaptured = verify(localIdentityDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(signCaptured[0], bbjjKey);
      expect(signCaptured[1], message);
    });

    test(
        "Given a private key and a message, when I call signMessage and an error occured, then I expect an IdentityException to be thrown",
        () async {
      // Given
      when(localIdentityDataSource.signMessage(
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
      expect(verify(hexMapper.mapTo(captureAny)).captured.first,
          privateKey);
      var signCaptured = verify(localIdentityDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(signCaptured[0], bbjjKey);
      expect(signCaptured[1], message);
    });
  });
}
