import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoDataSource {
  final PackageInfo _packageInfo;

  PackageInfoDataSource(this._packageInfo);

  Future<String> getPackageName() async {
    return _packageInfo.packageName;
  }
}
