import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/proof_scope_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_request.dart';

List<ProofScopeRequest> mockProofScopeRequestList = [
  ProofScopeRequest(
      id: 0,
      circuit_id: 'credentialAtomicQueryMTP',
      optional: false,
      rules: ProofScopeRulesRequest()),
  ProofScopeRequest(
      id: 1,
      circuit_id: 'abcdef',
      optional: false,
      rules: ProofScopeRulesRequest()),
  ProofScopeRequest(
    id: 2,
    circuit_id: 'credentialAtomicQuerySig',
    optional: false,
    rules: ProofScopeRulesRequest(
      query: ProofScopeRulesQueryRequest(
        allowedIssuers: ["a", "b", "c"],
        challenge: 0,
      ),
    ),
  ),
];

ProofScopeRulesQueryRequest mockProofScopeRulesQueryRequest =
    ProofScopeRulesQueryRequest();

ProofScopeDataSource dataSource = ProofScopeDataSource();

void main() {
  group("proof scope data source", () {
    test(
      'given a list of proofScopeRequest, when we call filteredProofScopeRequestList, we expect a filtered list of proofScopeRequest to be returned',
      () {
        var filteredList =
            dataSource.filteredProofScopeRequestList(mockProofScopeRequestList);
        expect(filteredList.length, 1);
        expect(filteredList.first.id, 2);
      },
    );

    //TODO retrieve a valid obj example before testing
    /*test(
      'given a ProofScopeRulesQueryRequest, when we call proofScopeRulesQueryRequestFilters, we expect a FilterEntity list to be returned',
          () {
      },
    );*/
  });
}
