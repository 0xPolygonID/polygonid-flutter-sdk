import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/domain/common/use_case.dart';

import '../common/domain_logger.dart';
import '../repositories/identity_repository.dart';

class GetIdentityUseCase
    extends FutureUseCase<Uint8List?, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;

  GetIdentityUseCase(this._identityRepository);

  @override
  Future<Map<String, dynamic>> execute({Uint8List? param}) {
    return _identityRepository.createIdentity(privateKey: param).then((pair) {
      logger().i("[GetIdentityUseCase] Identity: $pair");

      return pair;
    }).catchError((error) {
      logger().e("[GetIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
