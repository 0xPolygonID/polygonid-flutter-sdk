// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  final AuthEvent _value;
  // ignore: unused_field
  final $Res Function(AuthEvent) _then;
}

/// @nodoc
abstract class _$$ClickScanQrCodeEventCopyWith<$Res> {
  factory _$$ClickScanQrCodeEventCopyWith(_$ClickScanQrCodeEvent value,
          $Res Function(_$ClickScanQrCodeEvent) then) =
      __$$ClickScanQrCodeEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClickScanQrCodeEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$ClickScanQrCodeEventCopyWith<$Res> {
  __$$ClickScanQrCodeEventCopyWithImpl(_$ClickScanQrCodeEvent _value,
      $Res Function(_$ClickScanQrCodeEvent) _then)
      : super(_value, (v) => _then(v as _$ClickScanQrCodeEvent));

  @override
  _$ClickScanQrCodeEvent get _value => super._value as _$ClickScanQrCodeEvent;
}

/// @nodoc

class _$ClickScanQrCodeEvent implements ClickScanQrCodeEvent {
  const _$ClickScanQrCodeEvent();

  @override
  String toString() {
    return 'AuthEvent.clickScanQrCode()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClickScanQrCodeEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
  }) {
    return clickScanQrCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
  }) {
    return clickScanQrCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    required TResult orElse(),
  }) {
    if (clickScanQrCode != null) {
      return clickScanQrCode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
  }) {
    return clickScanQrCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
  }) {
    return clickScanQrCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    required TResult orElse(),
  }) {
    if (clickScanQrCode != null) {
      return clickScanQrCode(this);
    }
    return orElse();
  }
}

abstract class ClickScanQrCodeEvent implements AuthEvent {
  const factory ClickScanQrCodeEvent() = _$ClickScanQrCodeEvent;
}

/// @nodoc
abstract class _$$ScanQrCodeResponseCopyWith<$Res> {
  factory _$$ScanQrCodeResponseCopyWith(_$ScanQrCodeResponse value,
          $Res Function(_$ScanQrCodeResponse) then) =
      __$$ScanQrCodeResponseCopyWithImpl<$Res>;
  $Res call({String? response});
}

/// @nodoc
class __$$ScanQrCodeResponseCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$ScanQrCodeResponseCopyWith<$Res> {
  __$$ScanQrCodeResponseCopyWithImpl(
      _$ScanQrCodeResponse _value, $Res Function(_$ScanQrCodeResponse) _then)
      : super(_value, (v) => _then(v as _$ScanQrCodeResponse));

  @override
  _$ScanQrCodeResponse get _value => super._value as _$ScanQrCodeResponse;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$ScanQrCodeResponse(
      response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ScanQrCodeResponse implements ScanQrCodeResponse {
  const _$ScanQrCodeResponse(this.response);

  @override
  final String? response;

  @override
  String toString() {
    return 'AuthEvent.onScanQrCodeResponse(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanQrCodeResponse &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  _$$ScanQrCodeResponseCopyWith<_$ScanQrCodeResponse> get copyWith =>
      __$$ScanQrCodeResponseCopyWithImpl<_$ScanQrCodeResponse>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
  }) {
    return onScanQrCodeResponse(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
  }) {
    return onScanQrCodeResponse?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    required TResult orElse(),
  }) {
    if (onScanQrCodeResponse != null) {
      return onScanQrCodeResponse(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
  }) {
    return onScanQrCodeResponse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
  }) {
    return onScanQrCodeResponse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    required TResult orElse(),
  }) {
    if (onScanQrCodeResponse != null) {
      return onScanQrCodeResponse(this);
    }
    return orElse();
  }
}

abstract class ScanQrCodeResponse implements AuthEvent {
  const factory ScanQrCodeResponse(final String? response) =
      _$ScanQrCodeResponse;

  String? get response;
  @JsonKey(ignore: true)
  _$$ScanQrCodeResponseCopyWith<_$ScanQrCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
