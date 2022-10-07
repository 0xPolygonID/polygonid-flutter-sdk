import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';

import '../../data/mappers/iden3_message_mapper.dart';
import '../../data/mappers/iden3_message_type_mapper.dart';
import '../repositories/iden3comm_repository.dart';

class AuthenticateParam {
  final String issuerMessage;
  final String identifier;
  final String? pushToken;

  AuthenticateParam(
      {required this.issuerMessage, required this.identifier, this.pushToken});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3commRepository _iden3commRepository;

  AuthenticateUseCase(this._iden3commRepository);

  @override
  Future<bool> execute({required AuthenticateParam param}) async {
    return await _iden3commRepository.authenticate(
        iden3message: Iden3MessageMapper(Iden3MessageTypeMapper())
            .mapFrom(Iden3Message.fromJson(jsonDecode(param.issuerMessage))),
        identifier: param.identifier,
        pushToken: param.pushToken);
  }
}
