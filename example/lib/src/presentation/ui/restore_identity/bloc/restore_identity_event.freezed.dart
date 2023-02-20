// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restore_identity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RestoreIdentityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() restoreIdentity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? restoreIdentity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? restoreIdentity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RestoreIdentity value) restoreIdentity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RestoreIdentity value)? restoreIdentity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RestoreIdentity value)? restoreIdentity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestoreIdentityEventCopyWith<$Res> {
  factory $RestoreIdentityEventCopyWith(RestoreIdentityEvent value,
          $Res Function(RestoreIdentityEvent) then) =
      _$RestoreIdentityEventCopyWithImpl<$Res, RestoreIdentityEvent>;
}

/// @nodoc
class _$RestoreIdentityEventCopyWithImpl<$Res,
        $Val extends RestoreIdentityEvent>
    implements $RestoreIdentityEventCopyWith<$Res> {
  _$RestoreIdentityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RestoreIdentityCopyWith<$Res> {
  factory _$$RestoreIdentityCopyWith(
          _$RestoreIdentity value, $Res Function(_$RestoreIdentity) then) =
      __$$RestoreIdentityCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RestoreIdentityCopyWithImpl<$Res>
    extends _$RestoreIdentityEventCopyWithImpl<$Res, _$RestoreIdentity>
    implements _$$RestoreIdentityCopyWith<$Res> {
  __$$RestoreIdentityCopyWithImpl(
      _$RestoreIdentity _value, $Res Function(_$RestoreIdentity) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RestoreIdentity implements RestoreIdentity {
  const _$RestoreIdentity();

  @override
  String toString() {
    return 'RestoreIdentityEvent.restoreIdentity()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RestoreIdentity);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() restoreIdentity,
  }) {
    return restoreIdentity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? restoreIdentity,
  }) {
    return restoreIdentity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? restoreIdentity,
    required TResult orElse(),
  }) {
    if (restoreIdentity != null) {
      return restoreIdentity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RestoreIdentity value) restoreIdentity,
  }) {
    return restoreIdentity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RestoreIdentity value)? restoreIdentity,
  }) {
    return restoreIdentity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RestoreIdentity value)? restoreIdentity,
    required TResult orElse(),
  }) {
    if (restoreIdentity != null) {
      return restoreIdentity(this);
    }
    return orElse();
  }
}

abstract class RestoreIdentity implements RestoreIdentityEvent {
  const factory RestoreIdentity() = _$RestoreIdentity;
}
