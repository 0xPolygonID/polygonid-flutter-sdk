import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart';

class AddDidProfileInfoParam {
  final String genesisDid;
  final String privateKey;
  final String interactedWithDid;
  final Map<String, dynamic> didProfileInfo;

  AddDidProfileInfoParam({
    required this.genesisDid,
    required this.privateKey,
    required this.interactedWithDid,
    required this.didProfileInfo,
  });
}

class AddDidProfileInfoUseCase
    extends FutureUseCase<AddDidProfileInfoParam, void> {
  final DidProfileInfoRepository _didProfileInfoRepository;

  AddDidProfileInfoUseCase(this._didProfileInfoRepository);

  @override
  Future<void> execute({required AddDidProfileInfoParam param}) {
    return _didProfileInfoRepository.addDidProfileInfo(
      didProfileInfo: param.didProfileInfo,
      interactedDid: param.interactedWithDid,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    );
  }
}
