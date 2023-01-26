import 'dart:convert';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/private_identity_entity.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/lib_pidcore_identity_data_source.dart';
import '../data_sources/local_contract_files_data_source.dart';
import '../data_sources/remote_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/hash_dto.dart';
import '../dtos/identity_dto.dart';
import '../dtos/node_dto.dart';
import '../mappers/did_mapper.dart';
import '../mappers/hash_mapper.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/node_mapper.dart';
import '../mappers/poseidon_hash_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';
import '../mappers/state_identifier_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final LocalClaimDataSource _localClaimDataSource;
  final LibBabyJubJubDataSource _libBabyJubJubDataSource;
  final LibPolygonIdCoreIdentityDataSource _libPolygonIdCoreIdentityDataSource;
  final SMTDataSource _smtDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  final StateIdentifierMapper _stateIdentifierMapper;
  final NodeMapper _nodeMapper;
  final DidMapper _didMapper;
  final PoseidonHashMapper _poseidonHashMapper;
  final HashMapper _hashMapper;
  final QMapper _qMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._localClaimDataSource,
    this._libBabyJubJubDataSource,
    this._libPolygonIdCoreIdentityDataSource,
    this._smtDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
    this._stateIdentifierMapper,
    this._nodeMapper,
    this._didMapper,
    this._poseidonHashMapper,
    this._hashMapper,
    this._qMapper,
  );

  Future<void> checkIdentityValidity(
      {required blockchain,
        required network,
        String? secret,
        required String accessMessage}) async {
    // Create a wallet
    PrivadoIdWallet wallet = await _walletDataSource.createWallet(
        secret: _privateKeyMapper.mapFrom(secret),
        accessMessage: accessMessage);
    String privateKey = _hexMapper.mapFrom(wallet.privateKey);

    String did = await getDidIdentifier(
      blockchain: blockchain,
      network: network,
      privateKey: privateKey,
    );
  }

  /// Get a [PrivateIdentityEntity] from a String secret
  /// It will create a new [PrivateIdentity]
  ///
  /// @return the associated identifier
  @override
  Future<PrivateIdentityEntity> createIdentity(
      {required blockchain,
      required network,
      String? secret,
      required String accessMessage}) async {
    try {
      PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          secret: _privateKeyMapper.mapFrom(secret),
          accessMessage: accessMessage);
      String privateKey = _hexMapper.mapFrom(wallet.privateKey);

      String did = await getDidIdentifier(
        blockchain: blockchain,
        network: network,
        privateKey: privateKey,
      );

      Map<String, dynamic> treeState = await _createIdentityState(
          did: did, privateKey: privateKey, publicKey: wallet.publicKey);

      PrivateIdentityEntity identityEntity = _identityDTOMapper.mapPrivateFrom(
          IdentityDTO(
              did: did, publicKey: wallet.publicKey, profiles: {0: did}),
          _hexMapper.mapFrom(wallet.privateKey));
      return Future.value(identityEntity);
    } catch (error) {
      return Future.error(IdentityException(error));
    }
  }

  Future<Map<String, dynamic>> _createIdentityState(
      {required String did,
      required String privateKey,
      required List<String> publicKey}) async {
    // 1. initialize merkle trees
    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: claimsTreeStoreName,
        did: did,
        privateKey: privateKey);

    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: revocationTreeStoreName,
        did: did,
        privateKey: privateKey);

    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: rootsTreeStoreName,
        did: did,
        privateKey: privateKey);

    // 2. add authClaim to claims tree
    List<String> authClaimChildren =
        await _localClaimDataSource.getAuthClaim(publicKey: publicKey);
    NodeEntity authClaimNode =
        await getAuthClaimNode(children: authClaimChildren);
    /*List<String> authClaimChildren =
        await _getAuthClaimChildren(publicKey: publicKey);*/

    HashDTO claimsTreeRoot = await _smtDataSource.addLeaf(
        newNodeLeaf: _nodeMapper.mapTo(authClaimNode),
        storeName: claimsTreeStoreName,
        did: did,
        privateKey: privateKey);

    // hash of clatr, revtr, rootr
    String genesisState = await _libBabyJubJubDataSource.hashPoseidon3(
        claimsTreeRoot.toString(),
        BigInt.zero.toString(),
        BigInt.zero.toString());

    Map<String, dynamic> treeState = {};
    treeState["state"] = genesisState;
    treeState["claimsRoot"] = claimsTreeRoot.toString();
    treeState["revocationRoot"] = BigInt.zero.toString();
    treeState["rootOfRoots"] = BigInt.zero.toString();
    return treeState;
  }

  Future<Map<String, dynamic>> _getGenesisState(
      {required List<String> publicKey}) async {
    List<String> authClaimChildren =
        await _localClaimDataSource.getAuthClaim(publicKey: publicKey);
    NodeEntity authClaimNode =
        await getAuthClaimNode(children: authClaimChildren);
    HashDTO claimsTreeRoot = _nodeMapper.mapTo(authClaimNode).hash;

    // hash of clatr, revtr, rootr
    String genesisState = await _libBabyJubJubDataSource.hashPoseidon3(
        claimsTreeRoot.toString(),
        BigInt.zero.toString(),
        BigInt.zero.toString());

    Map<String, dynamic> treeState = {};
    treeState["state"] = genesisState;
    treeState["claimsRoot"] = claimsTreeRoot.toString();
    treeState["revocationRoot"] = BigInt.zero.toString();
    treeState["rootOfRoots"] = BigInt.zero.toString();
    return treeState;
  }

  @override
  Future<Map<String, dynamic>> getLatestState({
    required String did,
    required String privateKey,
  }) async {
    HashDTO claimsTreeRoot = await _smtDataSource.getRoot(
        storeName: claimsTreeStoreName, did: did, privateKey: privateKey);

    HashDTO revocationTreeRoot = await _smtDataSource.getRoot(
        storeName: revocationTreeStoreName, did: did, privateKey: privateKey);

    HashDTO rootsTreeRoot = await _smtDataSource.getRoot(
        storeName: rootsTreeStoreName, did: did, privateKey: privateKey);

    // hash of clatr, revtr, rootr
    String state = await _libBabyJubJubDataSource.hashPoseidon3(
        claimsTreeRoot.toString(),
        revocationTreeRoot.toString(),
        rootsTreeRoot.toString());

    // TODO: convert to dto
    Map<String, dynamic> treeState = {};
    treeState["state"] = state;
    treeState["claimsRoot"] = claimsTreeRoot.toString();
    treeState["revocationRoot"] = revocationTreeRoot.toString();
    treeState["rootOfRoots"] = rootsTreeRoot.toString();
    return treeState;
  }

  @override
  Future<NodeEntity> getAuthClaimNode({required List<String> children}) async {
    String hashIndex = await _libBabyJubJubDataSource.hashPoseidon4(
      children[0],
      children[1],
      children[2],
      children[3],
    );
    String hashValue = await _libBabyJubJubDataSource.hashPoseidon4(
      children[4],
      children[5],
      children[6],
      children[7],
    );
    String hashClaimNode = await _libBabyJubJubDataSource.hashPoseidon3(
        hashIndex, hashValue, BigInt.one.toString());
    NodeDTO authClaimNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.parse(hashIndex)),
          HashDTO.fromBigInt(BigInt.parse(hashValue)),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(hashClaimNode)),
        type: NodeTypeDTO.leaf);
    return _nodeMapper.mapFrom(authClaimNode);
  }

  @override
  Future<void> storeIdentity({required IdentityEntity identity}) {
    return Future.value(_identityDTOMapper.mapTo(identity)).then((dto) =>
        _storageIdentityDataSource
            .storeIdentity(did: identity.did, identity: dto)
            .catchError((error) => throw IdentityException(error)));
  }

  /// Get an [IdentityEntity] from an identifier
  /// The [IdentityEntity] is the one previously stored and associated to the identifier
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<IdentityEntity> getIdentity({required String did}) {
    return _storageIdentityDataSource
        .getIdentity(did: did)
        .then((dto) => _identityDTOMapper.mapFrom(dto))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  /// Get an [PrivateIdentityEntity] from an [DidEntity] and a privateKey
  /// The [PrivateIdentityEntity] is the one previously stored and associated to the identifier
  /// And we and the private info (privateKey and authClaim)
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required DidEntity did, required String privateKey}) {
    return _storageIdentityDataSource
        .getIdentity(did: did.did)
        .then((dto) async {
      var didFromKey = await getDidIdentifier(
          privateKey: privateKey,
          blockchain: did.blockchain,
          network: did.network);

      if (didFromKey != did.did) {
        throw InvalidPrivateKeyException(privateKey);
      }

      return _identityDTOMapper.mapPrivateFrom(dto, privateKey);
    }).catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  @override
  Future<void> removeIdentity({required String did}) {
    return _storageIdentityDataSource.removeIdentity(did: did);
  }

  /// Sign a message through a privateKey
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String privateKey, required String message}) {
    return _walletDataSource
        .signMessage(privateKey: _hexMapper.mapTo(privateKey), message: message)
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<String> getState(
      {required String identifier, required String contractAddress}) {
    return _localContractFilesDataSource
        .loadStateContract(contractAddress)
        .then((contract) => _rpcDataSource
            .getState(_stateIdentifierMapper.mapTo(identifier), contract)
            .catchError((error) => throw FetchIdentityStateException(error)));
  }

  @override
  Future<RhsNodeEntity> getStateRoots({required String url}) {
    return _remoteIdentityDataSource
        .fetchStateRoots(url: url)
        .then((dto) => _rhsNodeMapper.mapFrom(dto))
        .catchError((error) => throw FetchStateRootsException(error));
  }

  @override
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required int nonce,
      required String baseUrl}) {
    return _remoteIdentityDataSource
        .getNonRevocationProof(identityState, nonce, baseUrl)
        .catchError((error) => throw NonRevProofException(error));
  }

  @override
  Future<String> getDidIdentifier({
    required String privateKey,
    required String blockchain,
    required String network,
  }) {
    return _walletDataSource
        .getWallet(privateKey: _hexMapper.mapTo(privateKey))
        .then((wallet) =>
            _getGenesisState(publicKey: wallet.publicKey).then((genesisState) {
              // Get the genesis id
              String genesisId =
                  _libPolygonIdCoreIdentityDataSource.calculateGenesisId(
                      genesisState["claimsRoot"], blockchain, network);

              Map<String, dynamic> genesis = jsonDecode(genesisId);

              return Future.value(genesis["did"]);
            }));
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }

  @override
  Future<String> getChallenge({required String message}) {
    return Future.value(_qMapper.mapFrom(message))
        .then((q) => _libBabyJubJubDataSource.hashPoseidon(q));
  }

  @override
  Future<String> convertIdToBigInt({required String id}) {
    String idBigInt = _libPolygonIdCoreIdentityDataSource.genesisIdToBigInt(id);
    return Future.value(idBigInt);
  }
}
