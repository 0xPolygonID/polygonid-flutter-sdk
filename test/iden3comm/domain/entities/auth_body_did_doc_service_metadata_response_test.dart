import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_body_did_doc_service_metadata_response.dart';

String data = '''
{
  "devices": [
    {
      "ciphertext": "sIyhw8MsRzFTMXnPvvPnjpj38vVHK9z7w/DvHzX+i/68hSjWfSDjXUA49KopWexyoVsAhenS+AS7+JkatJ3+OTlNxUD+lFrAIJUE51qBiM7l7mmkAuryybUQmOgWJCbuUU2nsWFKzIvk2ZTxcMh5EoUxYV2/0HaTmYYTDkzCKQr/oVePlHbiKwG6XjjMCuNaooSAO7UlLduEZY9CjCWBahiJ7LPHq5+SMCSpA9DdxlYe5IDY7ZT0Yg8fmEAq5+ZGvPVDzk1SdXvZNtG/2yygb3ILrSHXN81ztJRPdsEjzctqWwIhP1zEncSMnNEY4vtxEc1red4PuNT6QX0EoP/aX4LdSGIgfM3KB6yjqKBOqgIGoTFih0h/YzcC42lv4oJw0t5obX+32FM8pzQBUoXMvV0F9WpNgDcN04F3/Su9GGRLFNLXApCtj2Mh4H0qnkjMzRMO42RTd3258HYH7U8xK48hpO0Wolt+rn3jrk/JXrVQqO/9EnhCu/PJL1+AoeVtTYL0zp57OWnIAXbW98MGg0pm0MpYwH51hmHx0YLH+4Fkqj30ydcZQhV3xtAVgvKfxQOwwNz2WhIefm+fwYLVAQB4SjUMOrRQYAos7PWgoc21I0QFu52dIA4IvYYBws2Vjb1LvssdFnrd4kUYbC7THdlWONfunbp9xgofzXTrj2g=",
      "alg": "RSA-OAEP-512"
    }
  ]
}
''';
var json = jsonDecode(data);

main() {
  group("AuthBodyDidDocServiceMetadataResponse", () {
    test("fromJson", () {
      var dto = AuthBodyDidDocServiceMetadataResponse.fromJson(json);
      expect(dto.devices?[0].ciphertext, json["devices"][0]["ciphertext"]);
      expect(dto.devices?[0].alg, json["devices"][0]["alg"]);
    });

    test("toJson", () {
      var authBodyDidDocServiceMetadataResponse =
          AuthBodyDidDocServiceMetadataResponse.fromJson(json);
      expect(authBodyDidDocServiceMetadataResponse.toJson(), json);
    });
  });
}
