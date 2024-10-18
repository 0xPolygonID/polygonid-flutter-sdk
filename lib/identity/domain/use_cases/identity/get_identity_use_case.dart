import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

class GetIdentityParam {
  final String genesisDid;

  GetIdentityParam({
    required this.genesisDid,
  });
}

class GetIdentityUseCase
    extends FutureUseCase<GetIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;
  final StacktraceManager _stacktraceManager;

  GetIdentityUseCase(
    this._identityRepository,
    this._stacktraceManager,
  );

  @override
  Future<IdentityEntity> execute({
    required GetIdentityParam param,
  }) async {
    try {
      // Return [IdentityEntity] with no profiles and no checks
      final identity = await _identityRepository.getIdentity(
        genesisDid: param.genesisDid,
      );
      logger().i("[GetIdentityUseCase] Identity: $identity");
      _stacktraceManager.addTrace(
          "[GetIdentityUseCase] Identity DID: ${identity.did}, public key: ${identity.publicKey}, profiles: ${identity.profiles}");

      return identity;
    } catch (error) {
      logger().e("[GetIdentityUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetIdentityUseCase] Error: $error");
      _stacktraceManager.addError("[GetIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
