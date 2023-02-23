import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

// Data
const states = ["expired", "pending", "revoked", ""];
const stateEnums = [
  ClaimState.expired,
  ClaimState.pending,
  ClaimState.revoked,
  ClaimState.active
];

// Tested instance
ClaimStateMapper mapper = ClaimStateMapper();

void main() {
  group("Map from", () {
    test(
        "Given a string, when I call mapFrom, then I expect an ClaimState to be returned",
        () {
      // When
      for (int i = 0; i < states.length; i++) {
        expect(mapper.mapFrom(states[i]), stateEnums[i]);
      }
    });
  });

  group("Map to", () {
    test(
        "Given a ClaimState, when I call mapTo, then I expect an string to be returned",
        () {
      // When
      for (int i = 0; i < stateEnums.length; i++) {
        expect(mapper.mapTo(stateEnums[i]), states[i]);
      }
    });
  });
}
