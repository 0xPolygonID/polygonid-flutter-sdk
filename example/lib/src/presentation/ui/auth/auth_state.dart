import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';

abstract class AuthState {
  Iden3Message? iden3message;

  AuthState({this.iden3message});

  factory AuthState.init() => InitAuthState();

  factory AuthState.loading() => LoadingAuthState();

  factory AuthState.loaded(Iden3Message? iden3message) => LoadedAuthState(iden3message);

  factory AuthState.error(String message) => ErrorAuthState(message: message);
}

///
class InitAuthState extends AuthState {
  InitAuthState();
}

///
class LoadingAuthState extends AuthState {
  LoadingAuthState();
}

///
class LoadedAuthState extends AuthState {
  LoadedAuthState(iden3message) : super(iden3message: iden3message);
}

///
class ErrorAuthState<T> extends AuthState {
  final String message;

  ErrorAuthState({required this.message});
}
