import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/fetch/fetch_iden3_message_entity.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';

// Data
const typ = "theTyp";
const type = "https://iden3-communication.io/credentials/1.0/fetch-request";
final param =
    GetFetchRequestsParam(Iden3commMocks.offerRequest, CommonMocks.identifier);
const claimIds = ["claimId", "otherClaimId"];

// Tested instance
GetFetchRequestsUseCase useCase = GetFetchRequestsUseCase();

void main() {
  group("Get fetch request", () {
    test(
        "Given a GetFetchRequestsParam, when I call execute, then I expect a list of String to be returned",
        () async {
      // When
      await useCase.execute(param: param).then((requests) {
        for (int i = 0; i < requests.length; i++) {
          /// We suppose [FetchIden3MessageEntity.fromJson] has been tested
          FetchIden3MessageEntity entity =
              FetchIden3MessageEntity.fromJson(jsonDecode(requests[i]));
          expect(entity.typ, typ);
          expect(entity.type, type);
          expect(entity.thid, param.message.thid);
          expect(entity.body.id, claimIds[i]);
          expect(entity.from, param.did);
          expect(entity.to, param.message.from);
        }
      });
    });
  });
}
