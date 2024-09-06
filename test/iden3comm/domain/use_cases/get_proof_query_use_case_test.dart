import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

ProofScopeRequest mockProofScopeRequestLT = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$lt": 20000101,
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestNOOP = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$noop": 19880101,
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestEQ = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$eq": 19870202,
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestGT = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$gt": 19900202,
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestIN = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$in": [19900202, 19900205],
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestNIN = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {
        "\$nin": [19900202, 19900205],
      },
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestNoReq = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestTooMany = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": [
        {
          "\$nin": [19900202, 19900205],
        },
        {"\$gt": 19900202}
      ],
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);

ProofScopeRequest mockProofScopeRequestInvalid = ProofScopeRequest(
  id: 1,
  circuitId: "credentialAtomicQuerySig",
  query: ProofScopeQueryRequest(
    type: "KYCAgeCredential",
    allowedIssuers: ["*"],
    credentialSubject: {
      "birthday": {"\$gt": "19900202"},
    },
    context:
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
    challenge: 0,
  ),
);
