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

import 'package:polygonid_flutter_sdk/model/proof_scope_data_response.dart';

class ProofScopeResponse {
  String? circuit_id = "auth";
  String? type = "zeroknowledge";
  late List<dynamic>? pub_signals;
  late ProofScopeDataResponse? proof_data;

  ProofScopeResponse(
      {this.circuit_id, this.type, this.pub_signals, this.proof_data});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProofScopeResponse]
  factory ProofScopeResponse.fromJson(Map<String, dynamic> json) {
    return ProofScopeResponse(
        type: json['type'],
        circuit_id: json['circuit_id'],
        pub_signals: json['pub_signals'],
        proof_data: json['proof_data']);
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'circuit_id': circuit_id,
        'pub_signals': pub_signals,
        'proof_data': proof_data!.toJson()
      };
}
