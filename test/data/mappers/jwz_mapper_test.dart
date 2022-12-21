import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/mappers/jwz_mapper.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/jwz/jwz_exceptions.dart';

import '../../common/common_mocks.dart';
import '../../common/proof_mocks.dart';

// Data
JWZEntity jwzNoHeader =
    JWZEntity(payload: JWZPayload(payload: CommonMocks.message));
JWZEntity jwzNoPayload = JWZEntity(header: ProofMocks.jwzHeader, payload: null);

// Tested instance
JWZMapper mapper = JWZMapper();

void main() {
  test(
      "Given a JWZEntity, when I call mapFrom, then I expect a String to be returned",
      () {
    // When
    expect(mapper.mapFrom(ProofMocks.jwz), ProofMocks.encodedJWZ);
  });

  test(
      "Given a JWZEntity with no JWZHeader, when I call mapFrom, then I expect a NullJWZHeaderException to be thrown",
      () {
    // When
    expect(() => mapper.mapFrom(jwzNoHeader),
        throwsA(isA<NullJWZHeaderException>()));
  });

  test(
      "Given a JWZEntity with no JWZPayload, when I call mapFrom, then I expect a NullJWZHeaderException to be thrown",
      () {
    // When
    expect(() => mapper.mapFrom(jwzNoPayload),
        throwsA(isA<NullJWZPayloadException>()));
  });
}
