import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';

import '../repositories/iden3comm_repository.dart';

class GetVocabsUseCase
    extends FutureUseCase<Iden3Message, List<Map<String, dynamic>>> {
  final Iden3commRepository _iden3commRepository;

  GetVocabsUseCase(this._iden3commRepository);

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required Iden3Message param}) async {
    return _iden3commRepository.getVocabs(iden3Message: param);
  }
}
