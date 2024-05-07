import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/jwz_exceptions.dart';

class JWZMapper extends FromMapper<JWZEntity, String> {
  @override
  String mapFrom(JWZEntity from) {
    if (from.header == null) {
      throw NullJWZHeaderException(errorMessage: "JWZ header is null");
    }

    if (from.payload == null) {
      throw NullJWZPayloadException(errorMessage: "JWZ payload is null");
    }

    String header = Base64Util.encode64(jsonEncode(from.header));
    String payload = "." + Base64Util.encode64(from.payload!.payload);
    String proof = from.proof != null
        ? "." + Base64Util.encode64(jsonEncode(from.proof))
        : "";

    return "$header$payload$proof";
  }
}
