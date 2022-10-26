// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitAuthStateCopyWith<$Res> {
  factory _$$InitAuthStateCopyWith(
          _$InitAuthState value, $Res Function(_$InitAuthState) then) =
      __$$InitAuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitAuthState>
    implements _$$InitAuthStateCopyWith<$Res> {
  __$$InitAuthStateCopyWithImpl(
      _$InitAuthState _value, $Res Function(_$InitAuthState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitAuthState implements InitAuthState {
  const _$InitAuthState();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitAuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitAuthState implements AuthState {
  const factory InitAuthState() = _$InitAuthState;
}

/// @nodoc
abstract class _$$LoadingAuthStateCopyWith<$Res> {
  factory _$$LoadingAuthStateCopyWith(
          _$LoadingAuthState value, $Res Function(_$LoadingAuthState) then) =
      __$$LoadingAuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingAuthState>
    implements _$$LoadingAuthStateCopyWith<$Res> {
  __$$LoadingAuthStateCopyWithImpl(
      _$LoadingAuthState _value, $Res Function(_$LoadingAuthState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingAuthState implements LoadingAuthState {
  const _$LoadingAuthState();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingAuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingAuthState implements AuthState {
  const factory LoadingAuthState() = _$LoadingAuthState;
}

/// @nodoc
abstract class _$$NavigateToQrCodeScannerAuthStateCopyWith<$Res> {
  factory _$$NavigateToQrCodeScannerAuthStateCopyWith(
          _$NavigateToQrCodeScannerAuthState value,
          $Res Function(_$NavigateToQrCodeScannerAuthState) then) =
      __$$NavigateToQrCodeScannerAuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToQrCodeScannerAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$NavigateToQrCodeScannerAuthState>
    implements _$$NavigateToQrCodeScannerAuthStateCopyWith<$Res> {
  __$$NavigateToQrCodeScannerAuthStateCopyWithImpl(
      _$NavigateToQrCodeScannerAuthState _value,
      $Res Function(_$NavigateToQrCodeScannerAuthState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NavigateToQrCodeScannerAuthState
    implements NavigateToQrCodeScannerAuthState {
  const _$NavigateToQrCodeScannerAuthState();

  @override
  String toString() {
    return 'AuthState.navigateToQrCodeScanner()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigateToQrCodeScannerAuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return navigateToQrCodeScanner();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return navigateToQrCodeScanner?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (navigateToQrCodeScanner != null) {
      return navigateToQrCodeScanner();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return navigateToQrCodeScanner(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return navigateToQrCodeScanner?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (navigateToQrCodeScanner != null) {
      return navigateToQrCodeScanner(this);
    }
    return orElse();
  }
}

abstract class NavigateToQrCodeScannerAuthState implements AuthState {
  const factory NavigateToQrCodeScannerAuthState() =
      _$NavigateToQrCodeScannerAuthState;
}

/// @nodoc
abstract class _$$LoadedAuthStateCopyWith<$Res> {
  factory _$$LoadedAuthStateCopyWith(
          _$LoadedAuthState value, $Res Function(_$LoadedAuthState) then) =
      __$$LoadedAuthStateCopyWithImpl<$Res>;
  @useResult
  $Res call({Iden3Message iden3message});
}

/// @nodoc
class __$$LoadedAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadedAuthState>
    implements _$$LoadedAuthStateCopyWith<$Res> {
  __$$LoadedAuthStateCopyWithImpl(
      _$LoadedAuthState _value, $Res Function(_$LoadedAuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iden3message = null,
  }) {
    return _then(_$LoadedAuthState(
      null == iden3message
          ? _value.iden3message
          : iden3message // ignore: cast_nullable_to_non_nullable
              as Iden3Message,
    ));
  }
}

/// @nodoc

class _$LoadedAuthState implements LoadedAuthState {
  const _$LoadedAuthState(this.iden3message);

  @override
  final Iden3Message iden3message;

  @override
  String toString() {
    return 'AuthState.loaded(iden3message: $iden3message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedAuthState &&
            const DeepCollectionEquality()
                .equals(other.iden3message, iden3message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(iden3message));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedAuthStateCopyWith<_$LoadedAuthState> get copyWith =>
      __$$LoadedAuthStateCopyWithImpl<_$LoadedAuthState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return loaded(iden3message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return loaded?.call(iden3message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(iden3message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedAuthState implements AuthState {
  const factory LoadedAuthState(final Iden3Message iden3message) =
      _$LoadedAuthState;

  Iden3Message get iden3message;
  @JsonKey(ignore: true)
  _$$LoadedAuthStateCopyWith<_$LoadedAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorAuthStateCopyWith<$Res> {
  factory _$$ErrorAuthStateCopyWith(
          _$ErrorAuthState value, $Res Function(_$ErrorAuthState) then) =
      __$$ErrorAuthStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorAuthState>
    implements _$$ErrorAuthStateCopyWith<$Res> {
  __$$ErrorAuthStateCopyWithImpl(
      _$ErrorAuthState _value, $Res Function(_$ErrorAuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorAuthState(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorAuthState implements ErrorAuthState {
  const _$ErrorAuthState(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorAuthState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorAuthStateCopyWith<_$ErrorAuthState> get copyWith =>
      __$$ErrorAuthStateCopyWithImpl<_$ErrorAuthState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorAuthState implements AuthState {
  const factory ErrorAuthState(final String message) = _$ErrorAuthState;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorAuthStateCopyWith<_$ErrorAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticatedAuthStateCopyWith<$Res> {
  factory _$$AuthenticatedAuthStateCopyWith(_$AuthenticatedAuthState value,
          $Res Function(_$AuthenticatedAuthState) then) =
      __$$AuthenticatedAuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedAuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedAuthState>
    implements _$$AuthenticatedAuthStateCopyWith<$Res> {
  __$$AuthenticatedAuthStateCopyWithImpl(_$AuthenticatedAuthState _value,
      $Res Function(_$AuthenticatedAuthState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatedAuthState implements AuthenticatedAuthState {
  const _$AuthenticatedAuthState();

  @override
  String toString() {
    return 'AuthState.authenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedAuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() navigateToQrCodeScanner,
    required TResult Function(Iden3Message iden3message) loaded,
    required TResult Function(String message) error,
    required TResult Function() authenticated,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? navigateToQrCodeScanner,
    TResult? Function(Iden3Message iden3message)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? authenticated,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? navigateToQrCodeScanner,
    TResult Function(Iden3Message iden3message)? loaded,
    TResult Function(String message)? error,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitAuthState value) initial,
    required TResult Function(LoadingAuthState value) loading,
    required TResult Function(NavigateToQrCodeScannerAuthState value)
        navigateToQrCodeScanner,
    required TResult Function(LoadedAuthState value) loaded,
    required TResult Function(ErrorAuthState value) error,
    required TResult Function(AuthenticatedAuthState value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitAuthState value)? initial,
    TResult? Function(LoadingAuthState value)? loading,
    TResult? Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult? Function(LoadedAuthState value)? loaded,
    TResult? Function(ErrorAuthState value)? error,
    TResult? Function(AuthenticatedAuthState value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitAuthState value)? initial,
    TResult Function(LoadingAuthState value)? loading,
    TResult Function(NavigateToQrCodeScannerAuthState value)?
        navigateToQrCodeScanner,
    TResult Function(LoadedAuthState value)? loaded,
    TResult Function(ErrorAuthState value)? error,
    TResult Function(AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedAuthState implements AuthState {
  const factory AuthenticatedAuthState() = _$AuthenticatedAuthState;
}
