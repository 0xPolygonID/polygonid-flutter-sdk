import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk/sdk/proof.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent {
  const factory SplashEvent.fakeLoadingEvent() = FakeLoadingSplashEvent;
  const factory SplashEvent.downloadProgressEvent(DownloadInfo downloadInfo) = DownloadProgressSplashEvent;
}
