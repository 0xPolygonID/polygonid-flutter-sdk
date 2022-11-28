import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';

class GetProofRequestsUseCase
    extends FutureUseCase<Iden3MessageEntity, List<ProofRequestEntity>> {
  final GetProofQueryUseCase _getProofQueryUseCase;

  GetProofRequestsUseCase(this._getProofQueryUseCase);

  @override
  Future<List<ProofRequestEntity>> execute(
      {required Iden3MessageEntity param}) async {
    List<ProofRequestEntity> proofRequests = [];

    if (![Iden3MessageType.auth, Iden3MessageType.contractFunctionCall]
        .contains(param.messageType)) {
      return Future.error(UnsupportedIden3MsgTypeException(param.messageType));
    }

    await param.body.scope?.forEach((scope) async {
      await _getProofQueryUseCase
          .execute(param: scope)
          .then((query) => proofRequests.add(ProofRequestEntity(scope, query)))
          .catchError((_) {});
    });

    return Future.value(proofRequests);
  }
}
