import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class PolygonIdSdkIden3CommDataSource {
  final PolygonIdSdk _polygonIdSdk;

  PolygonIdSdkIden3CommDataSource(this._polygonIdSdk);

  ///
  Future<void> authenticate({
    required String issuerMessage,
    required String identifier,
  }) {
    return _polygonIdSdk.iden3comm.authenticate(
      issuerMessage: issuerMessage,
      identifier: identifier,
    );
  }
}
