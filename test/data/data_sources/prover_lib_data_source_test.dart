import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart';

import 'prover_lib_data_source_test.mocks.dart';

MockProverLibWrapper proverLibWrapper = MockProverLibWrapper();

ProverLibDataSource dataSource = ProverLibDataSource(proverLibWrapper);

final zKey = Uint8List(32);
final wtns = Uint8List(32);
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

      when(proverLibWrapper.prover(any, any))
          .thenAnswer((realInvocation) => Future.value(mockProverRes));
    });

    test(
      'Given a zkeyBytes and WtnsBytes, when call prover, we expect a Map to be returned',
      () async {
        expect(await dataSource.prove(zKey, wtns), mockProverRes);

        var captured =
            verify(proverLibWrapper.prover(captureAny, captureAny)).captured;
        expect(captured[0], zKey);
        expect(captured[1], wtns);
      },
    );
  });
}
