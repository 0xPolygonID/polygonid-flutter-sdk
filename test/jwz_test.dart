import 'package:flutter_test/flutter_test.dart';
import 'package:privadoid_sdk/model/jwz/jwz.dart';
import 'package:privadoid_sdk/model/jwz/jwz_header.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';

import 'jwz_mocks.dart';

void main() {
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
}
