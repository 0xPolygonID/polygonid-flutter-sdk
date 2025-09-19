import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:intl/intl.dart';
import 'package:ninja_prime/ninja_prime.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/common/utils/pinata_gateway_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service_metadata.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service_metadata_devices.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_vp_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/gist_proof_cache.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:poseidon/poseidon.dart';
import 'package:uuid/uuid.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class Authenticate {
  late ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  late StacktraceManager _stacktraceManager;

  Future<Iden3Message?> authenticate({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    required String? pushToken,
    String? challenge,
    final Map<String, dynamic>? transactionData,
    String? authClaimNonce,
    List<RequestAndCredentials>? requestsAndCreds,
  }) async {
    final nonce = authClaimNonce ?? DEFAULT_AUTH_CLAIM_NONCE;
    try {
      List<Iden3commProofEntity> proofs = [];
      Map<int, String> groupIdLinkNonceMap = {};

      AuthClaimCompanionObject? authClaimCompanionObject;
      ProofRepository proofRepository =
          await getItSdk.getAsync<ProofRepository>();
      _proofGenerationStepsStreamManager =
          getItSdk<ProofGenerationStepsStreamManager>();
      _stacktraceManager = getItSdk<StacktraceManager>();

      _proofGenerationStepsStreamManager.add("preparing authentication...");

      // Check if the message type is supported
      if (![
        Iden3MessageType.authRequest,
        Iden3MessageType.proofContractInvokeRequest,
      ].contains(message.type)) {
        _stacktraceManager.addError(
          "[Authenticate] Unsupported message type: ${message.type} It should be either authRequest or proofContractInvokeRequest",
        );
        throw UnsupportedIden3MsgTypeException(
          type: message.type,
          errorMessage: "Unsupported message type\nIt should be either "
              "authRequest or proofContractInvokeRequest",
        );
      }

      Uint8List privateKeyBytes = hexToBytes(privateKey);

      GetSelectedChainUseCase getSelectedChainUseCase =
          getItSdk.get<GetSelectedChainUseCase>();

      ChainConfigEntity chain = await getSelectedChainUseCase.execute();
      _stacktraceManager.addTrace(
        "[Authenticate] Chain: ${chain.blockchain} ${chain.network}",
      );
      GetDidIdentifierUseCase getDidIdentifierUseCase =
          getItSdk<GetDidIdentifierUseCase>();

      final getPubKeyUseCase = getItSdk<GetPublicKeyUseCase>();
      final bjjPublicKey = await getPubKeyUseCase.execute(param: privateKey);

      String profileDid = await getDidIdentifierUseCase.execute(
        param: GetDidIdentifierParam(
          bjjPublicKey: bjjPublicKey,
          blockchain: chain.blockchain,
          network: chain.network,
          profileNonce: profileNonce,
          method: chain.method,
        ),
      );

      List<RequestAndCredentials> requestsAndCredsLocal;
      if (requestsAndCreds == null) {
        // Get the credentials and proof requests by scope
        final getCredentialsUseCase =
            await getItSdk.getAsync<GetMessageRequestsAndCredsUseCase>();
        final requestsAndCredentials = await getCredentialsUseCase.execute(
          param: GetMessageRequestsAndCredsParam(
            message: message,
            genesisDid: genesisDid,
            profileNonce: profileNonce,
            encryptionKey: privateKey,
          ),
        );

        requestsAndCredsLocal = requestsAndCredentials;
      } else {
        requestsAndCredsLocal = requestsAndCreds;
      }

      // this authClaimCompanionObject is the one that is being used to get the
      // authClaim, incProof, nonRevProof, treeState, authClaimNode, gistProofEntity
      _proofGenerationStepsStreamManager.add("getting auth claim...");
      authClaimCompanionObject ??= await getAuthClaim(
        genesisDid: genesisDid,
        env: env,
        chain: chain,
        privateKey: privateKey,
        privateKeyBytes: privateKeyBytes,
        authClaimNonce: nonce,
      );

      // if there are proof requests and claims and they are the same length
      // then create the proof for every proof request
      if (requestsAndCredsLocal.isNotEmpty) {
        // it is assigning the proofs to the variable directly from the function call
        await createProofForEveryProofRequest(
          requestsAndCreds: requestsAndCredsLocal,
          identityEntity: identityEntity,
          groupIdLinkNonceMap: groupIdLinkNonceMap,
          genesisDid: genesisDid,
          profileNonce: profileNonce,
          privateKey: privateKey,
          challenge: challenge,
          env: env,
          message: message,
          transactionData: transactionData,
          privateKeyBytes: privateKeyBytes,
          proofRepository: proofRepository,
          authClaimCompanionObject: authClaimCompanionObject,
          proofs: proofs,
        );
      }

      // prepare the auth response message
      _proofGenerationStepsStreamManager.add(
        "preparing authentication parameters...",
      );
      String authResponseString = await prepareAuthResponseMessage(
        env: env,
        pushToken: pushToken,
        profileDid: profileDid,
        message: message,
        proofs: proofs,
      );

      // get the auth token
      _proofGenerationStepsStreamManager.add(
        "preparing authentication token...",
      );
      String authToken = await _getAuthToken(
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        privateKeyBytes: privateKeyBytes,
        message: authResponseString,
        authClaim: authClaimCompanionObject.authClaim!,
        incProof: authClaimCompanionObject.incProof!,
        nonRevProof: authClaimCompanionObject.nonRevProof!,
        treeState: authClaimCompanionObject.treeState!,
        authClaimNode: authClaimCompanionObject.authClaimNode!,
        gistProofEntity: authClaimCompanionObject.gistProofEntity!,
        proofRepository: proofRepository,
        env: env,
      );
      _stacktraceManager.addTrace("[Authenticate] authToken: $authToken");

      _proofGenerationStepsStreamManager.add(
        "sending auth token to the requester...",
      );
      String? callbackUrl = message.body.callbackUrl;

      if (callbackUrl == null || callbackUrl.isEmpty) {
        _stacktraceManager.addError(
          "[Authenticate] Callback url is null or empty",
        );
        throw NullAuthenticateCallbackException(
          authRequest: message as AuthorizationRequestMessage,
          errorMessage: "Callback url is null or empty",
        );
      }

      // perform the authentication with the auth token calling the callback url
      http.Client httpClient = http.Client();
      Uri uri = Uri.parse(callbackUrl);
      http.Response response = await httpClient.post(
        uri,
        body: authToken,
        headers: {
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.contentTypeHeader: 'text/plain',
        },
      ).timeout(const Duration(seconds: 30));

      _stacktraceManager.addTrace(
        "[Authenticate] responseStatusCode: ${response.statusCode}\nresponseBody: ${response.body}",
      );

      if (response.statusCode != 200) {
        _stacktraceManager.addError(
          "[Authenticate] Error sending auth token to the requester: ${response.statusCode} ${response.body}",
        );
        throw NetworkException(
          statusCode: response.statusCode,
          errorMessage: response.body,
        );
      }

      if (response.body.isEmpty) {
        return null;
      }

      try {
        final messageJson = jsonDecode(response.body);

        if (messageJson is! Map<String, dynamic> || messageJson.isEmpty) {
          return null;
        }

        final messageFactory = Iden3MessageFactory(
          getItSdk<StacktraceManager>(),
        );
        final nextRequest = messageFactory.createMessage(
          rawMessage: response.body,
        );

        return nextRequest;
      } catch (e) {
        return null;
      }
    } on TimeoutException catch (e) {
      String waitingTime = e.duration?.inSeconds.toString() ?? "unknown";
      throw NetworkException(
        statusCode: 504,
        errorMessage:
            "Connection timeout while sending auth token to the requester.\nwaited for $waitingTime seconds.",
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> prepareAuthResponseMessage({
    required EnvEntity env,
    required String? pushToken,
    required String profileDid,
    required Iden3Message message,
    required List<Iden3commProofEntity> proofs,
  }) async {
    String pushUrl = env.pushUrl;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;

    DIDDocument? didDocResponse = await _getDidDoc(
      pushUrl: pushUrl,
      pushToken: pushToken,
      packageName: packageName,
      profileDid: profileDid,
    );

    final authResponse = AuthorizationResponseMessage(
      id: const Uuid().v4(),
      thid: message.thid,
      to: message.from,
      from: profileDid,
      typ: "application/iden3-zkp-json",
      body: AuthorizationMessageResponseBody(
        message: (message as AuthorizationRequestMessage).body.message,
        proofs: proofs,
        did_doc: didDocResponse,
      ),
    );

    String authResponseString = jsonEncode(authResponse.toJson());
    return authResponseString;
  }

  ///
  Future<void> createProofForEveryProofRequest({
    required List<RequestAndCredentials> requestsAndCreds,
    required IdentityEntity identityEntity,
    required Map<int, String> groupIdLinkNonceMap,
    required String genesisDid,
    required BigInt profileNonce,
    required String privateKey,
    required String? challenge,
    required EnvEntity env,
    required Iden3Message message,
    required Map<String, dynamic>? transactionData,
    required Uint8List privateKeyBytes,
    required ProofRepository proofRepository,
    required AuthClaimCompanionObject authClaimCompanionObject,
    required List<Iden3commProofEntity> proofs,
  }) async {
    for (int i = 0; i < requestsAndCreds.length; i++) {
      final request = requestsAndCreds[i].request;
      final credentials = requestsAndCreds[i].credentials;

      // if there are no credentials for the request
      if (credentials.isEmpty) {
        // if the request is optional, continue to the next request
        if (request.isOptional) {
          continue;
        } else {
          // if the request is not optional, throw an error
          _stacktraceManager.addError(
            "[Authenticate] No credentials found for request: ${request.scope.id}",
          );
          throw NoCredentialsFoundException(
            proofRequest: request,
            errorMessage:
                "No credentials found for request: ${request.scope.id}",
          );
        }
      }
      CredentialEntity claim = credentials.first;

      if (claim.expiration != null) {
        claim = await _checkCredentialExpirationAndTryRefreshIfExpired(
          claim: claim,
          genesisDid: genesisDid,
          privateKey: privateKey,
        );
      }

      _proofGenerationStepsStreamManager.add(
        "#${i + 1} creating proof for ${request.scope.query.type}...",
      );

      final appDir = await getApplicationDocumentsDirectory();
      final circuitsDataSource = CircuitsFilesDataSource(appDir);

      final graphFileBytes = await circuitsDataSource.loadGraphFile(
        request.scope.circuitId,
      );
      final zkeyFilePath = await circuitsDataSource.getZkeyFilePath(
        request.scope.circuitId,
      );

      CircuitDataEntity circuitDataEntity = CircuitDataEntity(
        request.scope.circuitId,
        graphFileBytes,
        zkeyFilePath,
      );

      BigInt claimSubjectProfileNonce = identityEntity.profiles.keys.firstWhere(
        (k) =>
            identityEntity.profiles[k] == claim.info["credentialSubject"]["id"],
        orElse: () => GENESIS_PROFILE_NONCE,
      );

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

      Map<String, dynamic>? config;
      String? signature;

      if (request.scope.circuitId == CircuitTypes.mtpOnChain.id ||
          request.scope.circuitId == CircuitTypes.sigOnChain.id ||
          request.scope.circuitId == CircuitTypes.circuitsV3OnChain.id) {
        /// SIGN MESSAGE
        signature = await signMessage(
          privateKey: privateKeyBytes,
          message: challenge!,
        );
      }

      config = env.config.toJson();

      List<String> splittedDid = genesisDid.split(":");
      String id = splittedDid[4];
      final generateInputsRes =
          await proofRepository.calculateAtomicQueryInputs(
        id: id,
        profileNonce: profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        claim: claim,
        proofScopeRequest: request.scope.toJson(),
        circuitId: request.scope.circuitId,
        incProof: authClaimCompanionObject.incProof,
        nonRevProof: authClaimCompanionObject.nonRevProof,
        gistProof: authClaimCompanionObject.gistProofEntity,
        authClaim: authClaimCompanionObject.authClaim,
        treeState: authClaimCompanionObject.treeState,
        challenge: challenge,
        signature: signature,
        config: config,
        verifierId: message.from,
        linkNonce: linkNonce,
        scopeParams: request.scope.params,
        transactionData: transactionData,
      );

      final atomicQueryInputs = json.encode(generateInputsRes.inputs);
      if (kDebugMode) {
        //just for debug
        logger().i("atomicQueryInputs: $atomicQueryInputs");
      }

      Iden3commVPProof? vpProof;
      final verifiablePresentation = generateInputsRes.verifiablePresentation;
      if (verifiablePresentation != null) {
        vpProof = Iden3commVPProof.fromJson(verifiablePresentation);
      }

      _stacktraceManager.addTrace(
        "[Authenticate] AtomicQueryInputs: $atomicQueryInputs",
      );

      Uint8List witnessBytes = await proofRepository.calculateWitness(
        circuitData: circuitDataEntity,
        atomicQueryInputs: atomicQueryInputs,
      );

      ZKProofEntity zkProofEntity = await proofRepository.prove(
        circuitData: circuitDataEntity,
        wtnsBytes: witnessBytes,
      );

      Iden3commProofEntity proof;
      if (vpProof != null) {
        proof = Iden3commSDProofEntity(
          id: request.scope.id,
          circuitId: request.scope.circuitId,
          proof: zkProofEntity.proof,
          pubSignals: zkProofEntity.pubSignals,
          publicStatesInfo: generateInputsRes.publicStatesInfo,
          vp: vpProof,
        );
      } else {
        proof = Iden3commProofEntity(
          id: request.scope.id,
          circuitId: request.scope.circuitId,
          proof: zkProofEntity.proof,
          pubSignals: zkProofEntity.pubSignals,
          publicStatesInfo: generateInputsRes.publicStatesInfo,
        );
      }
      proofs.add(proof);
    }
  }

  /// Fetches the schema from the given URL
  Future<Map<String, dynamic>> fetchSchema({required String schemaUrl}) async {
    if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
      String fileHash = schemaUrl.replaceFirst("ipfs://", "");
      String? pinataGatewayUrl =
          await PinataGatewayUtils().retrievePinataGatewayUrlFromEnvironment(
        fileHash: fileHash,
      );

      if (pinataGatewayUrl != null) {
        schemaUrl = pinataGatewayUrl;
      } else {
        schemaUrl = "https://ipfs.io/ipfs/$fileHash";
      }
    }

    final schemaUri = Uri.parse(schemaUrl);
    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(path),
          policy: CachePolicy.request,
          maxStale: const Duration(days: 14),
          priority: CachePriority.high,
        ),
      ),
    );
    final schemaResponse = await dio.get(schemaUri.toString());
    if (schemaResponse.statusCode == 200 || schemaResponse.statusCode == 304) {
      Map<String, dynamic> schema = {};
      bool isMap = schemaResponse.data is Map<String, dynamic>;
      if (!isMap) {
        schema = json.decode(schemaResponse.data);
      } else {
        schema = schemaResponse.data;
      }

      return schema;
    } else {
      _stacktraceManager.addError(
        "[Authenticate] Error fetching schema: ${schemaResponse.statusCode} ${schemaResponse.statusMessage}",
      );
      throw NetworkException(
        statusCode: schemaResponse.statusCode ?? 0,
        errorMessage: schemaResponse.statusMessage ?? "",
      );
    }
  }

  String generateLinkNonce() {
    final BigInt safeMaxVal = BigInt.parse(
      "21888242871839275222246405745257275088548364400416034343698204186575808495617",
    );
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

  /// SIGN MESSAGE WITH BJJ KEY
  Future<String> signMessage({
    required Uint8List privateKey,
    required String message,
  }) async {
    final walletDs = getItSdk<WalletDataSource>();
    return walletDs.signMessage(privateKey: privateKey, message: message);
  }

  Future<DIDDocument?> _getDidDoc({
    required String? pushUrl,
    required String? pushToken,
    required String? packageName,
    required String profileDid,
  }) async {
    if (pushUrl == null ||
        pushToken == null ||
        packageName == null ||
        pushUrl.isEmpty ||
        pushToken.isEmpty ||
        packageName.isEmpty) {
      return null;
    }

    return DIDDocument(
      context: const ["https://www.w3.org/ns/did/v1"],
      id: profileDid,
      service: [
        DIDDocumentService(
          id: '$profileDid#mobile',
          type: 'Iden3MobileServiceV1',
          serviceEndpoint: 'iden3comm:v0.1:callbackHandler',
        ),
        DIDDocumentService(
          id: "$profileDid#push",
          type: "push-notification",
          serviceEndpoint: pushUrl,
          metadata: DIDDocumentServiceMetadata(
            devices: [
              DIDDocumentServiceMetadataDevices(
                ciphertext: await _getPushCipherText(
                  pushToken,
                  pushUrl,
                  packageName,
                ),
                alg: "RSA-OAEP-512",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> _getPushCipherText(
    String pushToken,
    String serviceEndpoint,
    String packageName,
  ) async {
    var pushInfo = {
      "app_id": packageName, //"com.polygonid.wallet",
      "pushkey": pushToken,
    };

    Dio dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(path),
          policy: CachePolicy.request,
          maxStale: const Duration(days: 7),
          priority: CachePriority.high,
        ),
      ),
    );

    var publicKeyResponse = await dio.get(
      Uri.parse("$serviceEndpoint/public").toString(),
    );

    if (publicKeyResponse.statusCode == 200 ||
        publicKeyResponse.statusCode == 304) {
      String publicKeyPem = publicKeyResponse.data;
      final publicKey = RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final encrypter = OAEPEncoding.withCustomDigest(
        () => SHA512Digest(),
        RSAEngine(),
      );
      encrypter.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
      Uint8List encrypted = encrypter.process(
        Uint8List.fromList(json.encode(pushInfo).codeUnits),
      );
      return base64.encode(encrypted);
    } else {
      _stacktraceManager.addError(
        "[Authenticate] Error fetching public key: ${publicKeyResponse.statusCode} ${publicKeyResponse.statusMessage}",
      );
      throw NetworkException(
        statusCode: publicKeyResponse.statusCode ?? 0,
        errorMessage: publicKeyResponse.statusMessage ?? "",
      );
    }
  }

  Future<String> _getAuthToken({
    required String genesisDid,
    required BigInt profileNonce,
    required String privateKey,
    required Uint8List privateKeyBytes,
    required String message,
    required List<String> authClaim,
    required NodeEntity authClaimNode,
    required MTProofEntity incProof,
    required MTProofEntity nonRevProof,
    required Map<String, dynamic> treeState,
    required GistMTProofEntity gistProofEntity,
    required ProofRepository proofRepository,
    required EnvEntity env,
  }) async {
    JWZHeader header = JWZHeader(
      circuitId: "authV2",
      crit: ["circuitId"],
      typ: "application/iden3-zkp-json",
      alg: "groth16",
    );

    JWZPayload payload = JWZPayload(payload: message);
    JWZEntity jwz = JWZEntity(
      header: header,
      payload: payload,
    );

    String jwzString = stringFromJwz(jwz);

    Uint8List sha = Uint8List.fromList(
      sha256.convert(Uint8ArrayUtils.uint8ListfromString(jwzString)).bytes,
    );

    // Endianness
    BigInt endian = Uint8ArrayUtils.leBuff2int(sha);

    BigInt qNormalized = endian.qNormalize();

    String authChallenge = poseidon1([qNormalized]).toString();

    String signature = await signMessage(
      privateKey: privateKeyBytes,
      message: authChallenge,
    );

    final libPidCoreIden3commDS = getItSdk<LibPolygonIdCoreProofDataSource>();

    final inputsResponse = await libPidCoreIden3commDS.getAuthInputs(
      genesisDid: genesisDid,
      profileNonce: profileNonce,
      authClaim: authClaim,
      incProof: incProof.toJson(),
      nonRevProof: nonRevProof.toJson(),
      gistProof: gistProofEntity.toJson(),
      treeState: treeState,
      challenge: authChallenge,
      signature: signature,
      config: env.config.toJson(),
    );

    final appDir = await getApplicationDocumentsDirectory();
    final circuitsDataSource = CircuitsFilesDataSource(appDir);

    final circuitDatFileBytes = await circuitsDataSource.loadGraphFile(
      'authV2',
    );
    final zkeyFilePath = await circuitsDataSource.getZkeyFilePath('authV2');

    CircuitDataEntity circuitDataEntity = CircuitDataEntity(
      "authV2",
      circuitDatFileBytes,
      zkeyFilePath,
    );

    Uint8List witnessBytes = await proofRepository.calculateWitness(
      circuitData: circuitDataEntity,
      atomicQueryInputs: jsonEncode(inputsResponse.inputs),
    );

    ZKProofEntity zkProofEntity = await proofRepository.prove(
      circuitData: circuitDataEntity,
      wtnsBytes: witnessBytes,
    );

    JWZEntity jwzZkProof = JWZEntity(
      header: header,
      payload: payload,
      proof: zkProofEntity,
    );

    String jwzZkProofString = stringFromJwz(jwzZkProof);
    return jwzZkProofString;
  }

  String stringFromJwz(JWZEntity jwzEntity) {
    if (jwzEntity.header == null) {
      _stacktraceManager.addError(
        "[Authenticate] JWZ header is null",
      );
      throw NullJWZHeaderException(errorMessage: "JWZ header is null");
    }

    if (jwzEntity.payload == null) {
      _stacktraceManager.addError(
        "[Authenticate] JWZ payload is null",
      );
      throw NullJWZPayloadException(errorMessage: "JWZ payload is null");
    }

    String header = Base64Util.encode64(jsonEncode(jwzEntity.header));
    String payload = "." + Base64Util.encode64(jwzEntity.payload!.payload);
    String proof = jwzEntity.proof != null
        ? "." + Base64Util.encode64(jsonEncode(jwzEntity.proof))
        : "";

    return "$header$payload$proof";
  }

  Future<AuthClaimCompanionObject> getAuthClaim({
    required String privateKey,
    required String genesisDid,
    required EnvEntity env,
    required ChainConfigEntity chain,
    required Uint8List privateKeyBytes,
    required String authClaimNonce,
  }) async {
    List<String>? authClaim;
    MTProofEntity? incProof;
    MTProofEntity? nonRevProof;
    GistMTProofEntity? gistProofEntity;
    Map<String, dynamic>? treeState;
    var libPolygonIdCredential =
        getItSdk<LibPolygonIdCoreCredentialDataSource>();

    final identityRepo = getItSdk<IdentityRepository>();
    final publicKey = await identityRepo.getPublicKeys(
      bjjPrivateKey: privateKey,
    );

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
      encryptionKey: privateKey,
    );

    // NON REV PROOF
    nonRevProof = await smtRepository.generateProof(
      key: authClaimNode.hash,
      type: TreeType.revocation,
      did: genesisDid,
      encryptionKey: privateKey,
    );

    // TREE STATE
    List<HashEntity> trees = await Future.wait(
      [
        smtRepository.getRoot(
          type: TreeType.claims,
          did: genesisDid,
          encryptionKey: privateKey,
        ),
        smtRepository.getRoot(
          type: TreeType.revocation,
          did: genesisDid,
          encryptionKey: privateKey,
        ),
        smtRepository.getRoot(
          type: TreeType.roots,
          did: genesisDid,
          encryptionKey: privateKey,
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
      jsonEncode(jsonDecode(stateAbiJson)["abi"]),
      'State',
    );
    EthereumAddress ethereumAddress = EthereumAddress.fromHex(
      chain.stateContractAddr,
    );
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

  Future<CredentialEntity> _checkCredentialExpirationAndTryRefreshIfExpired({
    required CredentialEntity claim,
    required String genesisDid,
    required String privateKey,
  }) async {
    var now = DateTime.now().toUtc();
    DateTime expirationTime = DateFormat(
      "yyyy-MM-ddTHH:mm:ssZ",
    ).parse(claim.expiration!);

    var nowFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    var expirationTimeFormatted = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(expirationTime);
    bool isExpired = nowFormatted.compareTo(expirationTimeFormatted) > 0 ||
        claim.state == CredentialState.expired;

    if (isExpired && claim.info.containsKey("refreshService")) {
      _proofGenerationStepsStreamManager.add(
        "Refreshing expired credential...",
      );

      RefreshCredentialUseCase _refreshCredentialUseCase =
          await getItSdk.getAsync<RefreshCredentialUseCase>();

      CredentialEntity refreshedClaimEntity =
          await _refreshCredentialUseCase.execute(
        param: RefreshCredentialParam(
          credential: claim,
          genesisDid: genesisDid,
          privateKey: privateKey,
        ),
      );

      claim = refreshedClaimEntity;
    }
    return claim;
  }
}

class AuthClaimCompanionObject {
  List<String>? authClaim;
  MTProofEntity? incProof;
  MTProofEntity? nonRevProof;
  GistMTProofEntity? gistProofEntity;
  Map<String, dynamic>? treeState;
  NodeEntity? authClaimNode;
}
