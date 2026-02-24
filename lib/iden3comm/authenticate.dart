import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/common/utils/did_doc_compose.dart';
import 'package:polygonid_flutter_sdk/common/utils/ipfs.dart';
import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_vp_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/iden3comm/util/generate_link_nonce.dart';
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
    DIDDocument? didDocument,
    String? pushToken,
    String? challenge,
    final Map<String, dynamic>? transactionData,
    String? authClaimNonce,
    List<RequestAndCredentials>? requestsAndCreds,
    CircuitId circuitId = CircuitId.authV2,
  }) async {
    try {
      String authToken = await getAuthResponseToken(
        privateKey: privateKey,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        identityEntity: identityEntity,
        message: message,
        env: env,
        didDocument: didDocument,
        pushToken: pushToken,
        challenge: challenge,
        transactionData: transactionData,
        authClaimNonce: authClaimNonce,
        requestsAndCreds: requestsAndCreds,
        circuitId: circuitId,
      );
      _stacktraceManager.addTrace("[Authenticate] authToken: $authToken");

      _proofGenerationStepsStreamManager.add(
        "sending auth token to the requester...",
      );
      String? callbackUrl;
      if (message is AuthorizationRequestMessage) {
        callbackUrl = message.body.callbackUrl;
      }

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
      http.Response response = await httpClient
          .post(
            uri,
            body: authToken,
            headers: {
              HttpHeaders.acceptHeader: '*/*',
              HttpHeaders.contentTypeHeader: 'text/plain',
            },
          )
          .timeout(const Duration(seconds: 30));

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

  Future<String> getAuthResponseToken({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    DIDDocument? didDocument,
    String? pushToken,
    String? challenge,
    final Map<String, dynamic>? transactionData,
    String? authClaimNonce,
    List<RequestAndCredentials>? requestsAndCreds,
    CircuitId circuitId = CircuitId.authV2,
  }) async {
    final nonce = authClaimNonce ?? DEFAULT_AUTH_CLAIM_NONCE;
    try {
      List<Iden3commProofEntity> proofs = [];
      Map<int, String> groupIdLinkNonceMap = {};

      AuthClaimCompanionObject? authClaimCompanionObject;
      ProofRepository proofRepository = await getItSdk
          .getAsync<ProofRepository>();
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
          errorMessage:
              "Unsupported message type\nIt should be either "
              "authRequest or proofContractInvokeRequest",
        );
      }

      Uint8List privateKeyBytes = hexToBytes(privateKey);

      GetSelectedChainUseCase getSelectedChainUseCase = getItSdk
          .get<GetSelectedChainUseCase>();

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

      final List<ProofScopeRequest> requests;
      if (message is AuthorizationRequestMessage) {
        requests = message.body.scope;
      } else if (message is ContractInvokeRequestMessage) {
        requests = message.body.scope;
      } else {
        throw UnsupportedIden3MsgTypeException(
          type: message.type,
          errorMessage: "Unsupported message type - ${message.type}",
        );
      }

      List<RequestAndCredentials> requestsAndCredsLocal;
      if (requestsAndCreds == null) {
        // Get the credentials and proof requests by scope
        final getCredentialsUseCase = await getItSdk
            .getAsync<GetMessageRequestsAndCredsUseCase>();
        final requestsAndCredentials = await getCredentialsUseCase.execute(
          param: GetMessageRequestsAndCredsParam(
            proofRequests: requests,
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
      DIDDocument didDoc;
      if (didDocument != null) {
        didDoc = didDocument;
      } else {
        PushServiceData? pushServiceData;
        if (pushToken != null && pushToken.isNotEmpty) {
          final info = await PackageInfo.fromPlatform();
          pushServiceData = PushServiceData(
            pushToken: pushToken,
            serviceEndpoint: env.pushUrl,
            packageName: info.packageName,
          );
        }

        didDoc = await composeDidDoc(
          did: profileDid,
          pushServiceData: pushServiceData,
        );
      }

      String authResponseString = await prepareAuthResponseMessage(
        profileDid: profileDid,
        message: message,
        proofs: proofs,
        didDocument: didDoc,
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
        circuitId: circuitId,
        env: env,
      );
      return authToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> prepareAuthResponseMessage({
    required String profileDid,
    required Iden3Message message,
    required List<Iden3commProofEntity> proofs,
    required DIDDocument didDocument,
  }) async {
    final authResponse = AuthorizationResponseMessage(
      id: const Uuid().v4(),
      thid: message.thid,
      to: message.from!,
      from: profileDid,
      typ: messageTypeZkp,
      body: AuthorizationResponseMessageBody(
        message: (message as AuthorizationRequestMessage).body.message,
        scope: proofs,
        did_doc: didDocument,
      ),
      createdTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
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
            "[Authenticate] No credentials found for request: ${request.id}",
          );
          throw NoCredentialsFoundException(
            proofRequest: request,
            errorMessage: "No credentials found for request: ${request.id}",
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
        "#${i + 1} creating proof for ${request.query.type}...",
      );

      final appDir = await getApplicationDocumentsDirectory();
      final circuitsDataSource = CircuitsFilesDataSource(appDir);

      final graphFileBytes = await circuitsDataSource.loadGraphFile(
        request.circuitId,
      );
      final zkeyFilePath = await circuitsDataSource.getZkeyFilePath(
        request.circuitId,
      );

      CircuitDataEntity circuitDataEntity = CircuitDataEntity(
        request.circuitId,
        graphFileBytes,
        zkeyFilePath,
      );

      BigInt claimSubjectProfileNonce = identityEntity.profiles.keys.firstWhere(
        (k) =>
            identityEntity.profiles[k] == claim.info["credentialSubject"]["id"],
        orElse: () => GENESIS_PROFILE_NONCE,
      );

      int? groupId = request.query.groupId;
      String linkNonce = "0";
      // Check if groupId exists in the map
      if (groupId != null) {
        if (groupIdLinkNonceMap.containsKey(groupId)) {
          // Use the existing linkNonce for this groupId
          linkNonce = groupIdLinkNonceMap[groupId]!;
        } else {
          // Generate a new linkNonce for this groupId
          linkNonce = generateLinkNonce();
          groupIdLinkNonceMap[groupId] = linkNonce;
        }
      }

      Map<String, dynamic>? config;
      String? signature;

      final circuitId = CircuitId.fromId(request.circuitId);
      if (circuitId.isOnChain) {
        /// SIGN MESSAGE
        signature = await signMessage(
          privateKey: privateKeyBytes,
          message: challenge!,
        );
      }

      config = env.config.toJson();

      List<String> splittedDid = genesisDid.split(":");
      String id = splittedDid[4];
      final generateInputsRes = await proofRepository
          .calculateAtomicQueryInputs(
            id: id,
            profileNonce: profileNonce,
            claimSubjectProfileNonce: claimSubjectProfileNonce,
            claim: claim,
            proofScopeRequest: request.toJson(),
            circuitId: request.circuitId,
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
            scopeParams: request.params,
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

      final proof = Iden3commProofEntity(
        id: request.id,
        circuitId: request.circuitId,
        proof: zkProofEntity.proof,
        pubSignals: zkProofEntity.pubSignals,
        publicStatesInfo: generateInputsRes.publicStatesInfo,
        vp: vpProof,
      );

      proofs.add(proof);
    }
  }

  /// Fetches the schema from the given URL
  Future<Map<String, dynamic>> fetchSchema({required String schemaUrl}) async {
    if (schemaUrl.toLowerCase().startsWith("ipfs://")) {
      schemaUrl = await IPFSUtils.getIpfsFileUrl(schemaUrl);
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

  /// SIGN MESSAGE WITH BJJ KEY
  Future<String> signMessage({
    required Uint8List privateKey,
    required String message,
  }) async {
    final walletDs = getItSdk<WalletDataSource>();
    return walletDs.signMessage(privateKey: privateKey, message: message);
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
    required CircuitId circuitId,
    required EnvEntity env,
  }) async {
    JWZHeader header = JWZHeader(
      circuitId: circuitId.id,
      crit: ["circuitId"],
      typ: messageTypeZkp,
      alg: "groth16",
    );

    JWZPayload payload = JWZPayload(payload: message);
    JWZEntity jwz = JWZEntity(header: header, payload: payload);

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
      circuitId: circuitId,
      config: env.config.toJson(),
    );

    final appDir = await getApplicationDocumentsDirectory();
    final circuitsDataSource = CircuitsFilesDataSource(appDir);

    final circuitDatFileBytes = await circuitsDataSource.loadGraphFile(
      circuitId.id,
    );
    final zkeyFilePath = await circuitsDataSource.getZkeyFilePath(circuitId.id);

    CircuitDataEntity circuitDataEntity = CircuitDataEntity(
      circuitId.id,
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
      _stacktraceManager.addError("[Authenticate] JWZ header is null");
      throw NullJWZHeaderException(errorMessage: "JWZ header is null");
    }

    if (jwzEntity.payload == null) {
      _stacktraceManager.addError("[Authenticate] JWZ payload is null");
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
    final libPidCredentialDS = getItSdk<LibPolygonIdCoreCredentialDataSource>();
    final identityRepo = getItSdk<IdentityRepository>();
    final publicKey = identityRepo.getPublicKeys(bjjPrivateKey: privateKey);

    String issuedAuthClaim = libPidCredentialDS.issueClaim(
      schema: AUTH_CLAIM_SCHEMA,
      nonce: authClaimNonce,
      publicKey: publicKey,
    );
    final authClaim = List<String>.from(jsonDecode(issuedAuthClaim));
    NodeEntity authClaimNode = identityRepo.getAuthClaimNode(
      children: authClaim,
    );

    // INC PROOF
    SMTRepository smtRepository = getItSdk<SMTRepository>();
    final MTProofEntity incProof = await smtRepository.generateProof(
      key: authClaimNode.hash,
      type: TreeType.claims,
      did: genesisDid,
      encryptionKey: privateKey,
    );

    // NON REV PROOF
    final MTProofEntity nonRevProof = await smtRepository.generateProof(
      key: authClaimNode.hash,
      type: TreeType.revocation,
      did: genesisDid,
      encryptionKey: privateKey,
    );

    // TREE STATE
    List<HashEntity> trees = await Future.wait([
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
    ], eagerError: true);

    String hash = smtRepository.hashState(
      claims: trees[0].toBigInt(),
      revocation: trees[1].toBigInt(),
      roots: trees[2].toBigInt(),
    );

    TreeStateEntity treeStateEntity = TreeStateEntity(
      hash,
      trees[0],
      trees[1],
      trees[2],
    );

    final Map<String, dynamic> treeState = treeStateEntity.toJson();

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
    final GistMTProofEntity gistProofEntity = gistMTProofDataSource
        .getGistMTProof(gistProof);

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
    bool isExpired =
        nowFormatted.compareTo(expirationTimeFormatted) > 0 ||
        claim.state == CredentialState.expired;

    if (isExpired && claim.info.containsKey("refreshService")) {
      _proofGenerationStepsStreamManager.add(
        "Refreshing expired credential...",
      );

      RefreshCredentialUseCase _refreshCredentialUseCase = await getItSdk
          .getAsync<RefreshCredentialUseCase>();

      CredentialEntity refreshedClaimEntity = await _refreshCredentialUseCase
          .execute(
            param: RefreshCredentialParam(
              credential: claim,
              genesisDid: genesisDid,
              privateKey: privateKey,
              // TODO Maybe provide keys here?
              keys: [],
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
