import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/local_identity_data_source.dart';

import 'local_identity_data_source_test.mocks.dart';

// Data
const key = "privateKey";
const identity = "theIdenity";
const keyHex = "707269766174654b6579";
final privateKey = Uint8List.fromList(key.codeUnits);
var exception = Exception();

// Dependencies
MockLibWrapper libWrapper = MockLibWrapper();

// Tested instance
LocalIdentityDataSource dataSource = LocalIdentityDataSource(libWrapper);

@GenerateMocks([LibWrapper])
void main() {
  group("Generate identifier", () {
    test(
        "Given a private key, when I call generateIdentifier, then I expect an identifier to be returned",
        () async {
      // Given
      when(libWrapper.generateIdentifier(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(identity));

      // When
      expect(await dataSource.createIdentity(privateKey: privateKey), identity);

      // Then
      expect(
          verify(libWrapper.generateIdentifier(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          key);
    });

    test(
        "Given a private key, when I call generateIdentifier and an error occured, then I expect an error is thrown",
        () async {
      // Given
      when(libWrapper.generateIdentifier(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(dataSource.createIdentity(privateKey: privateKey),
          throwsA(exception));

      // Then
      expect(
          verify(libWrapper.generateIdentifier(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          key);
    });
  });
}
