import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
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
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';

class GetIden3commProofsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String? challenge;
  final String? ethereumUrl;
  final String? stateContractAddr;
  final String? ipfsNodeUrl;
  final Map<int, Map<String, dynamic>>? nonRevocationProofs;

  GetIden3commProofsParam(
      {required this.message,
      required this.genesisDid,
      required this.profileNonce,
      required this.privateKey,
      this.challenge,
      this.ethereumUrl,
      this.stateContractAddr,
      this.ipfsNodeUrl,
      this.nonRevocationProofs});
}

class GetIden3commProofsUseCase
    extends FutureUseCase<GetIden3commProofsParam, List<Iden3commProofEntity>> {
  final ProofRepository _proofRepository;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;

  GetIden3commProofsUseCase(
    this._proofRepository,
    this._getIden3commClaimsUseCase,
    this._generateIden3commProofUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
    this._getIdentityUseCase,
    this._proofGenerationStepsStreamManager,
  );

  @override
  Future<List<Iden3commProofEntity>> execute(
      {required GetIden3commProofsParam param}) async {
    try {
      List<Iden3commProofEntity> proofs = [];

      _proofGenerationStepsStreamManager.add("Getting proof requests");
      List<ProofRequestEntity> requests =
          await _getProofRequestsUseCase.execute(param: param.message);

      List<ClaimEntity?> claims = await _getIden3commClaimsUseCase.execute(
          param: GetIden3commClaimsParam(
              message: param.message,
              genesisDid: param.genesisDid,
              profileNonce: param.profileNonce,
              privateKey: param.privateKey,
              nonRevocationProofs: param.nonRevocationProofs ?? {}));

      if ((requests.isNotEmpty &&
              claims.isNotEmpty &&
              requests.length == claims.length) ||
          requests.isEmpty) {
        /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
        /// and generate [ProofEntity]
        for (int i = 0; i < requests.length; i++) {
          ProofRequestEntity request = requests[i];
          ClaimEntity? claim = claims[i];
          if (claim != null &&
              claim.type == request.scope.query.type &&
              await _isProofCircuitSupported.execute(
                  param: request.scope.circuitId)) {
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
                    genesisDid: param.genesisDid,
                    privateKey: param.privateKey));

            BigInt claimSubjectProfileNonce = identityEntity.profiles.keys
                .firstWhere((k) => identityEntity.profiles[k] == claim.did,
                    orElse: () => GENESIS_PROFILE_NONCE);

            _proofGenerationStepsStreamManager
                .add("Generating proof for ${claim.type}");
            // Generate proof
            proofs.add(await _generateIden3commProofUseCase.execute(
                param: GenerateIden3commProofParam(
              param.genesisDid,
              param.profileNonce,
              claimSubjectProfileNonce,
              claim,
              request.scope,
              circuitData,
              privKey,
              challenge,
              param.ethereumUrl,
              param.stateContractAddr,
              param.ipfsNodeUrl,
            )));
          }
        }
      } else {
        throw CredentialsNotFoundException(requests);
      }

      /// If we have requests but didn't get any proofs, we throw
      /// as it could be we didn't find any associated [ClaimEntity]
      if (requests.isNotEmpty && proofs.isEmpty ||
          proofs.length != requests.length) {
        throw ProofsNotFoundException(requests);
      }

      return proofs;
    } catch (e) {
      rethrow;
    }
  }
}
