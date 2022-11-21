import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_state.freezed.dart';

@freezed
class SignState with _$SignState {
  const factory SignState.initial({String? signature}) = InitialSignState;

  const factory SignState.loading({String? signature}) = LoadingSignState;

  const factory SignState.loaded({String? signature}) = LoadedSignState;

  const factory SignState.error({required String message, String? signature}) =
      ErrorSignState;
}
