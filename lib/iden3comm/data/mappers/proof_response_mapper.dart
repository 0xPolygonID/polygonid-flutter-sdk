import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

import '../../../proof_generation/data/dtos/zk_proof.dart';
import '../dtos/response/auth/proof_response.dart';

class ProofResponseMapper
    extends FromMapper<Map<String, dynamic>, ProofResponse> {
  @override
  ProofResponse mapFrom(Map<String, dynamic> from) {
    Map<String, dynamic> proof = from["proof"];
    final zkproof = ZKProof.fromJson(proof);
    return ProofResponse(
        proof: zkproof,
        pubSignals: from["pub_signals"],
        circuitId: from["circuit_id"], //proofRequest.circuit_id!,
        id: from["proof_request_id"]); //proofRequest.id!);
  }
}
