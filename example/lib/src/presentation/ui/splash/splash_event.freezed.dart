// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SplashEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fakeLoadingEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fakeLoadingEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fakeLoadingEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FakeLoadingSplashEvent value) fakeLoadingEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FakeLoadingSplashEvent value)? fakeLoadingEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FakeLoadingSplashEvent value)? fakeLoadingEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashEventCopyWith<$Res> {
  factory $SplashEventCopyWith(
          SplashEvent value, $Res Function(SplashEvent) then) =
      _$SplashEventCopyWithImpl<$Res, SplashEvent>;
}

/// @nodoc
class _$SplashEventCopyWithImpl<$Res, $Val extends SplashEvent>
    implements $SplashEventCopyWith<$Res> {
  _$SplashEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FakeLoadingSplashEventCopyWith<$Res> {
  factory _$$FakeLoadingSplashEventCopyWith(_$FakeLoadingSplashEvent value,
          $Res Function(_$FakeLoadingSplashEvent) then) =
      __$$FakeLoadingSplashEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FakeLoadingSplashEventCopyWithImpl<$Res>
    extends _$SplashEventCopyWithImpl<$Res, _$FakeLoadingSplashEvent>
    implements _$$FakeLoadingSplashEventCopyWith<$Res> {
  __$$FakeLoadingSplashEventCopyWithImpl(_$FakeLoadingSplashEvent _value,
      $Res Function(_$FakeLoadingSplashEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FakeLoadingSplashEvent implements FakeLoadingSplashEvent {
  const _$FakeLoadingSplashEvent();

  @override
  String toString() {
    return 'SplashEvent.fakeLoadingEvent()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FakeLoadingSplashEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fakeLoadingEvent,
  }) {
    return fakeLoadingEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fakeLoadingEvent,
  }) {
    return fakeLoadingEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fakeLoadingEvent,
    required TResult orElse(),
  }) {
    if (fakeLoadingEvent != null) {
      return fakeLoadingEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FakeLoadingSplashEvent value) fakeLoadingEvent,
  }) {
    return fakeLoadingEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FakeLoadingSplashEvent value)? fakeLoadingEvent,
  }) {
    return fakeLoadingEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FakeLoadingSplashEvent value)? fakeLoadingEvent,
    required TResult orElse(),
  }) {
    if (fakeLoadingEvent != null) {
      return fakeLoadingEvent(this);
    }
    return orElse();
  }
}

abstract class FakeLoadingSplashEvent implements SplashEvent {
  const factory FakeLoadingSplashEvent() = _$FakeLoadingSplashEvent;
}
