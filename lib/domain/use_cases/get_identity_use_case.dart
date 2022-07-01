import 'package:polygonid_flutter_sdk/domain/common/use_case.dart';

import '../common/domain_logger.dart';
import '../common/tuples.dart';
import '../repositories/identity_repository.dart';

class GetIdentityUseCase extends FutureUseCase<String?, Pair<String, String>> {
  final IdentityRepository _identityRepository;

  GetIdentityUseCase(this._identityRepository);

  @override
  Future<Pair<String, String>> execute({String? param}) {
    return _identityRepository.getIdentity(key: param).then((pair) {
      logger().i("[GetIdentityUseCase] Identity: $pair");

      return pair;
    }).catchError((error) {
      logger().e("[GetIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
