import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';

class GetIden3commProofsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final int profileNonce;
  final String privateKey;
  final String? challenge;

  GetIden3commProofsParam(
      {required this.message,
      required this.genesisDid,
      required this.profileNonce,
      required this.privateKey,
      this.challenge});
}

class GetIden3commProofsUseCase
    extends FutureUseCase<GetIden3commProofsParam, List<JWZProofEntity>> {
  final ProofRepository _proofRepository;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GenerateProofUseCase _generateProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;

  GetIden3commProofsUseCase(
    this._proofRepository,
    this._getIden3commClaimsUseCase,
    this._generateProofUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
    this._getIdentityUseCase,
    this._proofGenerationStepsStreamManager,
  );

  @override
  Future<List<JWZProofEntity>> execute(
      {required GetIden3commProofsParam param}) async {
    List<JWZProofEntity> proofs = [];

    _proofGenerationStepsStreamManager.add("Getting proof requests");
    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    /// and generate [ProofEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        await _getIden3commClaimsUseCase
            .execute(
                param: GetIden3commClaimsParam(
                    message: param.message,
                    did: param.genesisDid,
                    profileNonce: 0,
                    privateKey: param.privateKey))
            .then((claim) => claim.first)
            .then((credential) async {
          String circuitId = request.scope.circuitId;
          CircuitDataEntity circuitData =
              await _proofRepository.loadCircuitFiles(circuitId);

          String? challenge;
          String? privKey;
          if (circuitId == "credentialAtomicQuerySigV2OnChain" ||
              circuitId == "credentialAtomicQueryMTPV2OnChain") {
            privKey = param.privateKey;
            challenge = param.challenge;
          }

          var identityEntity = await _getIdentityUseCase.execute(
              param: GetIdentityParam(
                  genesisDid: param.genesisDid, privateKey: param.privateKey));

          int claimSubjectProfileNonce = identityEntity.profiles.keys
              .firstWhere((k) => identityEntity.profiles[k] == credential.did,
                  orElse: () => 0);

          _proofGenerationStepsStreamManager
              .add("Generating proof for ${credential.type}");
          // Generate proof
          proofs.add(await _generateProofUseCase.execute(
              param: GenerateProofParam(
                  param.genesisDid,
                  param.profileNonce,
                  claimSubjectProfileNonce,
                  credential,
                  request.scope,
                  circuitData,
                  privKey,
                  challenge)));
        }).catchError((error) {
          throw error;
        });
      }
    }

    /// If we have requests but didn't get any proofs, we throw
    /// as it could be we didn't find any associated [ClaimEntity]
    if (requests.isNotEmpty && proofs.isEmpty) {
      throw ProofsNotFoundException(requests);
    }

    return proofs;
  }
}
