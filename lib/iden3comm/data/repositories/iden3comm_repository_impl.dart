import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/iden3_message_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_body_did_doc_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_body_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_inputs_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/jwz_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/gist_mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';
import 'package:uuid/uuid.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final Iden3MessageDataSource _iden3messageDataSource;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final LibPolygonIdCoreIden3commDataSource
      _libPolygonIdCoreIden3commDataSource;
  final LibBabyJubJubDataSource
      _libBabyJubJubDataSource; // TODO move bjj DS to common
  final AuthResponseMapper _authResponseMapper;
  final AuthInputsMapper _authInputsMapper;
  final AuthProofMapper _authProofMapper;
  final GistMTProofMapper _gistProofMapper;
  final QMapper _qMapper;
  final JWZMapper _jwzMapper;
  final Iden3commProofMapper _iden3commProofMapper;
  final GetIden3MessageUseCase _getIden3MessageUseCase;
  final StacktraceManager _stacktraceManager;

  Iden3commRepositoryImpl(
    this._iden3messageDataSource,
    this._remoteIden3commDataSource,
    this._libPolygonIdCoreIden3commDataSource,
    this._libBabyJubJubDataSource,
    this._authResponseMapper,
    this._authInputsMapper,
    this._authProofMapper,
    this._gistProofMapper,
    this._qMapper,
    this._jwzMapper,
    this._iden3commProofMapper,
    this._getIden3MessageUseCase,
    this._stacktraceManager,
  );

  @override
  Future<Iden3MessageEntity?> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  }) async {
    String? url = request.body.callbackUrl;

    if (url == null || url.isEmpty) {
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

      final nextRequest = await _getIden3MessageUseCase.execute(
        param: jsonEncode(messageJson),
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
    required AuthIden3MessageEntity request,
    required List<Iden3commProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? packageName,
  }) async {
    AuthBodyDidDocResponseDTO? didDocResponse;
    if (pushUrl != null &&
        pushUrl.isNotEmpty &&
        pushToken != null &&
        pushToken.isNotEmpty &&
        packageName != null &&
        packageName.isNotEmpty) {
      didDocResponse = await _iden3messageDataSource.getDidDocResponse(
          pushUrl, did, pushToken, packageName);
    }

    AuthResponseDTO authResponse = AuthResponseDTO(
      id: const Uuid().v4(),
      thid: request.thid,
      to: request.from,
      from: did,
      typ: "application/iden3-zkp-json",
      //request
      //.typ, // "application/iden3-zkp-json", // TODO if it's plain json typ: "application/iden3comm-plain-json",
      type: "https://iden3-communication.io/authorization/1.0/response",
      body: AuthBodyResponseDTO(
        message: request.body.message,
        scope: scope
            .map((iden3commProofEntity) =>
                _iden3commProofMapper.mapTo(iden3commProofEntity))
            .toList(),
        did_doc: didDocResponse,
      ),
    );
    return _authResponseMapper.mapFrom(authResponse);
  }

  @override
  Future<Uint8List> getAuthInputs(
      {required String genesisDid,
      required BigInt profileNonce,
      required String challenge,
      required List<String> authClaim,
      required IdentityEntity identity,
      required String signature,
      required MTProofEntity incProof,
      required MTProofEntity nonRevProof,
      required GistMTProofEntity gistProof,
      required Map<String, dynamic> treeState}) {
    return Future.value(_libPolygonIdCoreIden3commDataSource.getAuthInputs(
            genesisDid: genesisDid,
            profileNonce: profileNonce,
            authClaim: authClaim,
            incProof: _authProofMapper.mapTo(incProof),
            nonRevProof: _authProofMapper.mapTo(nonRevProof),
            gistProof: _gistProofMapper.mapTo(gistProof),
            treeState: treeState,
            challenge: challenge,
            signature: signature))
        .then((inputs) => _authInputsMapper.mapFrom(inputs));
  }

  @override
  Future<String> getChallenge({required String message}) {
    return Future.value(_qMapper.mapFrom(message))
        .then((q) => _libBabyJubJubDataSource.hashPoseidon(q));
  }

  @override
  Future<void> cleanSchemaCache() async {
    return _remoteIden3commDataSource.cleanSchemaCache();
  }
}
