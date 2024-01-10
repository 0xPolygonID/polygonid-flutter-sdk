import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_param.dart';
import 'package:polygonid_flutter_sdk/common/utils/format_utils.dart';

import '../../../common/credential_mocks.dart';

void main() {
  group('AtomicQueryInputsParam', () {
    test('toJson includes all non-null fields', () {
      final param = AtomicQueryInputsParam(
        type: AtomicQueryInputsType.mtp,
        id: 'testId',
        profileNonce: BigInt.from(123),
        claimSubjectProfileNonce: BigInt.from(456),
        credential:
            ClaimInfoDTO.fromJson(jsonDecode(CredentialMocks.claimInfoJson)),
        request: {'key': 'value'},
      );

      final json = param.toJson();

      expect(json['id'], 'testId');
      expect(json['profileNonce'], '123');
      expect(json['claimSubjectProfileNonce'], '456');
      expect(json['request'], {'key': 'value'});
    });

    test('toJson excludes null fields', () {
      final param = AtomicQueryInputsParam(
        type: AtomicQueryInputsType.mtp,
        id: 'testId',
        profileNonce: BigInt.from(123),
        claimSubjectProfileNonce: BigInt.from(456),
        credential:
            ClaimInfoDTO.fromJson(jsonDecode(CredentialMocks.claimInfoJson)),
        request: {'key': 'value'},
      );

      final json = param.toJson();

      expect(json.containsKey('authClaim'), false);
      expect(json.containsKey('incProof'), false);
      expect(json.containsKey('nonRevProof'), false);
      expect(json.containsKey('gistProof'), false);
      expect(json.containsKey('treeState'), false);
      expect(json.containsKey('challenge'), false);
      expect(json.containsKey('signature'), false);
      expect(json.containsKey('verifierId'), false);
      expect(json.containsKey('linkNonce'), false);
      expect(json.containsKey('params'), false);
    });

    test('toJson converts transactionData to camelCase', () {
      final param = AtomicQueryInputsParam(
        type: AtomicQueryInputsType.mtp,
        id: 'testId',
        profileNonce: BigInt.from(123),
        claimSubjectProfileNonce: BigInt.from(456),
        credential:
            ClaimInfoDTO.fromJson(jsonDecode(CredentialMocks.claimInfoJson)),
        request: {'key': 'value'},
        transactionData: {'snake_case_key': 'value'},
      );

      final json = param.toJson();

      expect(json['request']['transactionData'], {'snakeCaseKey': 'value'});
    });

    test('toJson excludes verifierId if it is empty', () {
      final param = AtomicQueryInputsParam(
        type: AtomicQueryInputsType.mtp,
        id: 'testId',
        profileNonce: BigInt.from(123),
        claimSubjectProfileNonce: BigInt.from(456),
        credential:
            ClaimInfoDTO.fromJson(jsonDecode(CredentialMocks.claimInfoJson)),
        request: {'key': 'value'},
        verifierId: '',
      );

      final json = param.toJson();

      expect(json.containsKey('verifierId'), false);
    });
  });
}
