import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent {
  const factory SplashEvent.fakeLoadingEvent() = FakeLoadingSplashEvent;
}
