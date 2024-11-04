import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:ninja_prime/ninja_prime.dart';

import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/authenticate.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/gist_proof_cache.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:poseidon/poseidon.dart';
import 'package:web3dart/web3dart.dart';

class GetIden3commProofsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String? challenge;
  final EnvConfigEntity? config;
  final Map<int, Map<String, dynamic>>? nonRevocationProofs;

  final Map<String, dynamic>? transactionData;

  GetIden3commProofsParam({
    required this.message,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    this.challenge,
    this.config,
    this.nonRevocationProofs,
    this.transactionData,
  });
}

class GetIden3commProofsUseCase
    extends FutureUseCase<GetIden3commProofsParam, List<Iden3commProofEntity>> {
  final ProofRepository _proofRepository;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  final RefreshCredentialUseCase _refreshCredentialUseCase;

  GetIden3commProofsUseCase(
    this._proofRepository,
    this._getIden3commClaimsUseCase,
    this._generateIden3commProofUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
    this._getIdentityUseCase,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
    this._refreshCredentialUseCase,
  );

  @override
  Future<List<Iden3commProofEntity>> execute({
    required GetIden3commProofsParam param,
  }) async {
    try {
      List<Iden3commProofEntity> proofs = [];
      Map<int, String> groupIdLinkNonceMap = {};

      final message = param.message;

      _proofGenerationStepsStreamManager.add("Getting proof requests");
      List<ProofRequestEntity> requests =
          await _getProofRequestsUseCase.execute(param: param.message);
      _stacktraceManager
          .addTrace("[GetIden3commProofsUseCase] requests: $requests");

      /// Generate auth proof for empty contract request message
      if (requests.isEmpty && message is ContractIden3MessageEntity) {
        final authProof = await _generateAuthProof(
          message: message,
          param: param,
        );

        return [authProof];
      }

      List<ClaimEntity?> claims = await _getIden3commClaimsUseCase.execute(
        param: GetIden3commClaimsParam(
          message: param.message,
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          privateKey: param.privateKey,
          nonRevocationProofs: param.nonRevocationProofs ?? {},
          credentialSortOrderList: [CredentialSortOrder.ExpirationDescending],
        ),
      );
      _stacktraceManager.addTrace(
          "[GetIden3commProofsUseCase] claims found: ${claims.length}");

      if ((requests.isNotEmpty &&
              claims.isNotEmpty &&
              requests.length == claims.length) ||
          requests.isEmpty) {
        /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
        /// and generate [ProofEntity]
        for (int i = 0; i < requests.length; i++) {
          ProofRequestEntity request = requests[i];
          ClaimEntity? claim = claims[i];

          if (claim == null) {
            continue;
          }

          if (claim.expiration != null) {
            claim = await _checkCredentialExpirationAndTryRefreshIfExpired(
              claim: claim,
              param: param,
            );
          }

          bool isCircuitSupported = await _isProofCircuitSupported.execute(
            param: request.scope.circuitId,
          );
          bool isCorrectType = claim.type == request.scope.query.type;

          if (isCorrectType && isCircuitSupported) {
            String circuitId = request.scope.circuitId;
            CircuitDataEntity circuitData =
                await _proofRepository.loadCircuitFiles(circuitId);

            String? challenge;
            String? privKey;
            if (circuitId == CircuitType.mtponchain.name ||
                circuitId == CircuitType.sigonchain.name ||
                circuitId == CircuitType.circuitsV3onchain.name) {
              privKey = param.privateKey;
              challenge = param.challenge;
            }

            var identityEntity = await _getIdentityUseCase.execute(
                param: GetIdentityParam(
                    genesisDid: param.genesisDid,
                    privateKey: param.privateKey));

            BigInt claimSubjectProfileNonce = identityEntity.profiles.keys
                .firstWhere((k) => identityEntity.profiles[k] == claim!.did,
                    orElse: () => GENESIS_PROFILE_NONCE);

            int? groupId = request.scope.query.groupId;
            String linkNonce = "0";
            // Check if groupId exists in the map
            if (groupId != null) {
              if (groupIdLinkNonceMap.containsKey(groupId)) {
                // Use the existing linkNonce for this groupId
                linkNonce = groupIdLinkNonceMap[groupId]!;
              } else {
                // Generate a new linkNonce for this groupId
                linkNonce =
                    generateLinkNonce(); // Replace this with your linkNonce generation logic
                groupIdLinkNonceMap[groupId] = linkNonce;
              }
            }

            _proofGenerationStepsStreamManager
                .add("#${i + 1} creating proof for ${claim.type}");

            // Generate proof param
            GenerateIden3commProofParam proofParam =
                GenerateIden3commProofParam(
              did: param.genesisDid,
              profileNonce: param.profileNonce,
              claimSubjectProfileNonce: claimSubjectProfileNonce,
              credential: claim,
              request: request.scope,
              circuitData: circuitData,
              privateKey: privKey,
              challenge: challenge,
              config: param.config,
              verifierId: param.message.from,
              linkNonce: linkNonce,
              transactionData: param.transactionData,
            );

            // Generate proof
            Iden3commProofEntity proof =
                await _generateIden3commProofUseCase.execute(
              param: proofParam,
            );

            proofs.add(proof);
          }
        }
      } else {
        _stacktraceManager.addTrace(
            "[GetIden3commProofsUseCase] CredentialsNotFoundException - requests: $requests");
        _stacktraceManager.addError(
            "[GetIden3commProofsUseCase] CredentialsNotFoundException - requests: $requests");
        throw CredentialsNotFoundException(
          errorMessage: "Credentials not found for requests",
          proofRequests: requests,
        );
      }

      /// If we have requests but didn't get any proofs, we throw
      /// as it could be we didn't find any associated [ClaimEntity]
      if (requests.isNotEmpty && proofs.isEmpty ||
          proofs.length != requests.length) {
        _stacktraceManager.addTrace(
            "[GetIden3commProofsUseCase] ProofsNotFoundException - requests: $requests");
        _stacktraceManager.addError(
            "[GetIden3commProofsUseCase] ProofsNotFoundException - requests: $requests");
        throw ProofsNotCreatedException(
          proofRequests: requests,
          errorMessage: "Proofs not created for requests",
        );
      }

      return proofs;
    } catch (e) {
      _stacktraceManager.addTrace("[GetIden3commProofsUseCase] Exception: $e");
      rethrow;
    }
  }

  /// We generate a random linkNonce for each groupId
  String generateLinkNonce() {
    final BigInt safeMaxVal = BigInt.parse(
        "21888242871839275222246405745257275088548364400416034343698204186575808495617");
    // get max value of 2 ^ 248
    BigInt base = BigInt.parse('2');
    int exponent = 248;
    final maxVal = base.pow(exponent) - BigInt.one;
    final random = Random.secure();
    BigInt randomNumber;
    do {
      randomNumber = randomBigInt(248, max: maxVal, random: random);
      if (kDebugMode) {
        logger().i("random number $randomNumber");
        logger().i("less than safeMax ${randomNumber < safeMaxVal}");
      }
    } while (randomNumber >= safeMaxVal);

    return randomNumber.toString();
  }

  /// Check if the credential is expired and try to refresh it if it is
  /// and if it has a refresh service
  Future<ClaimEntity> _checkCredentialExpirationAndTryRefreshIfExpired({
    required ClaimEntity claim,
    required GetIden3commProofsParam param,
  }) async {
    var now = DateTime.now().toUtc();
    DateTime expirationTime =
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(claim.expiration!);

    var nowFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    var expirationTimeFormatted =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(expirationTime);
    bool isExpired = nowFormatted.compareTo(expirationTimeFormatted) > 0 ||
        claim.state == ClaimState.expired;

    if (isExpired && claim.info.containsKey("refreshService")) {
      _proofGenerationStepsStreamManager
          .add("Refreshing expired credential...");

      ClaimEntity refreshedClaimEntity =
          await _refreshCredentialUseCase.execute(
              param: RefreshCredentialParam(
        credential: claim,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ));

      claim = refreshedClaimEntity;
    }
    return claim;
  }

  Future<Iden3commProofEntity> _generateAuthProof({
    required ContractIden3MessageEntity message,
    required GetIden3commProofsParam param,
  }) async {
    final env = await (await getItSdk.getAsync<GetEnvUseCase>()).execute();

    final chainId = message.body.transactionData.chainId;
    final chain = env.chainConfigs[chainId] ??
        await (await getItSdk.getAsync<GetSelectedChainUseCase>()).execute();

    final authClaimCompanion = await getAuthClaim(
      privateKey: param.privateKey,
      genesisDid: param.genesisDid,
      env: env,
      chain: chain,
      authClaimNonce: DEFAULT_AUTH_CLAIM_NONCE,
    );

    final challengeBytes = HexUtils.hexToBytes(param.challenge!);

    /// Endianness
    BigInt endian = Uint8ArrayUtils.leBuff2int(challengeBytes);

    BigInt qNormalized = endian.qNormalize();

    String authChallenge = poseidon1([qNormalized]).toString();

    String signature = await signMessage(
      privateKey: HexUtils.hexToBytes(param.privateKey),
      message: authChallenge,
    );

    final authInputsDS = getItSdk<LibPolygonIdCoreIden3commDataSource>();
    Uint8List authInputsBytes = await authInputsDS.getAuthInputs(
      genesisDid: param.genesisDid,
      profileNonce: param.profileNonce,
      authClaim: authClaimCompanion.authClaim!,
      incProof: authClaimCompanion.incProof!.toJson(),
      nonRevProof: authClaimCompanion.nonRevProof!.toJson(),
      gistProof: authClaimCompanion.gistProofEntity!.toJson(),
      treeState: authClaimCompanion.treeState!,
      challenge: authChallenge,
      signature: signature,
    );

    final circuitsDS = await getItSdk.getAsync<CircuitsFilesDataSource>();
    final circuitDatFileBytes = await circuitsDS.loadCircuitDatFile('authV2');
    final zkeyFilePath = await circuitsDS.getZkeyFilePath('authV2');

    final circuitData = CircuitDataEntity(
      "authV2",
      circuitDatFileBytes,
      zkeyFilePath,
    );

    Uint8List witnessBytes = await _proofRepository.calculateWitness(
      circuitData: circuitData,
      atomicQueryInputs: authInputsBytes,
    );

    ZKProofEntity zkProofEntity = await _proofRepository.prove(
      circuitData: circuitData,
      wtnsBytes: witnessBytes,
    );

    return Iden3commProofEntity(
      id: 0,
      circuitId: "authV2",
      proof: zkProofEntity.proof,
      pubSignals: zkProofEntity.pubSignals,
    );
  }
}

/// SIGN MESSAGE WITH BJJ KEY
Future<String> signMessage({
  required Uint8List privateKey,
  required String message,
}) async {
  final walletDs = getItSdk<WalletDataSource>();
  return walletDs.signMessage(privateKey: privateKey, message: message);
}

Future<AuthClaimCompanionObject> getAuthClaim({
  required String privateKey,
  required String genesisDid,
  required EnvEntity env,
  required ChainConfigEntity chain,
  required String authClaimNonce,
}) async {
  List<String>? authClaim;
  MTProofEntity? incProof;
  MTProofEntity? nonRevProof;
  GistMTProofEntity? gistProofEntity;
  Map<String, dynamic>? treeState;
  var libPolygonIdCredential = getItSdk<LibPolygonIdCoreCredentialDataSource>();

  final identityRepo = await getItSdk.getAsync<IdentityRepository>();
  final publicKey = await identityRepo.getPublicKeys(privateKey: privateKey);

  String authClaimSchema = AUTH_CLAIM_SCHEMA;
  String issuedAuthClaim = libPolygonIdCredential.issueClaim(
    schema: authClaimSchema,
    nonce: authClaimNonce,
    publicKey: publicKey,
  );
  authClaim = List.from(jsonDecode(issuedAuthClaim));
  BigInt hashIndex = poseidon4([
    BigInt.parse(authClaim[0]),
    BigInt.parse(authClaim[1]),
    BigInt.parse(authClaim[2]),
    BigInt.parse(authClaim[3]),
  ]);
  BigInt hashValue = poseidon4([
    BigInt.parse(authClaim[4]),
    BigInt.parse(authClaim[5]),
    BigInt.parse(authClaim[6]),
    BigInt.parse(authClaim[7]),
  ]);
  BigInt hashClaimNode = poseidon3([
    hashIndex,
    hashValue,
    BigInt.one,
  ]);
  NodeEntity authClaimNode = NodeEntity(
    children: [
      HashEntity.fromBigInt(hashIndex),
      HashEntity.fromBigInt(hashValue),
      HashEntity.fromBigInt(BigInt.one),
    ],
    hash: HashEntity.fromBigInt(hashClaimNode),
    type: NodeType.leaf,
  );

  // INC PROOF
  SMTRepository smtRepository = getItSdk<SMTRepository>();
  incProof = await smtRepository.generateProof(
    key: authClaimNode.hash,
    type: TreeType.claims,
    did: genesisDid,
    privateKey: privateKey,
  );

  // NON REV PROOF
  nonRevProof = await smtRepository.generateProof(
    key: authClaimNode.hash,
    type: TreeType.revocation,
    did: genesisDid,
    privateKey: privateKey,
  );

  // TREE STATE
  List<HashEntity> trees = await Future.wait(
    [
      smtRepository.getRoot(
        type: TreeType.claims,
        did: genesisDid,
        privateKey: privateKey,
      ),
      smtRepository.getRoot(
        type: TreeType.revocation,
        did: genesisDid,
        privateKey: privateKey,
      ),
      smtRepository.getRoot(
        type: TreeType.roots,
        did: genesisDid,
        privateKey: privateKey,
      ),
    ],
    eagerError: true,
  );

  String hash = await smtRepository.hashState(
    claims: trees[0].string(),
    revocation: trees[1].string(),
    roots: trees[2].string(),
  );

  TreeStateEntity treeStateEntity = TreeStateEntity(
    hash,
    trees[0],
    trees[1],
    trees[2],
  );

  treeState = await smtRepository.convertState(
    state: treeStateEntity,
  );

  //GIST
  List<String> splittedDid = genesisDid.split(":");
  String id = splittedDid[4];
  var libPolygonIdIdentity = getItSdk<LibPolygonIdCoreIdentityDataSource>();
  String convertedId = libPolygonIdIdentity.genesisIdToBigInt(id);
  ContractAbi contractAbi = ContractAbi.fromJson(
      jsonEncode(jsonDecode(stateAbiJson)["abi"]), 'State');
  EthereumAddress ethereumAddress =
      EthereumAddress.fromHex(chain.stateContractAddr);
  DeployedContract contract = DeployedContract(contractAbi, ethereumAddress);

  String gistProof = await GistProofCache().getGistProof(
    id: convertedId,
    deployedContract: contract,
    envEntity: env,
  );

  final gistMTProofDataSource = getItSdk<GistMTProofDataSource>();
  gistProofEntity = gistMTProofDataSource.getGistMTProof(gistProof);

  return AuthClaimCompanionObject()
    ..authClaim = authClaim
    ..incProof = incProof
    ..nonRevProof = nonRevProof
    ..gistProofEntity = gistProofEntity
    ..treeState = treeState
    ..authClaimNode = authClaimNode;
}
