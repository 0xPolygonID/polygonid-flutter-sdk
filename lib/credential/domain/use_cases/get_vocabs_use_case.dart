import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../../../common/domain/tuples.dart';
import '../../../sdk/mappers/schema_info_mapper.dart';
import '../repositories/credential_repository.dart';

class GetVocabsUseCase
    extends FutureUseCase<List<Pair<String, String>>, List<Map<String, dynamic>>> {
  final CredentialRepository _credentialRepository;

  GetVocabsUseCase(this._credentialRepository);

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required List<Pair<String, String>> param}) async {
    List<Map<String, dynamic>> result = [];

    for (Pair<String, String> schemaInfo in param) {
      Map<String, dynamic>? schema =
          await _credentialRepository.fetchSchema(url: schemaInfo.first);
      Map<String, dynamic>? vocab = await _credentialRepository.fetchVocab(
          schema: schema, type: schemaInfo.second);
      if (vocab != null) {
        result.add(vocab);
      }
    }
    return result;
  }
}
