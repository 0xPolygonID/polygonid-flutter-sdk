import 'dart:convert';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';

import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/private_identity_entity.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/local_contract_files_data_source.dart';
import '../data_sources/remote_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/hash_dto.dart';
import '../dtos/identity_dto.dart';
import '../dtos/node_dto.dart';
import '../dtos/proof_dto.dart';
import '../mappers/did_mapper.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';
import '../mappers/state_identifier_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final LibBabyJubJubDataSource _libBabyJubJubDataSource;
  final LibPolygonIdCoreDataSource _libPolygonIdCoreDataSource;
  final SMTDataSource _smtDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final HexMapper _hexMapper;
  //final BigIntMapper _bigIntMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  final StateIdentifierMapper _stateIdentifierMapper;
  final DidMapper _didMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libIdentityDataSource,
    this._libBabyJubJubDataSource,
    this._libPolygonIdCoreDataSource,
    this._smtDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
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
  Future<PrivateIdentityEntity> createIdentity({String? secret}) async {
    try {
      // Create a wallet
      //PrivadoIdWallet wallet = await _walletDataSource.createWallet(
      //secret: _privateKeyMapper.mapFrom(
      //    "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f")*/
      //);
      PrivadoIdWallet wallet = await _walletDataSource.getWallet(
          privateKey: _hexMapper.mapTo(
              "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f"));
      //user "28156abe7fe2fd433dc9df969286b96666489bac508612d0e16593e944c4f69f"));
      //issuer "21a5e7321d0e2f3ca1cc6504396e6594a2211544b08c206847cdee96f832421a"
      String dbIdentifier = wallet.publicKeyBase64!;
      String privateKey = _hexMapper.mapFrom(wallet.privateKey);

      String challenge = "10";
      String signature = await _walletDataSource.signMessage(
          privateKey: wallet.privateKey, message: challenge);

      // initialize merkle trees
      await _smtDataSource.createSMT(
          maxLevels: 32,
          storeName: claimsTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      await _smtDataSource.createSMT(
          maxLevels: 32,
          storeName: revocationTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      await _smtDataSource.createSMT(
          maxLevels: 32,
          storeName: rootsTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      // Get the associated claimsTreeRoot
      //String claimsTreeRoot = await _libIdentityDataSource.getClaimsTreeRoot(
      //    pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]);

      String authClaimSchema = "ca938857241db9451ea329256b9c06e5";
      String authClaimNonce = "15930428023331155902";
      String authClaim = _libPolygonIdCoreDataSource.issueClaim(
          schema: authClaimSchema,
          nonce: authClaimNonce,
          pubX: wallet.publicKey[0],
          pubY: wallet.publicKey[1]);
      List<String> children = List.from(jsonDecode(authClaim));
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
      HashDTO claimsTreeRoot = await _smtDataSource.addLeaf(
          newNodeLeaf: authClaimNode,
          storeName: claimsTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      ProofDTO proof = await _smtDataSource.generateProof(
          key: HashDTO.fromBigInt(BigInt.parse(hashIndex)),
          storeName: claimsTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      ProofDTO nonRevProof = await _smtDataSource.generateProof(
          key: HashDTO.fromBigInt(BigInt.parse(hashIndex)),
          storeName: revocationTreeStoreName,
          identifier: dbIdentifier,
          privateKey: privateKey);

      // hash of clatr, revtr, rootr
      String genesisState = await _libBabyJubJubDataSource.hashPoseidon3(
          hashClaimNode, BigInt.zero.toString(), BigInt.zero.toString());

      Map<String, dynamic> treeState = {};
      treeState["state"] = genesisState;
      treeState["claimsRoot"] = hashClaimNode;
      treeState["revocationRoot"] = BigInt.zero.toString();
      treeState["rootOfRoots"] = BigInt.zero.toString();
      // Get the genesis id

      String genesisId = await getGenesisId(
        claimsTreeRoot: claimsTreeRoot.toString(),
        blockchain: "polygon",
        network: "mumbai",
      );

      Map<String, dynamic> genesis = jsonDecode(genesisId);

      String authInputs = _libPolygonIdCoreDataSource.getAuthInputs(
          id: genesis["id"],
          profileNonce: 0,
          authClaim: children,
          incProof: {
            "existence": proof.existence,
            "siblings":
                proof.siblings.map((hashDTO) => hashDTO.toString()).toList()
          },
          nonRevProof: {
            "existence": nonRevProof.existence,
            "siblings": nonRevProof.siblings
                .map((hashDTO) => hashDTO.toString())
                .toList()
          },
          treeState: treeState,
          challenge: challenge,
          signature: signature);

      PrivateIdentityEntity identityEntity = _identityDTOMapper.mapPrivateFrom(
          IdentityDTO(identifier: genesisId, publicKey: wallet.publicKey),
          _hexMapper.mapFrom(wallet.privateKey));
      return Future.value(identityEntity);
    } catch (error) {
      return Future.error(IdentityException(error));
    }
  }

  @override
  Future<String> getGenesisId({
    required String claimsTreeRoot,
    required String blockchain,
    required String network,
  }) async {
    // Create a wallet
    //PrivadoIdWallet wallet = await _walletDataSource.getWallet(
    //    privateKey: _hexMapper.mapTo(privateKey));

    String genesisId = _libPolygonIdCoreDataSource.calculateGenesisId(
        claimsTreeRoot, blockchain, network);

    return genesisId;
  }

  @override
  Future<void> storeIdentity(
      {required IdentityEntity identity, required String privateKey}) async {
    try {
      String identifier = await getIdentifier(privateKey: privateKey);
      if (identifier == identity.identifier) {
        IdentityDTO dto = _identityDTOMapper.mapTo(identity);
        await _storageIdentityDataSource.storeIdentity(
            identifier: identifier, identity: dto);
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
  Future<IdentityEntity> getIdentity({required String identifier}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
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
      {required String identifier, required String privateKey}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _walletDataSource
            .getWallet(privateKey: _hexMapper.mapTo(privateKey))
            .then((wallet) => _libIdentityDataSource
                    .getClaimsTreeRoot(
                        pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
                    .then((claimsTreeRoot) =>
                        _libPolygonIdCoreDataSource.calculateGenesisId(
                            claimsTreeRoot, "polygon", "mumbai"))
                    .then((identifierFromKey) {
                  if (identifierFromKey != identifier) {
                    throw InvalidPrivateKeyException(privateKey);
                  }

                  return _identityDTOMapper.mapPrivateFrom(dto, privateKey);
                })))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  @override
  Future<void> removeIdentity(
      {required String identifier, required String privateKey}) {
    return _storageIdentityDataSource.removeIdentity(identifier: identifier);
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
    required String identifier,
    required String networkName,
    required String networkEnv,
  }) {
    return Future.value(
        _didMapper.mapTo(DidMapperParam(identifier, networkName, networkEnv)));
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }

  @override
  Future<String> getIdentifier({required String privateKey}) {
    // TODO: implement getIdentifier
    throw UnimplementedError();
  }
}
