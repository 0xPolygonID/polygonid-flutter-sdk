// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  String? get identifier => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? identifier) initial,
    required TResult Function(String? identifier) loading,
    required TResult Function(String? identifier) loaded,
    required TResult Function(String message, String? identifier) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? identifier)? initial,
    TResult? Function(String? identifier)? loading,
    TResult? Function(String? identifier)? loaded,
    TResult? Function(String message, String? identifier)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? identifier)? initial,
    TResult Function(String? identifier)? loading,
    TResult Function(String? identifier)? loaded,
    TResult Function(String message, String? identifier)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialHomeState value) initial,
    required TResult Function(LoadingDataHomeState value) loading,
    required TResult Function(LoadedIdentifierHomeState value) loaded,
    required TResult Function(ErrorHomeState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialHomeState value)? initial,
    TResult? Function(LoadingDataHomeState value)? loading,
    TResult? Function(LoadedIdentifierHomeState value)? loaded,
    TResult? Function(ErrorHomeState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialHomeState value)? initial,
    TResult Function(LoadingDataHomeState value)? loading,
    TResult Function(LoadedIdentifierHomeState value)? loaded,
    TResult Function(ErrorHomeState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({String? identifier});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialHomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$InitialHomeStateCopyWith(
          _$InitialHomeState value, $Res Function(_$InitialHomeState) then) =
      __$$InitialHomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? identifier});
}

/// @nodoc
class __$$InitialHomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$InitialHomeState>
    implements _$$InitialHomeStateCopyWith<$Res> {
  __$$InitialHomeStateCopyWithImpl(
      _$InitialHomeState _value, $Res Function(_$InitialHomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
  }) {
    return _then(_$InitialHomeState(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialHomeState implements InitialHomeState {
  const _$InitialHomeState({this.identifier});

  @override
  final String? identifier;

  @override
  String toString() {
    return 'HomeState.initial(identifier: $identifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialHomeState &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialHomeStateCopyWith<_$InitialHomeState> get copyWith =>
      __$$InitialHomeStateCopyWithImpl<_$InitialHomeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? identifier) initial,
    required TResult Function(String? identifier) loading,
    required TResult Function(String? identifier) loaded,
    required TResult Function(String message, String? identifier) error,
  }) {
    return initial(identifier);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? identifier)? initial,
    TResult? Function(String? identifier)? loading,
    TResult? Function(String? identifier)? loaded,
    TResult? Function(String message, String? identifier)? error,
  }) {
    return initial?.call(identifier);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? identifier)? initial,
    TResult Function(String? identifier)? loading,
    TResult Function(String? identifier)? loaded,
    TResult Function(String message, String? identifier)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(identifier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialHomeState value) initial,
    required TResult Function(LoadingDataHomeState value) loading,
    required TResult Function(LoadedIdentifierHomeState value) loaded,
    required TResult Function(ErrorHomeState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialHomeState value)? initial,
    TResult? Function(LoadingDataHomeState value)? loading,
    TResult? Function(LoadedIdentifierHomeState value)? loaded,
    TResult? Function(ErrorHomeState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialHomeState value)? initial,
    TResult Function(LoadingDataHomeState value)? loading,
    TResult Function(LoadedIdentifierHomeState value)? loaded,
    TResult Function(ErrorHomeState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialHomeState implements HomeState {
  const factory InitialHomeState({final String? identifier}) =
      _$InitialHomeState;

  @override
  String? get identifier;
  @override
  @JsonKey(ignore: true)
  _$$InitialHomeStateCopyWith<_$InitialHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingDataHomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$LoadingDataHomeStateCopyWith(_$LoadingDataHomeState value,
          $Res Function(_$LoadingDataHomeState) then) =
      __$$LoadingDataHomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? identifier});
}

/// @nodoc
class __$$LoadingDataHomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$LoadingDataHomeState>
    implements _$$LoadingDataHomeStateCopyWith<$Res> {
  __$$LoadingDataHomeStateCopyWithImpl(_$LoadingDataHomeState _value,
      $Res Function(_$LoadingDataHomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
  }) {
    return _then(_$LoadingDataHomeState(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingDataHomeState implements LoadingDataHomeState {
  const _$LoadingDataHomeState({this.identifier});

  @override
  final String? identifier;

  @override
  String toString() {
    return 'HomeState.loading(identifier: $identifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingDataHomeState &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingDataHomeStateCopyWith<_$LoadingDataHomeState> get copyWith =>
      __$$LoadingDataHomeStateCopyWithImpl<_$LoadingDataHomeState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? identifier) initial,
    required TResult Function(String? identifier) loading,
    required TResult Function(String? identifier) loaded,
    required TResult Function(String message, String? identifier) error,
  }) {
    return loading(identifier);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? identifier)? initial,
    TResult? Function(String? identifier)? loading,
    TResult? Function(String? identifier)? loaded,
    TResult? Function(String message, String? identifier)? error,
  }) {
    return loading?.call(identifier);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? identifier)? initial,
    TResult Function(String? identifier)? loading,
    TResult Function(String? identifier)? loaded,
    TResult Function(String message, String? identifier)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(identifier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialHomeState value) initial,
    required TResult Function(LoadingDataHomeState value) loading,
    required TResult Function(LoadedIdentifierHomeState value) loaded,
    required TResult Function(ErrorHomeState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialHomeState value)? initial,
    TResult? Function(LoadingDataHomeState value)? loading,
    TResult? Function(LoadedIdentifierHomeState value)? loaded,
    TResult? Function(ErrorHomeState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialHomeState value)? initial,
    TResult Function(LoadingDataHomeState value)? loading,
    TResult Function(LoadedIdentifierHomeState value)? loaded,
    TResult Function(ErrorHomeState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingDataHomeState implements HomeState {
  const factory LoadingDataHomeState({final String? identifier}) =
      _$LoadingDataHomeState;

  @override
  String? get identifier;
  @override
  @JsonKey(ignore: true)
  _$$LoadingDataHomeStateCopyWith<_$LoadingDataHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedIdentifierHomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$LoadedIdentifierHomeStateCopyWith(
          _$LoadedIdentifierHomeState value,
          $Res Function(_$LoadedIdentifierHomeState) then) =
      __$$LoadedIdentifierHomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? identifier});
}

/// @nodoc
class __$$LoadedIdentifierHomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$LoadedIdentifierHomeState>
    implements _$$LoadedIdentifierHomeStateCopyWith<$Res> {
  __$$LoadedIdentifierHomeStateCopyWithImpl(_$LoadedIdentifierHomeState _value,
      $Res Function(_$LoadedIdentifierHomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
  }) {
    return _then(_$LoadedIdentifierHomeState(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedIdentifierHomeState implements LoadedIdentifierHomeState {
  const _$LoadedIdentifierHomeState({this.identifier});

  @override
  final String? identifier;

  @override
  String toString() {
    return 'HomeState.loaded(identifier: $identifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedIdentifierHomeState &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedIdentifierHomeStateCopyWith<_$LoadedIdentifierHomeState>
      get copyWith => __$$LoadedIdentifierHomeStateCopyWithImpl<
          _$LoadedIdentifierHomeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? identifier) initial,
    required TResult Function(String? identifier) loading,
    required TResult Function(String? identifier) loaded,
    required TResult Function(String message, String? identifier) error,
  }) {
    return loaded(identifier);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? identifier)? initial,
    TResult? Function(String? identifier)? loading,
    TResult? Function(String? identifier)? loaded,
    TResult? Function(String message, String? identifier)? error,
  }) {
    return loaded?.call(identifier);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? identifier)? initial,
    TResult Function(String? identifier)? loading,
    TResult Function(String? identifier)? loaded,
    TResult Function(String message, String? identifier)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(identifier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialHomeState value) initial,
    required TResult Function(LoadingDataHomeState value) loading,
    required TResult Function(LoadedIdentifierHomeState value) loaded,
    required TResult Function(ErrorHomeState value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialHomeState value)? initial,
    TResult? Function(LoadingDataHomeState value)? loading,
    TResult? Function(LoadedIdentifierHomeState value)? loaded,
    TResult? Function(ErrorHomeState value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialHomeState value)? initial,
    TResult Function(LoadingDataHomeState value)? loading,
    TResult Function(LoadedIdentifierHomeState value)? loaded,
    TResult Function(ErrorHomeState value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedIdentifierHomeState implements HomeState {
  const factory LoadedIdentifierHomeState({final String? identifier}) =
      _$LoadedIdentifierHomeState;

  @override
  String? get identifier;
  @override
  @JsonKey(ignore: true)
  _$$LoadedIdentifierHomeStateCopyWith<_$LoadedIdentifierHomeState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorHomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$ErrorHomeStateCopyWith(
          _$ErrorHomeState value, $Res Function(_$ErrorHomeState) then) =
      __$$ErrorHomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? identifier});
}

/// @nodoc
class __$$ErrorHomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$ErrorHomeState>
    implements _$$ErrorHomeStateCopyWith<$Res> {
  __$$ErrorHomeStateCopyWithImpl(
      _$ErrorHomeState _value, $Res Function(_$ErrorHomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? identifier = freezed,
  }) {
    return _then(_$ErrorHomeState(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorHomeState implements ErrorHomeState {
  const _$ErrorHomeState({required this.message, this.identifier});

  @override
  final String message;
  @override
  final String? identifier;

  @override
  String toString() {
    return 'HomeState.error(message: $message, identifier: $identifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorHomeState &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, identifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorHomeStateCopyWith<_$ErrorHomeState> get copyWith =>
      __$$ErrorHomeStateCopyWithImpl<_$ErrorHomeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? identifier) initial,
    required TResult Function(String? identifier) loading,
    required TResult Function(String? identifier) loaded,
    required TResult Function(String message, String? identifier) error,
  }) {
    return error(message, identifier);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? identifier)? initial,
    TResult? Function(String? identifier)? loading,
    TResult? Function(String? identifier)? loaded,
    TResult? Function(String message, String? identifier)? error,
  }) {
    return error?.call(message, identifier);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? identifier)? initial,
    TResult Function(String? identifier)? loading,
    TResult Function(String? identifier)? loaded,
    TResult Function(String message, String? identifier)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, identifier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialHomeState value) initial,
    required TResult Function(LoadingDataHomeState value) loading,
    required TResult Function(LoadedIdentifierHomeState value) loaded,
    required TResult Function(ErrorHomeState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialHomeState value)? initial,
    TResult? Function(LoadingDataHomeState value)? loading,
    TResult? Function(LoadedIdentifierHomeState value)? loaded,
    TResult? Function(ErrorHomeState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialHomeState value)? initial,
    TResult Function(LoadingDataHomeState value)? loading,
    TResult Function(LoadedIdentifierHomeState value)? loaded,
    TResult Function(ErrorHomeState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorHomeState implements HomeState {
  const factory ErrorHomeState(
      {required final String message,
      final String? identifier}) = _$ErrorHomeState;

  String get message;
  @override
  String? get identifier;
  @override
  @JsonKey(ignore: true)
  _$$ErrorHomeStateCopyWith<_$ErrorHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
