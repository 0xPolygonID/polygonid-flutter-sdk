import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:privadoid_sdk/data/data_sources/local_identity_data_source.dart';
import 'package:privadoid_sdk/data/repositories/identity_repository_impl.dart';
import 'package:privadoid_sdk/domain/common/tuples.dart';
import 'package:privadoid_sdk/domain/exceptions/identity_exceptions.dart';
import 'package:privadoid_sdk/domain/repositories/identity_repository.dart';

import 'identity_repository_impl_test.mocks.dart';

// Data
const key = "theKey";
const mockResults = ["theResult1", "theResult2"];
final result = Pair<String, String>(mockResults[0], mockResults[1]);
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
    test(
        "Given a seed phrase, when I call getIdentity, then I expect a private key and an identity to be returned (as a Pair)",
        () async {
      // Given
      when(localIdentityDataSource.generatePrivateKey(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockResults[0]));
      when(localIdentityDataSource.generateIdentifier(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockResults[1]));

      // When
      expect(await repository.getIdentity(key: key), result);

      // Then
      expect(
          verify(localIdentityDataSource.generatePrivateKey(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          isA<Uint8List>());
      expect(
          verify(localIdentityDataSource.generateIdentifier(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          mockResults[0]);
    });

    test(
        "Given a seed phrase which is null, when I call getIdentity, then I expect a private key and an identity to be returned (as a Pair)",
        () async {
      // Given
      when(localIdentityDataSource.generatePrivateKey(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockResults[0]));
      when(localIdentityDataSource.generateIdentifier(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockResults[1]));

      // When
      expect(await repository.getIdentity(), isA<Pair<String, String>>());

      // Then
      expect(
          verify(localIdentityDataSource.generatePrivateKey(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          null);
      expect(
          verify(localIdentityDataSource.generateIdentifier(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          isA<String>());
    });

    test(
        "Given a seed phrase, when I call getIdentity and an error occured, then I expect an error to be thrown",
        () async {
      // Given
      when(localIdentityDataSource.generatePrivateKey(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.error(exception));
      when(localIdentityDataSource.generateIdentifier(
              privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockResults[1]));

      // When
      await repository.getIdentity().then((_) => null).catchError((error) {
        expect(error, isA<IdentityException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(localIdentityDataSource.generatePrivateKey(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          null);
      verifyNever(localIdentityDataSource.generateIdentifier(
          privateKey: captureAnyNamed('privateKey')));
    });
  });
}
