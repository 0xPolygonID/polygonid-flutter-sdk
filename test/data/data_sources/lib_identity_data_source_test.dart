import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/libs/iden3core/iden3core.dart';

import '../repositories/identity_repository_impl_test.mocks.dart';
import 'lib_identity_data_source_test.mocks.dart';

// Data
const pubX = "thePubX";
const pubY = "thePubY";
const identifier = "3DFF";
const authClaim = "theAuthClaim";
const resultIdentifier = "5ie";
const mockCoreIdentity = {"id": identifier, "authClaim": authClaim};
var exception = Exception();

// Dependencies
MockIden3CoreLib coreLib = MockIden3CoreLib();
MockStorageIdentityDataSource storageIdentityDataSource = MockStorageIdentityDataSource();
MockWalletDataSource walletDataSource = MockWalletDataSource();

// Tested instance
LibIdentityDataSource dataSource = LibIdentityDataSource(coreLib, walletDataSource, storageIdentityDataSource);

@GenerateMocks([Iden3CoreLib,WalletDataSource,StorageIdentityDataSource])
void main() {
  group("Get identifier", () {
    test(
        "Given a pubX and a pubY, when I call getIdentifier, then I expect an identifier to be returned",
        () async {
      // Given
      when(coreLib.generateIdentity(any, any))
          .thenAnswer((realInvocation) => mockCoreIdentity);

      // When
      expect(await dataSource.getIdentifier(pubX: pubX, pubY: pubY),
          resultIdentifier);

      // Then
      var captured =
          verify(coreLib.generateIdentity(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });

    test(
        "Given a pubX and a pubY, when I call getIdentifier and an error occured, then I expect an error is thrown",
        () async {
      // Given
      when(coreLib.generateIdentity(any, any)).thenThrow(exception);

      // When
      await expectLater(
          dataSource.getIdentifier(pubX: pubX, pubY: pubY), throwsA(exception));

      // Then
      var captured =
          verify(coreLib.generateIdentity(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });
  });

  group("Get auth claim", () {
    test(
        "Given a pubX and a pubY, when I call getAuthclaim, then I expect an authclaim to be returned",
        () async {
      // Given
      when(coreLib.getAuthClaim(any, any))
          .thenAnswer((realInvocation) => authClaim);

      // When
      expect(await dataSource.getAuthClaim(pubX: pubX, pubY: pubY), authClaim);

      // Then
      var captured =
          verify(coreLib.getAuthClaim(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });

    test(
        "Given a pubX and a pubY, when I call getAuthclaim and an error occured, then I expect an error is thrown",
        () async {
      // Given
      when(coreLib.getAuthClaim(any, any)).thenThrow(exception);

      // When
      await expectLater(
          dataSource.getAuthClaim(pubX: pubX, pubY: pubY), throwsA(exception));

      // Then
      var captured =
          verify(coreLib.getAuthClaim(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });
  });
}
