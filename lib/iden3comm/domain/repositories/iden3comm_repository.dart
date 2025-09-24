import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/generate_inputs_response.dart';

abstract class Iden3commRepository {
  Future<Iden3Message?> authenticate({
    required AuthorizationRequestMessage request,
    required String authToken,
  });

  Future<GenerateInputsResponse> getAuthInputs({
    required String genesisDid,
    required BigInt profileNonce,
    required String challenge,
    required List<String> authClaim,
    required IdentityEntity identity,
    required String signature,
    required MTProofEntity incProof,
    required MTProofEntity nonRevProof,
    required GistMTProofEntity gistProof,
    required Map<String, dynamic> treeState,
    Map<String, dynamic>? config,
  });

  Future<String> getAuthResponse({
    required String did,
    required AuthorizationRequestMessage request,
    required List<Iden3commProofEntity> scope,
    DIDDocument? didDocument,
  });

  Future<String> encodeJWZ({required JWZEntity jwz});

  Future<String> getChallenge({required String message});

  Future<void> cleanSchemaCache();
}
