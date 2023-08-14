import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';
import 'get_proof_query_use_case_test.mocks.dart';

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

MockStacktraceManager mockStacktraceManager = MockStacktraceManager();

// Tested instance
GetProofQueryUseCase useCase = GetProofQueryUseCase(mockStacktraceManager);

@GenerateMocks([StacktraceManager])
void main() {
  group("Get proof query", () {
    test(
      'Given a ProofScopeRequest with NOOP query operator, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "birthday",
          [19880101],
          0,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestNOOP);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest with EQ query operator, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "birthday",
          [19870202],
          1,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestEQ);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest with LT query operator, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "birthday",
          [20000101],
          2,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestLT);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest with IN query operator, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "birthday",
          [19900202, 19900205],
          4,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestIN);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest with NIN query operator, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "birthday",
          [19900202, 19900205],
          5,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestNIN);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest without req field, when we call getFieldOperatorAndValues, we expect a ProofQueryParamEntity with the field, operator and values',
      () async {
        // Arrange
        final expected = ProofQueryParamEntity(
          "",
          [],
          0,
        );

        // Act
        final actual = await useCase.execute(param: mockProofScopeRequestNoReq);

        // Assert
        expect(actual, expected);
      },
    );

    test(
      'Given a ProofScopeRequest with req field with too many entries, when we call getFieldOperatorAndValues, we expect a InvalidProofReqException to be thrown',
      () async {
        // Act
        await expectLater(useCase.execute(param: mockProofScopeRequestTooMany),
            throwsA(isA<InvalidProofReqException>()));
      },
    );

    test(
      'Given a ProofScopeRequest with req field with invalid entry, when we call getFieldOperatorAndValues, we expect a InvalidProofReqException to be thrown',
      () async {
        // Act
        await expectLater(useCase.execute(param: mockProofScopeRequestInvalid),
            throwsA(isA<InvalidProofReqException>()));
      },
    );
  });
}
