import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../dtos/claim_info_dto.dart';

class CredentialInfoMapper extends Mapper<W3CCredential, Map<String, dynamic>> {
  @override
  Map<String, dynamic> mapFrom(W3CCredential to) {
    return to.toJson();
  }

  @override
  W3CCredential mapTo(Map<String, dynamic> from) {
    return W3CCredential.fromJson(from);
  }
}
