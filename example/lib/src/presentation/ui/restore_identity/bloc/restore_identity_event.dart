import 'package:freezed_annotation/freezed_annotation.dart';

part 'restore_identity_event.freezed.dart';

@freezed
class RestoreIdentityEvent with _$RestoreIdentityEvent {
  const factory RestoreIdentityEvent.restoreIdentity() = RestoreIdentity;
}
