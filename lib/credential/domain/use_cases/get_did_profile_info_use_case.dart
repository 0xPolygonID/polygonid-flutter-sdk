import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart';

class GetDidProfileInfoParam {
  final String genesisDid;
  final String privateKey;
  final String interactedWithDid;

  GetDidProfileInfoParam({
    required this.genesisDid,
    required this.privateKey,
    required this.interactedWithDid,
  });
}

class GetDidProfileInfoUseCase
    extends FutureUseCase<GetDidProfileInfoParam, Map<String, dynamic>> {
  final DidProfileInfoRepository _didProfileInfoRepository;

  GetDidProfileInfoUseCase(
    this._didProfileInfoRepository,
  );

  @override
  Future<Map<String, dynamic>> execute(
      {required GetDidProfileInfoParam param}) {
    return _didProfileInfoRepository.getDidProfileInfo(
      interactedDid: param.interactedWithDid,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    );
  }
}
