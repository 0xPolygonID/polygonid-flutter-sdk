import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/fetch/fetch_request.dart';

import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.fetchRequestJson);

const String from = "theFrom";
const String to = "theTo";
const String id = "theId";

void main() {
  group("FetchRequest", () {
    test("fromJson", () {
      var fetchRequest = FetchRequest.fromJson(json);
      expect(fetchRequest.id, "4dd6479b-99b6-405c-ba9e-c7b18d251a5e");
      expect(fetchRequest.typ, "application/iden3comm-plain-json");
      expect(fetchRequest.type, Iden3MessageType.issuance);
      expect(fetchRequest.thid, "4dd6479b-99b6-405c-ba9e-c7b18d251a5e");
      expect(fetchRequest.from, "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ");
      expect(fetchRequest.to, "1244GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ");
      expect(fetchRequest.body.id, "fe4d9b5e-7b7e-4b9e-8c5a-1b5b4b4e4e4e");
    });
  });
}
