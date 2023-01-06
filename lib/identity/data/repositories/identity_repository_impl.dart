import 'dart:convert';
import 'dart:core';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';

import '../../../credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import '../../../credential/data/data_sources/local_claim_data_source.dart';
import '../../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart';
import '../../../proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import '../../../proof/data/dtos/proof_dto.dart';
import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/node_entity.dart';
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
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/node_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';
import '../mappers/state_identifier_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibBabyJubJubDataSource _libBabyJubJubDataSource;
  final LibPolygonIdCoreIdentityDataSource _libPolygonIdCoreIdentityDataSource;
  final LibPolygonIdCoreCredentialDataSource
      _libPolygonIdCoreCredentialDataSource;
  final LibPolygonIdCoreIden3commDataSource
      _libPolygonIdCoreIden3commDataSource;
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;

  final SMTDataSource _smtDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final LocalClaimDataSource _localClaimDataSource;
  final HexMapper _hexMapper;
  //final BigIntMapper _bigIntMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  final NodeMapper _nodeMapper;
  final StateIdentifierMapper _stateIdentifierMapper;
  final DidMapper _didMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libBabyJubJubDataSource,
    this._libPolygonIdCoreIdentityDataSource,
    this._libPolygonIdCoreCredentialDataSource,
    this._libPolygonIdCoreIden3commDataSource,
    this._libPolygonIdCoreProofDataSource,
    this._smtDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._localClaimDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
    this._nodeMapper,
    this._stateIdentifierMapper,
    this._didMapper,
  );

  /// https://go.dev/play/p/L3No4mMLwJv
  Future<void> testSMT() async {
    PrivadoIdWallet wallet = await _walletDataSource.getWallet(
        privateKey: _hexMapper.mapTo(
            "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f"));
    //user "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f"));
    //issuer "21a5e7321d0e2f3ca1cc6504396e6594a2211544b08c206847cdee96f832421a"
    String dbIdentifier = wallet.publicKeyBase64!;
    String privateKey = _hexMapper.mapFrom(wallet.privateKey);
    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    /// 1

    String exampleOneOne = await _libBabyJubJubDataSource.hashPoseidon3(
        BigInt.one.toString(), BigInt.one.toString(), BigInt.one.toString());
    NodeDTO oneNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.one),
          HashDTO.fromBigInt(BigInt.one),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(exampleOneOne)),
        type: NodeTypeDTO.leaf);
    HashDTO claimsTreeRoot = await _smtDataSource.addLeaf(
        newNodeLeaf: oneNode,
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO proof = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.one),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO nonExistProof = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(100)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    /// 2
    String exampleTwoTwo = await _libBabyJubJubDataSource.hashPoseidon3(
      HashDTO.fromBigInt(BigInt.from(2)).toString(),
      HashDTO.fromBigInt(BigInt.from(2)).toString(),
      BigInt.one.toString(),
    );

    NodeDTO twoNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.from(2)),
          HashDTO.fromBigInt(BigInt.from(2)),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(exampleTwoTwo)),
        type: NodeTypeDTO.leaf);
    HashDTO claimsTreeRoot2 = await _smtDataSource.addLeaf(
        newNodeLeaf: twoNode,
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO proof2 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(2)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO nonExistProof2 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(100)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    /// 3

    String exampleThreeThree = await _libBabyJubJubDataSource.hashPoseidon3(
      HashDTO.fromBigInt(BigInt.from(3)).toString(),
      HashDTO.fromBigInt(BigInt.from(3)).toString(),
      BigInt.one.toString(),
    );

    NodeDTO threeNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.from(3)),
          HashDTO.fromBigInt(BigInt.from(3)),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(exampleThreeThree)),
        type: NodeTypeDTO.leaf);
    HashDTO claimsTreeRoot3 = await _smtDataSource.addLeaf(
        newNodeLeaf: threeNode,
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO proof3 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(3)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO nonExistProof3 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(100)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    /// 4

    String exampleFourFour = await _libBabyJubJubDataSource.hashPoseidon3(
      HashDTO.fromBigInt(BigInt.from(4)).toString(),
      HashDTO.fromBigInt(BigInt.from(4)).toString(),
      BigInt.one.toString(),
    );

    NodeDTO fourNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.from(4)),
          HashDTO.fromBigInt(BigInt.from(4)),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(exampleFourFour)),
        type: NodeTypeDTO.leaf);
    HashDTO claimsTreeRoot4 = await _smtDataSource.addLeaf(
        newNodeLeaf: fourNode,
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO proof4 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(4)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);

    ProofDTO nonExistProof4 = await _smtDataSource.generateProof(
        key: HashDTO.fromBigInt(BigInt.from(100)),
        storeName: claimsTreeStoreName,
        identifier: dbIdentifier,
        privateKey: privateKey);
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
      // Create a wallet
      PrivadoIdWallet wallet = await _walletDataSource.getWallet(
          privateKey: _hexMapper.mapTo(
              "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f"));
      /*PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          secret: _privateKeyMapper.mapFrom(secret),
          accessMessage: accessMessage);*/
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
        identifier: did,
        privateKey: privateKey);

    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: revocationTreeStoreName,
        identifier: did,
        privateKey: privateKey);

    await _smtDataSource.createSMT(
        maxLevels: 32,
        storeName: rootsTreeStoreName,
        identifier: did,
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
        identifier: did,
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
        storeName: claimsTreeStoreName,
        identifier: did,
        privateKey: privateKey);

    HashDTO revocationTreeRoot = await _smtDataSource.getRoot(
        storeName: revocationTreeStoreName,
        identifier: did,
        privateKey: privateKey);

    HashDTO rootsTreeRoot = await _smtDataSource.getRoot(
        storeName: rootsTreeStoreName, identifier: did, privateKey: privateKey);

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

  /*Future<String> _getAuthInputs({
    required NodeDTO authClaim,
    required List<String> authClaimChildren,
    required String challenge,
    required String did,
    required String privateKey,
  }) async {
    String challenge = "10";
    String signature = await _walletDataSource.signMessage(
        privateKey: _hexMapper.mapTo(privateKey), message: challenge);

    ProofDTO proof = await _smtDataSource.generateProof(
        key: authClaim
            .hash, //authClaim.children[0]??? //HashDTO.fromBigInt(BigInt.parse(hashIndex)),
        storeName: claimsTreeStoreName,
        identifier: did,
        privateKey: privateKey);

    ProofDTO nonRevProof = await _smtDataSource.generateProof(
        key: authClaim.hash,
        storeName: revocationTreeStoreName,
        identifier: did,
        privateKey: privateKey);

    // hash of clatr, revtr, rootr
    Map<String, dynamic> treeState =
        await getLatestState(did: did, privateKey: privateKey);

    var didMap = _didMapper.mapFrom(did);
    String idBigInt = _libPolygonIdCoreIdentityDataSource
        .genesisIdToBigInt(didMap.identifier);

    String gistProofSC = await getGistProof(
      identifier:
          idBigInt, // "21051438350758615910194871316894294942737671344817514009731719137348227585", //genesis["id"] as big int
      contractAddress: "0x6811f4b44354C29993f8088c4D38B61018C5338d",
    );

    String gistProof =
        _libPolygonIdCoreProofDataSource.proofFromSC(gistProofSC);

    String authInputs = _libPolygonIdCoreIden3commDataSource.getAuthInputs(
        did: did,
        profileNonce: 0,
        authClaim: authClaimChildren,
        incProof: {
          "existence": proof.existence,
          "siblings":
              proof.siblings.map((hashDTO) => hashDTO.toString()).toList()
        },
        nonRevProof: {
          "existence": nonRevProof.existence,
          "siblings":
              nonRevProof.siblings.map((hashDTO) => hashDTO.toString()).toList()
        },
        gistProof: jsonDecode(gistProof),
        treeState: treeState,
        challenge: challenge,
        signature: signature);
    return authInputs;
  }*/

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
  Future<void> storeIdentity(
      {required IdentityEntity identity, required String privateKey}) async {
    try {
      var didMap = _didMapper.mapFrom(identity.did);
      PrivadoIdWallet wallet = await _walletDataSource.getWallet(
          privateKey: _hexMapper.mapTo(privateKey));
      String did = await getDidIdentifier(
          privateKey: privateKey,
          blockchain: didMap.blockchain,
          network: didMap.network);
      if (did == identity.did) {
        IdentityDTO dto = _identityDTOMapper.mapTo(identity);
        await _storageIdentityDataSource.storeIdentity(did: did, identity: dto);
        IdentityEntity identityEntity = _identityDTOMapper.mapFrom(dto);
      } else {
        throw InvalidPrivateKeyException(privateKey);
      }
    } catch (error) {
      return Future.error(IdentityException(error));
    }
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

  /// Get an [PrivateIdentityEntity] from an identifier and a privateKey
  /// The [PrivateIdentityEntity] is the one previously stored and associated to the identifier
  /// And we and the private info (privateKey and authClaim)
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required String did, required String privateKey}) {
    var didMap = _didMapper.mapFrom(did);
    return _storageIdentityDataSource.getIdentity(did: did).then((dto) async {
      var didFromKey = await getDidIdentifier(
          privateKey: privateKey,
          blockchain: didMap.blockchain,
          network: didMap.network);

      if (didFromKey != did) {
        throw InvalidPrivateKeyException(privateKey);
      }

      return _identityDTOMapper.mapPrivateFrom(dto, privateKey);
    }).catchError((error) => throw IdentityException(error),
        test: (error) => error is! UnknownIdentityException);
  }

  @override
  Future<void> removeIdentity(
      {required String identifier, required String privateKey}) {
    return _storageIdentityDataSource.removeIdentity(did: identifier);
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
  }) async {
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
  Future<String> convertIdToBigInt({required String id}) {
    String idBigInt = _libPolygonIdCoreIdentityDataSource.genesisIdToBigInt(id);
    return Future.value(idBigInt);
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }
}
