import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_param_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

ProofScopeRequest proofScopeRequest = ProofScopeRequest(
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      req: {
        "field": {
          "\$eq": [1, 2, 3],
        },
      },
    ),
  ),
);

ProofScopeRequest invalidProofScopeRequest = ProofScopeRequest(
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      req: {
        "field": {
          "\$eq": "a12",
        },
      },
    ),
  ),
);

ProofScopeRequest invalidProofScopeRequestAlternative = ProofScopeRequest(
  rules: ProofScopeRulesRequest(
    query: ProofScopeRulesQueryRequest(
      req: {
        "field": "a12",
      },
    ),
  ),
);

// Tested instance
ProofQueryParamMapper proofQueryParamMapper = ProofQueryParamMapper();

void main() {
  group("ProofQueryParamMapper", () {
    test("mapFrom", () {
      ProofQueryParamEntity proofQueryParamEntity =
          proofQueryParamMapper.mapFrom(proofScopeRequest);
      expect(proofQueryParamEntity.operator, 1);
      expect(proofQueryParamEntity.field, "field");
      expect(proofQueryParamEntity.values, [1, 2, 3]);
    });

    test("invalid values expect exception", () {
      expect(() => proofQueryParamMapper.mapFrom(invalidProofScopeRequest),
          throwsA(isA<InvalidProofReqException>()));
      expect(
          () => proofQueryParamMapper
              .mapFrom(invalidProofScopeRequestAlternative),
          throwsA(isA<InvalidProofReqException>()));
    });
  });
}
