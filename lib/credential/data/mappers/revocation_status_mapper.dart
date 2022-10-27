import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/revocation_status.dart';

class RevocationStatusMapper
    extends Mapper<RevocationStatus, Map<String, dynamic>> {
  @override
  Map<String, dynamic> mapFrom(RevocationStatus from) {
    return from.toJson();
  }

  @override
  RevocationStatus mapTo(Map<String, dynamic> to) {
    return RevocationStatus.fromJson(to);
  }
}
