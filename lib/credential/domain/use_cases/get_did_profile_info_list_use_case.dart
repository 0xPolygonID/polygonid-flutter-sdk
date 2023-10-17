import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart';

class GetDidProfileInfoListParam {
  final String genesisDid;
  final String privateKey;
  final List<FilterEntity>? filters;

  GetDidProfileInfoListParam({
    required this.genesisDid,
    required this.privateKey,
    required this.filters,
  });
}

class GetDidProfileInfoListUseCase
    extends FutureUseCase<GetDidProfileInfoListParam, void> {
  final DidProfileInfoRepository _didProfileInfoRepository;

  GetDidProfileInfoListUseCase(
    this._didProfileInfoRepository,
  );

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required GetDidProfileInfoListParam param}) {
    return _didProfileInfoRepository.getDidProfileInfoList(
      filters: param.filters,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    );
  }
}
