import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:polygonid_flutter_sdk/credential/libs/polygonidcore/pidcore_credential.dart';
import 'package:polygonid_flutter_sdk/iden3comm/libs/polygonidcore/pidcore_iden3comm.dart';
import 'package:polygonid_flutter_sdk/identity/libs/polygonidcore/pidcore_identity.dart';
import 'package:polygonid_flutter_sdk/proof/libs/polygonidcore/pidcore_proof.dart';

import 'polygonidcore_mocks.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test polygonId core lib identity functions', () {
    final pidCoreIdentity = PolygonIdCoreIdentity();

    testWidgets('PolygonIdCoreIdentity calculate genesis Id',
        (WidgetTester tester) async {
      expect(
          pidCoreIdentity.calculateGenesisId(
              PolygonIdCoreMocks.calculateGenesisIdInputJson),
          equals(PolygonIdCoreMocks.calculateGenesisIdOutputJson));
    });

    testWidgets('PolygonIdCoreIdentity calculate profile Id',
        (WidgetTester tester) async {
      expect(
          pidCoreIdentity.calculateProfileId(
              PolygonIdCoreMocks.calculateProfileIdInputJson),
          equals(PolygonIdCoreMocks.calculateProfileIdOutputJson));
    });

    testWidgets('PolygonIdCoreIdentity convert id to big int',
        (WidgetTester tester) async {
      expect(
          pidCoreIdentity
              .convertIdToBigInt(jsonEncode(PolygonIdCoreMocks.idToIntInput)),
          equals(jsonEncode(PolygonIdCoreMocks.idToIntOutput)));
    });
  });

  group('Test polygonId core lib credential functions', () {
    final pidCoreCredential = PolygonIdCoreCredential();

    testWidgets('PolygonIdCoreIdentity create claim',
        (WidgetTester tester) async {
      expect(
          pidCoreCredential
              .createClaim(PolygonIdCoreMocks.createClaimInputJson),
          equals(PolygonIdCoreMocks.createClaimOutput));
    });

    testWidgets('PolygonIdCoreIdentity create claim all fields 1',
        (WidgetTester tester) async {
      expect(
          pidCoreCredential
              .createClaim(PolygonIdCoreMocks.createClaimAllFields1InputJson),
          equals(PolygonIdCoreMocks.createClaimAllFields1Output));
    });

    testWidgets('PolygonIdCoreIdentity create claim all fields 2',
        (WidgetTester tester) async {
      expect(
          pidCoreCredential
              .createClaim(PolygonIdCoreMocks.createClaimAllFields2InputJson),
          equals(PolygonIdCoreMocks.createClaimAllFields2Output));
    });
  });

  group('Test polygonId core lib iden3comm functions', () {
    final pidCoreIden3comm = PolygonIdCoreIden3comm();

    testWidgets('PolygonIdCoreIdentity get Auth Inputs',
        (WidgetTester tester) async {
      expect(pidCoreIden3comm.getAuthInputs(PolygonIdCoreMocks.authV2InputJson),
          equals(PolygonIdCoreMocks.authV2OutputJson));
    });
  });

  group('Test polygonId core lib proof functions', () {
    final pidCoreProof = PolygonIdCoreProof();

    testWidgets('PolygonIdCoreIdentity get sig proofs inputs',
        (WidgetTester tester) async {
      var result = pidCoreProof.getSigProofInputs(
          PolygonIdCoreMocks.sigV2InputJson,
          PolygonIdCoreMocks.sigV2InputConfigJson);
      var resultJson = jsonDecode(result) as Map<String, dynamic>;
      resultJson['inputs'].remove('timestamp');
      expect(
          jsonEncode(resultJson), equals(PolygonIdCoreMocks.sigV2OutputJson));
    });

    testWidgets('PolygonIdCoreIdentity proof from smart contract',
        (WidgetTester tester) async {
      expect(
          pidCoreProof.proofFromSmartContract(
              PolygonIdCoreMocks.proofFromSmartContractInputJson),
          equals(PolygonIdCoreMocks.proofFromSmartContractOutputJson));
    });

    // TODO: fix localhost url from input
    /*testWidgets('PolygonIdCoreIdentity get sig on chain proofs inputs',
            (WidgetTester tester) async {
          expect(
              pidCoreProof.getSigOnchainProofInputs(
                  PolygonIdCoreMocks.sigV2OnChainInputJson),
              equals(PolygonIdCoreMocks.sigV2OnChainOutputJson));
        });

    // TODO: fix localhost url from input
    testWidgets('PolygonIdCoreIdentity get mtp proofs inputs',
            (WidgetTester tester) async {
          expect(
              pidCoreProof.getMTProofInputs(
                  PolygonIdCoreMocks.mtpV2InputJson),
              equals(PolygonIdCoreMocks.mtpV2OutputJson));
        });

    // TODO: fix localhost url from input
    testWidgets('PolygonIdCoreIdentity get sig proofs inputs',
            (WidgetTester tester) async {
          expect(
              pidCoreProof.getMTPOnchainProofInputs(
                  PolygonIdCoreMocks.mtpV2OnChainInputJson),
              equals(PolygonIdCoreMocks.mtpV2OnChainOutputJson));
        });*/
  });
}
