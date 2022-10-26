import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_dto.dart';

import '../../../credential/data/dtos/revocation_status.dart';

enum AtomicQueryInputsType { mtp, sig }

class AtomicQueryInputsParam {
  final AtomicQueryInputsType type;
  final String challenge;
  final String pubX;
  final String pubY;
  final String signature;
  final CredentialDTO credential;
  final String jsonLDDocument;
  final String schema;
  final String key;
  final List<int> values;
  final int operator;
  final RevocationStatus? revocationStatus;

  AtomicQueryInputsParam(
    this.type,
    this.challenge,
    this.pubX,
    this.pubY,
    this.signature,
    this.credential,
    this.jsonLDDocument,
    this.schema,
    this.key,
    this.values,
    this.operator,
    this.revocationStatus,
  );
}
