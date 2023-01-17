import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

class GetProofQueryUseCase
    extends FutureUseCase<ProofScopeRequest, ProofQueryParamEntity> {
  final Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };

  @override
  Future<ProofQueryParamEntity> execute({required ProofScopeRequest param}) {
    String field = "";
    int operator = 0;
    List<int> values = [];

    if (param.query.credentialSubject != null &&
        param.query.credentialSubject!.length == 1) {
      MapEntry reqEntry = param.query.credentialSubject!.entries.first;

      if (reqEntry.value != null &&
          reqEntry.value is Map &&
          reqEntry.value.length == 1) {
        field = reqEntry.key;
        MapEntry entry = (reqEntry.value as Map).entries.first;

        if (_queryOperators.containsKey(entry.key)) {
          operator = _queryOperators[entry.key]!;
        }

        if (entry.value is List<dynamic>) {
          values = entry.value.cast<int>();
        } else if (entry.value is int) {
          values = [entry.value];
        } else {
          return Future.error(InvalidProofReqException());
        }
      } else {
        return Future.error(InvalidProofReqException());
      }
    }

    return Future.value(ProofQueryParamEntity(field, values, operator));
  }
}
