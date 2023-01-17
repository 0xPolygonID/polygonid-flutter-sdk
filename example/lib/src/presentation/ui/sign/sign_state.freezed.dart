// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignState {
  String? get signature => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? signature) initial,
    required TResult Function(String? signature) loading,
    required TResult Function(String? signature) loaded,
    required TResult Function(String message, String? signature) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? signature)? initial,
    TResult? Function(String? signature)? loading,
    TResult? Function(String? signature)? loaded,
    TResult? Function(String message, String? signature)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? signature)? initial,
    TResult Function(String? signature)? loading,
    TResult Function(String? signature)? loaded,
    TResult Function(String message, String? signature)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSignState value) initial,
    required TResult Function(LoadingSignState value) loading,
    required TResult Function(LoadedSignState value) loaded,
    required TResult Function(ErrorSignState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialSignState value)? initial,
    TResult? Function(LoadingSignState value)? loading,
    TResult? Function(LoadedSignState value)? loaded,
    TResult? Function(ErrorSignState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSignState value)? initial,
    TResult Function(LoadingSignState value)? loading,
    TResult Function(LoadedSignState value)? loaded,
    TResult Function(ErrorSignState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignStateCopyWith<SignState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignStateCopyWith<$Res> {
  factory $SignStateCopyWith(SignState value, $Res Function(SignState) then) =
      _$SignStateCopyWithImpl<$Res, SignState>;
  @useResult
  $Res call({String? signature});
}

/// @nodoc
class _$SignStateCopyWithImpl<$Res, $Val extends SignState>
    implements $SignStateCopyWith<$Res> {
  _$SignStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = freezed,
  }) {
    return _then(_value.copyWith(
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialSignStateCopyWith<$Res>
    implements $SignStateCopyWith<$Res> {
  factory _$$InitialSignStateCopyWith(
          _$InitialSignState value, $Res Function(_$InitialSignState) then) =
      __$$InitialSignStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? signature});
}

/// @nodoc
class __$$InitialSignStateCopyWithImpl<$Res>
    extends _$SignStateCopyWithImpl<$Res, _$InitialSignState>
    implements _$$InitialSignStateCopyWith<$Res> {
  __$$InitialSignStateCopyWithImpl(
      _$InitialSignState _value, $Res Function(_$InitialSignState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = freezed,
  }) {
    return _then(_$InitialSignState(
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialSignState implements InitialSignState {
  const _$InitialSignState({this.signature});

  @override
  final String? signature;

  @override
  String toString() {
    return 'SignState.initial(signature: $signature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialSignState &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialSignStateCopyWith<_$InitialSignState> get copyWith =>
      __$$InitialSignStateCopyWithImpl<_$InitialSignState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? signature) initial,
    required TResult Function(String? signature) loading,
    required TResult Function(String? signature) loaded,
    required TResult Function(String message, String? signature) error,
  }) {
    return initial(signature);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? signature)? initial,
    TResult? Function(String? signature)? loading,
    TResult? Function(String? signature)? loaded,
    TResult? Function(String message, String? signature)? error,
  }) {
    return initial?.call(signature);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? signature)? initial,
    TResult Function(String? signature)? loading,
    TResult Function(String? signature)? loaded,
    TResult Function(String message, String? signature)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(signature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSignState value) initial,
    required TResult Function(LoadingSignState value) loading,
    required TResult Function(LoadedSignState value) loaded,
    required TResult Function(ErrorSignState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialSignState value)? initial,
    TResult? Function(LoadingSignState value)? loading,
    TResult? Function(LoadedSignState value)? loaded,
    TResult? Function(ErrorSignState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSignState value)? initial,
    TResult Function(LoadingSignState value)? loading,
    TResult Function(LoadedSignState value)? loaded,
    TResult Function(ErrorSignState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialSignState implements SignState {
  const factory InitialSignState({final String? signature}) =
      _$InitialSignState;

  @override
  String? get signature;
  @override
  @JsonKey(ignore: true)
  _$$InitialSignStateCopyWith<_$InitialSignState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingSignStateCopyWith<$Res>
    implements $SignStateCopyWith<$Res> {
  factory _$$LoadingSignStateCopyWith(
          _$LoadingSignState value, $Res Function(_$LoadingSignState) then) =
      __$$LoadingSignStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? signature});
}

/// @nodoc
class __$$LoadingSignStateCopyWithImpl<$Res>
    extends _$SignStateCopyWithImpl<$Res, _$LoadingSignState>
    implements _$$LoadingSignStateCopyWith<$Res> {
  __$$LoadingSignStateCopyWithImpl(
      _$LoadingSignState _value, $Res Function(_$LoadingSignState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = freezed,
  }) {
    return _then(_$LoadingSignState(
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingSignState implements LoadingSignState {
  const _$LoadingSignState({this.signature});

  @override
  final String? signature;

  @override
  String toString() {
    return 'SignState.loading(signature: $signature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingSignState &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingSignStateCopyWith<_$LoadingSignState> get copyWith =>
      __$$LoadingSignStateCopyWithImpl<_$LoadingSignState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? signature) initial,
    required TResult Function(String? signature) loading,
    required TResult Function(String? signature) loaded,
    required TResult Function(String message, String? signature) error,
  }) {
    return loading(signature);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? signature)? initial,
    TResult? Function(String? signature)? loading,
    TResult? Function(String? signature)? loaded,
    TResult? Function(String message, String? signature)? error,
  }) {
    return loading?.call(signature);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? signature)? initial,
    TResult Function(String? signature)? loading,
    TResult Function(String? signature)? loaded,
    TResult Function(String message, String? signature)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(signature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSignState value) initial,
    required TResult Function(LoadingSignState value) loading,
    required TResult Function(LoadedSignState value) loaded,
    required TResult Function(ErrorSignState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialSignState value)? initial,
    TResult? Function(LoadingSignState value)? loading,
    TResult? Function(LoadedSignState value)? loaded,
    TResult? Function(ErrorSignState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSignState value)? initial,
    TResult Function(LoadingSignState value)? loading,
    TResult Function(LoadedSignState value)? loaded,
    TResult Function(ErrorSignState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingSignState implements SignState {
  const factory LoadingSignState({final String? signature}) =
      _$LoadingSignState;

  @override
  String? get signature;
  @override
  @JsonKey(ignore: true)
  _$$LoadingSignStateCopyWith<_$LoadingSignState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedSignStateCopyWith<$Res>
    implements $SignStateCopyWith<$Res> {
  factory _$$LoadedSignStateCopyWith(
          _$LoadedSignState value, $Res Function(_$LoadedSignState) then) =
      __$$LoadedSignStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? signature});
}

/// @nodoc
class __$$LoadedSignStateCopyWithImpl<$Res>
    extends _$SignStateCopyWithImpl<$Res, _$LoadedSignState>
    implements _$$LoadedSignStateCopyWith<$Res> {
  __$$LoadedSignStateCopyWithImpl(
      _$LoadedSignState _value, $Res Function(_$LoadedSignState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = freezed,
  }) {
    return _then(_$LoadedSignState(
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedSignState implements LoadedSignState {
  const _$LoadedSignState({this.signature});

  @override
  final String? signature;

  @override
  String toString() {
    return 'SignState.loaded(signature: $signature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedSignState &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedSignStateCopyWith<_$LoadedSignState> get copyWith =>
      __$$LoadedSignStateCopyWithImpl<_$LoadedSignState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? signature) initial,
    required TResult Function(String? signature) loading,
    required TResult Function(String? signature) loaded,
    required TResult Function(String message, String? signature) error,
  }) {
    return loaded(signature);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? signature)? initial,
    TResult? Function(String? signature)? loading,
    TResult? Function(String? signature)? loaded,
    TResult? Function(String message, String? signature)? error,
  }) {
    return loaded?.call(signature);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? signature)? initial,
    TResult Function(String? signature)? loading,
    TResult Function(String? signature)? loaded,
    TResult Function(String message, String? signature)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(signature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSignState value) initial,
    required TResult Function(LoadingSignState value) loading,
    required TResult Function(LoadedSignState value) loaded,
    required TResult Function(ErrorSignState value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialSignState value)? initial,
    TResult? Function(LoadingSignState value)? loading,
    TResult? Function(LoadedSignState value)? loaded,
    TResult? Function(ErrorSignState value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSignState value)? initial,
    TResult Function(LoadingSignState value)? loading,
    TResult Function(LoadedSignState value)? loaded,
    TResult Function(ErrorSignState value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedSignState implements SignState {
  const factory LoadedSignState({final String? signature}) = _$LoadedSignState;

  @override
  String? get signature;
  @override
  @JsonKey(ignore: true)
  _$$LoadedSignStateCopyWith<_$LoadedSignState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorSignStateCopyWith<$Res>
    implements $SignStateCopyWith<$Res> {
  factory _$$ErrorSignStateCopyWith(
          _$ErrorSignState value, $Res Function(_$ErrorSignState) then) =
      __$$ErrorSignStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? signature});
}

/// @nodoc
class __$$ErrorSignStateCopyWithImpl<$Res>
    extends _$SignStateCopyWithImpl<$Res, _$ErrorSignState>
    implements _$$ErrorSignStateCopyWith<$Res> {
  __$$ErrorSignStateCopyWithImpl(
      _$ErrorSignState _value, $Res Function(_$ErrorSignState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? signature = freezed,
  }) {
    return _then(_$ErrorSignState(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorSignState implements ErrorSignState {
  const _$ErrorSignState({required this.message, this.signature});

  @override
  final String message;
  @override
  final String? signature;

  @override
  String toString() {
    return 'SignState.error(message: $message, signature: $signature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorSignState &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, signature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorSignStateCopyWith<_$ErrorSignState> get copyWith =>
      __$$ErrorSignStateCopyWithImpl<_$ErrorSignState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? signature) initial,
    required TResult Function(String? signature) loading,
    required TResult Function(String? signature) loaded,
    required TResult Function(String message, String? signature) error,
  }) {
    return error(message, signature);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? signature)? initial,
    TResult? Function(String? signature)? loading,
    TResult? Function(String? signature)? loaded,
    TResult? Function(String message, String? signature)? error,
  }) {
    return error?.call(message, signature);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? signature)? initial,
    TResult Function(String? signature)? loading,
    TResult Function(String? signature)? loaded,
    TResult Function(String message, String? signature)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, signature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSignState value) initial,
    required TResult Function(LoadingSignState value) loading,
    required TResult Function(LoadedSignState value) loaded,
    required TResult Function(ErrorSignState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialSignState value)? initial,
    TResult? Function(LoadingSignState value)? loading,
    TResult? Function(LoadedSignState value)? loaded,
    TResult? Function(ErrorSignState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSignState value)? initial,
    TResult Function(LoadingSignState value)? loading,
    TResult Function(LoadedSignState value)? loaded,
    TResult Function(ErrorSignState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorSignState implements SignState {
  const factory ErrorSignState(
      {required final String message,
      final String? signature}) = _$ErrorSignState;

  String get message;
  @override
  String? get signature;
  @override
  @JsonKey(ignore: true)
  _$$ErrorSignStateCopyWith<_$ErrorSignState> get copyWith =>
      throw _privateConstructorUsedError;
}
