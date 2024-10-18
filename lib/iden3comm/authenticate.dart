import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:ninja_prime/ninja_prime.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/kms/index.dart';
import 'package:polygonid_flutter_sdk/common/kms/keys/types.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_vp_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/circuit_type_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:poseidon/poseidon.dart';
import 'package:sembast/sembast.dart';

class Authenticate {
  late ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  late StacktraceManager _stacktraceManager;

  KMS get _kms => getItSdk<KMS>();

  Future<Iden3MessageEntity?> authenticate({
    required Iden3MessageEntity message,
    required KeyId? bjjKeyId,
    required String? privateKey,
    required KeyId? ethKeyId,
    required String encryptionKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required String? pushToken,
    String? challenge,
    final Map<String, dynamic>? transactionData,
  }) async {
    try {
      List<Iden3commProofEntity> proofs = [];

      final env = await (await getItSdk.getAsync<GetEnvUseCase>()).execute();

      final proofRepository = await getItSdk.getAsync<ProofRepository>();
      _proofGenerationStepsStreamManager =
          getItSdk<ProofGenerationStepsStreamManager>();
      _stacktraceManager = getItSdk<StacktraceManager>();

      _proofGenerationStepsStreamManager.add("preparing authentication...");

      // Check if the message type is supported
      if (![
        Iden3MessageType.authRequest,
        Iden3MessageType.proofContractInvokeRequest
      ].contains(message.messageType)) {
        _stacktraceManager.addError(
          "[Authenticate] Unsupported message type: ${message.messageType} It should be either authRequest or proofContractInvokeRequest",
        );
        throw UnsupportedIden3MsgTypeException(
          type: message.messageType,
          errorMessage: "Unsupported message type\nIt should be either "
              "authRequest or proofContractInvokeRequest",
        );
      }

      final getSelectedChainUseCase =
          await getItSdk.getAsync<GetSelectedChainUseCase>();

      final chain = await getSelectedChainUseCase.execute();
      _stacktraceManager.addTrace(
        "[Authenticate] Chain: ${chain.blockchain} ${chain.network}",
      );

      BjjPublicKey? bjjPublicKey;

      final String profileDid;
      switch (identityEntity.type) {
        case IdentityType.bjj:
          final getDidUseCase =
              await getItSdk.getAsync<GetDidIdentifierUseCase>();

          bjjPublicKey = (await _kms.publicKey(bjjKeyId!)) as BjjPublicKey;

          profileDid = await getDidUseCase.execute(
            param: GetDidIdentifierParam(
              bjjPublicKey: bjjPublicKey.asStringList(),
              profileNonce: profileNonce,
              blockchain: chain.blockchain,
              network: chain.network,
              method: chain.method,
            ),
          );

          break;
        case IdentityType.ethereum:
          // TODO Get eth address outta eth key id

          final ethPublicKey =
              (await _kms.publicKey(ethKeyId!)) as Secp256k1PublicKey;
          final ethAddress = ethPublicKey.toEthAddress();

          final identityRepo = await getItSdk.getAsync<IdentityRepository>();

          profileDid = await identityRepo.getEthDidIdentifier(
            ethAddress: ethAddress,
            profileNonce: profileNonce,
            blockchain: chain.blockchain,
            network: chain.network,
            method: chain.method,
            config: env.config,
          );
          break;
      }

      List<ProofRequestEntity> proofRequests = [];
      List<ClaimEntity> claims = [];

      // Get the credentials and proof requests by scope
      // it is assigning the proofRequests and claims to the variables directly
      // from the function call
      await _getCredentialsAndProofRequestsByScope(
        message: message,
        proofRequests: proofRequests,
        genesisDid: genesisDid,
        encryptionKey: encryptionKey,
        claims: claims,
      );

      AuthClaimCompanionObject? authClaimCompanionObject;

      if (bjjPublicKey != null) {
        // this authClaimCompanionObject is the one that is being used to get the
        // authClaim, incProof, nonRevProof, treeState, authClaimNode, gistProofEntity
        _proofGenerationStepsStreamManager.add("getting auth claim...");
        authClaimCompanionObject = await _getAuthClaimData(
          genesisDid: genesisDid,
          env: env,
          chain: chain,
          publicKey: bjjPublicKey.asStringList(),
          encryptionKey: encryptionKey,
        );
      }

      // if there are proof requests and claims and they are the same length
      // then create the proof for every proof request
      if (proofRequests.isNotEmpty &&
          claims.isNotEmpty &&
          proofRequests.length == claims.length) {
        // it is assigning the proofs to the variable directly from the function call
        await _createProofForEveryProofRequest(
          proofRequests: proofRequests,
          claims: claims,
          identityEntity: identityEntity,
          genesisDid: genesisDid,
          profileNonce: profileNonce,
          privateKey: privateKey!,
          encryptionKey: encryptionKey,
          challenge: challenge,
          env: env,
          message: message,
          transactionData: transactionData,
          proofRepository: proofRepository,
          authClaimCompanionObject: authClaimCompanionObject!,
          proofs: proofs,
          bjjKeyId: bjjKeyId!,
        );
      }

      // prepare the auth response message
      _proofGenerationStepsStreamManager
          .add("preparing authentication parameters...");

      final iden3commRepo = getItSdk<Iden3commRepository>();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final authResponse = await iden3commRepo.getAuthResponse(
        did: profileDid,
        request: message as AuthIden3MessageEntity,
        scope: proofs,
        pushUrl: env.pushUrl,
        pushToken: pushToken,
        packageName: packageInfo.packageName,
      );

      final authResponseString = jsonEncode(authResponse.toJson());

      // get the auth token
      _proofGenerationStepsStreamManager
          .add("preparing authentication token...");

      final String authToken;
      switch (identityEntity.type) {
        case IdentityType.bjj:
          authClaimCompanionObject!;
          authToken = await _getJWZAuthToken(
            genesisDid: genesisDid,
            profileNonce: profileNonce,
            privateKey: privateKey!,
            message: authResponseString,
            authClaim: authClaimCompanionObject.authClaim,
            incProof: authClaimCompanionObject.incProof,
            nonRevProof: authClaimCompanionObject.nonRevProof,
            treeState: authClaimCompanionObject.treeState,
            gistProofEntity: authClaimCompanionObject.gistProofEntity,
            proofRepository: proofRepository,
          );
          break;
        case IdentityType.ethereum:
          authToken = await _getJWSAuthToken(
            message: authResponseString,
            fromDid: message.from,
            ethKeyId: ethKeyId!,
          );
      }

      _stacktraceManager.addTrace(
        "[Authenticate] authToken: $authToken",
      );

      _proofGenerationStepsStreamManager
          .add("sending auth token to the requester...");
      String? callbackUrl = message.body.callbackUrl;

      if (callbackUrl == null || callbackUrl.isEmpty) {
        _stacktraceManager.addError(
          "[Authenticate] Callback url is null or empty",
        );
        throw NullAuthenticateCallbackException(
          authRequest: message,
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

        final _getIden3MessageUseCase = getItSdk<GetIden3MessageUseCase>();
        final nextRequest = await _getIden3MessageUseCase.execute(
          param: jsonEncode(messageJson),
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
              "Connection timeout while sending auth token to the requester.\nwaited for $waitingTime seconds.");
    } catch (e) {
      rethrow;
    }
  }

  ///
  Future<void> _createProofForEveryProofRequest({
    required List<ProofRequestEntity> proofRequests,
    required List<ClaimEntity> claims,
    required IdentityEntity identityEntity,
    required String genesisDid,
    required BigInt profileNonce,
    required String privateKey,
    required KeyId bjjKeyId,
    required String encryptionKey,
    required String? challenge,
    required EnvEntity env,
    required Iden3MessageEntity message,
    required Map<String, dynamic>? transactionData,
    required ProofRepository proofRepository,
    required AuthClaimCompanionObject authClaimCompanionObject,
    required List<Iden3commProofEntity> proofs,
  }) async {
    final groupIdLinkNonceMap = <int, String>{};

    for (int i = 0; i < proofRequests.length; i++) {
      ProofRequestEntity proofRequest = proofRequests[i];
      ClaimEntity claim = claims[i];

      if (claim.expiration != null) {
        claim = await _checkCredentialExpirationAndTryRefreshIfExpired(
          claim: claim,
          genesisDid: genesisDid,
          privateKey: privateKey,
        );
      }

      _proofGenerationStepsStreamManager.add(
          "#${i + 1} creating proof for ${proofRequest.scope.query.type}...");

      final appDir = await getApplicationDocumentsDirectory();
      final circuitsDataSource = CircuitsFilesDataSource(appDir);

      final circuitDatFileBytes = await circuitsDataSource
          .loadCircuitDatFile(proofRequest.scope.circuitId);
      final zkeyFilePath = await circuitsDataSource
          .getZkeyFilePath(proofRequest.scope.circuitId);

      CircuitDataEntity circuitDataEntity = CircuitDataEntity(
        proofRequest.scope.circuitId,
        circuitDatFileBytes,
        zkeyFilePath,
      );

      BigInt claimSubjectProfileNonce = identityEntity.profiles.keys.firstWhere(
          (k) => identityEntity.profiles[k] == claim.did,
          orElse: () => GENESIS_PROFILE_NONCE);

      int? groupId = proofRequest.scope.query.groupId;
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

      if (proofRequest.scope.circuitId == CircuitType.mtponchain.name ||
          proofRequest.scope.circuitId == CircuitType.sigonchain.name ||
          proofRequest.scope.circuitId == CircuitType.circuitsV3onchain.name) {
        /// SIGN MESSAGE

        Uint8List messHash;
        if (challenge!.toLowerCase().startsWith("0x")) {
          messHash = HexUtils.hexToBytes(challenge);
        } else {
          messHash = HexUtils.hexToBytes(
              BigInt.parse(challenge, radix: 10).toRadixString(16));
        }

        signature = HexUtils.bytesToHex(await _kms.sign(bjjKeyId, messHash));
      }

      config = ConfigParam.fromEnv(env).toJson();

      List<String> splittedDid = genesisDid.split(":");
      String id = splittedDid[4];
      Uint8List res = await proofRepository.calculateAtomicQueryInputs(
        id: id,
        profileNonce: profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        claim: claim,
        proofScopeRequest: proofRequest.scope.toJson(),
        circuitId: proofRequest.scope.circuitId,
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
        scopeParams: proofRequest.scope.params,
        transactionData: transactionData,
      );

      final inputsString = Uint8ArrayUtils.uint8ListToString(res);

      dynamic inputsJson = json.decode(inputsString);
      Uint8List atomicQueryInputs = Uint8ArrayUtils.uint8ListfromString(
          json.encode(inputsJson["inputs"]));
      if (kDebugMode) {
        //just for debug
        String inputs = Uint8ArrayUtils.uint8ListToString(atomicQueryInputs);
        logger().i("atomicQueryInputs: $inputs");
      }

      var vpProof;
      if (inputsJson["verifiablePresentation"] != null) {
        vpProof =
            Iden3commVPProof.fromJson(inputsJson["verifiablePresentation"]);
      }

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
            id: proofRequest.scope.id,
            circuitId: proofRequest.scope.circuitId,
            proof: zkProofEntity.proof,
            pubSignals: zkProofEntity.pubSignals,
            vp: vpProof);
      } else {
        proof = Iden3commProofEntity(
          id: proofRequest.scope.id,
          circuitId: proofRequest.scope.circuitId,
          proof: zkProofEntity.proof,
          pubSignals: zkProofEntity.pubSignals,
        );
      }
      proofs.add(proof);
    }
  }

  Future<void> _getCredentialsAndProofRequestsByScope({
    required Iden3MessageEntity message,
    required List<ProofRequestEntity> proofRequests,
    required List<ClaimEntity> claims,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    List<ProofScopeRequest>? scopes = message.body.scope;
    if (scopes == null || scopes.isEmpty) {
      return;
    }

    final groupedByGroupId = groupBy(scopes, (obj) => obj.query.groupId);

    Map<int, List<ClaimEntity>> claimsByGroupId = {};

    final remoteIden3commDS = getItSdk<RemoteIden3commDataSource>();

    // for each group of scopes
    for (final group in groupedByGroupId.entries) {
      int? groupId = group.key;
      if (groupId == null) {
        continue;
      }

      List<FilterEntity> filtersForQueryClaimDb = [];

      List<ProofScopeRequest> groupScopes = group.value;
      for (final scope in groupScopes) {
        final credentialSchema = await remoteIden3commDS.fetchSchema(
          url: scope.query.context!,
        );
        ProofRequestEntity proofRequest = ProofRequestEntity(
          scope,
          credentialSchema,
        );
        ProofRequestFiltersMapper proofRequestFiltersMapper =
            getItSdk<ProofRequestFiltersMapper>();
        List<FilterEntity> filterForSingleScope =
            proofRequestFiltersMapper.mapFrom(proofRequest);
        // we add the filters for each scope to the list of filters
        filtersForQueryClaimDb.addAll(filterForSingleScope);
        // we remove duplicates
        filtersForQueryClaimDb = filtersForQueryClaimDb.toSet().toList();
      }

      FiltersMapper filtersMapper = getItSdk<FiltersMapper>();
      Filter filter = filtersMapper.mapTo(filtersForQueryClaimDb);

      StorageClaimDataSource storageClaimDataSource =
          getItSdk<StorageClaimDataSource>();

      List<ClaimDTO> claimDTO = await storageClaimDataSource.getClaims(
        filter: filter,
        did: genesisDid,
        encryptionKey: encryptionKey,
        credentialSortOrderList: [CredentialSortOrder.IssuanceDateDescending],
      );
      ClaimMapper claimMapper = getItSdk<ClaimMapper>();
      List<ClaimEntity> validClaims =
          claimDTO.map((e) => claimMapper.mapFrom(e)).toList();
      claimsByGroupId[groupId] = validClaims;
    }

    for (final scope in scopes) {
      List<ClaimEntity> validClaims = [];
      final credentialSchema = await remoteIden3commDS.fetchSchema(
        url: scope.query.context!,
      );
      ProofRequestEntity proofRequest = ProofRequestEntity(
        scope,
        credentialSchema,
      );
      proofRequests.add(proofRequest);

      if (scope.query.groupId != null) {
        validClaims = claimsByGroupId[scope.query.groupId] ?? [];
      } else {
        ProofRequestFiltersMapper proofRequestFiltersMapper =
            getItSdk<ProofRequestFiltersMapper>();
        List<FilterEntity> filtersForQueryClaimDb =
            proofRequestFiltersMapper.mapFrom(proofRequest);
        FiltersMapper filtersMapper = getItSdk<FiltersMapper>();
        Filter filter = filtersMapper.mapTo(filtersForQueryClaimDb);

        StorageClaimDataSource storageClaimDataSource =
            getItSdk<StorageClaimDataSource>();

        List<ClaimDTO> claimDTO = await storageClaimDataSource.getClaims(
          filter: filter,
          did: genesisDid,
          encryptionKey: encryptionKey,
          credentialSortOrderList: [CredentialSortOrder.IssuanceDateDescending],
        );
        ClaimMapper claimMapper = getItSdk<ClaimMapper>();
        validClaims = claimDTO.map((e) => claimMapper.mapFrom(e)).toList();
      }

      validClaims = _filterManuallyIfPositiveInteger(
        request: proofRequest,
        claimsFiltered: validClaims,
      );

      validClaims = _filterManuallyIfQueryContainsProofType(
        request: proofRequest,
        claimsFiltered: validClaims,
      );

      if (validClaims.isEmpty) {
        continue;
      }

      final validClaim = validClaims.firstWhereOrNull((element) {
        List<Map<String, dynamic>> proofs = element.info["proof"];
        List<String> proofTypes =
            proofs.map((e) => e["type"] as String).toList();

        final circuitId = scope.circuitId;
        // TODO (moria): remove this with v3 circuit release
        if (circuitId.startsWith(CircuitType.v3CircuitPrefix) &&
            !circuitId.endsWith(CircuitType.currentCircuitBetaPostfix)) {
          _stacktraceManager.addError(
            "[Authenticate] V3 circuit beta version mismatch $circuitId is not supported, current is ${CircuitType.currentCircuitBetaPostfix}",
          );
          throw CircuitNotDownloadedException(
              circuit: circuitId,
              errorMessage:
                  "V3 circuit beta version mismatch $circuitId is not supported, current is ${CircuitType.currentCircuitBetaPostfix}");
        }

        CircuitTypeMapper circuitTypeMapper = getItSdk<CircuitTypeMapper>();
        CircuitType circuitType = circuitTypeMapper.mapTo(circuitId);

        switch (circuitType) {
          case CircuitType.mtp:
          case CircuitType.mtponchain:
            bool success = [
              'Iden3SparseMerkleProof',
              'Iden3SparseMerkleTreeProof'
            ].any((element) => proofTypes.contains(element));
            return success;
          case CircuitType.sig:
          case CircuitType.sigonchain:
            bool success = proofTypes.contains('BJJSignature2021');
            return success;
          case CircuitType.auth:
          case CircuitType.unknown:
            break;
          case CircuitType.circuitsV3:
          case CircuitType.circuitsV3onchain:
          case CircuitType.linkedMultyQuery10:
            bool success = [
              'Iden3SparseMerkleProof',
              'Iden3SparseMerkleTreeProof',
              'BJJSignature2021',
            ].any((element) => proofTypes.contains(element));
            return success;
        }
        return false;
      });

      if (validClaim == null) {
        continue;
      }

      claims.add(validClaim);
    }
  }

  List<ClaimEntity> _filterManuallyIfPositiveInteger({
    required ProofRequestEntity request,
    required List<ClaimEntity> claimsFiltered,
  }) {
    try {
      if (request.scope.query.credentialSubject == null) return claimsFiltered;

      ProofScopeQueryRequest query = request.scope.query;
      Map<String, dynamic>? context =
          request.context["@context"][0][query.type]["@context"];
      if (context == null) return claimsFiltered;

      Map<String, dynamic> requestMap = request.scope.query.credentialSubject!;
      requestMap.forEach((key, map) {
        if (map == null || map is! Map || map.isEmpty) return;

        String type = _getTypeFromNestedObject(context, key);
        if (!type.contains("positiveInteger")) return;

        _processMap(map, key, claimsFiltered);
      });
    } catch (ignored) {
      // Consider logging the exception
    }
    return claimsFiltered;
  }

  void _processMap(dynamic map, String key, List<ClaimEntity> claimsFiltered) {
    map.forEach((operator, needle) {
      _filterClaims(operator, needle, key, claimsFiltered);
    });
  }

  void _filterClaims(String operator, dynamic needle, String key,
      List<ClaimEntity> claimsFiltered) {
    claimsFiltered.removeWhere((element) {
      Map<String, dynamic> credentialSubject =
          element.info["credentialSubject"];
      dynamic value = _getNestedValue(credentialSubject, key);
      if (value != null) {
        BigInt valueBigInt = BigInt.parse(value);
        switch (operator) {
          case '\$gt':
            return valueBigInt <= BigInt.from(needle);
          case '\$gte':
            return valueBigInt < BigInt.from(needle);
          case '\$lt':
            return valueBigInt >= BigInt.from(needle);
          case '\$lte':
            return valueBigInt > BigInt.from(needle);
          case '\$eq':
            return valueBigInt != BigInt.from(needle);
          case '\$neq':
            return valueBigInt == BigInt.from(needle);
          case '\$in':
            List<dynamic> values = List.from(needle);
            List<String> stringList = values.map((e) => e.toString()).toList();
            return !stringList.contains(value);
          case '\$nin':
            List<dynamic> values = List.from(needle);
            List<String> stringList = values.map((e) => e.toString()).toList();
            return stringList.contains(value);
        }
      }
      return false;
    });
  }

  List<ClaimEntity> _filterManuallyIfQueryContainsProofType({
    required ProofRequestEntity request,
    required List<ClaimEntity> claimsFiltered,
  }) {
    try {
      if (request.scope.query.proofType == null ||
          request.scope.query.proofType!.isEmpty) return claimsFiltered;

      String proofType = request.scope.query.proofType!;
      claimsFiltered.removeWhere((element) {
        List<Map<String, dynamic>> proofs = element.info["proof"];
        List<String> proofTypes =
            proofs.map((e) => e["type"] as String).toList();
        return !proofTypes.contains(proofType);
      });
    } catch (ignored) {
      // Consider logging the exception
    }
    return claimsFiltered;
  }

  String _getTypeFromNestedObject(
      Map<String, dynamic> contextMap, String nestedKey) {
    List<String> keys = nestedKey.split('.');
    dynamic value = contextMap;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value[key].containsKey("@context")) {
        value = value[key]["@context"];
      } else if (value is Map<String, dynamic> &&
          value[key].containsKey("@type")) {
        value = value[key]["@type"];
        break;
      } else {
        break;
      }
    }
    return value;
  }

  ///
  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    List<String> keys = key.split('.');
    dynamic value = map;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value.containsKey(key)) {
        value = value[key];
      } else {
        break;
      }
    }
    return value;
  }

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

  /// SIGN MESSAGE WITH BJJ KEY
  Future<String> signMessage({
    required Uint8List privateKey,
    required String message,
  }) async {
    final walletDs = getItSdk<WalletDataSource>();
    return walletDs.signMessage(privateKey: privateKey, message: message);
  }

  Future<String> _getJWSAuthToken({
    required String message,
    required String fromDid,
    required KeyId ethKeyId,
  }) async {
    final kms = getItSdk<KMS>();

    /// I suppose vm-0 is JWZ token verification method
    final header = {
      "alg": "ES256K",

      /// did:iden3:privado:main:2SZDsdYordSH49VhS6hGo164RLwfcQe9FGow5ftSUG#vm-1
      "kid": fromDid + "#vm-1",
      "typ": "application/iden3comm-signed-json",
    };
    final encodedHeader = base64UrlEncode(jsonEncode(header).codeUnits);

    final encodedMessage = base64UrlEncode(message.codeUnits);

    final signingInput = "$encodedHeader.$encodedMessage";
    final signingInputBytes = Uint8List.fromList(signingInput.codeUnits);

    final signatureBytes = await kms.sign(ethKeyId, signingInputBytes);
    final signatureEncoded = base64UrlEncode(signatureBytes);

    final jws = signingInput + '.' + signatureEncoded;

    return jws;
  }

  Future<String> _getJWZAuthToken({
    required String genesisDid,
    required BigInt profileNonce,
    required String privateKey,
    required String message,
    required List<String> authClaim,
    required MTProofEntity incProof,
    required MTProofEntity nonRevProof,
    required Map<String, dynamic> treeState,
    required GistMTProofEntity gistProofEntity,
    required ProofRepository proofRepository,
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

    Uint8List jwzBytes = Uint8ArrayUtils.uint8ListfromString(jwzString);
    Uint8List jwzHash = Uint8List.fromList(sha256.convert(jwzBytes).bytes);

    // Little endianness
    BigInt jwzBigInt = Uint8ArrayUtils.leBuff2int(jwzHash);

    BigInt jwzBigIntNormalized = jwzBigInt.qNormalize();

    String authChallenge = poseidon1([jwzBigIntNormalized]).toString();

    String signature = await signMessage(
      privateKey: HexUtils.hexToBytes(privateKey),
      message: authChallenge,
    );

    final libPolygonIdCoreIden3commDS =
        getItSdk<LibPolygonIdCoreIden3commDataSource>();

    AuthProofMapper authProofMapper = getItSdk<AuthProofMapper>();

    Uint8List authInputsBytes = await libPolygonIdCoreIden3commDS.getAuthInputs(
      genesisDid: genesisDid,
      profileNonce: profileNonce,
      authClaim: authClaim,
      incProof: authProofMapper.mapTo(incProof),
      nonRevProof: authProofMapper.mapTo(nonRevProof),
      gistProof: gistProofEntity.toJson(),
      treeState: treeState,
      challenge: authChallenge,
      signature: signature,
    );

    final appDir = await getApplicationDocumentsDirectory();
    final circuitsDataSource = CircuitsFilesDataSource(appDir);

    final circuitDatFileBytes =
        await circuitsDataSource.loadCircuitDatFile('authV2');
    final zkeyFilePath = await circuitsDataSource.getZkeyFilePath('authV2');

    CircuitDataEntity circuitDataEntity = CircuitDataEntity(
      "authV2",
      circuitDatFileBytes,
      zkeyFilePath,
    );

    Uint8List witnessBytes = await proofRepository.calculateWitness(
      circuitData: circuitDataEntity,
      atomicQueryInputs: authInputsBytes,
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

  Future<AuthClaimCompanionObject> _getAuthClaimData({
    required List<String> publicKey,
    required String encryptionKey,
    required String genesisDid,
    required EnvEntity env,
    required ChainConfigEntity chain,
  }) async {
    /// Fields needed
    final List<String> authClaim;
    final MTProofEntity incProof;
    final MTProofEntity nonRevProof;
    final GistMTProofEntity gistProofEntity;
    final Map<String, dynamic> treeState;

    final identityRepo = await getItSdk.getAsync<IdentityRepository>();

    /// First param
    final localClaimDs = getItSdk<LocalClaimDataSource>();
    authClaim = await localClaimDs.getAuthClaim(publicKey: publicKey);

    final authClaimNode =
        await identityRepo.getAuthClaimNode(children: authClaim);

    /// Second param
    SMTRepository smtRepository = getItSdk<SMTRepository>();
    incProof = await smtRepository.generateProof(
      key: authClaimNode.hash,
      type: TreeType.claims,
      did: genesisDid,
      encryptionKey: encryptionKey,
    );

    /// Third param
    nonRevProof = await smtRepository.generateProof(
      key: authClaimNode.hash,
      type: TreeType.revocation,
      did: genesisDid,
      encryptionKey: encryptionKey,
    );

    /// Fourth param
    final getLatestStateUC = getItSdk<GetLatestStateUseCase>();
    treeState = await getLatestStateUC.execute(
      param: GetLatestStateParam(
        did: genesisDid,
        encryptionKey: encryptionKey,
      ),
    );

    /// Fifth param
    final getGistMTProofUC = getItSdk<GetGistMTProofUseCase>();
    gistProofEntity = await getGistMTProofUC.execute(param: genesisDid);

    return AuthClaimCompanionObject(
      authClaim: authClaim,
      incProof: incProof,
      nonRevProof: nonRevProof,
      gistProofEntity: gistProofEntity,
      treeState: treeState,
    );
  }

  Future<ClaimEntity> _checkCredentialExpirationAndTryRefreshIfExpired({
    required ClaimEntity claim,
    required String genesisDid,
    required String privateKey,
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

      RefreshCredentialUseCase _refreshCredentialUseCase =
          await getItSdk.getAsync<RefreshCredentialUseCase>();

      final refreshedClaimEntity = await _refreshCredentialUseCase.execute(
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
  final List<String> authClaim;
  final MTProofEntity incProof;
  final MTProofEntity nonRevProof;
  final GistMTProofEntity gistProofEntity;
  final Map<String, dynamic> treeState;

  AuthClaimCompanionObject({
    required this.authClaim,
    required this.incProof,
    required this.nonRevProof,
    required this.gistProofEntity,
    required this.treeState,
  });
}
