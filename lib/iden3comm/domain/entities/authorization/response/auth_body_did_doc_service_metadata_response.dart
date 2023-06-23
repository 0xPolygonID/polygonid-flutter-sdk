/*{
"id": "89c423c0-852a-4f6d-91f7-5691b9413516",
"typ": "application/iden3comm-plain-json",
"type": "https://iden3-communication.io/authorization/1.0/response",
"thid": "3ebf0021-ea14-4c0f-b579-b66c2236dab7",
"body": {
"did_doc": {
"@context": [
"https://www.w3.org/ns/did/v1"
],
"id": "did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ",
"service": [
{
"id": "did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ#push",
"type": "push-notification",
"serviceEndpoint": "https://push.polygonid.me/api/v1",
"metadata": {
"devices": [
{
"ciphertext": "sIyhw8MsRzFTMXnPvvPnjpj38vVHK9z7w/DvHzX+i/68hSjWfSDjXUA49KopWexyoVsAhenS+AS7+JkatJ3+OTlNxUD+lFrAIJUE51qBiM7l7mmkAuryybUQmOgWJCbuUU2nsWFKzIvk2ZTxcMh5EoUxYV2/0HaTmYYTDkzCKQr/oVePlHbiKwG6XjjMCuNaooSAO7UlLduEZY9CjCWBahiJ7LPHq5+SMCSpA9DdxlYe5IDY7ZT0Yg8fmEAq5+ZGvPVDzk1SdXvZNtG/2yygb3ILrSHXN81ztJRPdsEjzctqWwIhP1zEncSMnNEY4vtxEc1red4PuNT6QX0EoP/aX4LdSGIgfM3KB6yjqKBOqgIGoTFih0h/YzcC42lv4oJw0t5obX+32FM8pzQBUoXMvV0F9WpNgDcN04F3/Su9GGRLFNLXApCtj2Mh4H0qnkjMzRMO42RTd3258HYH7U8xK48hpO0Wolt+rn3jrk/JXrVQqO/9EnhCu/PJL1+AoeVtTYL0zp57OWnIAXbW98MGg0pm0MpYwH51hmHx0YLH+4Fkqj30ydcZQhV3xtAVgvKfxQOwwNz2WhIefm+fwYLVAQB4SjUMOrRQYAos7PWgoc21I0QFu52dIA4IvYYBws2Vjb1LvssdFnrd4kUYbC7THdlWONfunbp9xgofzXTrj2g=",
"alg": "RSA-OAEP-512"
}
]
}
}
]
},
"message": "message to sign",
"scope": []
},
"from": "119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ",
"to": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"
}*/

import 'auth_body_did_doc_service_metadata_devices_response.dart';

class AuthBodyDidDocServiceMetadataResponse {
  final List<AuthBodyDidDocServiceMetadataDevicesResponse>? devices;

  AuthBodyDidDocServiceMetadataResponse({this.devices});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AuthBodyDidDocServiceMetadataResponse]
  factory AuthBodyDidDocServiceMetadataResponse.fromJson(
      Map<String, dynamic> json) {
    List<AuthBodyDidDocServiceMetadataDevicesResponse>? devices =
        (json['devices'] as List?)
            ?.map((item) =>
                AuthBodyDidDocServiceMetadataDevicesResponse.fromJson(item))
            .toList();
    return AuthBodyDidDocServiceMetadataResponse(
      devices: devices,
    );
  }

  Map<String, dynamic> toJson() => {
        'devices': devices?.map((item) => item.toJson()).toList(),
      };
}
