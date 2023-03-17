// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_identity_validity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CheckIdentityValidityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String secret) checkIdentityValidity,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String secret)? checkIdentityValidity,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String secret)? checkIdentityValidity,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckIdentityValidity value)
        checkIdentityValidity,
    required TResult Function(ResetCheckIdentityValidity value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult? Function(ResetCheckIdentityValidity value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult Function(ResetCheckIdentityValidity value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckIdentityValidityEventCopyWith<$Res> {
  factory $CheckIdentityValidityEventCopyWith(CheckIdentityValidityEvent value,
          $Res Function(CheckIdentityValidityEvent) then) =
      _$CheckIdentityValidityEventCopyWithImpl<$Res,
          CheckIdentityValidityEvent>;
}

/// @nodoc
class _$CheckIdentityValidityEventCopyWithImpl<$Res,
        $Val extends CheckIdentityValidityEvent>
    implements $CheckIdentityValidityEventCopyWith<$Res> {
  _$CheckIdentityValidityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CheckIdentityValidityCopyWith<$Res> {
  factory _$$CheckIdentityValidityCopyWith(_$CheckIdentityValidity value,
          $Res Function(_$CheckIdentityValidity) then) =
      __$$CheckIdentityValidityCopyWithImpl<$Res>;
  @useResult
  $Res call({String secret});
}

/// @nodoc
class __$$CheckIdentityValidityCopyWithImpl<$Res>
    extends _$CheckIdentityValidityEventCopyWithImpl<$Res,
        _$CheckIdentityValidity>
    implements _$$CheckIdentityValidityCopyWith<$Res> {
  __$$CheckIdentityValidityCopyWithImpl(_$CheckIdentityValidity _value,
      $Res Function(_$CheckIdentityValidity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secret = null,
  }) {
    return _then(_$CheckIdentityValidity(
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckIdentityValidity implements CheckIdentityValidity {
  const _$CheckIdentityValidity({required this.secret});

  @override
  final String secret;

  @override
  String toString() {
    return 'CheckIdentityValidityEvent.checkIdentityValidity(secret: $secret)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckIdentityValidity &&
            (identical(other.secret, secret) || other.secret == secret));
  }

  @override
  int get hashCode => Object.hash(runtimeType, secret);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckIdentityValidityCopyWith<_$CheckIdentityValidity> get copyWith =>
      __$$CheckIdentityValidityCopyWithImpl<_$CheckIdentityValidity>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String secret) checkIdentityValidity,
    required TResult Function() reset,
  }) {
    return checkIdentityValidity(secret);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String secret)? checkIdentityValidity,
    TResult? Function()? reset,
  }) {
    return checkIdentityValidity?.call(secret);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String secret)? checkIdentityValidity,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (checkIdentityValidity != null) {
      return checkIdentityValidity(secret);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckIdentityValidity value)
        checkIdentityValidity,
    required TResult Function(ResetCheckIdentityValidity value) reset,
  }) {
    return checkIdentityValidity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult? Function(ResetCheckIdentityValidity value)? reset,
  }) {
    return checkIdentityValidity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult Function(ResetCheckIdentityValidity value)? reset,
    required TResult orElse(),
  }) {
    if (checkIdentityValidity != null) {
      return checkIdentityValidity(this);
    }
    return orElse();
  }
}

abstract class CheckIdentityValidity implements CheckIdentityValidityEvent {
  const factory CheckIdentityValidity({required final String secret}) =
      _$CheckIdentityValidity;

  String get secret;
  @JsonKey(ignore: true)
  _$$CheckIdentityValidityCopyWith<_$CheckIdentityValidity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetCheckIdentityValidityCopyWith<$Res> {
  factory _$$ResetCheckIdentityValidityCopyWith(
          _$ResetCheckIdentityValidity value,
          $Res Function(_$ResetCheckIdentityValidity) then) =
      __$$ResetCheckIdentityValidityCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetCheckIdentityValidityCopyWithImpl<$Res>
    extends _$CheckIdentityValidityEventCopyWithImpl<$Res,
        _$ResetCheckIdentityValidity>
    implements _$$ResetCheckIdentityValidityCopyWith<$Res> {
  __$$ResetCheckIdentityValidityCopyWithImpl(
      _$ResetCheckIdentityValidity _value,
      $Res Function(_$ResetCheckIdentityValidity) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ResetCheckIdentityValidity implements ResetCheckIdentityValidity {
  const _$ResetCheckIdentityValidity();

  @override
  String toString() {
    return 'CheckIdentityValidityEvent.reset()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetCheckIdentityValidity);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String secret) checkIdentityValidity,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String secret)? checkIdentityValidity,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String secret)? checkIdentityValidity,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckIdentityValidity value)
        checkIdentityValidity,
    required TResult Function(ResetCheckIdentityValidity value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult? Function(ResetCheckIdentityValidity value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckIdentityValidity value)? checkIdentityValidity,
    TResult Function(ResetCheckIdentityValidity value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class ResetCheckIdentityValidity
    implements CheckIdentityValidityEvent {
  const factory ResetCheckIdentityValidity() = _$ResetCheckIdentityValidity;
}
