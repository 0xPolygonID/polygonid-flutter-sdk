import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../../../common/domain/tuples.dart';
import '../../../identity/data/mappers/auth_request_mapper.dart';
import '../../data/dtos/request/auth/auth_request.dart';
import '../../data/dtos/request/auth/proof_scope_request.dart';
import '../../data/dtos/response/auth/proof_response.dart';
import '../../data/mappers/iden3_message_mapper.dart';
import '../../data/mappers/iden3_message_type_mapper.dart';
import '../repositories/iden3comm_repository.dart';
import 'get_auth_token_use_case.dart';
import 'get_proofs_use_case.dart';

class AuthenticateParam {
  final String issuerMessage;
  final String identifier;
  final String? pushToken;

  AuthenticateParam(
      {required this.issuerMessage, required this.identifier, this.pushToken});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3commRepository _iden3commRepository;
  final AuthRequestMapper _authRequestMapper;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetProofsUseCase _getProofsUseCase;

  AuthenticateUseCase(this._iden3commRepository, this._authRequestMapper,
      this._getProofsUseCase, this._getAuthTokenUseCase);

  @override
  Future<bool> execute({required AuthenticateParam param}) async {
    Iden3MessageEntity iden3Message =
        Iden3MessageMapper(Iden3MessageTypeMapper())
            .mapFrom(Iden3Message.fromJson(jsonDecode(param.issuerMessage)));

    if (iden3Message.type == Iden3MessageType.auth) {
      AuthRequest authRequest =
          _authRequestMapper.mapFrom(iden3Message.toString());

      List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofList =
          await _getProofsUseCase.execute(
              param: GetProofsParam(
                  issuerMessage: param.issuerMessage,
                  identifier: param.identifier));

      List<ProofResponse> scope =
          await _iden3commRepository.getProofResponseList(proofs: proofList);

      String authResponse = await _iden3commRepository.getAuthResponse(
          identifier: param.identifier, authRequest: authRequest, scope: scope);

      String authToken = await _getAuthTokenUseCase.execute(
          param: GetAuthTokenParam(param.identifier, authResponse));

      String? url = authRequest.body?.callbackUrl;

      if (url != null) {
        return _iden3commRepository.authenticate(
          url: url,
          authToken: authToken,
        );
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
