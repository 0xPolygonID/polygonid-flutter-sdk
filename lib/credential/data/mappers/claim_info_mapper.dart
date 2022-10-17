import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../dtos/claim_info_dto.dart';

class ClaimInfoMapper extends Mapper<ClaimInfoDTO, Map<String, dynamic>> {
  @override
  Map<String, dynamic> mapFrom(ClaimInfoDTO to) {
    return to.toJson();
  }

  @override
  ClaimInfoDTO mapTo(Map<String, dynamic> from) {
    return ClaimInfoDTO.fromJson(from);
  }
}
