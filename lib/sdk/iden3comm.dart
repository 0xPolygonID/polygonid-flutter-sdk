import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';

import '../credential/domain/use_cases/get_vocabs_use_case.dart';
import 'mappers/iden3_message_mapper.dart';
import 'mappers/schema_info_mapper.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3MessageEntity] from a message string
  Iden3MessageEntity getIden3Message({required String message});

  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  Future<List<Map<String, dynamic>>> getVocabsFromIden3Message(
      {required Iden3MessageEntity message});

  Future<List<ProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String identifier,
      required String privateKey,
      String? challenge});

  /// get iden3message from qr code and transform it as string "message" #3 through getIden3Message(message)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String identifier,
      required String privateKey,
      String? pushToken});
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetProofsUseCase _getProofsUseCase;
  final Iden3MessageMapper _iden3messageMapper;
  final SchemaInfoMapper _schemaInfoMapper;

  Iden3comm(this._getVocabsFromIden3MsgUseCase, this._authenticateUseCase,
      this._getProofsUseCase, this._iden3messageMapper, this._schemaInfoMapper);

  @override
  Iden3MessageEntity getIden3Message({required String message}) {
    return _iden3messageMapper.mapFrom(message);
  }

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  @override
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
  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String identifier,
      required String privateKey,
      String? pushToken}) {
    return _authenticateUseCase.execute(
        param: AuthenticateParam(
      message: message,
      identifier: identifier,
      privateKey: privateKey,
      pushToken: pushToken,
    ));
  }

  @override
  Future<List<ProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String identifier,
      required String privateKey,
      String? challenge}) {
    return _getProofsUseCase.execute(
        param: GetProofsParam(
      message: message,
      identifier: identifier,
      challenge: challenge,
      privateKey: privateKey,
    ));
  }
}
