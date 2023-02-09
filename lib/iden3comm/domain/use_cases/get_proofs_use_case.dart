import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';
import '../../../proof/domain/repositories/proof_repository.dart';
import '../../../proof/domain/use_cases/generate_proof_use_case.dart';
import 'get_proof_requests_use_case.dart';

class GetProofsParam {
  final Iden3MessageEntity message;
  final String did;
  final int profileNonce;
  final String privateKey;
  final String? challenge;

  GetProofsParam(
      {required this.message,
      required this.did,
      required this.profileNonce,
      required this.privateKey,
      this.challenge});
}

class GetProofsUseCase
    extends FutureUseCase<GetProofsParam, List<JWZProofEntity>> {
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final GetClaimsUseCase _getClaimsUseCase;
  final GenerateProofUseCase _generateProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;

  GetProofsUseCase(
    this._proofRepository,
    this._identityRepository,
    this._getClaimsUseCase,
    this._generateProofUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
  );

  @override
  Future<List<JWZProofEntity>> execute({required GetProofsParam param}) async {
    List<JWZProofEntity> proofs = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);

    List<String> publicKey = await _identityRepository
        .getIdentity(
          did: param.did,
        )
        .then((identity) => identity.publicKey);

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    /// and generate [ProofEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        await _proofRepository
            .getFilters(request: request)
            .then((filters) => _getClaimsUseCase.execute(
                    param: GetClaimsParam(
                  filters: filters,
                  did: param.did,
                  privateKey: param.privateKey,
                )))
            .then((claims) => claims.first)
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

          // Generate proof
          proofs.add(await _generateProofUseCase
              .execute(
                  param: GenerateProofParam(
                      param.did,
                      param.profileNonce,
                      0,
                      credential,
                      request.scope,
                      circuitData,
                      privKey,
                      challenge))
              .then((proof) => JWZProofEntity(
                  id: request.scope.id,
                  circuitId: circuitId,
                  proof: proof.proof,
                  pubSignals: proof.pubSignals)));
        }).catchError((_) {}, test: (error) => error is StateError);
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
