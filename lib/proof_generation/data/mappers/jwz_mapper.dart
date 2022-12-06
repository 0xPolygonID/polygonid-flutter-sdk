import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/jwz/jwz_exceptions.dart';

class JWZMapper extends FromMapper<JWZEntity, String> {
  @override
  String mapFrom(JWZEntity from) {
    if (from.header == null) {
      throw NullJWZHeaderException();
    }

    if (from.payload == null) {
      throw NullJWZPayloadException();
    }

    return "${Base64Util.encode64(jsonEncode(from.header))}"
        ".${Base64Util.encode64(from.payload!.payload)}"
        "${from.proof != null ? ".${Base64Util.encode64(jsonEncode(from.proof))}" : ""}";
  }
}
