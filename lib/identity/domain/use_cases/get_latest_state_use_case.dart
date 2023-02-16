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
    extends FutureUseCase<GetLatestStateParam, Map<String, dynamic>> {
  final SMTRepository _smtRepository;

  GetLatestStateUseCase(this._smtRepository);

  @override
  Future<Map<String, dynamic>> execute({required GetLatestStateParam param}) {
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
            .hashState(
                claims: trees[0].data,
                revocation: trees[1].data,
                roots: trees[2].data)
            .then(
                (hash) => TreeStateEntity(hash, trees[0], trees[1], trees[2])))
        .then((state) => _smtRepository.convertState(state: state))
        .then((state) {
      logger().i("[GetLatestStateUseCase] State: $state");

      return state;
    }).catchError((error) {
      logger().e("[GetLatestStateUseCase] Error: $error");

      throw error;
    });
  }
}
