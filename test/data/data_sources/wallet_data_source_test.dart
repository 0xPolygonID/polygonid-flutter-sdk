import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';

import 'wallet_data_source_test.mocks.dart';

// Data
class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => walletPrivateKey;

  @override
  List<String> get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const message = "theMessage";
const signature = "theSignature";
final walletPrivateKey = Uint8List.fromList("thePrivateKey".codeUnits);
var mockWallet = FakeWallet();
var exception = Exception();

// Dependencies
MockWalletLibWrapper walletLibWrapper = MockWalletLibWrapper();

// Tested instance
WalletDataSource dataSource = WalletDataSource(walletLibWrapper);

@GenerateMocks([WalletLibWrapper])
void main() {
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
      var capturedSign = verify(walletLibWrapper.signMessage(
              privateKey: captureAnyNamed("privateKey"),
              message: captureAnyNamed('message')))
          .captured;
      expect(capturedSign[0], walletPrivateKey);
      expect(capturedSign[1], message);
    });
  });
}
