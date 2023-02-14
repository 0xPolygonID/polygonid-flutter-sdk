import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart';

import '../../common/common_mocks.dart';
import '../../common/proof_mocks.dart';
import 'prover_lib_data_source_test.mocks.dart';

MockProverLibWrapper proverLibWrapper = MockProverLibWrapper();

ProverLibDataSource dataSource = ProverLibDataSource(proverLibWrapper);

Map<String, dynamic> mockProverRes = {
  'circuitId': 'auth',
  'proof': 'proof',
  'pub_signals': 'pub_signals',
};

@GenerateMocks([ProverLibWrapper])
main() {
  group('Prover', () {
    setUp(() {
      reset(proverLibWrapper);

      when(proverLibWrapper.prover(any, any, any))
          .thenAnswer((realInvocation) => Future.value(mockProverRes));
    });

    test(
      'Given a zkeyBytes and WtnsBytes, when call prover, we expect a Map to be returned',
      () async {
        expect(
            await dataSource.prove(
                CommonMocks.circuitId, ProofMocks.zKeyFile, ProofMocks.datFile),
            mockProverRes);

        var captured =
            verify(proverLibWrapper.prover(captureAny, captureAny, captureAny))
                .captured;
        expect(captured[0], CommonMocks.circuitId);
        expect(captured[1], ProofMocks.zKeyFile);
        expect(captured[2], ProofMocks.datFile);
      },
    );
  });
}
