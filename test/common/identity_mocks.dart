import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import 'common_mocks.dart';

class IdentityMocks {
  static IdentityEntity identity = IdentityEntity(
      identifier: CommonMocks.identifier, publicKey: CommonMocks.pubKeys);

  static PrivateIdentityEntity privateIdentity = PrivateIdentityEntity(
      identifier: CommonMocks.identifier,
      publicKey: CommonMocks.pubKeys,
      privateKey: CommonMocks.walletPrivateKey);
}
