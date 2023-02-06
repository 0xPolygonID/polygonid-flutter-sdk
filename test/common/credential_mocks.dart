import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_header.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

import 'common_mocks.dart';
import 'identity_mocks.dart';

class CredentialMocks {
  static List<String> authClaim = ["good", "auth", "claim"];

  static ClaimEntity claim = ClaimEntity(
    id: CommonMocks.id,
    issuer: CommonMocks.issuer,
    did: CommonMocks.did,
    state: ClaimState.active,
    type: CommonMocks.type,
    info: CommonMocks.aMap,
    schema: CommonMocks.aMap,
    vocab: CommonMocks.aMap,
  );
}
