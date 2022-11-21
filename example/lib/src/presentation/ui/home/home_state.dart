import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({String? identifier}) = InitialHomeState;

  const factory HomeState.loading({String? identifier}) = LoadingDataHomeState;

  const factory HomeState.loaded({String? identifier}) =
      LoadedIdentifierHomeState;

  const factory HomeState.error({required String message, String? identifier}) =
      ErrorHomeState;
}
