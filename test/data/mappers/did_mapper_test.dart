import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/did_mapper.dart';

// Data
const identifier = "theIdentifier";
const network = "theNetwork";
const env = "theEnv";
const mumbaiEnv = "mumbai";
const result = "did:iden3:$network:main:$identifier";
const mumbaiResult = "did:iden3:$network:$mumbaiEnv:$identifier";

// Tested instance
DidMapper mapper = DidMapper();

void main() {
  test(
      "Given a param with default network, when I call mapTo, then I expect a string to be returned",
      () {
    // Given
    final DidMapperParam param = DidMapperParam(identifier, network, env);

    // When
    expect(mapper.mapTo(param), result);
  });

  test(
      "Given a param with defined network, when I call mapTo, then I expect a string to be returned",
      () {
    // Given
    final DidMapperParam param = DidMapperParam(identifier, network, mumbaiEnv);

    // When
    expect(mapper.mapTo(param), mumbaiResult);
  });
}
