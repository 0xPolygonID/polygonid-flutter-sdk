import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

class GetGenesisStateUseCase extends FutureUseCase<String, TreeStateEntity> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;

  GetGenesisStateUseCase(
    this._identityRepository,
    this._smtRepository,
    this._getIdentityAuthClaimUseCase,
  );

  @override
  Future<TreeStateEntity> execute({required String param}) {
    String zero = BigInt.zero.toString();

    return _getIdentityAuthClaimUseCase
        .execute(param: param)
        .then((authClaim) =>
            _identityRepository.getAuthClaimNode(children: authClaim))
        .then((node) => _smtRepository
            .hashState(claims: node.hash, revocation: zero, roots: zero)
            .then((state) => TreeStateEntity(
                state: state,
                claimsTreeRoot: node.hash,
                revocationTreeRoot: zero,
                rootOfRoots: zero)))
        .then((state) {
      logger().i("[GetGenesisStateUseCase] State: $state");

      return state;
    }).catchError((error) {
      logger().e("[GetGenesisStateUseCase] Error: $error");

      throw error;
    });
  }
}
