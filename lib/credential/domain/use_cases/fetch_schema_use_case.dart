import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/entities/filter_entity.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';


class FetchSchemaUseCase
    extends FutureUseCase<String, Map<String,dynamic>> {
  final CredentialRepository _credentialRepository;

  FetchSchemaUseCase(this._credentialRepository);

  @override
  Future<Map<String,dynamic>> execute({required String param}) async {
    return _credentialRepository
        .fetchSchema(
            url: param)
        .then((schema) {
      logger().i("[FetchSchemaUseCase] Schema: $schema");
      return schema;
    }).catchError((error) {
      logger().e("[FetchSchemaUseCase] Error: $error");
      throw error;
    });
  }
}
