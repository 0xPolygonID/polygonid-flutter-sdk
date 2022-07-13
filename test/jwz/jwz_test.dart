import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/jwz/jwz_token.dart';
import 'package:polygonid_flutter_sdk/model/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/model/jwz/jwz_header.dart';
import 'package:polygonid_flutter_sdk/model/jwz/jwz_proof.dart';

import 'jwz_mocks.dart';
import 'jwz_test.mocks.dart';

// Data
var alg = 'groth16';
var circuitID = 'auth';
var prover = MockJWZProver();
var preparer = MockJWZInputPreparer();
var payload = 'message';
var compacted =
    'eyJhbGciOiJncm90aDE2IiwiY2lyY3VpdElkIjoiYXV0aCIsImNyaXQiOlsiY2lyY3VpdElkIl0sInR5cCI6IkpXWiJ9.eyJpZCI6Ijg1MDdiMWY2LTZhYTgtNDdjYi1hZWNhLWM3MWY2ZTY5MDMzYyIsInRoaWQiOiI4NTA3YjFmNi02YWE4LTQ3Y2ItYWVjYS1jNzFmNmU2OTAzM2MiLCJmcm9tIjoiMTEyNUdKcWd3NllFc0tGd2o2M0dZODdNTXhQTDlrd0RLeFBVaXdNTE5aIiwidHlwIjoiYXBwbGljYXRpb24vaWRlbjNjb21tLXBsYWluLWpzb24iLCJ0eXBlIjoiaHR0cHM6Ly9pZGVuMy1jb21tdW5pY2F0aW9uLmlvL2F1dGhvcml6YXRpb24vMS4wL3JlcXVlc3QiLCJib2R5Ijp7InJlYXNvbiI6InRlc3QgZmxvdyIsIm1lc3NhZ2UiOiIiLCJjYWxsYmFja1VybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4MC9hcGkvY2FsbGJhY2s_c2Vzc2lvbklkPTEiLCJzY29wZSI6W119fQ.eyJwcm9vZiI6eyJwaV9hIjpbIjIwNTgyODQwNTg5NDMzNDI3NTYwMDEzNjA1MzMxMzMzOTQ1MTUwMDc5ODE0NzgyNTU1OTczNDU1Nzg1NTg4MTc3OTEzODI3MzkwODI2IiwiMTg4NTkyMDY2MzY5MTcyNDI4NjI4NDI4MjU0MjA0OTU5NjUzNDk0MjkxODg4Mjc5NjU2MjE5NDYwMjcyMTYxNzAwMDg4MjI1ODg4MDUiLCIxIl0sInBpX2IiOltbIjgzNjU3Njc2ODEzNTI1MjY2MjUzNDAwOTkxMDI1NDg4NjE4NDQ0OTY0OTczNDA1NTQ3MDc1Mzg4NjAwMDA2ODI2OTY1ODg2Mzk5NjMiLCIyMTQ0NzU5ODU0MDk0NDk3NDAyODMxMjEyMTM3MTAzMzgwMjQ4NTY3Nzk3OTMzODIyNjkxOTk1Njc3NTAzMDEzMjk1MDY0MDc0OTkzMCJdLFsiNDc0NjQ5OTIzODcxNTg4MjExMjQzMTk0MTA3ODIwMTk3NjA5NzE0NTc3MTg5MTY3ODY4MTA5NzI2ODcyOTQxOTkwNTQ2MjAxMDQyNSIsIjIxNzEyMzk5MzQ5OTkyNjY3ODUwNTU4MTQxNjk4MjEwODg3NTQ0Nzg5ODExMjg1ODM0MTkwNjM4OTY3MjU1MDYzMDE1MjU1MjA0MzM5Il0sWyIxIiwiMCJdXSwicGlfYyI6WyIxODY0MzI1OTM4OTM0OTAwNDg2MDc0NDM2OTM2NzUzMTIzMzMyNDUzNDYxMDA1NDMwNDQ1MTY2MzA5MjcwMDU3NTAxNDM3MTUyNDI4NCIsIjM1NTU0MDQ0NDUyMTQ1MjY3MTM2MzI3NzQwMzc2Mjk3NTg1Mzg0MTUwMDEwOTUzMjU1Nzk0MTU1MDA2MjMzOTkzMjc2NTc4NDExNzYiLCIxIl0sInByb3RvY29sIjoiZ3JvdGgxNiJ9LCJwdWJfc2lnbmFscyI6WyI2NTY4MTg3MzA2MjkzMDczMTc1MTE0MjY3NTA0NzExNjgyODEyOTA0NTk4MzY4NDkwOTA0NTczNzQyNDk1MTI2MDYzMjk0NDgxOTM4IiwiMTg2NTYxNDc1NDY2NjY5NDQ0ODQ0NTM4OTkyNDE5MTY0Njk1NDQwOTAyNTg4MTAxOTI4MDM5NDk1MjI3OTQ0OTA0OTMyNzEwMDUzMTMiLCIzNzk5NDkxNTAxMzAyMTQ3MjM0MjA1ODk2MTA5MTExNjE4OTU0OTU2NDc3ODkwMDY2NDk3ODUyNjQ3MzgxNDEyOTkxMzU0MTQyNzIiXX0';
var circom = JWZMocks.fakeCircom;

@GenerateMocks([JWZProver, JWZInputPreparer])
void main() {
  group("Elements testing", () {
    // Encoding
    test("Test JWZHeader encoding", () {
      expect(JWZMocks.jwzHeader.encode(), JWZMocks.headerBase64);
    });

    test("Test JWZProof encoding", () {
      expect(JWZMocks.jwzProof.encode(), JWZMocks.proofBase64);
    });

    test("Test JWZ encoding", () {
      expect(JWZMocks.jwz.encode(), JWZMocks.jwzBase64);
    });

    // Decoding
    test("Test JWZHeader decoding", () {
      expect(JWZHeader.fromBase64(JWZMocks.headerBase64), JWZMocks.jwzHeader);
    });

    test("Test JWZProof decoding", () {
      expect(JWZProof.fromBase64(JWZMocks.proofBase64), JWZMocks.jwzProof);
    });

    test("Test JWZ decoding", () {
      expect(JWZ.fromBase64(JWZMocks.jwzBase64), JWZMocks.jwz);
    });
  });

  // JWZToken
  group("JWZToken", () {
    setUp(() async {
      when(prover.alg).thenReturn(alg);
      when(prover.circuitID).thenReturn(circuitID);
    });

    test("JWZProver prove", () async {
      when(preparer.prepare(any, any))
          .thenAnswer((realInvocation) => Future.value(Uint8List(0)));
      when(prover.prove(any, any, any))
          .thenAnswer((realInvocation) => Future.value(JWZMocks.jwzProof));
      JWZToken token = JWZToken.withJWZ(
          jwz: JWZMocks.jwz,
          prover: prover,
          preparer: preparer,
          circom: circom);

      expect(await token.prove(Uint8List(0), Uint8List(0)), JWZMocks.jwzBase64);
    });
  });

  test("JWZProver verify", () async {
    when(prover.verify(any, any, any))
        .thenAnswer((realInvocation) => Future.value(true));
    JWZToken token = JWZToken.fromBase64(
        data: compacted, prover: prover, preparer: preparer, circom: circom);
    var verificationKey =
        await File('test/jwz/verification_key.json').readAsBytes();

    expect(await token.verify(verificationKey), true);
  });
}
