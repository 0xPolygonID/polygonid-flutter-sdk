import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_identity_validity_event.freezed.dart';

@freezed
class CheckIdentityValidityEvent with _$CheckIdentityValidityEvent {
  const factory CheckIdentityValidityEvent.checkIdentityValidity(
      {required String secret}) = CheckIdentityValidity;

  const factory CheckIdentityValidityEvent.reset() = ResetCheckIdentityValidity;
}
