import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class CreateIdentityStateParam {
  final String did;
  final String privateKey;

  CreateIdentityStateParam({
    required this.did,
    required this.privateKey,
  });
}

class CreateIdentityStateUseCase
    extends FutureUseCase<CreateIdentityStateParam, void> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;
  final StacktraceManager _stacktraceManager;

  CreateIdentityStateUseCase(
    this._identityRepository,
    this._smtRepository,
    this._getIdentityAuthClaimUseCase,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required CreateIdentityStateParam param}) async {
    return Future.wait(
      [
        _smtRepository.createSMT(
          maxLevels: 40,
          type: TreeType.claims,
          did: param.did,
          privateKey: param.privateKey,
        ),
        _smtRepository.createSMT(
          maxLevels: 40,
          type: TreeType.revocation,
          did: param.did,
          privateKey: param.privateKey,
        ),
        _smtRepository.createSMT(
          maxLevels: 40,
          type: TreeType.roots,
          did: param.did,
          privateKey: param.privateKey,
        ),
      ],
      eagerError: true,
    )
        .then(
          (_) => _getIdentityAuthClaimUseCase.execute(param: param.privateKey),
        )
        .then(
          (authClaim) =>
              _identityRepository.getAuthClaimNode(children: authClaim),
        )
        .then(
          (node) => _smtRepository.addLeaf(
            leaf: node,
            type: TreeType.claims,
            did: param.did,
            privateKey: param.privateKey,
          ),
        )
        .then((_) {
      _stacktraceManager.addTrace("[CreateIdentityStateUseCase] State created");
      logger().i("[CreateIdentityStateUseCase] State created with: $param");
    }).catchError((error) {
      _stacktraceManager.addTrace("[CreateIdentityStateUseCase] Error: $error");
      _stacktraceManager.addError("[CreateIdentityStateUseCase] Error: $error");
      logger().e("[CreateIdentityStateUseCase] Error: $error");
      throw error;
    });
  }
}
