import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';

import '../credential/domain/use_cases/get_vocabs_use_case.dart';
import 'mappers/iden3_message_mapper.dart';
import 'mappers/schema_info_mapper.dart';

@injectable
class Iden3comm {
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetProofsUseCase _getProofsUseCase;
  final Iden3MessageMapper _iden3messageMapper;
  final SchemaInfoMapper _schemaInfoMapper;

  Iden3comm(this._getVocabsFromIden3MsgUseCase, this._authenticateUseCase,
      this._getProofsUseCase, this._iden3messageMapper, this._schemaInfoMapper);

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  Future<List<Map<String, dynamic>>> getVocabsFromIden3Message(
      {required Iden3MessageEntity message}) {
    return _getVocabsFromIden3MsgUseCase.execute(
        param: _schemaInfoMapper.mapFrom(message));
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
    return _authenticateUseCase.execute(
        param: AuthenticateParam(
            message: _iden3messageMapper.mapFrom(issuerMessage),
            identifier: identifier,
            pushToken: pushToken));
  }

  Future<List<ProofEntity>> getProofs(
      {required String message,
      required String identifier,
      String? challenge}) {
    return _getProofsUseCase.execute(
        param: GetProofsParam(
            message: _iden3messageMapper.mapFrom(message),
            identifier: identifier,
            challenge: challenge));
  }
}
