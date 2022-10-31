import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';
import 'package:uuid/uuid.dart';

import '../../../identity/data/data_sources/jwz_data_source.dart';
import '../../../identity/data/mappers/hex_mapper.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../domain/repositories/iden3comm_repository.dart';
import '../data_sources/proof_scope_data_source.dart';
import '../dtos/response/auth/auth_body_did_doc_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_metadata_devices_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_metadata_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_response.dart';
import '../mappers/auth_request_mapper.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final JWZDataSource _jwzDataSource;
  final HexMapper _hexMapper;
  final ProofScopeDataSource _proofScopeDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final AuthResponseMapper _authResponseMapper;
  final AuthRequestMapper _authRequestMapper;

  Iden3commRepositoryImpl(
      this._remoteIden3commDataSource,
      this._jwzDataSource,
      this._hexMapper,
      this._proofScopeDataSource,
      this._storageClaimDataSource,
      this._claimMapper,
      this._filtersMapper,
      this._authResponseMapper,
      this._authRequestMapper);

  @override
  Future<bool> authenticate({
    required String url,
    required String authToken,
  }) async {
    Response res = await _remoteIden3commDataSource.authWithToken(
        token: authToken, url: url);
    return res.statusCode == 200;
  }

  @override
  Future<String> getAuthToken(
      {required IdentityEntity identityEntity,
      required String message,
      required CircuitDataEntity authData}) async {
    return _jwzDataSource.getAuthToken(
        privateKey: _hexMapper.mapTo(identityEntity.privateKey),
        authClaim: identityEntity.authClaim,
        message: message,
        circuitId: authData.circuitId,
        datFile: authData.datFile,
        zKeyFile: authData.zKeyFile);
  }

  @override
  Future<String> getAuthResponse({
    required String identifier,
    required Iden3MessageEntity message,
    required List<ProofEntity> scope,
    String? pushToken,
  }) async {
    AuthBodyDidDocResponse? didDocResponse;

    if (pushToken != null && pushToken.isNotEmpty) {
      var envAuthResponse = ["main", "mumbai"];
      didDocResponse = await _getDidDocResponse(
          envAuthResponse.first, identifier, pushToken);
    }

    AuthRequest request = _authRequestMapper.mapTo(message);
    AuthResponse authResponse = AuthResponse(
      id: const Uuid().v4(),
      thid: request.thid,
      to: request.from,
      from: identifier,
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

  Future<AuthBodyDidDocResponse> _getDidDocResponse(
      String env, String identifier, String pushToken) async {
    String serviceEndpoint = "https://push.polygonid.me/api/v1";
    return AuthBodyDidDocResponse(
      context: ["https://www.w3.org/ns/did/v1"],
      id: "did:iden3:polygon:$env:$identifier",
      service: [
        AuthBodyDidDocServiceResponse(
          id: "did:iden3:polygon:$env:$identifier#push",
          type: "push-notification",
          serviceEndpoint: serviceEndpoint,
          metadata: AuthBodyDidDocServiceMetadataResponse(devices: [
            AuthBodyDidDocServiceMetadataDevicesResponse(
              ciphertext: await _getPushCipherText(pushToken, serviceEndpoint),
              alg: "RSA-OAEP-512",
            )
          ]),
        )
      ],
    );
  }

  Future<String?> _getPushCipherText(
      String pushToken, String serviceEndpoint) async {
    var pushInfo = {
      "app_id":
          "com.polygonid.wallet", // TODO: get bundle identifier of the app
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
      return null;
    }
  }

  @override
  Future<String> getAuthCallback({required Iden3MessageEntity message}) {
    return Future.value(_authRequestMapper.mapTo(message).body.callbackUrl);
  }
}
