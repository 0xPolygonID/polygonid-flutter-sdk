import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/id_description.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';

import '../entities/identity_entity.dart';
import '../entities/node_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class IdentityRepository {
  Future<String> getPrivateKey({
    required String? secret,
  });

  Future<List<String>> getPublicKeys({required privateKey});

  Future<void> storeIdentity({required IdentityEntity identity});

  Future<void> removeIdentity({required String genesisDid});

  Future<IdentityEntity> getIdentity({required String genesisDid});

  Future<List<IdentityEntity>> getIdentities();

  Future<String> signMessage({
    required String privateKey,
    required String message,
  });

  Future<String> getDidIdentifier({
    required String blockchain,
    required String network,
    required String claimsRoot,
    required BigInt profileNonce,
    required EnvConfigEntity config,
  });

  // RHS
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required BigInt nonce,
      required String baseUrl,
      Map<String, dynamic>? cachedNonRevProof});

  Future<String> getState(
      {required String identifier, required String contractAddress});

  Future<String> convertIdToBigInt({required String id});

  Future<IdDescription> describeId({required BigInt id, ConfigParam? config});

  Future<RhsNodeEntity> getStateRoots({required String url});

  Future<NodeEntity> getAuthClaimNode({required List<String> children});

  Future<String> exportIdentity({
    required String did,
    required String privateKey,
  });

  Future<void> importIdentity({
    required String did,
    required String privateKey,
    required String encryptedDb,
  });

  Future<void> putProfiles({
    required String did,
    required String privateKey,
    required Map<BigInt, String> profiles,
  });

  Future<Map<BigInt, String>> getProfiles({
    required String did,
    required String privateKey,
  });
}
