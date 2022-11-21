import 'package:country_code/country_code.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';

class ProofScopeDataSource {
  Map<String, dynamic> getFieldOperatorAndValues(
      ProofScopeRequest scopeRequest) {
    String field = "";
    int operator = 0;
    List<int> values = [];
    Map<String, dynamic> result = {};
    if (scopeRequest.rules!.query!.req != null) {
      if (scopeRequest.rules!.query!.req!.length > 1) {}

      scopeRequest.rules!.query!.req!.forEach((key1, val1) {
        field = key1;

        if (val1.length > 1) {}

        val1.forEach((key2, val2) {
          operator = _queryOperators[key2]!;
          if (val2 is List<dynamic>) {
            values = val2.cast<int>();
          } else if (val2 is int) {
            values = [val2];
          }
        });
      });
    }
    result["field"] = field;
    result["values"] = values;
    result["operator"] = operator;
    return result;
  }

  final Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };
}
