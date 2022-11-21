import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/data_sources/witness_data_source.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/mappers/circuit_type_mapper.dart';

import 'witness_data_source_test.mocks.dart';

MockWitnessIsolatesWrapper witnessIsolatesWrapper =
    MockWitnessIsolatesWrapper();

WitnessDataSource dataSource = WitnessDataSource(witnessIsolatesWrapper);

Uint8List wasm = Uint8List(32);
Uint8List json = Uint8List(32);
final param = WitnessParam(wasm: wasm, json: json);

Uint8List mockResponse = Uint8List(32);

@GenerateMocks([WitnessIsolatesWrapper])
main() {
  group(
    'witness data source',
    () {
      setUp(() {
        reset(witnessIsolatesWrapper);

        when(witnessIsolatesWrapper.computeWitnessAuth(any))
            .thenAnswer((realInvocation) => Future.value(mockResponse));

        when(witnessIsolatesWrapper.computeWitnessMtp(any))
            .thenAnswer((realInvocation) => Future.value(mockResponse));

        when(witnessIsolatesWrapper.computeWitnessSig(any))
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
              verify(witnessIsolatesWrapper.computeWitnessAuth(captureAny))
                  .captured
                  .first;
          expect(captured.wasm, wasm);
          expect(captured.json, json);
        },
      );

      test(
        'Given a WitnessParam obj (wasm, json), when called computeWitnessMtp, we expect a Uint8List to be returned',
        () async {
          expect(
              await dataSource.computeWitness(
                  param: param, type: CircuitType.mtp),
              mockResponse);

          WitnessParam captured =
              verify(witnessIsolatesWrapper.computeWitnessMtp(captureAny))
                  .captured
                  .first;
          expect(captured.wasm, wasm);
          expect(captured.json, json);
        },
      );

      test(
        'Given a WitnessParam obj (wasm, json), when called computeWitnessSig, we expect a Uint8List to be returned',
        () async {
          expect(
              await dataSource.computeWitness(
                  param: param, type: CircuitType.sig),
              mockResponse);

          WitnessParam captured =
              verify(witnessIsolatesWrapper.computeWitnessSig(captureAny))
                  .captured
                  .first;
          expect(captured.wasm, wasm);
          expect(captured.json, json);
        },
      );
    },
  );
}
