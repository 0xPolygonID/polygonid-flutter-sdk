import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';

abstract class Iden3commRepository {
  Future<void> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  });

  Future<Uint8List> getAuthInputs({
    required String genesisDid,
    required BigInt profileNonce,
    required List<String> authClaim,
    required Map<String, dynamic> incProof,
    required Map<String, dynamic> nonRevProof,
    required Map<String, dynamic> gistProof,
    required Map<String, dynamic> treeState,
    required String challenge,
    required String signature,
  });

  Future<String> getAuthResponse({
    required String did,
    required AuthIden3MessageEntity request,
    required List<JWZProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? packageName,
  });

  Future<String> getChallenge({required String message});
}
