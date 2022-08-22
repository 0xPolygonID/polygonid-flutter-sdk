import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/credential_request_entity.dart';
import '../dtos/credential_fetch_request.dart';

class CredentialRequestMapper
    extends ToMapper<CredentialFetchRequest, CredentialRequestEntity> {
  @override
  CredentialFetchRequest mapTo(CredentialRequestEntity to) {
    return CredentialFetchRequest(
        id: const Uuid().v4(),
        thid: to.thid,
        to: to.from,
        from: to.identifier,
        typ: "application/iden3comm-plain-json",
        type: "https://iden3-communication.io/credentials/1.0/fetch-request",
        body: CredentialFetchRequestBody(id: to.id));
  }
}
