import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_detail_event.freezed.dart';

@freezed
class ClaimDetailEvent with _$ClaimDetailEvent {
  const factory ClaimDetailEvent.deleteClaim({required String claimId}) =
      DeleteClaimEvent;
}
