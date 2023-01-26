import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';

import '../../../proof/domain/entities/proof_entity.dart';
import '../entities/identity_entity.dart';
import '../entities/node_entity.dart';
import '../entities/private_identity_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class IdentityRepository {
  // Identity
  Future<void> checkIdentityValidity({
    required String secret,
    required String accessMessage,
    required blockchain,
    required network,
  });

  Future<PrivateIdentityEntity> createIdentity({
    String? secret,
    required String accessMessage,
    required blockchain,
    required network,
  });

  Future<void> storeIdentity(
      {required IdentityEntity identity});

  Future<void> removeIdentity({required String did});

  Future<IdentityEntity> getIdentity({required String did});

  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required DidEntity did, required String privateKey});

  Future<List<IdentityEntity>> getIdentities();

  Future<String> signMessage(
      {required String privateKey, required String message});

  Future<String> getDidIdentifier({
    required String privateKey,
    required String blockchain,
    required String network,
  });

  // RHS
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required int nonce,
      required String baseUrl});

  Future<String> getState(
      {required String identifier, required String contractAddress});

  Future<String> convertIdToBigInt({required String id});

  Future<RhsNodeEntity> getStateRoots({required String url});

  Future<String> getChallenge({required String message});

  Future<NodeEntity> getAuthClaimNode({required List<String> children});

  Future<Map<String, dynamic>> getLatestState({
    required String did,
    required String privateKey,
  });
}
