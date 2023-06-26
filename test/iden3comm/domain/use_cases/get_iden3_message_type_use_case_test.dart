import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart';

// Data
const types = [
  "https://iden3-communication.io/authorization/1.0/request",
  "https://iden3-communication.io/authorization/1.0/response",
  "https://iden3-communication.io/credentials/1.0/offer",
  "https://iden3-communication.io/credentials/1.0/issuance-response",
  "https://iden3-communication.io/proofs/1.0/contract-invoke-request",
  "theType",
  ""
];
const expectations = [
  Iden3MessageType.authRequest,
  Iden3MessageType.authResponse,
  Iden3MessageType.credentialOffer,
  Iden3MessageType.credentialIssuanceResponse,
  Iden3MessageType.proofContractInvokeRequest,
  Iden3MessageType.unknown,
  Iden3MessageType.unknown
];

// Tested instance
GetIden3MessageTypeUseCase useCase = GetIden3MessageTypeUseCase();

void main() {
  test(
    'Given a string, when I call execute, I expect a Iden3MessageType to be returned',
    () async {
      for (int i = 0; i < types.length; i++) {
        expect(await useCase.execute(param: types[i]), expectations[i]);
      }
    },
  );
}
