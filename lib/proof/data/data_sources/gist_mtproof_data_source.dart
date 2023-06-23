import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_param.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof/libs/polygonidcore/pidcore_proof.dart';

@injectable
class GistMTProofDataSource {
  GistMTProofDTO getGistMTProof(String gistProof) {
    // remove all quotes from the string values
    final gistProof2 = gistProof.replaceAll("\"", "");

    // now we add quotes to both keys and Strings values
    final quotedString =
        gistProof2.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
      return '"${match.group(0)}"';
    });

    var gistProofJson = jsonDecode(quotedString);

    return GistMTProofDTO(
        root: gistProofJson["root"],
        proof: MTProofDTO(
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
