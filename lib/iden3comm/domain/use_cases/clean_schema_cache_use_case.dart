import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';

class CleanSchemaCacheUseCase extends FutureUseCase<void, void> {
  final Iden3commRepository _iden3commRepository;

  CleanSchemaCacheUseCase(this._iden3commRepository);

  Future<void> execute({required void param}) async {
    await _iden3commRepository.cleanSchemaCache();
  }
}
