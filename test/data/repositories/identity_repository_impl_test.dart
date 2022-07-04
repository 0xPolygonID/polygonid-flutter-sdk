import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/local_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import 'identity_repository_impl_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  dynamic get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const privateKey = "thePrivateKey";
const longPrivateKey =
    "thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long";
var mockWallet = FakeWallet();
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const result = Identity(identifier: identifier, authClaim: authClaim);
var exception = Exception();
var identityException = IdentityException(exception);

// Dependencies
MockLocalIdentityDataSource localIdentityDataSource =
    MockLocalIdentityDataSource();

// Tested instance
IdentityRepository repository = IdentityRepositoryImpl(localIdentityDataSource);

@GenerateMocks([LocalIdentityDataSource])
void main() {
  group("Get identity", () {
    setUp(() {
      reset(localIdentityDataSource);

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
        "Given a private key which is too long, when I call getIdentity, then I expect a TooLongPrivateKeyException to be thrown",
        () async {
      // When
      await expectLater(repository.createIdentity(privateKey: longPrivateKey),
          throwsA(isA<TooLongPrivateKeyException>()));

      // Then
      verifyNever(localIdentityDataSource.createWallet(
          privateKey: anyNamed('privateKey')));
      verifyNever(localIdentityDataSource.getIdentifier(
          pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')));
      verifyNever(localIdentityDataSource.getAuthclaim(
          pubX: captureAnyNamed('pubX'), pubY: captureAnyNamed('pubY')));
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
}
