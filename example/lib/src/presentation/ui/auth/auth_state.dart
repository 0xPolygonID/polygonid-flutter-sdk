import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState{
  const factory AuthState.initial() = InitAuthState;
  const factory AuthState.loading() = LoadingAuthState;
  const factory AuthState.navigateToQrCodeScanner() = NavigateToQrCodeScannerAuthState;
  const factory AuthState.loaded(Iden3Message iden3message) = LoadedAuthState;
  const factory AuthState.error(String message) = ErrorAuthState;
  const factory AuthState.authenticated() = AuthenticatedAuthState;
}