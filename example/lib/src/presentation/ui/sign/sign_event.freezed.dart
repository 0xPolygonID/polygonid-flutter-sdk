// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignEvent {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) signMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? signMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? signMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignMessageEvent value) signMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignMessageEvent value)? signMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignMessageEvent value)? signMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignEventCopyWith<SignEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignEventCopyWith<$Res> {
  factory $SignEventCopyWith(SignEvent value, $Res Function(SignEvent) then) =
      _$SignEventCopyWithImpl<$Res, SignEvent>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SignEventCopyWithImpl<$Res, $Val extends SignEvent>
    implements $SignEventCopyWith<$Res> {
  _$SignEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignMessageEventCopyWith<$Res>
    implements $SignEventCopyWith<$Res> {
  factory _$$SignMessageEventCopyWith(
          _$SignMessageEvent value, $Res Function(_$SignMessageEvent) then) =
      __$$SignMessageEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SignMessageEventCopyWithImpl<$Res>
    extends _$SignEventCopyWithImpl<$Res, _$SignMessageEvent>
    implements _$$SignMessageEventCopyWith<$Res> {
  __$$SignMessageEventCopyWithImpl(
      _$SignMessageEvent _value, $Res Function(_$SignMessageEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SignMessageEvent(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignMessageEvent implements SignMessageEvent {
  const _$SignMessageEvent(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SignEvent.signMessage(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignMessageEvent &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignMessageEventCopyWith<_$SignMessageEvent> get copyWith =>
      __$$SignMessageEventCopyWithImpl<_$SignMessageEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) signMessage,
  }) {
    return signMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? signMessage,
  }) {
    return signMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? signMessage,
    required TResult orElse(),
  }) {
    if (signMessage != null) {
      return signMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignMessageEvent value) signMessage,
  }) {
    return signMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignMessageEvent value)? signMessage,
  }) {
    return signMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignMessageEvent value)? signMessage,
    required TResult orElse(),
  }) {
    if (signMessage != null) {
      return signMessage(this);
    }
    return orElse();
  }
}

abstract class SignMessageEvent implements SignEvent {
  const factory SignMessageEvent(final String message) = _$SignMessageEvent;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$SignMessageEventCopyWith<_$SignMessageEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
