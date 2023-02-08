import 'package:polygonid_flutter_sdk/sdk/proof.dart';

abstract class SplashState {
  SplashState();

  factory SplashState.init() => InitSplashState();

  factory SplashState.waitingTimeEnded() => WaitingTimeEndedSplashState();

  factory SplashState.downloadProgress(DownloadInfo downloadInfo) =>
      DownloadProgressSplashState(downloadInfo);
}

class InitSplashState extends SplashState {
  InitSplashState();
}

class WaitingTimeEndedSplashState extends SplashState {
  WaitingTimeEndedSplashState();
}

class DownloadProgressSplashState extends SplashState {
  final DownloadInfo downloadInfo;

  DownloadProgressSplashState(this.downloadInfo);
}
