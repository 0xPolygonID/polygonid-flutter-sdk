import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';

import 'common_mocks.dart';

class IdentityMocks {
  static IdentityEntity identity = IdentityEntity(
      did: CommonMocks.did,
      publicKey: CommonMocks.pubKeys,
      profiles: CommonMocks.profiles);

  static PrivateIdentityEntity privateIdentity = PrivateIdentityEntity(
      did: CommonMocks.did,
      publicKey: CommonMocks.pubKeys,
      privateKey: CommonMocks.privateKey,
      profiles: CommonMocks.profiles);

  static DidEntity did = DidEntity(
    did: CommonMocks.did,
    identifier: CommonMocks.identifier,
    blockchain: CommonMocks.blockchain,
    network: CommonMocks.network,
  );

  static HashEntity hash = HashEntity(data: CommonMocks.message);

  static NodeEntity node =
      NodeEntity(hash: hash, children: [hash, hash], nodeType: NodeType.middle);

  static TreeStateEntity treeState =
      TreeStateEntity(CommonMocks.hash, hash, hash, hash);
}
