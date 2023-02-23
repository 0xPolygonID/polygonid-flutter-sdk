import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../../common/domain/entities/filter_entity.dart';
import 'get_proof_requests_use_case.dart';

class GetFiltersUseCase
    extends FutureUseCase<Iden3MessageEntity, List<FilterEntity>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;

  GetFiltersUseCase(
    this._iden3commCredentialRepository,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
  );

  @override
  Future<List<FilterEntity>> execute(
      {required Iden3MessageEntity param}) async {
    List<FilterEntity> filters = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param);

    /// We got [ProofRequestEntity], let's find the associated list of [FilterEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        filters =
            await _iden3commCredentialRepository.getFilters(request: request);
      }
    }

    return filters;
  }
}
