import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
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
          return addIdentity(secret: call.arguments['secret'] as String?);
  
        case 'getDidIdentifier':
          return _polygonIdSdk.identity.getDidIdentifier(
              privateKey: call.arguments['privateKey'] as String,
              blockchain: call.arguments['blockchain'] as String,
              network: call.arguments['network'] as String);

        case 'getIdentities':
          return _polygonIdSdk.identity.getIdentities().then((identities) =>
              identities.map((identity) => jsonEncode(identity)).toList());

        default:
          throw PlatformException(
              code: 'not_implemented',
              message: 'Method ${call.method} not implemented');
      }
    });
  }

  /// Iden3comm
  @override
  Future<InteractionBaseEntity> addInteraction(
      {required InteractionBaseEntity interaction,
      String? genesisDid,
      String? privateKey}) {
    return _polygonIdSdk.iden3comm.addInteraction(
        interaction: interaction,
        genesisDid: genesisDid,
        privateKey: privateKey);
  }

  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey,
      String? pushToken}) {
    return _polygonIdSdk.iden3comm.authenticate(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        pushToken: pushToken);
  }

  @override
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey}) {
    return _polygonIdSdk.iden3comm.fetchAndSaveClaims(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey);
  }

  @override
  Future<List<ClaimEntity>> getClaimsFromIden3Message(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey}) {
    return _polygonIdSdk.iden3comm.getClaimsFromIden3Message(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey);
  }

  @override
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message}) {
    return _polygonIdSdk.iden3comm.getFilters(message: message);
  }

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    return _polygonIdSdk.iden3comm.getIden3Message(message: message);
  }

  @override
  Future<List<InteractionBaseEntity>> getInteractions(
      {String? genesisDid,
      BigInt? profileNonce,
      String? privateKey,
      List<InteractionType>? types,
      List<InteractionState>? states,
      List<FilterEntity>? filters}) {
    return _polygonIdSdk.iden3comm.getInteractions(
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        types: types,
        states: states,
        filters: filters);
  }

  @override
  Future<List<JWZProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String genesisDid,
      BigInt? profileNonce,
      required String privateKey,
      String? challenge}) {
    return _polygonIdSdk.iden3comm.getProofs(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        challenge: challenge);
  }

  @override
  Future<void> removeInteractions(
      {String? genesisDid, String? privateKey, required List<String> ids}) {
    return _polygonIdSdk.iden3comm.removeInteractions(
        genesisDid: genesisDid, privateKey: privateKey, ids: ids);
  }

  @override
  Future<InteractionBaseEntity> updateInteraction(
      {required String id,
      String? genesisDid,
      String? privateKey,
      InteractionState? state}) {
    return _polygonIdSdk.iden3comm.updateInteraction(
        id: id, genesisDid: genesisDid, privateKey: privateKey, state: state);
  }

  /// Identity
  @override
  Future<PrivateIdentityEntity> addIdentity({String? secret}) {
    return _polygonIdSdk.identity.addIdentity(secret: secret);
  }

  @override
  Future<void> addProfile(
      {required String genesisDid,
      required String privateKey,
      required BigInt profileNonce}) {
    return _polygonIdSdk.identity.addProfile(
        genesisDid: genesisDid,
        privateKey: privateKey,
        profileNonce: profileNonce);
  }

  @override
  Future<String?> backupIdentity(
      {required String genesisDid, required String privateKey}) {
    return _polygonIdSdk.identity
        .backupIdentity(genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<void> checkIdentityValidity({required String secret}) {
    return _polygonIdSdk.identity.checkIdentityValidity(secret: secret);
  }

  @override
  Future<DidEntity> getDidEntity({required String did}) {
    return _polygonIdSdk.identity.getDidEntity(did: did);
  }

  @override
  Future<String> getDidIdentifier(
      {required String privateKey,
      required String blockchain,
      required String network,
      BigInt? profileNonce}) {
    return _polygonIdSdk.identity.getDidIdentifier(
        privateKey: privateKey,
        blockchain: blockchain,
        network: network,
        profileNonce: profileNonce);
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    return _polygonIdSdk.identity.getIdentities();
  }

  @override
  Future<IdentityEntity> getIdentity(
      {required String genesisDid, String? privateKey}) {
    return _polygonIdSdk.identity
        .getIdentity(genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<String> getPrivateKey({required String secret}) {
    return _polygonIdSdk.identity.getPrivateKey(secret: secret);
  }

  @override
  Future<Map<BigInt, String>> getProfiles(
      {required String genesisDid, required String privateKey}) {
    return _polygonIdSdk.identity
        .getProfiles(genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<String> getState({required String did}) {
    return _polygonIdSdk.identity.getState(did: did);
  }

  @override
  Future<void> removeIdentity(
      {required String genesisDid, required String privateKey}) {
    return _polygonIdSdk.identity
        .removeIdentity(genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<void> removeProfile(
      {required String genesisDid,
      required String privateKey,
      required BigInt profileNonce}) {
    return _polygonIdSdk.identity.removeProfile(
        genesisDid: genesisDid,
        privateKey: privateKey,
        profileNonce: profileNonce);
  }

  @override
  Future<PrivateIdentityEntity> restoreIdentity(
      {required String genesisDid,
      required String privateKey,
      String? encryptedDb}) {
    return _polygonIdSdk.identity.restoreIdentity(
        genesisDid: genesisDid,
        privateKey: privateKey,
        encryptedDb: encryptedDb);
  }

  @override
  Future<String> sign({required String privateKey, required String message}) {
    return _polygonIdSdk.identity
        .sign(privateKey: privateKey, message: message);
  }

  /// Credential
  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey}) {
    return _polygonIdSdk.credential.getClaims(
        filters: filters, genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    return _polygonIdSdk.credential.getClaimsByIds(
        claimIds: claimIds, genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<void> removeClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey}) {
    return _polygonIdSdk.credential.removeClaim(
        claimId: claimId, genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    return _polygonIdSdk.credential.removeClaims(
        claimIds: claimIds, genesisDid: genesisDid, privateKey: privateKey);
  }

  @override
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String genesisDid,
      required String privateKey}) {
    return _polygonIdSdk.credential.saveClaims(
        claims: claims, genesisDid: genesisDid, privateKey: privateKey);
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
    return _polygonIdSdk.credential.updateClaim(
        claimId: claimId,
        issuer: issuer,
        genesisDid: genesisDid,
        state: state,
        expiration: expiration,
        type: type,
        data: data,
        privateKey: privateKey);
  }

  /// Proof
  @override
  Future<Stream<DownloadInfo>> get initCircuitsDownloadAndGetInfoStream =>
      _polygonIdSdk.proof.initCircuitsDownloadAndGetInfoStream;

  @override
  Future<bool> isAlreadyDownloadedCircuitsFromServer() {
    return _polygonIdSdk.proof.isAlreadyDownloadedCircuitsFromServer();
  }

  @override
  Stream<String> proofGenerationStepsStream() {
    return _polygonIdSdk.proof.proofGenerationStepsStream();
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
    return _polygonIdSdk.proof.prove(
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        claim: claim,
        circuitData: circuitData,
        request: request,
        privateKey: privateKey,
        challenge: challenge);
  }
}
