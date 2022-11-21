import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_detail_state.freezed.dart';

@freezed
class ClaimDetailState with _$ClaimDetailState {
  const factory ClaimDetailState.initial() = InitialClaimDetailState;

  const factory ClaimDetailState.loading() = LoadingClaimDetailState;

  const factory ClaimDetailState.claimDeleted() = ClaimDeletedClaimDetailState;

  const factory ClaimDetailState.error(String message) = ErrorClaimDetailState;
}
