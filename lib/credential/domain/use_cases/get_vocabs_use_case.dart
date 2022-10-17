import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';

import '../../../common/domain/tuples.dart';
import '../../../iden3comm/data/mappers/schema_info_mapper.dart';
import '../repositories/credential_repository.dart';

class GetVocabsUseCase
    extends FutureUseCase<Iden3Message, List<Map<String, dynamic>>> {
  final CredentialRepository _credentialRepository;

  GetVocabsUseCase(this._credentialRepository);

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required Iden3Message param}) async {
    List<Pair<String, String>> schemaInfos = SchemaInfoMapper().mapFrom(param);

    List<Map<String, dynamic>> result = [];

    for (Pair<String, String> schemaInfo in schemaInfos) {
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
