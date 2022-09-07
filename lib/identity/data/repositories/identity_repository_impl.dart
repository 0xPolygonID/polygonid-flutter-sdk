import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_credential.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/proof_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/zk_proof.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/proof_scope_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/prover_lib_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/witness_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../domain/entities/identity_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/jwz_data_source.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/storage_key_value_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/identity_dto.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/private_key_mapper.dart';

enum SupportedCircuits { mtp, sig }

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final StorageKeyValueDataSource _storageKeyValueDataSource;
  final JWZDataSource _jwzDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final AuthRequestMapper _authRequestMapper;
  final ProofScopeDataSource _proofScopeDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final AuthResponseMapper _authResponseMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libIdentityDataSource,
    this._storageIdentityDataSource,
    this._storageKeyValueDataSource,
    this._jwzDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._remoteIdentityDataSource,
    this._authRequestMapper,
    this._proofScopeDataSource,
    this._storageClaimDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._witnessDataSource,
    this._proverLibDataSource,
    this._authResponseMapper,
  );

  static const Map<SupportedCircuits, String> _supportedCircuits = {
    SupportedCircuits.mtp: "credentialAtomicQueryMTP",
    SupportedCircuits.sig: "credentialAtomicQuerySig",
  };

  static const Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };

  /// Get an identifier from a String
  /// It will create and store a new [IdentityDTO] if it doesn't exists
  ///
  /// @return the associated identifier
  @override
  Future<String> createIdentity({String? privateKey}) async {
    try {
      // Create a wallet
      PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          privateKey: _privateKeyMapper.mapFrom(privateKey));

      // Get the associated identifier
      String identifier = await _libIdentityDataSource.getIdentifier(
          pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]);

      // Store the identity
      await _libIdentityDataSource
          .getAuthClaim(pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
          .then((authClaim) {
        IdentityDTO dto = IdentityDTO(
            privateKey: _hexMapper.mapFrom(wallet.privateKey),
            identifier: identifier,
            authClaim: authClaim);

        return _storageIdentityDataSource
            .storeIdentity(identifier: identifier, identity: dto)
            .then((_) => dto);
      });

      // Return the identifier
      return Future.value(identifier);
    } catch (error) {
      throw IdentityException(error);
    }
  }

  /// Get an [IdentityEntity] from a String
  ///
  /// Used for retro compatibility with demo
  @override
  Future<IdentityEntity> getIdentityFromKey({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey)).then((key) =>
        _walletDataSource
            .createWallet(privateKey: key)
            .then((wallet) => Future.wait([
                  _libIdentityDataSource.getIdentifier(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  _libIdentityDataSource.getAuthClaim(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
                ]).then((values) => IdentityEntity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: values[0],
                    authClaim: values[1])))
            .catchError((error) => throw IdentityException(error)));
  }

  /// Get an [IdentityEntity] from an identifier
  /// The [IdentityEntity] is the one previously stored and associated to the identifier
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<IdentityEntity> getIdentity({required String identifier}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _identityDTOMapper.mapFrom(dto))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  /// Sign a message through an identifier
  /// The [identifier] must be one returned previously by [createIdentity]
  /// so the [IdentityDTO] is known and stored
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String identifier, required String message}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _walletDataSource.signMessage(
            privateKey: _hexMapper.mapTo(dto.privateKey), message: message))
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<String?> getCurrentIdentifier() {
    return _storageKeyValueDataSource
        .get(key: currentIdentifierKey)
        .then((value) => value == null ? null : value as String);
  }

  @override
  Future<void> removeIdentity({required String identifier}) {
    return _storageIdentityDataSource.removeIdentity(identifier: identifier);
  }

  @override
  Future<String> getAuthToken(
      {required String identifier,
      required CircuitDataEntity circuitData,
      required String message}) {
    return _storageIdentityDataSource.getIdentity(identifier: identifier).then(
        (dto) => _jwzDataSource.getAuthToken(
            privateKey: _hexMapper.mapTo(dto.privateKey),
            authClaim: dto.authClaim,
            message: message,
            circuitId: circuitData.circuitId,
            datFile: circuitData.datFile,
            zKeyFile: circuitData.zKeyFile));
  }

  /// Get an identifier from a [privateKey]
  @override
  Future<String> getIdentifier({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey))
        .then((key) => // Create a wallet from the private key
            _walletDataSource.createWallet(privateKey: key))
        .then((wallet) => // Get the associated identifier
            _libIdentityDataSource.getIdentifier(
                pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]));
  }

  @override
  Future<void> authenticate({
    required String issuerMessage,
    required CircuitDataEntity circuitDataEntity,
    required String identifier,
  }) async {
    IdentityDTO identity =
        await _storageIdentityDataSource.getIdentity(identifier: identifier!);

    String privateKey = identity.privateKey;

    AuthRequest authRequest = _authRequestMapper.mapFrom(issuerMessage);

    List<ProofResponse> scope = await _getProofResponseList(
        scope: authRequest.body?.scope,
        privateKey: privateKey,
        circuit: circuitDataEntity);

    String authResponse = _getAuthResponse(
      identifier: identifier,
      privateKey: privateKey,
      authRequest: authRequest,
      circuitDataEntity: circuitDataEntity,
      scope: scope,
    );

    String authToken = await getAuthToken(
        identifier: identifier,
        circuitData: circuitDataEntity,
        message: authResponse);

    await _remoteIdentityDataSource.authWithToken(authToken, authRequest);
  }

  ///
  Future<List<ProofResponse>> _getProofResponseList({
    List<ProofScopeRequest>? scope,
    required String privateKey,
    required CircuitDataEntity circuit,
  }) async {
    List<ProofResponse> proofResponseScopeList = [];
    if (scope == null) return proofResponseScopeList;

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
        ClaimEntity authClaim = claims.first;
        ProofResponse proofResponse =
            await _getProofResponse(proofReq, privateKey, circuit, authClaim);
        proofResponseScopeList.add(proofResponse);
      }
    }

    return proofResponseScopeList;
  }

  ///
  Future<ProofResponse> _getProofResponse(
      ProofScopeRequest proofRequest,
      String privateKey,
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

    /// FIXME: remove the usage of [CredentialData]
    CredentialData credentialData = CredentialData(
        issuer: authClaim.issuer,
        identifier: authClaim.identifier,
        credential: CredentialCredential.fromJson(authClaim.credential));

    PrivadoIdWallet wallet = await _walletDataSource.createWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String? signatureString;
    try {
      signatureString = await _walletDataSource.signMessage(
          privateKey: HexUtils.hexToBytes(privateKey), message: challenge);
    } catch (_) {}

    String? res = await _libIdentityDataSource.prepareAtomicQueryInputs(
      challenge,
      privateKey,
      credentialData,
      circuitId,
      claimType,
      field,
      values,
      operator,
      credentialData.credential!.credentialStatus!.id!,
      wallet.publicKey[0],
      wallet.publicKey[1],
      signatureString,
    );

    Map<String, dynamic>? inputs = res != null ? json.decode(res) : null;

    Uint8List inputsJsonBytes =
        Uint8ArrayUtils.uint8ListfromString(json.encode(inputs));

    // 2. Calculate witness
    Uint8List? wtnsBytes = await _calculateWitness(circuit, inputsJsonBytes);

    if (wtnsBytes == null) {
      throw NullWitnessException(circuit.circuitId);
    }

    // 4. generate proof
    Map<String, dynamic>? proofResult =
        await _proverLibDataSource.prover(circuit.zKeyFile, wtnsBytes);

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

  ///
  Future<Uint8List?> _calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List inputsJsonBytes,
  ) async {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: inputsJsonBytes);
    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.mtp]) {
      return await _witnessDataSource.computeWitnessMtp(witnessParam);
    }

    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.sig]) {
      return await _witnessDataSource.computeWitnessSig(witnessParam);
    }

    return null;
  }

  String _getAuthResponse({
    required String identifier,
    required String privateKey,
    required AuthRequest authRequest,
    required CircuitDataEntity circuitDataEntity,
    required List<ProofResponse> scope,
  }) {
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
        did_doc: null, //TODO @Raul is it right, we don't have pushToken here?
      ),
    );
    return _authResponseMapper.mapFrom(authResponse);
  }
}
