import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/sign_message_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetAuthInputsParam {
  final String challenge;
  final String identifier;
  final String privateKey;

  GetAuthInputsParam(this.challenge, this.identifier, this.privateKey);
}

class GetAuthInputsUseCase
    extends FutureUseCase<GetAuthInputsParam, Uint8List> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final IdentityRepository _identityRepository;

  GetAuthInputsUseCase(this._getIdentityUseCase, this._getAuthClaimUseCase,
      this._signMessageUseCase, this._identityRepository);

  @override
  Future<Uint8List> execute({required GetAuthInputsParam param}) {
    return _getIdentityUseCase
        .execute(
            param: GetIdentityParam(
                identifier: param.identifier, privateKey: param.privateKey))
        .then((identity) => Future.wait([
              _signMessageUseCase.execute(
                  param: SignMessageParam(param.privateKey, param.challenge)),
              _getAuthClaimUseCase.execute(param: identity)
            ]).then((values) => _identityRepository.getAuthInputs(
                challenge: param.challenge,
                authClaim: values[1],
                identity: identity,
                signature: values[0])))
        .then((inputs) {
      logger().i("[GetAuthInputsUseCase] Auth inputs: $inputs");

      return inputs;
    }).catchError((error) {
      logger().e("[GetAuthInputsUseCase] Error: $error");

      throw error;
    });
  }
}
