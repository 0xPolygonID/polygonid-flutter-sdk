import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/common/utils/did_doc_compose.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_auth_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/iden3comm/util/generate_link_nonce.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/gist_proof_cache.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:poseidon/poseidon.dart';
import 'package:uuid/uuid.dart';

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

      final getSelectedChainUseCase = getItSdk.get<GetSelectedChainUseCase>();
      ChainConfigEntity chain = await getSelectedChainUseCase.execute();
      _stacktraceManager.addTrace(
        "[Authenticate] Chain: ${chain.blockchain} ${chain.network}",
      );
      final getDidIdentifierUseCase = getItSdk<GetDidIdentifierUseCase>();

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
        final getCredentialsUseCase = await getItSdk
            .getAsync<GetMessageRequestsAndCredsUseCase>();
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
      final authClaimCompanionObject = await getAuthClaim(
        genesisDid: genesisDid,
        env: env,
        stateContractAddress: chain.stateContractAddr,
        privateKey: privateKey,
        authClaimNonce: nonce,
      );

      List<Iden3commProofEntity> proofs = [];
      // if there are proof requests and claims and they are the same length
      // then create the proof for every proof request
      if (requestsAndCredsLocal.isNotEmpty) {
        // it is assigning the proofs to the variable directly from the function call
        proofs = await createProofForEveryProofRequest(
          requestsAndCreds: requestsAndCredsLocal,
          identityEntity: identityEntity,
          genesisDid: genesisDid,
          profileNonce: profileNonce,
          privateKey: privateKey,
          challenge: challenge,
          env: env,
          verifierDid: message.from,
          transactionData: transactionData,
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
        message: authResponseString,
        authClaim: authClaimCompanionObject.authClaim!,
        incProof: authClaimCompanionObject.incProof!,
        nonRevProof: authClaimCompanionObject.nonRevProof!,
        treeState: authClaimCompanionObject.treeState!,
        authClaimNode: authClaimCompanionObject.authClaimNode!,
        gistProofEntity: authClaimCompanionObject.gistProofEntity!,
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
  Future<List<Iden3commProofEntity>> createProofForEveryProofRequest({
    required List<RequestAndCredentials> requestsAndCreds,
    required IdentityEntity identityEntity,
    required String genesisDid,
    required BigInt profileNonce,
    required String privateKey,
    required String? challenge,
    required EnvEntity env,
    required String? verifierDid,
    required Map<String, dynamic>? transactionData,
  }) async {
    final proofs = <Iden3commProofEntity>[];

    final groupIdLinkNonceMap = <int, String>{};

    for (int i = 0; i < requestsAndCreds.length; i++) {
      final request = requestsAndCreds[i].request;
      final isAuthQuery = request.circuitId.startsWith('auth');
      final credentials = requestsAndCreds[i].credentials;

      // if there are no credentials for the request
      if (credentials.isEmpty) {
        // if the request is optional, continue to the next request
        if (request.isOptional) {
          continue;
        } else if (request.query.isEmpty && isAuthQuery) {
          // if request query is empty and it's an auth circuit,
          // skip credential check as auth proofs don't need credentials
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

      _proofGenerationStepsStreamManager.add(
        "#${i + 1} creating proof for ${request.query.type}...",
      );

      final Iden3commProofEntity proof;
      if (isAuthQuery) {
        final generateAuthProofUseCase = await getItSdk
            .getAsync<GenerateAuthProofUseCase>();

        final challenge = request.params?['challenge']?.toString();
        if (challenge == null) {
          throw NullAuthChallengeException(
            proofRequest: request,
            errorMessage: "Challenge is null",
          );
        }

        proof = await generateAuthProofUseCase.execute(
          param: GenerateAuthProofParam(
            genesisDid: genesisDid,
            privateKey: privateKey,
            profileNonce: profileNonce,
            requestId: request.id,
            circuitId: request.circuitId,
            challenge: challenge,
          ),
        );
      } else {
        final generateProofUseCase = await getItSdk
            .getAsync<GenerateIden3commProofUseCase>();

        final credential = credentials.first;

        final credentialSubjectDid = credential.credentialSubject['id'];
        final profileEntries = identityEntity.profiles.entries;
        final credentialSubjectNonce = profileEntries
            .firstWhere(
              (profile) => profile.value == credentialSubjectDid,
              orElse: () => MapEntry(GENESIS_PROFILE_NONCE, ''),
            )
            .key;

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

        proof = await generateProofUseCase.execute(
          param: GenerateIden3commProofParam(
            did: genesisDid,
            profileNonce: profileNonce,
            claimSubjectProfileNonce: credentialSubjectNonce,
            credential: credential,
            request: request,
            privateKey: privateKey,
            challenge: challenge,
            config: env.config,
            verifierId: verifierDid,
            linkNonce: linkNonce,
            transactionData: transactionData,
          ),
        );
      }

      proofs.add(proof);
    }

    return proofs;
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
    required String message,
    required List<String> authClaim,
    required NodeEntity authClaimNode,
    required MTProofEntity incProof,
    required MTProofEntity nonRevProof,
    required Map<String, dynamic> treeState,
    required GistMTProofEntity gistProofEntity,
    required CircuitId circuitId,
    required EnvEntity env,
  }) async {
    final proofRepository = await getItSdk.getAsync<ProofRepository>();

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
      privateKey: privateKey.hexToBytes(),
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

    final optimizedCircuitId = inputsResponse.circuitId ?? circuitId.id;

    final circuitData = await proofRepository.loadCircuitFiles(
      optimizedCircuitId,
    );

    Uint8List witnessBytes = await proofRepository.calculateWitness(
      circuitData: circuitData,
      inputs: jsonEncode(inputsResponse.inputs),
    );

    ZKProofEntity zkProofEntity = await proofRepository.prove(
      circuitData: circuitData,
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
    required String stateContractAddress,
    required String authClaimNonce,
  }) async {
    final localClaimDS = getItSdk<LocalClaimDataSource>();
    final identityRepo = getItSdk<IdentityRepository>();
    final publicKey = identityRepo.getPublicKeys(bjjPrivateKey: privateKey);

    final authClaim = localClaimDS.getAuthClaim(
      publicKey: publicKey,
      authClaimNonce: authClaimNonce,
    );

    final authClaimNode = identityRepo.getAuthClaimNode(children: authClaim);

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

    final getLatestStateUC = getItSdk<GetLatestStateUseCase>();
    final Map<String, dynamic> treeState = await getLatestStateUC.execute(
      param: GetLatestStateParam(did: genesisDid, encryptionKey: privateKey),
    );

    //GIST
    List<String> splittedDid = genesisDid.split(":");
    String id = splittedDid[4];
    var libPolygonIdIdentity = getItSdk<LibPolygonIdCoreIdentityDataSource>();
    String convertedId = libPolygonIdIdentity.genesisIdToBigInt(id);

    final contract = LocalContractFilesDataSource().loadStateContract(
      stateContractAddress,
    );
    String gistProof = await GistProofCache().getGistProof(
      id: convertedId,
      deployedContract: contract,
      envEntity: env,
    );

    final gistMTProofDataSource = getItSdk<GistMTProofDataSource>();
    final gistProofEntity = gistMTProofDataSource.getGistMTProof(gistProof);

    return AuthClaimCompanionObject()
      ..authClaim = authClaim
      ..incProof = incProof
      ..nonRevProof = nonRevProof
      ..gistProofEntity = gistProofEntity
      ..treeState = treeState
      ..authClaimNode = authClaimNode;
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
