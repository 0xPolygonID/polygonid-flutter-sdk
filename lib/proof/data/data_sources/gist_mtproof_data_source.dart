import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_entity.dart';

@injectable
class GistMTProofDataSource {
  GistMTProofEntity getGistMTProof(String gistProof) {
    // remove all quotes from the string values
    final unquotedString = gistProof.replaceAll("\"", "");

    // now we add quotes to both keys and Strings values
    final quotedString = unquotedString.replaceAllMapped(
      RegExp(r'\b\w+\b'),
      (match) {
        return '"${match.group(0)}"';
      },
    );

    var gistProofJson = jsonDecode(quotedString);

    return GistMTProofEntity(
      root: gistProofJson["root"],
      proof: MTProofEntity(
        existence: gistProofJson["proof"]["existence"] == "true" ? true : false,
        siblings: (gistProofJson["proof"]["siblings"] as List)
            .map((hash) => HashEntity.fromBigInt(BigInt.parse(hash)))
            .toList(),
        nodeAux: gistProofJson["proof"]["node_aux"] != null
            ? NodeAuxEntity(
                key: gistProofJson["proof"]["node_aux"]["key"],
                value: gistProofJson["proof"]["node_aux"]["value"])
            : null,
      ),
    );
  }
}
