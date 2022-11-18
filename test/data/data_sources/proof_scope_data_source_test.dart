import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/proof_scope_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_schema_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_request.dart';

ProofScopeRequest mockProofScopeRequestLT = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
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
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestNOOP = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
      req: {
        "birthday": {
          "\$noop": 19880101,
        },
      },
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestEQ = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
      req: {
        "birthday": {
          "\$eq": 19870202,
        },
      },
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestGT = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
      req: {
        "birthday": {
          "\$gt": 19900202,
        },
      },
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestIN = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
      req: {
        "birthday": {
          "\$in": [19900202,19900205],
        },
      },
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestNIN = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
      req: {
        "birthday": {
          "\$nin": [19900202,19900205],
        },
      },
    ),
  ),
);

ProofScopeRequest mockProofScopeRequestNoReq = ProofScopeRequest(
  id: 1,
  circuit_id: "credentialAtomicQuerySig",
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      schema: ProofScopeRulesQuerySchemaRequest(
        type: "KYCAgeCredential",
        url:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
      ),
      allowedIssuers: ["*"],
    ),
  ),
);

// Tested instance
ProofScopeDataSource dataSource = ProofScopeDataSource();

void main() {
  group("getFieldOperatorAndValues", () {
    test(
      'given a proofScopeRequest with NOOP query operator, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
          () {
        // Arrange
        final expected = {
          "field": "birthday",
          "values": [19880101],
          "operator": 0,
        };

        // Act
        final actual =
        dataSource.getFieldOperatorAndValues(mockProofScopeRequestNOOP);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'given a proofScopeRequest with EQ query operator, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
          () {
        // Arrange
        final expected = {
          "field": "birthday",
          "values": [19870202],
          "operator": 1,
        };

        // Act
        final actual =
        dataSource.getFieldOperatorAndValues(mockProofScopeRequestEQ);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'given a proofScopeRequest with LT query operator, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
      () {
        // Arrange
        final expected = {
          "field": "birthday",
          "values": [20000101],
          "operator": 2,
        };

        // Act
        final actual =
            dataSource.getFieldOperatorAndValues(mockProofScopeRequestLT);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'given a proofScopeRequest with IN query operator, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
          () {
        // Arrange
        final expected = {
          "field": "birthday",
          "values": [19900202,19900205],
          "operator": 4,
        };

        // Act
        final actual =
        dataSource.getFieldOperatorAndValues(mockProofScopeRequestIN);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'given a proofScopeRequest with NIN query operator, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
          () {
        // Arrange
        final expected = {
          "field": "birthday",
          "values": [19900202,19900205],
          "operator": 5,
        };

        // Act
        final actual =
        dataSource.getFieldOperatorAndValues(mockProofScopeRequestNIN);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'given a proofScopeRequest without req field, when we call getFieldOperatorAndValues, we expect a Map with the field, operator and values',
          () {
        // Arrange
        final expected = {
          "field": "",
          "values": [],
          "operator": 0,
        };

        // Act
        final actual =
        dataSource.getFieldOperatorAndValues(mockProofScopeRequestNoReq);

        // Assert
        expect(actual, expected);
      },
    );
  });
}
