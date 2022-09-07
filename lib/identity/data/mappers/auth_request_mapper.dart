import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';

class AuthRequestMapper extends FromMapper<String, AuthRequest> {
  @override
  AuthRequest mapFrom(String from) {
    Map<String, dynamic> param = jsonDecode(from);
    AuthRequest authRequest = AuthRequest.fromJson(param);
    return authRequest;
  }
}
