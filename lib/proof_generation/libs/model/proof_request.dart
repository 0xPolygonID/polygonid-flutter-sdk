/*
    "BBJAx": "1213652364257902510151929662417166377482228723440905593738842691803502149981",
    "BBJAy": "14676214067024414667976818344434463403313919157482529511753944064776430669351",
    "BBJClaimClaimsTreeRoot": "4097868691633605779443288721202760029772661722531849619505147199061679889928",
    "BBJClaimMtp": ["0", "0", "0", "0"],
    "BBJClaimRevTreeRoot": "0",
    "BBJClaimRootsTreeRoot": "0",
    "challenge": "12345",
    "challengeSignatureR8x": "17117490976969752075917313588219231495899176621058055728822427462930535155358",
    "challengeSignatureR8y": "4481570372340485836597206504051057164694091431728642716350782168839437167003",
    "challengeSignatureS": "1192399849894749028480562760239671791247178472281287874551148245771902000568",
    "id": "371135506535866236563870411357090963344408827476607986362864968105378316288",
    "state": "16751774198505232045539489584666775489135471631443877047826295522719290880931"
*/

class ProofRequest {
  late String? BBJAx;
  late String? BBJAy;
  final String? BBJClaimClaimsTreeRoot;
  List<String>? BBJClaimMtp = ["0", "0", "0", "0"];
  String? BBJClaimRevTreeRoot = "0";
  String? BBJClaimRootsTreeRoot = "0";
  late String? challenge;
  late String? challengeSignatureR8x;
  late String? challengeSignatureR8y;
  late String? challengeSignatureS;
  final String? id;
  final String? state;

  ProofRequest(
      {this.BBJAx,
      this.BBJAy,
      this.BBJClaimClaimsTreeRoot,
      this.BBJClaimMtp,
      this.BBJClaimRevTreeRoot,
      this.BBJClaimRootsTreeRoot,
      this.challenge,
      this.challengeSignatureR8x,
      this.challengeSignatureR8y,
      this.challengeSignatureS,
      this.id,
      this.state});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProofRequest]
  factory ProofRequest.fromJson(Map<String, dynamic> json) {
    return ProofRequest(
        BBJAx: json['BBJAx'],
        BBJAy: json['BBJAy'],
        BBJClaimClaimsTreeRoot: json['BBJClaimClaimsTreeRoot'],
        BBJClaimMtp: json['BBJClaimMtp'],
        BBJClaimRevTreeRoot: json['BBJClaimRevTreeRoot'],
        BBJClaimRootsTreeRoot: json['BBJClaimRootsTreeRoot'],
        challenge: json['challenge'],
        challengeSignatureR8x: json['challengeSignatureR8x'],
        challengeSignatureR8y: json['challengeSignatureR8y'],
        challengeSignatureS: json['challengeSignatureS'],
        id: json['id'],
        state: json['state']);
  }

  Map<String, dynamic> toJson() => {
        'BBJAx': BBJAx,
        'BBJAy': BBJAy,
        'BBJClaimClaimsTreeRoot': BBJClaimClaimsTreeRoot,
        'BBJClaimMtp': BBJClaimMtp,
        'BBJClaimRevTreeRoot': BBJClaimRevTreeRoot,
        'BBJClaimRootsTreeRoot': BBJClaimRootsTreeRoot,
        'challengeSignatureR8x': challengeSignatureR8x,
        'challengeSignatureR8y': challengeSignatureR8y,
        'challengeSignatureS': challengeSignatureS,
        'id': id,
        'state': state,
      };
}
