import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../../../common/domain/tuples.dart';
import '../../../identity/data/data_sources/wallet_data_source.dart';
import '../../../identity/data/mappers/auth_request_mapper.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../../proof_generation/domain/repositories/proof_repository.dart';
import '../../data/data_sources/proof_scope_data_source.dart';
import '../../data/dtos/request/auth/auth_request.dart';
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
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final AuthRequestMapper _authRequestMapper;
  final ProofScopeDataSource _proofScopeDataSource;
  final WalletDataSource _walletDataSource;
  final GetProofsUseCase _getProofsUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;

  AuthenticateUseCase(
      this._iden3commRepository,
      this._proofRepository,
      this._identityRepository,
      this._credentialRepository,
      this._authRequestMapper,
      this._proofScopeDataSource,
      this._walletDataSource,
      this._getProofsUseCase,
      this._getAuthTokenUseCase);

  @override
  Future<bool> execute({required AuthenticateParam param}) async {
    Iden3MessageEntity iden3Message =
        Iden3MessageMapper(Iden3MessageTypeMapper())
            .mapFrom(Iden3Message.fromJson(jsonDecode(param.issuerMessage)));

    if (iden3Message.type == Iden3MessageType.auth) {
      AuthRequest authRequest =
          _authRequestMapper.mapFrom(iden3Message.toString());
      CircuitDataEntity authData =
          await _proofRepository.loadCircuitFiles("auth");
      IdentityEntity identityEntity =
          await _identityRepository.getIdentity(identifier: param.identifier);

      List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofs =
          await _getProofsUseCase.execute(
              param: GetProofsParam(
                  issuerMessage: param.issuerMessage,
                  identifier: param.identifier));

      return _iden3commRepository.authenticate(
          authRequest: authRequest,
          identityEntity: identityEntity,
          authData: authData,
          proofList: proofs,
          pushToken: param.pushToken);
    } else {
      return false;
    }
  }
}
