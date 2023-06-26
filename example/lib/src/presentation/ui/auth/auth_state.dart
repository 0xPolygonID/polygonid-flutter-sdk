import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = InitAuthState;

  const factory AuthState.loading() = LoadingAuthState;

  const factory AuthState.navigateToQrCodeScanner() =
      NavigateToQrCodeScannerAuthState;

  const factory AuthState.loaded(Iden3MessageEntity iden3message) =
      LoadedAuthState;

  const factory AuthState.error(String message) = ErrorAuthState;

  const factory AuthState.authenticated() = AuthenticatedAuthState;
}
