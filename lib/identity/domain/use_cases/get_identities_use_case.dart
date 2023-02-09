import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';
import 'get_did_use_case.dart';

class GetIdentitiesUseCase
    extends FutureUseCase<void, List<IdentityEntity>> {
  final IdentityRepository _identityRepository;

  GetIdentitiesUseCase(this._identityRepository);

  @override
  Future<List<IdentityEntity>> execute({void param}) {
    return _identityRepository.getIdentities().then((identities) {
            logger().i("[GetIdentitiesUseCase] identities: $identities");

            return identities;
          }).catchError((error) {
            logger().e("[GetIdentitiesUseCase] Error: $error");

            throw error;
          });
  }
}
