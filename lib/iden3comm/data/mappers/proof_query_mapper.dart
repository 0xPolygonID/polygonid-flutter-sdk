import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';

import '../../domain/entities/proof_request_entity.dart';
import '../dtos/request/auth/proof_scope_rules_request.dart';

class ProofQueryMapper
    extends ToMapper<ProofScopeRulesQueryRequest, ProofRequestEntity> {
  @override
  ProofScopeRulesQueryRequest mapTo(ProofRequestEntity to) {
    // Should be better to also have this one in a mapper
    ProofScopeRulesRequest rules = ProofScopeRulesRequest.fromJson(to.info);

    return rules.query!;
  }
}
