import 'package:polygonid_flutter_sdk_example/src/data/iden3comm/data_sources/polygonid_sdk_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/iden3comm/repositories/iden3comm_repository.dart';

class Iden3CommRepositoryImpl extends Iden3CommRepository {
  final PolygonIdSdkIden3CommDataSource _polygonIdSdkIden3CommDataSource;

  Iden3CommRepositoryImpl(this._polygonIdSdkIden3CommDataSource);

  @override
  Future<void> authenticate({
    required String issuerMessage,
    required String identifier,
  }) {
    return _polygonIdSdkIden3CommDataSource.authenticate(
      issuerMessage: issuerMessage,
      identifier: identifier,
    );
  }
}
