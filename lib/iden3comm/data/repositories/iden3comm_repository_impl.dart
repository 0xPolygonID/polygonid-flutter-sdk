import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/proof_response.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../../common/domain/tuples.dart';
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
import '../mappers/proof_response_mapper.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final WalletDataSource _walletDataSource;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final JWZDataSource _jwzDataSource;
  final HexMapper _hexMapper;
  final ProofScopeDataSource _proofScopeDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final AuthResponseMapper _authResponseMapper;
  //final IdentityRepository _identityRepository;
  //final ProofRepository _proofRepository;
  //final CredentialRepository _credentialRepository;

  Iden3commRepositoryImpl(
    this._walletDataSource,
    this._remoteIden3commDataSource,
    this._jwzDataSource,
    this._hexMapper,
    this._proofScopeDataSource,
    this._storageClaimDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._authResponseMapper,
    //this._identityRepository,
    //this._proofRepository,
    //this._credentialRepository,
  );

  /*static const Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };*/

  @override
  Future<bool> authenticate(
      {required AuthRequest authRequest,
      required IdentityEntity identityEntity,
      required CircuitDataEntity authData,
      required List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofList,
      String? pushToken}) async {
    List<ProofResponse> scope = await _getProofResponseList(proofs: proofList);

    String authResponse = await _getAuthResponse(
      identifier: identityEntity.identifier,
      authRequest: authRequest,
      scope: scope,
      pushToken: pushToken,
    );

    String authToken = await getAuthToken(
      identityEntity: identityEntity,
      message: authResponse,
      authData: authData,
    );

    Response res =
        await _remoteIden3commDataSource.authWithToken(authToken, authRequest);
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

  ///
  Future<List<ProofResponse>> _getProofResponseList({
    required List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofs,
  }) async {
    List<ProofResponse> proofResponseScopeList = [];
    if (proofs.isEmpty) {
      return proofResponseScopeList;
    }

    for (Pair<ProofScopeRequest, Map<String, dynamic>> proof in proofs) {
      ProofResponse proofResponse =
          await _getProofResponse(proof.first, proof.second);
      proofResponseScopeList.add(proofResponse);
    }

    return proofResponseScopeList;
  }

  Future<List<ClaimEntity>> _getClaimsFromScope(
      ProofScopeRequest proofReq) async {
    List<FilterEntity> filters = _proofScopeDataSource
        .proofScopeRulesQueryRequestFilters(proofReq.rules!.query!);
    Filter filter = _filtersMapper.mapTo(filters);

    List<ClaimDTO> claimDtoList =
        await _storageClaimDataSource.getClaims(filter: filter);

    List<ClaimEntity> claims =
        claimDtoList.map((claimDTO) => _claimMapper.mapFrom(claimDTO)).toList();
    return claims;
  }

  ///
  Future<ProofResponse> _getProofResponse(
      ProofScopeRequest proofRequest, Map<String, dynamic>? proofResult) async {
    proofResult!["circuit_id"] = proofRequest.circuit_id!;
    proofResult["proof_request_id"] = proofRequest.id!;
    final zkProofResp = ProofResponseMapper().mapFrom(proofResult);
    return Future.value(zkProofResp);
  }

  Future<String> _getAuthResponse({
    required String identifier,
    required AuthRequest authRequest,
    required List<ProofResponse> scope,
    String? pushToken,
  }) async {
    AuthBodyDidDocResponse? didDocResponse;
    if (pushToken != null && pushToken.isNotEmpty) {
      var envAuthResponse = ["main", "mumbai"];
      didDocResponse = await _getDidDocResponse(
          envAuthResponse.first, identifier, pushToken);
    }

    AuthResponse authResponse = AuthResponse(
      id: const Uuid().v4(),
      thid: authRequest.thid,
      to: authRequest.from!,
      from: identifier,
      typ: "application/iden3comm-plain-json",
      type: "https://iden3-communication.io/authorization/1.0/response",
      body: AuthBodyResponse(
        message: authRequest.body?.message,
        scope: scope,
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

  /*@override
  Future<List<Map<String, dynamic>>> getVocabs(
      {required Iden3Message iden3Message}) async {
    List<Pair<String, String>> schemaInfos =
        SchemaInfoMapper().mapFrom(iden3Message);

    List<Map<String, dynamic>> result = [];

    for (Pair<String, String> schemaInfo in schemaInfos) {
      Map<String, dynamic>? schema =
          await _credentialRepository.fetchSchema(url: schemaInfo.first);
      Map<String, dynamic>? vocab = await _credentialRepository.fetchVocab(
          schema: schema, type: schemaInfo.second);
      if (vocab != null) {
        result.add(vocab);
      }
    }
    return result;
  }*/
}
