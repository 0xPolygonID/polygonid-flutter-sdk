import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

String authType = "https://iden3-communication.io/authorization/1.0/request";
String offerType = "https://iden3-communication.io/credentials/1.0/offer";
String issuanceType =
    "https://iden3-communication.io/credentials/1.0/issuance-response";
String contractFunctionCallType =
    "https://iden3-communication.io/proofs/1.0/contract-invoke-request";
String otherType = "";

// Tested instance
Iden3MessageTypeDataMapper mapper = Iden3MessageTypeDataMapper();

void main() {
  group('Iden3MessageTypeDataMapper', () {
    test('should return the correct type for auth', () {
      final result = mapper.mapTo(Iden3MessageType.auth);
      expect(result, authType);
    });
    test('should return the correct type for offer', () {
      final result = mapper.mapTo(Iden3MessageType.offer);
      expect(result, offerType);
    });
    test('should return the correct type for issuance', () {
      final result = mapper.mapTo(Iden3MessageType.issuance);
      expect(result, issuanceType);
    });
    test('should return the correct type for contractFunctionCall', () {
      final result = mapper.mapTo(Iden3MessageType.contractFunctionCall);
      expect(result, contractFunctionCallType);
    });
    test('should return the correct type for other', () {
      final result = mapper.mapTo(Iden3MessageType.unknown);
      expect(result, otherType);
    });
  });
}
