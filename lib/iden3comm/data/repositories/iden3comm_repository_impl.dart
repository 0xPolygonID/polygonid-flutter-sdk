import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/jwz_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/generate_inputs_response.dart';
import 'package:poseidon/poseidon.dart';
import 'package:uuid/uuid.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;
  final QMapper _qMapper;
  final JWZMapper _jwzMapper;
  final Iden3MessageFactory _messageFactory;
  final StacktraceManager _stacktraceManager;

  Iden3commRepositoryImpl(
    this._remoteIden3commDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._qMapper,
    this._jwzMapper,
    this._messageFactory,
    this._stacktraceManager,
  );

  @override
  Future<Iden3Message?> authenticate({
    required AuthorizationRequestMessage request,
    required String authToken,
  }) async {
    String? url = request.body.callbackUrl;

    if (url.isEmpty) {
      _stacktraceManager.addError("Callback url is null or empty");
      throw NullAuthenticateCallbackException(
        authRequest: request,
        errorMessage: "Callback url is null or empty",
      );
    }

    final response = await _remoteIden3commDataSource.authWithToken(
      token: authToken,
      url: url,
    );

    if (response.data.isEmpty) {
      return null;
    }

    try {
      final messageJson = jsonDecode(response.data);
      if (messageJson is! Map<String, dynamic> || messageJson.isEmpty) {
        return null;
      }

      final nextRequest = _messageFactory.createMessage(
        rawMessage: response.data,
      );

      return nextRequest;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> encodeJWZ({required JWZEntity jwz}) {
    return Future.value(_jwzMapper.mapFrom(jwz));
  }

  @override
  Future<String> getAuthResponse({
    required String did,
    required AuthorizationRequestMessage request,
    required List<Iden3commProofEntity> scope,
    DIDDocument? didDocument,
  }) async {
    final authResponse = AuthorizationResponseMessage(
      id: const Uuid().v4(),
      thid: request.thid,
      to: request.from,
      from: did,
      typ: messageTypeZkp,
      body: AuthorizationResponseMessageBody(
        message: request.body.message,
        scope: scope,
        did_doc: didDocument,
      ),
    );
    return jsonEncode(authResponse.toJson());
  }

  @override
  Future<GenerateInputsResponse> getAuthInputs({
    required String genesisDid,
    required BigInt profileNonce,
    required String challenge,
    required List<String> authClaim,
    required IdentityEntity identity,
    required String signature,
    required MTProofEntity incProof,
    required MTProofEntity nonRevProof,
    required GistMTProofEntity gistProof,
    required Map<String, dynamic> treeState,
    required CircuitId circuitId,
    Map<String, dynamic>? config,
  }) {
    return _libPolygonIdCoreProofDataSource.getAuthInputs(
      genesisDid: genesisDid,
      profileNonce: profileNonce,
      authClaim: authClaim,
      incProof: incProof.toJson(),
      nonRevProof: nonRevProof.toJson(),
      gistProof: gistProof.toJson(),
      treeState: treeState,
      challenge: challenge,
      signature: signature,
      config: config,
      circuitId: circuitId,
    );
  }

  @override
  Future<String> getChallenge({required String message}) async {
    final q = _qMapper.mapFrom(message);
    return poseidon1([BigInt.parse(q)]).toString();
  }

  @override
  Future<void> cleanSchemaCache() async {
    return _remoteIden3commDataSource.cleanSchemaCache();
  }
}
