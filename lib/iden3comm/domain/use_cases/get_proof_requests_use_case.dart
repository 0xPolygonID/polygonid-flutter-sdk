import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';

class GetProofRequestsUseCase
    extends FutureUseCase<Iden3MessageEntity, List<ProofRequestEntity>> {
  final GetProofQueryContextUseCase _getProofQueryContextUseCase;
  final GetProofQueryUseCase _getProofQueryUseCase;
  final StacktraceManager _stacktraceManager;

  GetProofRequestsUseCase(
    this._getProofQueryContextUseCase,
    this._getProofQueryUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<ProofRequestEntity>> execute(
      {required Iden3MessageEntity param}) async {
    List<ProofRequestEntity> proofRequests = [];

    if (![
      Iden3MessageType.authRequest,
      Iden3MessageType.proofContractInvokeRequest
    ].contains(param.messageType)) {
      _stacktraceManager.addTrace(
          "[GetProofRequestsUseCase] Error: Unsupported message type: ${param.messageType}");
      return Future.error(UnsupportedIden3MsgTypeException(param.messageType));
    }

    if (param.body.scope != null && param.body.scope!.isNotEmpty) {
      for (ProofScopeRequest scope in param.body.scope!) {
        var context = await _getProofQueryContextUseCase.execute(param: scope);
        _stacktraceManager.addTrace(
            "[GetProofRequestsUseCase] _getProofQueryContextUseCase: ${jsonEncode(context)}");
        ProofQueryParamEntity query =
            await _getProofQueryUseCase.execute(param: scope);
        _stacktraceManager.addTrace(
            "[GetProofRequestsUseCase] _getProofQueryUseCase: ${jsonEncode(query.toJson())}");
        proofRequests.add(ProofRequestEntity(scope, context, query));
      }
    }

    return Future.value(proofRequests);
  }
}
