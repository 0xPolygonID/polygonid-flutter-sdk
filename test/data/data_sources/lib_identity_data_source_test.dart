import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/libs/iden3corelib.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import 'lib_identity_data_source_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => walletPrivateKey;

  @override
  dynamic get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const message = "theMessage";
const signature = "theSignature";
final walletPrivateKey = Uint8List.fromList("thePrivateKey".codeUnits);
var mockWallet = FakeWallet();
const mockCoreIdentity = {"id": identifier, "authClaim": authClaim};
const keyHex = "707269766174654b6579";
var exception = Exception();

// Dependencies
MockIden3CoreLib coreLib = MockIden3CoreLib();
MockWalletLibWrapper walletLibWrapper = MockWalletLibWrapper();

// Tested instance
LibIdentityDataSource dataSource =
    LibIdentityDataSource(coreLib, walletLibWrapper);

@GenerateMocks([Iden3CoreLib, WalletLibWrapper])
void main() {
  group("Get identifier", () {
    test(
        "Given a pubX and a pubY, when I call getIdentifier, then I expect an identifier to be returned",
        () async {
      // Given
      when(coreLib.generateIdentity(any, any))
          .thenAnswer((realInvocation) => mockCoreIdentity);

      // When
      expect(
          await dataSource.getIdentifier(pubX: pubX, pubY: pubY), identifier);

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
      expect(await dataSource.getAuthclaim(pubX: pubX, pubY: pubY), authClaim);

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
          dataSource.getAuthclaim(pubX: pubX, pubY: pubY), throwsA(exception));

      // Then
      var captured =
          verify(coreLib.getAuthClaim(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });
  });

  group("Create wallet", () {
    test(
        "Given a private key, when I call createWallet, then I expect an PrivadoIdWallet to be returned",
        () async {
      // Given
      when(walletLibWrapper.createWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));

      // When
      expect(await dataSource.createWallet(privateKey: walletPrivateKey),
          mockWallet);

      // Then
      expect(
          verify(walletLibWrapper.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          walletPrivateKey);
    });

    test(
        "Given a private key, when I call createWallet and an error occured, then I expect an exception to be thrown",
        () async {
      // Given
      when(walletLibWrapper.createWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(dataSource.createWallet(privateKey: walletPrivateKey),
          throwsA(exception));

      // Then
      expect(
          verify(walletLibWrapper.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          walletPrivateKey);
    });
  });

  group("Sign message", () {
    setUp(() {
      when(walletLibWrapper.createWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));
    });

    test(
        "Given a private key and a message, when I call signMessage, then I expect a signature as a String to be returned",
        () async {
      // Given
      when(walletLibWrapper.signMessage(
              privateKey: anyNamed("privateKey"), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.value(signature));

      // When
      expect(
          await dataSource.signMessage(
              privateKey: walletPrivateKey, message: message),
          signature);

      // Then
      expect(
          verify(walletLibWrapper.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          walletPrivateKey);

      var capturedSign = verify(walletLibWrapper.signMessage(
              privateKey: captureAnyNamed("privateKey"),
              message: captureAnyNamed('message')))
          .captured;
      expect(capturedSign[0], walletPrivateKey);
      expect(capturedSign[1], message);
    });

    test(
        "Given a private key and a message, when I call signMessage and an error occured, then I expect an exception to be thrown",
        () async {
      // Given
      when(walletLibWrapper.signMessage(
              privateKey: anyNamed("privateKey"), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.signMessage(
              privateKey: walletPrivateKey, message: message),
          throwsA(exception));

      // Then
      expect(
          verify(walletLibWrapper.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          walletPrivateKey);

      var capturedSign = verify(walletLibWrapper.signMessage(
              privateKey: captureAnyNamed("privateKey"),
              message: captureAnyNamed('message')))
          .captured;
      expect(capturedSign[0], walletPrivateKey);
      expect(capturedSign[1], message);
    });
  });
}
