import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../../common/domain/entities/filter_entity.dart';
import '../../../credential/domain/entities/claim_entity.dart';
import '../../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import '../../../credential/domain/use_cases/update_claim_use_case.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';
import '../../../proof/domain/repositories/proof_repository.dart';
import '../../../proof/domain/use_cases/generate_proof_use_case.dart';
import 'get_proof_requests_use_case.dart';

class GetFiltersParam {
  final Iden3MessageEntity message;

  GetFiltersParam({
    required this.message,
  });
}

class GetFiltersUseCase
    extends FutureUseCase<GetFiltersParam, List<FilterEntity>> {
  final Iden3commRepository _iden3commRepository;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;

  GetFiltersUseCase(
    this._iden3commRepository,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
  );

  @override
  Future<List<FilterEntity>> execute({required GetFiltersParam param}) async {
    List<FilterEntity> filters = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);

    /// We got [ProofRequestEntity], let's find the associated list of [FilterEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        filters = await _iden3commRepository.getFilters(request: request);
      }
    }

    return filters;
  }
}
