import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/entities/filter_entity.dart';
import '../../../common/domain/tuples.dart';
import '../../../common/utils/hex_utils.dart';
import '../../../credential/data/dtos/credential_dto.dart';
import '../../../credential/domain/entities/claim_entity.dart';
import '../../../identity/data/data_sources/wallet_data_source.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../identity/libs/bjj/privadoid_wallet.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../../proof_generation/domain/repositories/proof_repository.dart';
import '../../../proof_generation/domain/use_cases/generate_proof_use_case.dart';
import '../../data/data_sources/proof_scope_data_source.dart';
import '../../data/dtos/request/auth/proof_scope_request.dart';

class GetProofsParam {
  final List<ProofScopeRequest>? proofScopeRequestList;
  final String identifier;

  GetProofsParam(
      {required this.proofScopeRequestList, required this.identifier});
}

class GetProofsUseCase extends FutureUseCase<GetProofsParam,
    List<Pair<ProofScopeRequest, Map<String, dynamic>>>> {
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final ProofScopeDataSource _proofScopeDataSource;
  final WalletDataSource _walletDataSource;
  final GenerateProofUseCase _generateProofUseCase;

  GetProofsUseCase(
    this._proofRepository,
    this._identityRepository,
    this._credentialRepository,
    this._proofScopeDataSource,
    this._walletDataSource,
    this._generateProofUseCase,
  );

  @override
  Future<List<Pair<ProofScopeRequest, Map<String, dynamic>>>> execute(
      {required GetProofsParam param}) async {
    List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofs = [];
    if (param.proofScopeRequestList == null ||
        param.proofScopeRequestList!.isEmpty) {
      return proofs;
    }

    // TODO: check to load correct circuit files
    CircuitDataEntity authData =
        await _proofRepository.loadCircuitFiles("auth");
    IdentityEntity identityEntity =
        await _identityRepository.getIdentity(identifier: param.identifier);

    List<ProofScopeRequest> proofScopeRequestList = _proofScopeDataSource
        .filteredProofScopeRequestList(param.proofScopeRequestList!);

    for (ProofScopeRequest proofReq in proofScopeRequestList) {
      // Get Claims
      List<FilterEntity> filters = _proofScopeDataSource
          .proofScopeRulesQueryRequestFilters(proofReq.rules!.query!);
      List<ClaimEntity> claims =
          await _credentialRepository.getClaims(filters: filters);

      if (claims.isNotEmpty) {
        ClaimEntity authClaim = claims.first;
        CredentialDTO credential = CredentialDTO.fromJson(authClaim.credential);
        // &&
        //circuitDataMap.containsKey(proofReq.circuit_id!)) {

        // TODO load circuitFiles
        String circuitId = proofReq.circuit_id!;

        Map<String, dynamic> queryParams =
            _proofScopeDataSource.getFieldOperatorAndValues(proofReq);

        // Challenge
        String challenge = proofReq.id.toString();
        // Signature
        String? signatureString = await _identityRepository.signMessage(
            identifier: param.identifier, message: challenge);

        // TODO remove when IdentityEntity has the bjj pub keys
        PrivadoIdWallet wallet = await _walletDataSource.createWallet(
            privateKey: HexUtils.hexToBytes(identityEntity.privateKey));

        // Generate proof
        Map<String, dynamic>? proofResult = await _generateProofUseCase.execute(
            param: GenerateProofParam(challenge, signatureString, credential,
                authData, wallet.publicKey, queryParams));

        if (proofResult != null) {
          proofs.add(Pair(proofReq, proofResult));
        }
      }
    }
    return proofs;
  }
}
