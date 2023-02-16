import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_identity_validity_state.freezed.dart';

@freezed
class CheckIdentityValidityState with _$CheckIdentityValidityState {
  const factory CheckIdentityValidityState.initial() =
      InitialCheckIdentityValidityState;

  const factory CheckIdentityValidityState.loading() =
      LoadingDataCheckIdentityValidityState;

  const factory CheckIdentityValidityState.success() =
      SuccessCheckIdentityValidityState;

  const factory CheckIdentityValidityState.error(String message) =
      ErrorCheckIdentityValidityState;
}
