import 'dart:convert';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_response_dto.dart';

class AuthResponseMapper extends FromMapper<AuthResponseDTO, String> {
  @override
  String mapFrom(AuthResponseDTO from) {
    return jsonEncode(from);
  }
}
