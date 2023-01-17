import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import 'common_mocks.dart';

class IdentityMocks {
  static IdentityEntity identity = IdentityEntity(
      did: CommonMocks.identifier, publicKey: CommonMocks.pubKeys);

  static PrivateIdentityEntity privateIdentity = PrivateIdentityEntity(
      did: CommonMocks.identifier,
      publicKey: CommonMocks.pubKeys,
      privateKey: CommonMocks.walletPrivateKey);
}
