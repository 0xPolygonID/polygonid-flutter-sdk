import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';

class AuthResponseMapper extends FromMapper<AuthResponse, String> {
  @override
  String mapFrom(AuthResponse from) {
    return jsonEncode(from);
  }
}
