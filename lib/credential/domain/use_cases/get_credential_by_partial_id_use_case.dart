import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class GetCredentialByPartialIdParam {
  final String partialId;
  final String genesisDid;
  final String privateKey;

  GetCredentialByPartialIdParam({
    required this.partialId,
    required this.genesisDid,
    required this.privateKey,
  });
}

class GetCredentialByPartialIdUseCase
    extends FutureUseCase<GetCredentialByPartialIdParam, ClaimEntity> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  GetCredentialByPartialIdUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<ClaimEntity> execute(
      {required GetCredentialByPartialIdParam param}) async {
    return _credentialRepository.getCredentialByPartialId(
      partialId: param.partialId,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    );
  }
}
