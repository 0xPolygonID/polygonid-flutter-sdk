import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_param_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';

String mockQueryRequestLT = '''
{
  "allowedIssuers": [
    "*"
  ],
  "challenge": 74657374,
  "schema": {
    "type": "KYCAgeCredential",
    "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
  },
  "req": {
    "birthday": {
      "\$lt": 20000101
    }
  }
}
''';

String mockQueryRequestGT = '''
{
  "allowedIssuers": [
    "*"
  ],
  "challenge": 74657374,
  "schema": {
    "type": "KYCAgeCredential",
    "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
  },
  "req": {
    "birthday": {
      "\$gt": 20000101
    }
  }
}
''';

String mockQueryRequestEQ = '''
{
  "allowedIssuers": [
    "*"
  ],
  "challenge": 74657374,
  "schema": {
    "type": "KYCAgeCredential",
    "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
  },
  "req": {
    "birthday": {
      "\$eq": 20000101
    }
  }
}
''';

String mockQueryRequestIN = '''
{
  "allowedIssuers": [
    "issuer1"
  ],
  "challenge": 74657374,
  "schema": {
    "type": "KYCAgeCredential",
    "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
  },
  "req": {
    "birthday": {
      "\$in": [20000101,20000103]
    }
  }
}
''';

String mockQueryRequestNIN = '''
{
  "allowedIssuers": [
    "*"
  ],
  "challenge": 74657374,
  "schema": {
    "type": "KYCAgeCredential",
    "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
  },
  "req": {
    "birthday": {
      "\$nin": [20000101,20000103]
    }
  }
}
''';

String mockQueryRequestNINCountry = '''
{
  "allowedIssuers": [
    "*"
  ],
  "schema": {
    "type": "CountryOfResidenceCredential",
    "url": "https://schema.polygonid.com/jsonld/kyc.json-ld"
  },
  "req": {
    "countryCode": {
      "\$nin": [
        36,
        120,
        248,
        804
      ]
    }
  }
}
''';

String mockQueryRequestNotSupportedOperator = '''
{
  "allowedIssuers": [
    "*"
  ],
  "schema": {
    "type": "CountryOfResidenceCredential",
    "url": "https://schema.polygonid.com/jsonld/kyc.json-ld"
  },
  "req": {
    "countryCode": {
      "\$noop": [
        36,
        120,
        248,
        804
      ]
    }
  }
}
''';
ProofScopeRequest proofScopeRequest = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    audience: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
    challenge: 74657374,
    query: ProofScopeRulesQueryRequest.fromJson(jsonDecode(mockQueryRequestLT)),
  ),
);
ProofQueryParamMapper proofQueryParamMapper = ProofQueryParamMapper();
ProofQueryParamEntity proofQueryParamEntity =
    proofQueryParamMapper.mapFrom(proofScopeRequest);
ProofRequestEntity mockProofRequestEntityLT = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestLT),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityGT = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestGT),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityEQ = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestEQ),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityIN = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestIN),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNIN = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestNIN),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNINCountry = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestNINCountry),
  },
  proofQueryParamEntity,
);

ProofRequestEntity mockProofRequestEntityNotSupportedOperator =
    ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequestNotSupportedOperator),
  },
  proofQueryParamEntity,
);

// Tested instance
ProofRequestFiltersMapper proofRequestFiltersMapper =
    ProofRequestFiltersMapper(ProofQueryMapper());

main() {
  group("ProofRequestFiltersMapper", () {
    test("From ProofRequestEntity to List<FilterEntity> LT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityLT);
      expect(filters.length, 2);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> GT operator", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityGT);
      expect(filters.length, 2);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> EQ", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityEQ);
      expect(filters.length, 2);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> IN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityIN);
      expect(filters.length, 3);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> NIN", () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNIN);
      expect(filters.length, 2);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "KYCAgeCredential");
    });

    test(
        "From ProofRequestEntity to List<FilterEntity> NIN Country of residence",
        () {
      List<FilterEntity> filters =
          proofRequestFiltersMapper.mapFrom(mockProofRequestEntityNINCountry);
      expect(filters.length, 2);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "CountryOfResidenceCredential");
    });

    test("From ProofRequestEntity to List<FilterEntity> Not supported operator",
        () {
      List<FilterEntity> filters = proofRequestFiltersMapper
          .mapFrom(mockProofRequestEntityNotSupportedOperator);
      expect(filters.length, 1);
      expect(filters[0].name, "credential.credentialSchema.type");
      expect(filters[0].value, "CountryOfResidenceCredential");
    });
  });
}
