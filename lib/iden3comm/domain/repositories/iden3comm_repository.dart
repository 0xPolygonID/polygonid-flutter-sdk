import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

import '../../../common/domain/entities/filter_entity.dart';
import '../../../credential/domain/entities/claim_entity.dart';
import '../entities/jwz_proof_entity.dart';
import '../entities/proof_request_entity.dart';
import '../entities/request/auth/auth_iden3_message_entity.dart';
import '../entities/request/offer/offer_iden3_message_entity.dart';

abstract class Iden3commRepository {
  Future<void> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  });

  // FIXME: use Entities only from the same part
  Future<Uint8List> getAuthInputs(
      {required String did,
      required int profileNonce,
      required String challenge,
      required List<String> authClaim,
      required IdentityEntity identity,
      required String signature,
      required ProofEntity incProof,
      required ProofEntity nonRevProof,
      required GistProofEntity gistProof,
      required Map<String, dynamic> treeState});

  Future<String> getAuthResponse({
    required String did,
    required AuthIden3MessageEntity request,
    required List<JWZProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? didIdentifier,
    String? packageName,
  });

  Future<String> getChallenge({required String message});

  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request});

  Future<ClaimEntity> fetchClaim({
    required OfferIden3MessageEntity message,
    required String did,
    required String authToken,
  });
}
