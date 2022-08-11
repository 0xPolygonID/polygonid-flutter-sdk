import 'package:polygonid_flutter_sdk/domain/common/entities/FIlterEntity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';

import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../../identity/repositories/credential_repository.dart';

class GetClaimsUseCase
    extends FutureUseCase<List<FilterEntity>?, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;

  GetClaimsUseCase(this._credentialRepository);

  @override
  Future<List<ClaimEntity>> execute({List<FilterEntity>? param}) async {
    return _credentialRepository.getClaims(filters: param).then((claims) {
      logger().i("[GetClaimsUseCase] Claims: $claims");
      return claims;
    }).catchError((error) {
      logger().e("[GetClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
