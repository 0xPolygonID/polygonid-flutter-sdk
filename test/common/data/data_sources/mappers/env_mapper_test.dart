import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/env_mapper.dart';

import '../../../common_mocks.dart';

// Tested instance
EnvMapper mapper = EnvMapper();

void main() {
  test(
      "Given a EnvEntity, when I call mapTo, I expect an EnvDTO to be returned",
      () {
    // When
    expect(mapper.mapTo(CommonMocks.env), CommonMocks.envJson);
  });

  test(
      "Given a EnvDTO, when I call mapFrom, I expect an EnvEntity to be returned",
      () {
    // When
    expect(mapper.mapFrom(CommonMocks.envJson), CommonMocks.env);
  });
}
