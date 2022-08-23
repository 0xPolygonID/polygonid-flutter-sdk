/*
{
  "type": "https://iden3-communication.io/authorization-response/v1",
  "data": {
    "scope": [
      {
        "type": "zeroknowledge",
        "circuit_id": "auth",
        "pub_signals": [
          "383481829333688262229762912714748186426235428103586432827469388069546950656",
          "12345"
        ],
        "proof_data": {
          "pi_a": [
            "14146277947056297753840642586002829867111675410988595047766001252156753371528",
            "14571022849315211248046007113544986624773029852663683182064313232057584750907",
            "1"
          ],
          "pi_b": [
            [
              "16643510334478363316178974136322830670001098048711963846055396047727066595515",
              "10398230582752448515583571758866992012509398625081722188208617704185602394573"
            ],
            [
              "6754852150473185509183929580585027939167256175425095292505368999953776521762",
              "4988338043999536569468301597030911639875135237017470300699903062776921637682"
            ],
            [
              "1",
              "0"
            ]
          ],
          "pi_c": [
            "17016608018243685488662035612576776697709541343999980909476169114486580874935",
            "1344455328868272682523157740509602348889110849570014394831093852006878298645",
            "1"
          ],
          "protocol": "groth16"
        }
      }
    ]
  }
}


{
  "type": "https://iden3-communication.io/authorization-request/v1",
  "data": {
    "callbackUrl": "https://auth-demo.idyllicvision.com/callback?id=27887",
    "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
    "scope": [
      {
        "circuit_id": "auth",
        "type": "zeroknowledge",
        "rules": {
          "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
          "challenge": 27887
        }
      }
    ]
  }
}


*/

class OfferBodyRequest {
  final String? url;
  final List<CredentialOfferData>? credentials;

  OfferBodyRequest({this.url, this.credentials});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory OfferBodyRequest.fromJson(Map<String, dynamic> json) {
    List<CredentialOfferData>? credentials = (json['credentials'] as List?)
        ?.map((item) => CredentialOfferData.fromJson(item))
        .toList();
    return OfferBodyRequest(
      url: json['url'],
      credentials: credentials,
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'credentials': credentials,
      };
}

class CredentialOfferData {
  final String? id;
  final String? description;

  CredentialOfferData({this.id, this.description});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialOfferData]
  factory CredentialOfferData.fromJson(Map<String, dynamic> json) {
    return CredentialOfferData(
      id: json['id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };
}
