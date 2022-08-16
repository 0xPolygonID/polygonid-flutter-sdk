abstract class HomeState {
  String? identifier;
  bool isLoadingData = true;

  HomeState({this.identifier});

  factory HomeState.init() => InitHomeState();

  factory HomeState.loading() => LoadingDataHomeState();

  factory HomeState.loaded(String? identifier) => LoadedIdentifierHomeState(identifier);

  factory HomeState.error(String message) => ErrorHomeState(message: message);
}

/// Initial state
class InitHomeState extends HomeState {
  InitHomeState();
}

///
class LoadingDataHomeState extends HomeState {
  LoadingDataHomeState() {
    isLoadingData = true;
  }
}

///
class LoadedIdentifierHomeState extends HomeState {
  LoadedIdentifierHomeState(identifier) : super(identifier: identifier) {
    isLoadingData = false;
  }
}

///
class ErrorHomeState<T> extends HomeState {
  final String message;

  ErrorHomeState({required this.message}) {
    isLoadingData = false;
  }
}
