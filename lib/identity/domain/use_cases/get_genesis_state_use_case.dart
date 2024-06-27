import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

class GetGenesisStateUseCase extends FutureUseCase<String, TreeStateEntity> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;
  final StacktraceManager _stacktraceManager;

  GetGenesisStateUseCase(
    this._identityRepository,
    this._smtRepository,
    this._getIdentityAuthClaimUseCase,
    this._stacktraceManager,
  );

  @override
  Future<TreeStateEntity> execute({required String param}) {
    String zero = BigInt.zero.toString();

    return _getIdentityAuthClaimUseCase
        .execute(param: param)
        .then((authClaim) =>
            _identityRepository.getAuthClaimNode(children: authClaim))
        .then((node) => _smtRepository
            .hashState(
                claims: node.hash.string(), revocation: zero, roots: zero)
            .then((hash) => TreeStateEntity(
                hash, node.hash, HashEntity.zero(), HashEntity.zero())))
        .then((state) {
      _stacktraceManager.addTrace("[GetGenesisStateUseCase] State");
      logger().i("[GetGenesisStateUseCase] State: $state");

      return state;
    }).catchError((error) {
      _stacktraceManager.addTrace("[GetGenesisStateUseCase] Error: $error");
      _stacktraceManager.addError("[GetGenesisStateUseCase] Error: $error");
      logger().e("[GetGenesisStateUseCase] Error: $error");

      throw error;
    });
  }
}
