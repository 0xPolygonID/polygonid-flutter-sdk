import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';

class GetLatestStateParam {
  final String did;
  final String privateKey;

  GetLatestStateParam({required this.did, required this.privateKey});
}

class GetLatestStateUseCase
    extends FutureUseCase<GetLatestStateParam, TreeStateEntity> {
  final SMTRepository _smtRepository;

  GetLatestStateUseCase(this._smtRepository);

  @override
  Future<TreeStateEntity> execute({required GetLatestStateParam param}) {
    return Future.wait([
      _smtRepository.getRoot(
        type: TreeType.claims,
        did: param.did,
        privateKey: param.privateKey,
      ),
      _smtRepository.getRoot(
        type: TreeType.revocation,
        did: param.did,
        privateKey: param.privateKey,
      ),
      _smtRepository.getRoot(
        type: TreeType.roots,
        did: param.did,
        privateKey: param.privateKey,
      ),
    ], eagerError: true)
        .then((trees) => _smtRepository
            .hashState(claims: trees[0], revocation: trees[1], roots: trees[2])
            .then((state) => TreeStateEntity(
                state: state,
                claimsTreeRoot: trees[0],
                revocationTreeRoot: trees[1],
                rootOfRoots: trees[2])))
        .then((state) {
      logger().i("[GetLatestStateUseCase] State: $state");

      return state;
    }).catchError((error) {
      logger().e("[GetLatestStateUseCase] Error: $error");

      throw error;
    });
  }
}
