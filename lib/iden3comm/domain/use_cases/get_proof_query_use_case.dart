import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
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
    "\$ne": 6
  };

  @override
  Future<ProofQueryParamEntity> execute({required ProofScopeRequest param}) {
    String field = "";
    int operator = 0;
    List<dynamic> values = [];

    if (param.query.credentialSubject != null &&
        param.query.credentialSubject!.length == 1) {
      MapEntry reqEntry = param.query.credentialSubject!.entries.first;

      if (reqEntry.value != null && reqEntry.value is Map) {
        field = reqEntry.key;
        if (reqEntry.value.length == 0) {
          Future.value(ProofQueryParamEntity(field, values, operator));
        } else {
          MapEntry entry = (reqEntry.value as Map).entries.first;
          if (_queryOperators.containsKey(entry.key)) {
            operator = _queryOperators[entry.key]!;
          }
          if (entry.value == "true" || entry.value == "false") {
            values = [entry.value == "true" ? 1 : 0];
          } else if (entry.value is List<dynamic>) {
            if (operator == 2 || operator == 3) {
              // lt, gt
              return Future.error(InvalidProofReqException());
            }
            try {
              values = entry.value.cast<int>();
            } catch (e) {
              try {
                values = entry.value.cast<String>();
              } catch (e) {
                return Future.error(InvalidProofReqException());
              }
              return Future.error(InvalidProofReqException());
            }
          } else if (entry.value is String) {
            if (operator == 2 || operator == 3) {
              // lt, gt
              return Future.error(InvalidProofReqException());
            }
            values = [entry.value];
          } else if (entry.value is int) {
            values = [entry.value];
          } else if (entry.value is double) {
            values = [entry.value];
          }
          else if (entry.value is bool) {
            values = [entry.value == true ? 1 : 0];
          } else {
            return Future.error(InvalidProofReqException());
          }
        }
      } else {
        return Future.error(InvalidProofReqException());
      }
    }

    return Future.value(ProofQueryParamEntity(field, values, operator));
  }
}
