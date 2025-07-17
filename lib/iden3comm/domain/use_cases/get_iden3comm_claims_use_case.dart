import 'package:collection/collection.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';

class GetIden3commClaimsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String encryptionKey;
  final List<ProofRequestEntity>? proofRequests;

  List<CredentialSortOrder> credentialSortOrderList;

  GetIden3commClaimsParam({
    required this.message,
    required this.genesisDid,
    required this.profileNonce,
    required this.encryptionKey,
    this.proofRequests,
    this.credentialSortOrderList = const [],
  });
}

class GetIden3commClaimsUseCase
    extends FutureUseCase<GetIden3commClaimsParam, List<ClaimEntity?>> {
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;

  GetIden3commClaimsUseCase(
    this._getMessageRequestsAndCredsUseCase,
  );

  @override
  Future<List<ClaimEntity>> execute({
    required GetIden3commClaimsParam param,
  }) async {
    final requestsAndCreds = await _getMessageRequestsAndCredsUseCase.execute(
      param: GetMessageRequestsAndCredsParam(
        message: param.message,
        genesisDid: param.genesisDid,
        profileNonce: param.profileNonce,
        encryptionKey: param.encryptionKey,
        credentialSortOrderList: param.credentialSortOrderList,
      ),
    );

    final credentials = <ClaimEntity>[];

    for (final requestAndCreds in requestsAndCreds) {
      final credential = requestAndCreds.credentials.firstOrNull;
      if (credential != null) {
        credentials.add(credential);
      } else if (requestAndCreds.request.isOptional) {
        continue;
      } else {
        throw NoCredentialsFoundException(
          proofRequest: requestAndCreds.request,
          errorMessage: "No credentials found for request: ${requestAndCreds.request.scope.id}",
        );
      }
    }

    return credentials;
  }
}
