import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getIdentifier() = GetIdentifierHomeEvent;
  const factory HomeEvent.createIdentity() = CreateIdentityHomeEvent;
  const factory HomeEvent.removeIdentity() = RemoveIdentityHomeEvent;
}
