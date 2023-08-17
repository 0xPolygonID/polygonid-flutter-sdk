import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetDidUseCase extends FutureUseCase<String, DidEntity> {
  final IdentityRepository _identityRepository;

  GetDidUseCase(this._identityRepository);

  @override
  Future<DidEntity> execute({required String param}) {
    List<String> splits = param.split(":");

    if (splits.length == 5 && splits[0] == "did" && splits[1] == "polygonid") {
      var did = DidEntity(
        did: param,
        identifier: splits[4],
        blockchain: splits[2],
        network: splits[3],
      );
      logger().i("[GetDidUseCase] DID: $did");

      return Future.value(did);
    } else {
      logger().e("[GetDidUseCase] Error on did string representation");

      throw FormatException;
    }
  }
}
