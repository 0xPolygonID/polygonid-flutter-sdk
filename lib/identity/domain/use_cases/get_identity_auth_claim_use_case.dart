import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

/// Get the public keys as List<String> associated with the @param String privateKey
class GetIdentityAuthClaimUseCase extends FutureUseCase<String, List<String>> {
  final IdentityRepository _identityRepo;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final StacktraceManager _stacktraceManager;

  GetIdentityAuthClaimUseCase(
    this._identityRepo,
    this._getAuthClaimUseCase,
    this._stacktraceManager,
  );

  /// [param] - private key
  @override
  Future<List<String>> execute({required String param}) {
    return Future(() async {
      final pubKeys = await _identityRepo.getPublicKeys(privateKey: param);
      final authClaim = await _getAuthClaimUseCase.execute(param: pubKeys);

      logger().i("[GetIdentityAuthClaimUseCase] AuthClaim is $authClaim");

      return authClaim;
    }).catchError((error) {
      _stacktraceManager
          .addTrace("[GetIdentityAuthClaimUseCase] Error: $error");
      _stacktraceManager
          .addError("[GetIdentityAuthClaimUseCase] Error: $error");
      logger().e("[GetIdentityAuthClaimUseCase] Error: $error");

      throw error;
    });
  }
}
