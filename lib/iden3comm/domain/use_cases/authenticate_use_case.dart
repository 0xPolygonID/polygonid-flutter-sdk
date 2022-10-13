import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/tuples.dart';
import '../../data/dtos/request/auth/auth_request.dart';
import '../../data/dtos/request/auth/proof_scope_request.dart';
import '../../data/dtos/response/auth/proof_response.dart';
import '../repositories/iden3comm_repository.dart';
import 'get_auth_token_use_case.dart';
import 'get_proofs_use_case.dart';

class AuthenticateParam {
  final AuthRequest authRequest;
  final String identifier;
  final String? pushToken;

  AuthenticateParam(
      {required this.authRequest, required this.identifier, this.pushToken});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3commRepository _iden3commRepository;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetProofsUseCase _getProofsUseCase;

  AuthenticateUseCase(this._iden3commRepository, this._getProofsUseCase,
      this._getAuthTokenUseCase);

  @override
  Future<void> execute({required AuthenticateParam param}) async {
    List<ProofScopeRequest>? proofScopeRequestList =
        param.authRequest.body?.scope;

    List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofList =
        await _getProofsUseCase.execute(
            param: GetProofsParam(
                proofScopeRequestList: proofScopeRequestList,
                identifier: param.identifier));

    List<ProofResponse> scope =
        await _iden3commRepository.getProofResponseList(proofs: proofList);

    String authResponse = await _iden3commRepository.getAuthResponse(
        identifier: param.identifier,
        authRequest: param.authRequest,
        scope: scope);

    String authToken = await _getAuthTokenUseCase.execute(
        param: GetAuthTokenParam(param.identifier, authResponse));

    String? url = param.authRequest.body?.callbackUrl;

    if (url != null) {
      _iden3commRepository
          .authenticate(
        url: url,
        authToken: authToken,
      )
          .catchError((error) {
        logger().e("[AuthenticateUseCase] Error: $error");
        throw error;
      });
    } else {
      throw NetworkException(
          "[AuthenticateUseCase] Error: Callback url is empty");
    }
  }
}
