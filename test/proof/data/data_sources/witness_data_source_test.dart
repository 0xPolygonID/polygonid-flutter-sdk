import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart';

import 'witness_data_source_test.mocks.dart';

MockWitnessIsolatesWrapper witnessIsolatesWrapper =
    MockWitnessIsolatesWrapper();

WitnessDataSource dataSource = WitnessDataSource(witnessIsolatesWrapper);

Uint8List wasm = Uint8List(32);
String json = "";
final param = WitnessParam(circuitGraphFile: wasm, inputsJson: "");

Uint8List mockResponse = Uint8List(32);

@GenerateMocks([WitnessIsolatesWrapper])
main() {
  group(
    'witness data source',
    () {
      setUp(() {
        reset(witnessIsolatesWrapper);

        when(witnessIsolatesWrapper.computeWitness(any))
            .thenAnswer((realInvocation) => Future.value(mockResponse));
      });

      test(
        'Given a WitnessParam obj (wasm, json), when called computeWitnessAuth, we expect a Uint8List to be returned',
        () async {
          expect(
              await dataSource.computeWitness(
                  param: param, type: CircuitType.auth),
              mockResponse);

          WitnessParam captured =
              verify(witnessIsolatesWrapper.computeWitness(captureAny))
                  .captured
                  .first;
          expect(captured.circuitGraphFile, wasm);
          expect(captured.inputsJson, json);
        },
      );
    },
  );
}
