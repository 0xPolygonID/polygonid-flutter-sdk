import 'package:polygonid_flutter_sdk/common/domain/repositories/package_info_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class GetPackageNameUseCase extends FutureUseCase<void, String> {
  final PackageInfoRepository _packageInfoRepository;

  GetPackageNameUseCase(this._packageInfoRepository);

  @override
  Future<String> execute({dynamic param}) async {
    return _packageInfoRepository.getPackageName();
  }
}
