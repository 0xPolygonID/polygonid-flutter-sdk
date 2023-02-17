import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';

import '../common/domain/entities/filter_entity.dart';
import '../credential/domain/entities/claim_entity.dart';
import '../credential/domain/use_cases/get_vocabs_use_case.dart';
import '../iden3comm/domain/use_cases/get_claims_from_iden3msg_use_case.dart';
import '../iden3comm/domain/use_cases/get_filters_from_iden3msg_use_case.dart';
import '../iden3comm/domain/use_cases/get_proofs_from_iden3msg_use_case.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3MessageEntity] from a message string
  Future<Iden3MessageEntity> getIden3Message({required String message});

  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps

  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message});

  Future<List<ClaimEntity>> getClaims({
    required Iden3MessageEntity message,
    required String did,
    int? profileNonce,
    required String privateKey,
  });

  Future<List<JWZProofEntity>> getProofs({
    required Iden3MessageEntity message,
    required String did,
    int? profileNonce,
    required String privateKey,
  });

  /// get iden3message from qr code and transform it as string "message" #3 through getIden3Message(message)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken});

  // TODO: move here fetching claims
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final GetIden3MessageUseCase _getIden3MessageUseCase;
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetFiltersFromIden3MsgUseCase _getFiltersFromIden3MsgUseCase;
  final GetClaimsFromIden3MsgUseCase _getClaimsFromIden3MsgUseCase;
  final GetProofsFromIden3MsgUseCase _getProofsFromIden3MsgUseCase;

  Iden3comm(
    this._getIden3MessageUseCase,
    this._getVocabsFromIden3MsgUseCase,
    this._authenticateUseCase,
    this._getFiltersFromIden3MsgUseCase,
    this._getClaimsFromIden3MsgUseCase,
    this._getProofsFromIden3MsgUseCase,
  );

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    return _getIden3MessageUseCase.execute(param: message);
  }

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  /*@override
  Future<List<Map<String, dynamic>>> getVocabs(
      {required Iden3MessageEntity message}) {
    return _getVocabsFromIden3MsgUseCase.execute(param: message);
  }*/

  ///AUTHENTICATION
  /// get iden3message from qr code and transform it as string "message" #3 through _getAuthMessage(data)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5
  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken}) {
    if (message is! AuthIden3MessageEntity) {
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.auth, message.messageType);
    }

    return _authenticateUseCase.execute(
        param: AuthenticateParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      pushToken: pushToken,
    ));
  }

  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message}) {
    return _getFiltersFromIden3MsgUseCase.execute(
        param: GetFiltersFromIden3MsgParam(
      message: message,
    ));
  }

  @override
  Future<List<ClaimEntity>> getClaims(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey}) {
    return _getClaimsFromIden3MsgUseCase.execute(
        param: GetClaimsFromIden3MsgParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
    ));
  }

  @override
  Future<List<JWZProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? challenge}) {
    return _getProofsFromIden3MsgUseCase.execute(
        param: GetProofsFromIden3MsgParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      challenge: challenge,
    ));
  }
}
