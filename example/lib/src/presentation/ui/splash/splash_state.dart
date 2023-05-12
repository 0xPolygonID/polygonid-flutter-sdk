import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

abstract class SplashState {
  SplashState();

  factory SplashState.init() => InitSplashState();

  factory SplashState.waitingTimeEnded() => WaitingTimeEndedSplashState();

  factory SplashState.downloadProgress({
    required int downloaded,
    required int contentLength,
  }) =>
      DownloadProgressSplashState(
        downloaded: downloaded,
        contentLength: contentLength,
      );

  factory SplashState.error({
    required String errorMessage,
  }) =>
      ErrorSplashState(
        errorMessage: errorMessage,
      );
}

class InitSplashState extends SplashState {
  InitSplashState();
}

class WaitingTimeEndedSplashState extends SplashState {
  WaitingTimeEndedSplashState();
}

class DownloadProgressSplashState extends SplashState {
  final int downloaded;
  final int contentLength;

  DownloadProgressSplashState({
    required this.downloaded,
    required this.contentLength,
  });
}

class ErrorSplashState extends SplashState {
  final String errorMessage;

  ErrorSplashState({
    required this.errorMessage,
  });
}
