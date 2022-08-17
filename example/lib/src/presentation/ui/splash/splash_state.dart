abstract class SplashState {
  SplashState();

  factory SplashState.init() => InitSplashState();

  factory SplashState.waitingTimeEnded() => WaitingTimeEndedSplashState();
}

class InitSplashState extends SplashState {
  InitSplashState();
}

class WaitingTimeEndedSplashState extends SplashState {
  WaitingTimeEndedSplashState();
}
