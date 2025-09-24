import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_event.freezed.dart';

@freezed
sealed class SignEvent with _$SignEvent {
  const factory SignEvent.signMessage(String message) = SignMessageEvent;
}
