import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';

import '../iden3comm/domain/use_cases/get_vocabs_use_case.dart';

@injectable
class Iden3comm {
  //final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;

  Iden3comm(
    //this._getAuthTokenUseCase,
    this._getVocabsFromIden3MsgUseCase,
    this._authenticateUseCase,
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
  Future<bool> authenticate(
      {required String issuerMessage,
      required String identifier,
      String? pushToken}) {
    return _authenticateUseCase.execute(
        param: AuthenticateParam(
            issuerMessage: issuerMessage,
            identifier: identifier,
            pushToken: pushToken));
  }
}
