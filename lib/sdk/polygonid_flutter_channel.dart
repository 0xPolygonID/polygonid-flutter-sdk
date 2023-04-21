import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/credential.dart';
import 'package:polygonid_flutter_sdk/sdk/iden3comm.dart';
import 'package:polygonid_flutter_sdk/sdk/identity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/sdk/proof.dart';

@injectable
class PolygonIdFlutterChannel
    implements
        PolygonIdSdkIden3comm,
        PolygonIdSdkIdentity,
        PolygonIdSdkCredential,
        PolygonIdSdkProof {
  final PolygonIdSdk _polygonIdSdk;
  final MethodChannel _channel;

  PolygonIdFlutterChannel(this._polygonIdSdk, this._channel) {
    print("PolygonIdFlutterChannel");
    _channel.setMethodCallHandler((call) {
      print(call.method);
      switch (call.method) {
        /// SDK
        case 'init':
          return PolygonIdSdk.init(
              env: call.arguments['env'] != null
                  ? EnvEntity.fromJson(jsonDecode(call.arguments['env']))
                  : null);

        case 'setEnv':
          return _polygonIdSdk.setEnv(
              env: EnvEntity.fromJson(jsonDecode(call.arguments['env'])));

        case 'getEnv':
          return _polygonIdSdk.getEnv().then((env) => jsonEncode(env));

        /// Identity
        case 'addIdentity':
          return _polygonIdSdk.identity
              .addIdentity(secret: call.arguments['secret'] as String?);
        //
        // case 'addProfile':
        //   return _polygonIdSdkWrapper.addProfile(
        //       privateKey: call.arguments['privateKey'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int);
        //
        // case 'backupIdentity':
        //   return _polygonIdSdkWrapper.backupIdentity(
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'checkIdentityValidity':
        //   return _polygonIdSdkWrapper.checkIdentityValidity(
        //       secret: call.arguments['secret'] as String);
        //
        case 'getDidIdentifier':
          return _polygonIdSdk.identity.getDidIdentifier(
              privateKey: call.arguments['privateKey'] as String,
              blockchain: call.arguments['blockchain'] as String,
              network: call.arguments['network'] as String);

        case 'getIdentities':
          return _polygonIdSdk.identity.getIdentities().then((identities) =>
              identities.map((identity) => jsonEncode(identity)).toList());
        //
        // case 'getIdentity':
        //   return _polygonIdSdkWrapper.getIdentity(
        //       genesisDid: call.arguments['genesisDid'] as String,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'getProfiles':
        //   return _polygonIdSdkWrapper.getProfiles(
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'getState':
        //   return _polygonIdSdkWrapper.getState(
        //       did: call.arguments['did'] as String);
        //
        // case 'removeIdentity':
        //   return _polygonIdSdkWrapper.removeIdentity(
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'removeProfile':
        //   return _polygonIdSdkWrapper.removeProfile(
        //       privateKey: call.arguments['privateKey'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int);
        //
        // case 'restoreIdentity':
        //   return _polygonIdSdkWrapper.restoreIdentity(
        //       privateKey: call.arguments['privateKey'] as String,
        //       encryptedIdentityDbs:
        //           call.arguments['encryptedIdentityDbs'] as Map<int, String>);
        //
        // case 'sign':
        //   return _polygonIdSdkWrapper.sign(
        //       privateKey: call.arguments['privateKey'] as String,
        //       message: call.arguments['message'] as String);
        //
        // /// Iden3comm
        // case 'authenticate':
        //   return _polygonIdSdkWrapper.authenticate(
        //       message: call.arguments['message'] as String,
        //       did: call.arguments['did'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int,
        //       privateKey: call.arguments['privateKey'] as String,
        //       pushToken: call.arguments['pushToken'] as String);
        //
        // case 'fetchAndSaveClaims':
        //   return _polygonIdSdkWrapper.fetchAndSaveClaims(
        //       message: call.arguments['message'] as String,
        //       did: call.arguments['did'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'getClaims':
        //   return _polygonIdSdkWrapper.getClaims(
        //       message: call.arguments['message'] as String,
        //       did: call.arguments['did'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'getFilters':
        //   return _polygonIdSdkWrapper.getFilters(
        //       message: call.arguments['message'] as String);
        //
        // case 'getIden3Message':
        //   return _polygonIdSdkWrapper.getIden3Message(
        //       message: call.arguments['message'] as String);
        //
        // case 'getProofs':
        //   return _polygonIdSdkWrapper.getProofs(
        //       message: call.arguments['message'] as String,
        //       did: call.arguments['did'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // /// Proof
        // case 'initCircuitsDownloadAndGetInfoStream':
        //   return _polygonIdSdkWrapper.initCircuitsDownloadAndGetInfoStream();
        //
        // case 'isAlreadyDownloadedCircuitsFromServer':
        //   return _polygonIdSdkWrapper.isAlreadyDownloadedCircuitsFromServer();
        //
        // case 'prove':
        //   return _polygonIdSdkWrapper.prove(
        //       did: call.arguments['did'] as String,
        //       profileNonce: call.arguments['profileNonce'] as int,
        //       claim: call.arguments['claim'] as String,
        //       circuitData: call.arguments['circuitData'] as String,
        //       request: call.arguments['request'] as String,
        //       privateKey: call.arguments['privateKey'] as String,
        //       challenge: call.arguments['challenge'] as String);
        //
        // case 'getClaimsByIds':
        //   return _polygonIdSdkWrapper.getClaimsByIds(
        //       claimIds: call.arguments['claimIds'] as List<String>,
        //       did: call.arguments['did'] as String,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'removeClaim':
        //   return _polygonIdSdkWrapper.removeClaim(
        //       claimId: call.arguments['claimId'] as String,
        //       did: call.arguments['did'] as String,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'removeClaims':
        //   return _polygonIdSdkWrapper.removeClaims(
        //       claimIds: call.arguments['claimIds'] as List<String>,
        //       did: call.arguments['did'] as String,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'saveClaims':
        //   return _polygonIdSdkWrapper.saveClaims(
        //       claims: call.arguments['claims'] as List<String>,
        //       did: call.arguments['did'] as String,
        //       privateKey: call.arguments['privateKey'] as String);
        //
        // case 'updateClaim':
        //   return _polygonIdSdkWrapper.updateClaim(
        //       claimId: call.arguments['claimId'] as String,
        //       issuer: call.arguments['issuer'] as String,
        //       did: call.arguments['did'] as String,
        //       state: call.arguments['state'] as String,
        //       privateKey: call.arguments['privateKey'] as String);

        default:
          throw PlatformException(
              code: 'not_implemented',
              message: 'Method ${call.method} not implemented');
      }
    });
  }

  @override
  Future<PrivateIdentityEntity> addIdentity({String? secret}) {
    // TODO: implement addIdentity
    throw UnimplementedError();
  }

  @override
  Future<InteractionEntity> addInteraction(
      {required InteractionEntity interaction, required String privateKey}) {
    // TODO: implement addInteraction
    throw UnimplementedError();
  }

  @override
  Future<void> addProfile(
      {required String genesisDid,
      required String privateKey,
      required BigInt profileNonce}) {
    // TODO: implement addProfile
    throw UnimplementedError();
  }

  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey,
      String? pushToken}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<String?> backupIdentity(
      {required String genesisDid, required String privateKey}) {
    // TODO: implement backupIdentity
    throw UnimplementedError();
  }

  @override
  Future<void> checkIdentityValidity({required String secret}) {
    // TODO: implement checkIdentityValidity
    throw UnimplementedError();
  }

  @override
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey}) {
    // TODO: implement fetchAndSaveClaims
    throw UnimplementedError();
  }

  @override
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    // TODO: implement getClaimsByIds
    throw UnimplementedError();
  }

  @override
  Future<DidEntity> getDidEntity(String did) {
    // TODO: implement getDidEntity
    throw UnimplementedError();
  }

  @override
  Future<String> getDidIdentifier(
      {required String privateKey,
      required String blockchain,
      required String network,
      BigInt? profileNonce}) {
    // TODO: implement getDidIdentifier
    throw UnimplementedError();
  }

  @override
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message}) {
    // TODO: implement getFilters
    throw UnimplementedError();
  }

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    // TODO: implement getIden3Message
    throw UnimplementedError();
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }

  @override
  Future<IdentityEntity> getIdentity(
      {required String genesisDid, String? privateKey}) {
    // TODO: implement getIdentity
    throw UnimplementedError();
  }

  @override
  Future<List<InteractionEntity>> getInteractions(
      {required String genesisDid,
      BigInt? profileNonce,
      required String privateKey,
      List<InteractionType>? types,
      List<FilterEntity>? filters}) {
    // TODO: implement getInteractions
    throw UnimplementedError();
  }

  @override
  Future<String> getPrivateKey({required String secret}) {
    // TODO: implement getPrivateKey
    throw UnimplementedError();
  }

  @override
  Future<Map<BigInt, String>> getProfiles(
      {required String genesisDid, required String privateKey}) {
    // TODO: implement getProfiles
    throw UnimplementedError();
  }

  @override
  Future<List<JWZProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey,
      String? challenge}) {
    // TODO: implement getProofs
    throw UnimplementedError();
  }

  @override
  Future<String> getState({required String did}) {
    // TODO: implement getState
    throw UnimplementedError();
  }

  @override
  // TODO: implement initCircuitsDownloadAndGetInfoStream
  Future<Stream<DownloadInfo>> get initCircuitsDownloadAndGetInfoStream =>
      throw UnimplementedError();

  @override
  Future<bool> isAlreadyDownloadedCircuitsFromServer() {
    // TODO: implement isAlreadyDownloadedCircuitsFromServer
    throw UnimplementedError();
  }

  @override
  Stream<String> proofGenerationStepsStream() {
    // TODO: implement proofGenerationStepsStream
    throw UnimplementedError();
  }

  @override
  Future<JWZProofEntity> prove(
      {required String genesisDid,
      required BigInt profileNonce,
      required BigInt claimSubjectProfileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge}) {
    // TODO: implement prove
    throw UnimplementedError();
  }

  @override
  Future<void> removeClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey}) {
    // TODO: implement removeClaim
    throw UnimplementedError();
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    // TODO: implement removeClaims
    throw UnimplementedError();
  }

  @override
  Future<void> removeIdentity(
      {required String genesisDid, required String privateKey}) {
    // TODO: implement removeIdentity
    throw UnimplementedError();
  }

  @override
  Future<void> removeInteractions(
      {required String genesisDid,
      required String privateKey,
      required List<String> ids}) {
    // TODO: implement removeInteractions
    throw UnimplementedError();
  }

  @override
  Future<void> removeProfile(
      {required String genesisDid,
      required String privateKey,
      required BigInt profileNonce}) {
    // TODO: implement removeProfile
    throw UnimplementedError();
  }

  @override
  Future<PrivateIdentityEntity> restoreIdentity(
      {required String genesisDid,
      required String privateKey,
      String? encryptedDb}) {
    // TODO: implement restoreIdentity
    throw UnimplementedError();
  }

  @override
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String genesisDid,
      required String privateKey}) {
    // TODO: implement saveClaims
    throw UnimplementedError();
  }

  @override
  Future<String> sign({required String privateKey, required String message}) {
    // TODO: implement sign
    throw UnimplementedError();
  }

  @override
  Future<ClaimEntity> updateClaim(
      {required String claimId,
      String? issuer,
      required String genesisDid,
      ClaimState? state,
      String? expiration,
      String? type,
      Map<String, dynamic>? data,
      required String privateKey}) {
    // TODO: implement updateClaim
    throw UnimplementedError();
  }

  @override
  Future<NotificationEntity> updateNotification(
      {required String id,
      required String genesisDid,
      required String privateKey,
      bool? isRead,
      NotificationState? state}) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }
}
