import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:intl/intl.dart';

class GetProofQueryUseCase
    extends FutureUseCase<ProofScopeRequest, ProofQueryParamEntity> {
  final StacktraceManager _stacktraceManager;
  final Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
    "\$ne": 6
  };

  GetProofQueryUseCase(this._stacktraceManager);

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
              _stacktraceManager.addTrace(
                  "[GetProofQueryUseCase] InvalidProofReqException param: $param\nentry: $entry");
              return Future.error(InvalidProofReqException());
            }
            try {
              values = entry.value.cast<int>();
            } catch (e) {
              try {
                values = entry.value.cast<String>();
              } catch (e) {
                _stacktraceManager.addTrace(
                    "[GetProofQueryUseCase] InvalidProofReqException param: $param\nentry: $entry");
                return Future.error(InvalidProofReqException());
              }
              _stacktraceManager.addTrace(
                  "[GetProofQueryUseCase] InvalidProofReqException param: $param\nentry: $entry");
              return Future.error(InvalidProofReqException());
            }
          } else if (entry.value is String) {
            if (!_isDateTime(entry.value) && (operator == 2 || operator == 3)) {
              // lt, gt
              _stacktraceManager.addTrace(
                  "[GetProofQueryUseCase] InvalidProofReqException param: $param\nentry: $entry");
              return Future.error(InvalidProofReqException());
            }

            values = [entry.value];
          } else if (entry.value is int) {
            values = [entry.value];
          } else if (entry.value is double) {
            values = [entry.value];
          } else if (entry.value is bool) {
            values = [entry.value == true ? 1 : 0];
          } else {
            _stacktraceManager.addTrace(
                "[GetProofQueryUseCase] InvalidProofReqException param: $param\nentry: $entry");
            return Future.error(InvalidProofReqException());
          }
        }
      } else {
        _stacktraceManager.addTrace(
            "[GetProofQueryUseCase] InvalidProofReqException param: $param\nreqEntry: $reqEntry");
        return Future.error(InvalidProofReqException());
      }
    }

    return Future.value(ProofQueryParamEntity(field, values, operator));
  }

  bool _isDateTime(String input) {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final timeZoneFormat = RegExp(r'.*\+\d{2}:\d{2}$');

    // Check if the input string matches the timezone format
    if (timeZoneFormat.hasMatch(input)) {
      // Remove the timezone from the input
      final noTimeZoneInput = input.substring(0, input.length - 6);
      try {
        dateFormat.parseStrict(noTimeZoneInput);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
