import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';

import '../../../common/iden3comm_mocks.dart';
import 'proof_request_filters_mapper_test.mocks.dart';

String mockQueryRequestLT = '''
{
  "birthday": {
    "\$lt": 20000101
  }
}
''';

String mockQueryRequestGT = '''
{
  "birthday": {
    "\$gt": 20000101
  }
}
''';

String mockQueryRequestEQ = '''
{
  "birthday": {
    "\$eq": 20000101
  }
}
''';

String mockQueryRequestIN = '''
{
  "birthday": {
    "\$in": [20000101,20000103]
  }
}
''';

String mockQueryRequestNIN = '''
{
  "birthday": {
    "\$nin": [20000101,20000103]
  }
}
''';

String mockQueryRequestNINCountry = '''
{
  "countryCode": {
    "\$nin": [
      36,
      120,
      248,
      804
    ]
  }
}
''';

String mockQueryRequestNotSupportedOperator = '''
{
  "countryCode": {
    "\$noop": [
      36,
      120,
      248,
      804
    ]
  }
}
''';

ProofScopeRequest proofScopeRequest = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
    challenge: 74657374,
    type: "KYCAgeCredential",
    credentialSubject: jsonDecode(mockQueryRequestLT),
  ),
);
ProofQueryParamEntity proofQueryParamEntity =
    ProofQueryParamEntity("theField", [0, 1, 2], 4);
ProofRequestEntity mockProofRequestEntityLT = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestLT),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityGT = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestGT),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityEQ = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestEQ),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityIN = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestIN),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNIN = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestNIN),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNINCountry = ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCCountryOfResidenceCredential",
      credentialSubject: jsonDecode(mockQueryRequestNINCountry),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNotSupportedOperator =
    ProofRequestEntity(
  ProofScopeRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ProofScopeQueryRequest(
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      challenge: 74657374,
      type: "KYCCountryOfResidenceCredential",
      credentialSubject: jsonDecode(mockQueryRequestNotSupportedOperator),
    ),
  ),
  Iden3commMocks.mockContext,
  proofQueryParamEntity,
);

MockStacktraceManager mockStacktraceManager = MockStacktraceManager();

// Tested instance
ProofRequestFiltersMapper proofRequestFiltersMapper =
    ProofRequestFiltersMapper(mockStacktraceManager);

@GenerateMocks([StacktraceManager])
main() {
  group("ProofRequestFiltersMapper", () {
    test("From ProofRequestEntity to List<FilterEntity> LT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityLT);
      expect(filters.length, 4);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> GT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityGT);
      expect(filters.length, 4);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> EQ", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityEQ);
      expect(filters.length, 4);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> IN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityIN);
      expect(filters.length, 4);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> NIN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNIN);
      expect(filters.length, 5);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test(
        "From ProofRequestEntity to List<FilterEntity> NIN Country of residence",
        () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNINCountry);
      expect(filters.length, 7);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCCountryOfResidenceCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> Not supported operator",
        () {
      List<FilterEntity> filters = proofRequestFiltersMapper
          .mapFrom(mockProofRequestEntityNotSupportedOperator);
      expect(filters.length, 3);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCCountryOfResidenceCredential");
    });
  });
}
