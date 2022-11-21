import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_schema_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_param_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';

ProofScopeRulesQueryRequest mockProofScopeRulesQueryRequest =
    ProofScopeRulesQueryRequest(
  challenge: 74657374,
  schema: ProofScopeRulesQuerySchemaRequest(
    type: "KYCAgeCredential",
    url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
  ),
  allowedIssuers: ["*"],
  req: {
    "birthday": {
      "\$lt": 20000101,
    },
  },
);

String mockQueryRequest = '''
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

ProofScopeRequest proofScopeRequest = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    audience: "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
    challenge: 74657374,
    query: ProofScopeRulesQueryRequest.fromJson(jsonDecode(mockQueryRequest)),
  ),
);

ProofQueryParamMapper proofQueryParamMapper = ProofQueryParamMapper();
ProofQueryParamEntity proofQueryParamEntity =
    proofQueryParamMapper.mapFrom(proofScopeRequest);
ProofRequestEntity mockProofRequestEntity = ProofRequestEntity(
  "1",
  "credentialAtomicQuerySig",
  false,
  {
    "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b",
    "challenge": 74657374,
    "query": jsonDecode(mockQueryRequest),
  },
  proofQueryParamEntity,
);

// Tested instance
ProofQueryMapper proofQueryMapper = ProofQueryMapper();

void main() {
  group("ProofQueryMapper", () {
    test("MapTo", () {
      ProofScopeRulesQueryRequest proofScopeRulesQueryRequest =
          proofQueryMapper.mapTo(mockProofRequestEntity);
      expect(proofScopeRulesQueryRequest.challenge,
          mockProofScopeRulesQueryRequest.challenge);
    });
  });
}
