import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/rpc_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_proof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/proof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

class LocalProofDataSource {
  GistProofDTO getGistProof(Map<String, dynamic> gistProofJson) {
    return GistProofDTO(
        root: gistProofJson["root"],
        proof: ProofDTO(
            existence:
                gistProofJson["proof"]["existence"] == "true" ? true : false,
            siblings: (gistProofJson["proof"]["siblings"] as List)
                .map((hash) => HashDTO.fromBigInt(BigInt.parse(hash)))
                .toList(),
            nodeAux: gistProofJson["proof"]["node_aux"] != null
                ? NodeAuxDTO(
                    key: gistProofJson["proof"]["node_aux"]["key"],
                    value: gistProofJson["proof"]["node_aux"]["value"])
                : null));
  }
}
