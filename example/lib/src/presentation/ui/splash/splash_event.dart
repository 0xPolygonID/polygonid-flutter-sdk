import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent {
  const factory SplashEvent.fakeLoadingEvent() = FakeLoadingSplashEvent;
  const factory SplashEvent.downloadProgressEvent(DownloadInfo downloadInfo) = DownloadProgressSplashEvent;
}
