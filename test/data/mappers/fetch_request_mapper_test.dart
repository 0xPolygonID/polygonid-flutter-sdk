import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/fetch/fetch_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/fetch_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

String data = '''
{
  "id": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "thid": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "body": {
    "id": "fe4d9b5e-7b7e-4b9e-8c5a-1b5b4b4e4e4e"
  }
}
''';

var json = jsonDecode(data);
final fetchRequest = FetchRequest.fromJson(json);

Iden3MessageMapper iden3messageMapper =
    Iden3MessageMapper(Iden3MessageTypeMapper());
Iden3MessageTypeDataMapper iden3messageTypeDataMapper =
    Iden3MessageTypeDataMapper();

// Tested instance
final fetchRequestMapper = FetchRequestMapper(iden3messageTypeDataMapper);

void main() {
  group("FetchRequestMapper", () {
    test("toMapper", () {
      Iden3MessageEntity iden3message = iden3messageMapper.mapFrom(data);
      FetchRequest mapTo = fetchRequestMapper.mapTo(iden3message);
      expect(mapTo.id, fetchRequest.id);
      expect(mapTo.typ, fetchRequest.typ);
      expect(mapTo.from, fetchRequest.from);
      expect(mapTo.type, fetchRequest.type);
      expect(mapTo.thid, fetchRequest.thid);
      expect(mapTo.body?.id, fetchRequest.body?.id);
    });
  });
}
