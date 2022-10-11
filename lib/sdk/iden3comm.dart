import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';

import '../credential/domain/use_cases/get_vocabs_use_case.dart';
import '../iden3comm/data/dtos/request/auth/auth_request.dart';
import '../iden3comm/data/mappers/iden3_message_mapper.dart';
import '../iden3comm/data/mappers/iden3_message_type_mapper.dart';
import '../iden3comm/domain/entities/iden3_message_entity.dart';
import '../iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import '../identity/data/mappers/auth_request_mapper.dart';

@injectable
class Iden3comm {
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final AuthRequestMapper _authRequestMapper;

  Iden3comm(
    this._getVocabsFromIden3MsgUseCase,
    this._authenticateUseCase,
    this._authRequestMapper,
  );

  /*/// Get a string auth token through an identifier
  /// The [identifier] is a string returned when creating an identity with [createIdentity]
  /// and [circuitData] describes data about the used circuit, see [CircuitDataEntity].
  /// [message] will be fully integrated on the resulting encoded string (follow JWZ standard).
  /// See [JWZ].
  Future<String> getAuthToken(
      {required String identifier, required String message}) {
    return _getAuthTokenUseCase.execute(
        param: GetAuthTokenParam(identifier, message));
  }*/

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  Future<List<Map<String, dynamic>>> getVocabsFromIden3Message(
      {required Iden3Message iden3Message}) {
    return _getVocabsFromIden3MsgUseCase.execute(param: iden3Message);
  }

  ///AUTHENTICATION
  /// get iden3message from qr code and transform it as string "message" #3 through _getAuthMessage(data)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  Future<void> authenticate(
      {required String issuerMessage,
      required String identifier,
      String? pushToken}) {
    Iden3MessageEntity iden3Message =
        Iden3MessageMapper(Iden3MessageTypeMapper())
            .mapFrom(Iden3Message.fromJson(jsonDecode(issuerMessage)));

    if (iden3Message.type == Iden3MessageType.auth) {
      AuthRequest authRequest =
          _authRequestMapper.mapFrom(iden3Message.toString());
      return _authenticateUseCase.execute(
          param: AuthenticateParam(
              authRequest: authRequest,
              identifier: identifier,
              pushToken: pushToken));
    } else {
      throw UnsupportedIden3MsgTypeException(iden3Message.type);
    }
  }
}
