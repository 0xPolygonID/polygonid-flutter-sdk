import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_identity_state.freezed.dart';

@freezed
class BackupIdentityState with _$BackupIdentityState {
  const factory BackupIdentityState.initial() = InitialBackupIdentityState;

  const factory BackupIdentityState.loading() = LoadingDataBackupIdentityState;

  const factory BackupIdentityState.success(String backup) =
      SuccessBackupIdentityState;

  const factory BackupIdentityState.error(String message) =
      ErrorBackupIdentityState;
}
