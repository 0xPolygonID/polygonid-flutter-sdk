/*
    [
      {proof:
        {pi_a:
         [17260080452766707212363264919996640152121561269290429148255775239840769953665,
          14043381087404145607866247535105418064250401145015621275880100702277525761821,
          1],
         pi_b:
         [
         [10629486532734330043951399643688989432557984817643807053083532208104622702289,
          8014413805870118397367448259230701331036555011199904768710737707426546849903],
         [3133618482877177146385115175470558119953701932593070352938039040197592909173,
          9064999730448073053077182350002607714730125751809020418689087984505489440411],
           [1, 0]],
         pi_c:
          [16628188776571216889874672688228968463010402794314846544093257088906398744285,
           15862885692919665286979090287115880860304822667614336459624074337172615038237,
            1],
         protocol: groth16},
      signals:
        [360506537017543098982364518145035624387547643177965411252793105868750389248,
         12345,
          12051733342209181702880711377819237050140862582923079913097401558944144010618]
      }
      ]
*/

import 'package:polygonid_flutter_sdk/proof_generation/libs/model/proof_data_response.dart';

/*

{"type":"https://iden3-communication.io/credential-fetch-offer/v1",
"data":{"url":"https://auth-demo.idyllicvision.com/cred-callback",
 "issuer":"11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba",
 "schema":"KYCAgeCredential",
 "claim_id":"739bb88d-4f46-4680-a9bf-db1b1f578c60",
 "scope":[{"circuit_id":"auth","type":"zeroknowledge","rules":{"challenge":56675202}}]}}

*/

class ProofResponse {
  String? type = "https://iden3-communication.io/authorization-response/v1";
  late ProofDataResponse? data;

  ProofResponse({
    this.type,
    this.data,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProofResponse]
  factory ProofResponse.fromJson(Map<String, dynamic> json) {
    return ProofResponse(type: json['type'], data: json['data']);
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data!.toJson(),
      };
}
