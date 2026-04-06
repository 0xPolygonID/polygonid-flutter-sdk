import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
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

ZeroKnowledgeProofRequest proofScopeRequest = ZeroKnowledgeProofRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ZeroKnowledgeProofQuery(
    allowedIssuers: ["*"],
    context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
    type: "KYCAgeCredential",
    credentialSubject: jsonDecode(mockQueryRequestLT),
  ),
);
ProofRequestEntity mockProofRequestEntityLT = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestLT),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityGT = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestGT),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityEQ = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestEQ),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityIN = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestIN),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityNIN = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCAgeCredential",
      credentialSubject: jsonDecode(mockQueryRequestNIN),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityNINCountry = ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCCountryOfResidenceCredential",
      credentialSubject: jsonDecode(mockQueryRequestNINCountry),
    ),
  ),
  Iden3commMocks.mockContext,
);

ProofRequestEntity mockProofRequestEntityNotSupportedOperator =
    ProofRequestEntity(
  ZeroKnowledgeProofRequest(
    id: 1,
    circuitId: "credentialAtomicQuerySig",
    query: ZeroKnowledgeProofQuery(
      allowedIssuers: ["*"],
      context: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
      type: "KYCCountryOfResidenceCredential",
      credentialSubject: jsonDecode(mockQueryRequestNotSupportedOperator),
    ),
  ),
  Iden3commMocks.mockContext,
);

MockStacktraceManager mockStacktraceManager = MockStacktraceManager();

// Tested instance
ProofRequestFiltersMapper proofRequestFiltersMapper =
    ProofRequestFiltersMapper(mockStacktraceManager);

/// Asserts that [filters] contains a non-equal filter on 'state' with value 'expired'.
void _expectNonExpiredFilter(List<FilterEntity> filters) {
  final expiredFilter = filters.where(
    (f) =>
        f.operator == FilterOperator.nonEqual &&
        f.name == 'state' &&
        f.value == CredentialState.expired.name,
  );
  expect(
    expiredFilter.length,
    1,
    reason: 'Expected exactly one state != expired filter',
  );
}

@GenerateMocks([StacktraceManager])
main() {
  group("ProofRequestFiltersMapper", () {
    test("From ProofRequestEntity to List<FilterEntity> LT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityLT);
      // type + context + nonRevoked + nonExpired + birthday<
      expect(filters.length, 5);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
      _expectNonExpiredFilter(filters);
    });

    test("From ProofRequestEntity to List<FilterEntity> GT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityGT);
      // type + context + nonRevoked + nonExpired + birthday>
      expect(filters.length, 5);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
      _expectNonExpiredFilter(filters);
    });

    test("From ProofRequestEntity to List<FilterEntity> EQ", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityEQ);
      // type + context + nonRevoked + nonExpired + birthday==
      expect(filters.length, 5);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
      _expectNonExpiredFilter(filters);
    });

    test("From ProofRequestEntity to List<FilterEntity> IN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityIN);
      // type + context + nonRevoked + nonExpired + birthday in [...]
      expect(filters.length, 5);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
      _expectNonExpiredFilter(filters);
    });

    test("From ProofRequestEntity to List<FilterEntity> NIN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNIN);
      // type + context + nonRevoked + nonExpired + birthday!=v1 + birthday!=v2
      expect(filters.length, 6);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCAgeCredential");
      _expectNonExpiredFilter(filters);
    });

    test(
        "From ProofRequestEntity to List<FilterEntity> NIN Country of residence",
        () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNINCountry);
      // type + context + nonRevoked + nonExpired + countryCode!=36,120,248,804
      expect(filters.length, 8);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCCountryOfResidenceCredential");
      _expectNonExpiredFilter(filters);
    });

    test("From ProofRequestEntity to List<FilterEntity> Not supported operator",
        () {
      List<FilterEntity> filters = proofRequestFiltersMapper
          .mapFrom(mockProofRequestEntityNotSupportedOperator);
      // type + context + nonRevoked + nonExpired (noop operator adds nothing)
      expect(filters.length, 4);
      expect(filters[0].name, "credential.credentialSubject.type");
      expect(filters[0].value, "KYCCountryOfResidenceCredential");
      _expectNonExpiredFilter(filters);
    });
  });
}
