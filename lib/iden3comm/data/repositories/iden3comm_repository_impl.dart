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
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/proof_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/zk_proof.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/repositories/proof_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../../identity/data/data_sources/jwz_data_source.dart';
import '../../../identity/data/mappers/hex_mapper.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../identity/libs/bjj/privadoid_wallet.dart';
import '../../../proof_generation/data/data_sources/proof_scope_data_source.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../../proof_generation/domain/exceptions/proof_generation_exceptions.dart';
import '../../domain/repositories/iden3comm_repository.dart';
import '../dtos/response/auth/auth_body_did_doc_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_metadata_devices_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_metadata_response.dart';
import '../dtos/response/auth/auth_body_did_doc_service_response.dart';

class Iden3commRepositoryImpl extends Iden3commRepository {
  final WalletDataSource _walletDataSource;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final JWZDataSource _jwzDataSource;
  final HexMapper _hexMapper;
  final AuthRequestMapper _authRequestMapper;
  final ProofScopeDataSource _proofScopeDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final AuthResponseMapper _authResponseMapper;
  final IdentityRepository _identityRepository;
  final ProofRepository _proofRepository;

  Iden3commRepositoryImpl(
    this._walletDataSource,
    this._remoteIden3commDataSource,
    this._jwzDataSource,
    this._hexMapper,
    this._authRequestMapper,
    this._proofScopeDataSource,
    this._storageClaimDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._authResponseMapper,
    this._identityRepository,
    this._proofRepository,
  );

  static const Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };

  @override
  Future<bool> authenticate(
      {required String issuerMessage,
      required String identifier,
      String? pushToken}) async {
    AuthRequest authRequest = _authRequestMapper.mapFrom(issuerMessage);

    List<ProofResponse> scope = await _getProofResponseList(
      scope: authRequest.body?.scope,
      identifier: identifier,
    );

    String authResponse = await _getAuthResponse(
      identifier: identifier,
      authRequest: authRequest,
      scope: scope,
      pushToken: pushToken,
    );

    String authToken = await getAuthToken(
      identifier: identifier,
      message: authResponse,
    );

    Response res =
        await _remoteIden3commDataSource.authWithToken(authToken, authRequest);
    return res.statusCode == 200;
  }

  @override
  Future<String> getAuthToken(
      {required String identifier, required String message}) async {
    CircuitDataEntity authData =
        await _proofRepository.loadCircuitFiles("auth");

    return _identityRepository.getIdentity(identifier: identifier).then(
        (IdentityEntity identityEntity) => _jwzDataSource.getAuthToken(
            privateKey: _hexMapper.mapTo(identityEntity.privateKey),
            authClaim: identityEntity.authClaim,
            message: message,
            circuitId: authData.circuitId,
            datFile: authData.datFile,
            zKeyFile: authData.zKeyFile));
  }

  ///
  Future<List<ProofResponse>> _getProofResponseList({
    List<ProofScopeRequest>? scope,
    required String identifier,
  }) async {
    List<ProofResponse> proofResponseScopeList = [];
    if (scope == null || scope.isEmpty) {
      return proofResponseScopeList;
    }

    List<ProofScopeRequest> proofScopeRequestList =
        _proofScopeDataSource.filteredProofScopeRequestList(scope);

    for (ProofScopeRequest proofReq in proofScopeRequestList) {
      List<FilterEntity> filters = _proofScopeDataSource
          .proofScopeRulesQueryRequestFilters(proofReq.rules!.query!);
      Filter filter = _filtersMapper.mapTo(filters);

      List<ClaimDTO> claimDtoList =
          await _storageClaimDataSource.getClaims(filter: filter);

      List<ClaimEntity> claims = claimDtoList
          .map((claimDTO) => _claimMapper.mapFrom(claimDTO))
          .toList();

      if (claims.isNotEmpty) {
        CircuitDataEntity circuit =
            await _proofRepository.loadCircuitFiles(proofReq.circuit_id!);

        ClaimEntity authClaim = claims.first;

        ProofResponse proofResponse =
            await _getProofResponse(proofReq, identifier, circuit, authClaim);
        proofResponseScopeList.add(proofResponse);
      }
    }

    return proofResponseScopeList;
  }

  ///
  Future<ProofResponse> _getProofResponse(
      ProofScopeRequest proofRequest,
      String identifier,
      CircuitDataEntity circuit,
      ClaimEntity authClaim) async {
    String field = "";
    List<int> values = [];
    int operator = 0;
    String circuitId = proofRequest.circuit_id!;
    String claimType = proofRequest.rules!.query!.schema!.type!;

    String challenge = proofRequest.id.toString();

    if (proofRequest.rules!.query!.req != null) {
      if (proofRequest.rules!.query!.req!.length > 1) {}

      proofRequest.rules!.query!.req!.forEach((key1, val1) {
        field = key1;

        if (val1.length > 1) {}

        val1.forEach((key2, val2) {
          operator = _queryOperators[key2]!;
          if (val2 is List<dynamic>) {
            values = val2.cast<int>();
          } else if (val2 is int) {
            values = [val2];
          }
        });
      });
    }

    CredentialDTO credential = CredentialDTO.fromJson(authClaim.credential);

    IdentityEntity identity =
        await _identityRepository.getIdentity(identifier: identifier);

    PrivadoIdWallet wallet = await _walletDataSource.createWallet(
        privateKey: HexUtils.hexToBytes(identity.privateKey));

    String? signatureString;
    try {
      signatureString = await _identityRepository.signMessage(
          identifier: identifier, message: challenge);
    } catch (_) {}

    Uint8List? inputsJsonBytes =
        await _proofRepository.calculateAtomicQueryInputs(
      challenge,
      credential,
      circuitId,
      claimType,
      field,
      values,
      operator,
      credential.credentialStatus.id,
      wallet.publicKey[0],
      wallet.publicKey[1],
      signatureString,
    );

    if (inputsJsonBytes == null) {
      throw NullAtomicQueryInputsException(circuit.circuitId);
    }

    // 2. Calculate witness
    Uint8List? wtnsBytes =
        await _proofRepository.calculateWitness(circuit, inputsJsonBytes!);

    if (wtnsBytes == null) {
      throw NullWitnessException(circuit.circuitId);
    }

    // 4. generate proof
    Map<String, dynamic>? proofResult =
        await _proofRepository.prove(circuit, wtnsBytes);

    // TODO: how does this work ??? proofResult!["proof"];
    Map<String, dynamic> proof = proofResult!["proof"];
    final zkproof = ZKProof.fromJson(proof);
    final zkProofResp = ProofResponse(
        proof: zkproof,
        pubSignals: proofResult["pub_signals"],
        circuitId: proofRequest.circuit_id!,
        id: proofRequest.id!);

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
}
