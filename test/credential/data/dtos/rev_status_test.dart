// Import the test package and Counter class
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/rev_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rev_status_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/node_aux_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/proof_mapper.dart';

void main() {
  test('RevocationStatus unmarshall from JSON', () {
    String authRevStatus =
        '{"issuer":{"state":"f6af12f3717056b4b1eacdf4bd4f6ad99a49dd761e36592d9a208fcba6d12c1c","rootOfRoots":"e0efe552623f0d4b590772a524aafa96a423501584f501277193e9b95d7d0f06","claimsTreeRoot":"accc5ba72ab97ab2a3b70ecf00b735bf88403d2f8dfad48378f86099ca034e00","revocationTreeRoot":"4dbfcf2bd0f75817c57cf722669429dafac102bf21343177f904fb84f887270a"},"mtp":{"existence":false,"siblings":[],"node_aux":{"key":"4027912901","value":"0"}}}';

    final RevStatusEntity authRevocationStatus = RevStatusMapper(
            TreeStateMapper(), ProofMapper(HashMapper(), NodeAuxMapper()))
        .mapFrom(json.decode(authRevStatus));

    expect(authRevocationStatus.mtp.existence, false);
    expect(authRevocationStatus.mtp.siblings.length, 0);
    expect(authRevocationStatus.mtp.node_aux?.key, '4027912901');
    expect(authRevocationStatus.mtp.node_aux?.value, '0');
  });

  test('RevocationStatus json', () {
    String authRevStatus =
        '{"issuer":{"state":"f6af12f3717056b4b1eacdf4bd4f6ad99a49dd761e36592d9a208fcba6d12c1c","rootOfRoots":"e0efe552623f0d4b590772a524aafa96a423501584f501277193e9b95d7d0f06","claimsTreeRoot":"accc5ba72ab97ab2a3b70ecf00b735bf88403d2f8dfad48378f86099ca034e00","revocationTreeRoot":"4dbfcf2bd0f75817c57cf722669429dafac102bf21343177f904fb84f887270a"},"mtp":{"existence":false,"siblings":[],"node_aux":{"key":"4027912901","value":"0"}}}';

    final RevStatusEntity authRevocationStatus = RevStatusMapper(
            TreeStateMapper(), ProofMapper(HashMapper(), NodeAuxMapper()))
        .mapFrom(json.decode(authRevStatus));

    expect(jsonEncode(authRevocationStatus.mtp.toJson()),
        '{"existence":false,"siblings":[],"node_aux":{"key":"4027912901","value":"0"}}');
  });
}
