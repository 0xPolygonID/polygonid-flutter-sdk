import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

import '../../domain/entities/proof_request_entity.dart';
import '../dtos/request/auth/proof_scope_request.dart';

class ProofQueryParamMapper
    extends FromMapper<ProofScopeRequest, ProofQueryParamEntity> {
  final Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };

  @override
  ProofQueryParamEntity mapFrom(ProofScopeRequest from) {
    String field = "";
    int operator = 0;
    List<int> values = [];

    if (from.rules != null &&
        from.rules!.query != null &&
        from.rules!.query!.req != null &&
        from.rules!.query!.req!.length == 1) {
      MapEntry reqEntry = from.rules!.query!.req!.entries.first;

      if (reqEntry.value != null &&
          reqEntry.value is Map &&
          reqEntry.value.length == 1) {
        field = reqEntry.key;
        MapEntry entry = (reqEntry.value as Map).entries.first;

        if (entry.value is List<dynamic>) {
          values = entry.value.cast<int>();
        } else if (entry.value is int) {
          values = [entry.value];
        } else {
          throw InvalidProofReqException();
        }
      } else {
        throw InvalidProofReqException();
      }
    } else {
      throw InvalidProofReqException();
    }

    return ProofQueryParamEntity(field, values, operator);
  }
}
