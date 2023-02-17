import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_identity_event.freezed.dart';

@freezed
class BackupIdentityEvent with _$BackupIdentityEvent {
  const factory BackupIdentityEvent.backupIdentity() = BackupIdentity;
}
