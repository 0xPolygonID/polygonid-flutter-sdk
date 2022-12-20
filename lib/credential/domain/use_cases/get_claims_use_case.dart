import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/entities/filter_entity.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class GetClaimsParam {
  final List<FilterEntity>? filters;
  final String identifier;
  final String privateKey;

  GetClaimsParam({
    this.filters,
    required this.identifier,
    required this.privateKey,
  });
}

class GetClaimsUseCase
    extends FutureUseCase<GetClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;

  GetClaimsUseCase(this._credentialRepository);

  @override
  Future<List<ClaimEntity>> execute({required GetClaimsParam param}) async {
    return _credentialRepository
        .getClaims(
            filters: param.filters,
            did: param.identifier,
            privateKey: param.privateKey)
        .then((claims) {
      logger().i("[GetClaimsUseCase] Claims: $claims");
      return claims;
    }).catchError((error) {
      logger().e("[GetClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
