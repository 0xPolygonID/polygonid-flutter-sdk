import '../../domain/repositories/package_info_repository.dart';
import '../data_sources/package_info_datasource.dart';

class PackageInfoRepositoryImpl implements PackageInfoRepository {
  final PackageInfoDataSource _packageInfoDataSource;

  PackageInfoRepositoryImpl(this._packageInfoDataSource);

  @override
  Future<String> getPackageName() {
    return Future.value(_packageInfoDataSource.getPackageName());
  }
}
