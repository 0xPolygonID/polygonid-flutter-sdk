import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart';

class GetProofRequestsUseCase
    extends FutureUseCase<Iden3Message, List<ProofRequestEntity>> {
  final GetProofQueryContextUseCase _getProofQueryContextUseCase;
  final StacktraceManager _stacktraceManager;

  GetProofRequestsUseCase(
    this._getProofQueryContextUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<ProofRequestEntity>> execute({
    required Iden3Message param,
  }) async {
    List<ProofRequestEntity> proofRequests = [];

    if (![
      Iden3MessageType.authRequest,
      Iden3MessageType.proofContractInvokeRequest,
    ].contains(param.type)) {
      _stacktraceManager.addTrace(
        "[GetProofRequestsUseCase] Error: Unsupported message type: ${param.type}\nExpected: ${Iden3MessageType.authRequest}, ${Iden3MessageType.proofContractInvokeRequest}",
      );
      return Future.error(
        UnsupportedIden3MsgTypeException(
          type: param.type,
          errorMessage: "Unsupported message type: ${param.type}",
        ),
      );
    }

    List<ZeroKnowledgeProofRequest>? scopes;
    if (param is AuthorizationRequestMessage) {
      scopes = param.body.scope;
    } else if (param is ContractInvokeRequestMessage) {
      scopes = param.body.scope;
    }

    if (scopes != null && scopes.isNotEmpty) {
      for (ZeroKnowledgeProofRequest scope in scopes) {
        var context = await _getProofQueryContextUseCase.execute(param: scope);
        _stacktraceManager.addTrace(
          "[GetProofRequestsUseCase] _getProofQueryContextUseCase: ${jsonEncode(context)}",
        );
        proofRequests.add(ProofRequestEntity(scope, context));
      }
    }

    return proofRequests;
  }
}
