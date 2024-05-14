import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/jwz_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'jwz_mapper_test.mocks.dart';

// Data
JWZEntity jwzNoHeader =
    JWZEntity(payload: JWZPayload(payload: CommonMocks.message));
JWZEntity jwzNoPayload =
    JWZEntity(header: Iden3commMocks.jwzHeader, payload: null);

MockStacktraceManager stacktraceManager = MockStacktraceManager();
// Tested instance
JWZMapper mapper = JWZMapper(stacktraceManager);

@GenerateMocks([StacktraceManager])
void main() {
  test(
      "Given a JWZEntity, when I call mapFrom, then I expect a String to be returned",
      () {
    // When
    expect(mapper.mapFrom(Iden3commMocks.jwz), Iden3commMocks.encodedJWZ);
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
