import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_identity_state.freezed.dart';

@freezed
class RestoreIdentityState with _$RestoreIdentityState {
  const factory RestoreIdentityState.initial() = InitialRestoreIdentityState;

  const factory RestoreIdentityState.loading() =
      LoadingDataRestoreIdentityState;

  const factory RestoreIdentityState.success() = SuccessRestoreIdentityState;

  const factory RestoreIdentityState.error(String message) =
      ErrorRestoreIdentityState;
}
