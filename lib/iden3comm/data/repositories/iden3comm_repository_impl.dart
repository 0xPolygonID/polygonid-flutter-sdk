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
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_did_doc_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_did_doc_service_metadata_devices_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_did_doc_service_metadata_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_did_doc_service_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_inputs_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/gist_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';
import 'package:uuid/uuid.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final LibPolygonIdCoreIden3commDataSource
      _libPolygonIdCoreIden3commDataSource;
  final LibBabyJubJubDataSource
      _libBabyJubJubDataSource; // TODO move bjj DS to common
  final AuthResponseMapper _authResponseMapper;
  final AuthInputsMapper _authInputsMapper;
  final AuthProofMapper _authProofMapper;
  final GistProofMapper _gistProofMapper;
  final QMapper _qMapper;

  Iden3commRepositoryImpl(
    this._remoteIden3commDataSource,
    this._libPolygonIdCoreIden3commDataSource,
    this._libBabyJubJubDataSource,
    this._authResponseMapper,
    this._authInputsMapper,
    this._authProofMapper,
    this._gistProofMapper,
    this._qMapper,
  );

  @override
  Future<void> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  }) async {
    String? url = request.body.callbackUrl;

    if (url == null || url.isEmpty) {
      throw NullAuthenticateCallbackException(request);
    }

    await _remoteIden3commDataSource.authWithToken(token: authToken, url: url);
  }

  @override
  Future<String> getAuthResponse({
    required String did,
    required AuthIden3MessageEntity request,
    required List<JWZProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? packageName,
  }) async {
    AuthBodyDidDocResponse? didDocResponse;
    if (pushUrl != null &&
        pushUrl.isNotEmpty &&
        pushToken != null &&
        pushToken.isNotEmpty &&
        packageName != null &&
        packageName.isNotEmpty) {
      didDocResponse =
          await _getDidDocResponse(pushUrl, did, pushToken, packageName);
    }

    AuthResponse authResponse = AuthResponse(
      id: const Uuid().v4(),
      thid: request.thid,
      to: request.from,
      from: did,
      typ: "application/iden3comm-plain-json",
      type: "https://iden3-communication.io/authorization/1.0/response",
      body: AuthBodyResponse(
        message: request.body.message,
        proofs: scope,
        did_doc: didDocResponse,
      ),
    );
    return _authResponseMapper.mapFrom(authResponse);
  }

  Future<AuthBodyDidDocResponse> _getDidDocResponse(String pushUrl,
      String didIdentifier, String pushToken, String packageName) async {
    return AuthBodyDidDocResponse(
      context: ["https://www.w3.org/ns/did/v1"],
      id: didIdentifier,
      service: [
        AuthBodyDidDocServiceResponse(
          id: "$didIdentifier#push",
          type: "push-notification",
          serviceEndpoint: pushUrl,
          metadata: AuthBodyDidDocServiceMetadataResponse(devices: [
            AuthBodyDidDocServiceMetadataDevicesResponse(
              ciphertext:
                  await _getPushCipherText(pushToken, pushUrl, packageName),
              alg: "RSA-OAEP-512",
            )
          ]),
        )
      ],
    );
  }

  Future<String> _getPushCipherText(
      String pushToken, String serviceEndpoint, String packageName) async {
    var pushInfo = {
      "app_id": packageName, //"com.polygonid.wallet",
      "pushkey": pushToken,
    };

    Response publicKeyResponse =
        await get(Uri.parse("$serviceEndpoint/public"));
    if (publicKeyResponse.statusCode == 200) {
      String publicKeyPem = publicKeyResponse.body;
      var publicKey = RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encrypter =
          OAEPEncoding.withCustomDigest(() => SHA512Digest(), RSAEngine());
      encrypter.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
      Uint8List encrypted = encrypter
          .process(Uint8List.fromList(json.encode(pushInfo).codeUnits));
      return base64.encode(encrypted);
    } else {
      logger().d(
          'getPublicKey Error: code: ${publicKeyResponse.statusCode} msg: ${publicKeyResponse.body}');
      throw NetworkException(publicKeyResponse);
    }
  }

  @override
  Future<Uint8List> getAuthInputs(
      {required String genesisDid,
      required BigInt profileNonce,
      required String challenge,
      required List<String> authClaim,
      required IdentityEntity identity,
      required String signature,
      required ProofEntity incProof,
      required ProofEntity nonRevProof,
      required GistProofEntity gistProof,
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
}
