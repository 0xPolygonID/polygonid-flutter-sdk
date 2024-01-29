import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class GetCredentialByIdUseCase
    extends FutureUseCase<GetCredentialByIdParam, ClaimEntity> {
  final CredentialRepository _credentialRepository;

  GetCredentialByIdUseCase(this._credentialRepository);

  Future<ClaimEntity> execute({required GetCredentialByIdParam param}) async {
    return await _credentialRepository.getClaim(
      privateKey: param.privateKey,
      genesisDid: param.genesisDid,
      claimId: param.id,
    );
  }
}

class GetCredentialByIdParam {
  final String id;
  final String privateKey;
  final String genesisDid;

  GetCredentialByIdParam({
    required this.id,
    required this.privateKey,
    required this.genesisDid,
  });
}
