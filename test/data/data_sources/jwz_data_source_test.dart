import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/bjj/bjj.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/data/identity/jwz/jwz_header.dart';
import 'package:polygonid_flutter_sdk/data/identity/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/data/identity/jwz/jwz_token.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import 'jwz_data_source_test.mocks.dart';

// Data
class FakeBjj extends Fake implements BabyjubjubLib {
  @override
  String poseidonHash(String input) {
    return '3DFF';
  }
}

class FakeWallet extends Fake implements PrivadoIdWallet {
  @override
  Uint8List get privateKey => walletPrivateKey;

  @override
  dynamic get publicKey => [pubX, pubY];
}

const pubX = "thePubX";
const pubY = "thePubY";
const authClaim = "theAuthClaim";
const message = "theMessage";
const signature = "theSignature";
const challenge = "15871";
final privateKey = Uint8List(32);
final walletPrivateKey = Uint8List.fromList("thePrivateKey".codeUnits);
var mockWallet = FakeWallet();
const circuitId = "auth";
final datFile = Uint8List(32);
final zKeyfile = Uint8List(32);
const inputs = "theInputs";
final prepareResultAuth = [116, 104, 101, 73, 110, 112, 117, 116, 115];
final prepareResultOther = [];

final JWZHeader jwzHeader = JWZHeader(
    circuitId: "auth",
    crit: const ["circuitId"],
    typ: "application/iden3-zkp-json",
    alg: "groth16");
final JWZPayload jwzPayload = JWZPayload(payload: message);
final JWZProof jwzProof = JWZProof(
    proof: const JWZBaseProof(piA: [
      "0",
      "1",
      "2"
    ], piB: [
      ["33", "44"],
      ["55", "66", "77", "88"]
    ], piC: [
      "999, 101010, 111111"
    ], protocol: "theProtocol"),
    pubSignals: const ["12, 13, 14, 15, 16"]);

final JWZ jwz = JWZ(header: jwzHeader, payload: jwzPayload, proof: jwzProof);
final JWZToken token = JWZToken.withJWZ(jwz: jwz);

var exception = Exception();

// Dependencies
FakeBjj bjj = FakeBjj();
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockJWZIsolatesWrapper jwzIsolatesWrapper = MockJWZIsolatesWrapper();

// Tested instance
JWZDataSource dataSource =
    JWZDataSource(bjj, walletDataSource, jwzIsolatesWrapper);

@GenerateMocks([WalletDataSource, JWZIsolatesWrapper])
void main() {
  group("Get auth token", () {
    setUp(() {
      reset(walletDataSource);
      reset(jwzIsolatesWrapper);

      // Given
      when(walletDataSource.createWallet(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockWallet));
      when(walletDataSource.signMessage(
              privateKey: anyNamed('privateKey'), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.value(signature));
      when(jwzIsolatesWrapper.computeAuthInputs(any, any, any, any, any))
          .thenAnswer((realInvocation) => Future.value(inputs));
      when(jwzIsolatesWrapper.computeCalculateProof(any, any, any))
          .thenAnswer((realInvocation) => Future.value(jwzProof.toJson()));
    });

    test(
        "Given parameters with auth circuit, when I call getAuthToken, then I expect a token as a String to be returned",
        () async {
      // When
      expect(
          await dataSource.getAuthToken(
              privateKey: privateKey,
              authClaim: authClaim,
              message: message,
              circuitId: circuitId,
              datFile: datFile,
              zKeyFile: zKeyfile),
          token.encode());

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          privateKey);

      var captureSign = verify(walletDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(captureSign[0], privateKey);
      expect(captureSign[1], challenge);

      var captureAuthInputs = verify(jwzIsolatesWrapper.computeAuthInputs(
              captureAny, captureAny, captureAny, captureAny, captureAny))
          .captured;
      expect(captureAuthInputs[0], challenge);
      expect(captureAuthInputs[1], authClaim);
      expect(captureAuthInputs[2], pubX);
      expect(captureAuthInputs[3], pubY);
      expect(captureAuthInputs[4], signature);

      var captureProof = verify(jwzIsolatesWrapper.computeCalculateProof(
              captureAny, captureAny, captureAny))
          .captured;
      expect(captureProof[0], prepareResultAuth);
      expect(captureProof[1], datFile);
      expect(captureProof[2], zKeyfile);
    });

    test(
        "Given parameters with another circuit, when I call getAuthToken, then I expect a token as a String to be returned",
        () async {
      // When
      expect(
          await dataSource.getAuthToken(
              privateKey: privateKey,
              authClaim: authClaim,
              message: message,
              circuitId: "another",
              datFile: datFile,
              zKeyFile: zKeyfile),
          token.encode());

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          privateKey);

      var captureSign = verify(walletDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(captureSign[0], privateKey);
      expect(captureSign[1], challenge);

      verifyNever(jwzIsolatesWrapper.computeAuthInputs(
          captureAny, captureAny, captureAny, captureAny, captureAny));

      var captureProof = verify(jwzIsolatesWrapper.computeCalculateProof(
              captureAny, captureAny, captureAny))
          .captured;
      expect(captureProof[0], prepareResultOther);
      expect(captureProof[1], datFile);
      expect(captureProof[2], zKeyfile);
    });

    test(
        "Given parameters, when I call getAuthToken and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(walletDataSource.signMessage(
              privateKey: anyNamed('privateKey'), message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.getAuthToken(
              privateKey: privateKey,
              authClaim: authClaim,
              message: message,
              circuitId: circuitId,
              datFile: datFile,
              zKeyFile: zKeyfile),
          throwsA(exception));

      // Then
      expect(
          verify(walletDataSource.createWallet(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          privateKey);

      var captureSign = verify(walletDataSource.signMessage(
              privateKey: captureAnyNamed('privateKey'),
              message: captureAnyNamed('message')))
          .captured;
      expect(captureSign[0], privateKey);
      expect(captureSign[1], challenge);

      verifyNever(jwzIsolatesWrapper.computeAuthInputs(
          captureAny, captureAny, captureAny, captureAny, captureAny));

      verifyNever(jwzIsolatesWrapper.computeCalculateProof(
          captureAny, captureAny, captureAny));
    });
  });
}
