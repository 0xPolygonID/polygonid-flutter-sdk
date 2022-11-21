// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'claim_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClaimDetailEvent {
  String get claimId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String claimId) deleteClaim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String claimId)? deleteClaim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String claimId)? deleteClaim,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeleteClaimEvent value) deleteClaim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeleteClaimEvent value)? deleteClaim,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeleteClaimEvent value)? deleteClaim,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClaimDetailEventCopyWith<ClaimDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimDetailEventCopyWith<$Res> {
  factory $ClaimDetailEventCopyWith(
          ClaimDetailEvent value, $Res Function(ClaimDetailEvent) then) =
      _$ClaimDetailEventCopyWithImpl<$Res, ClaimDetailEvent>;
  @useResult
  $Res call({String claimId});
}

/// @nodoc
class _$ClaimDetailEventCopyWithImpl<$Res, $Val extends ClaimDetailEvent>
    implements $ClaimDetailEventCopyWith<$Res> {
  _$ClaimDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimId = null,
  }) {
    return _then(_value.copyWith(
      claimId: null == claimId
          ? _value.claimId
          : claimId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteClaimEventCopyWith<$Res>
    implements $ClaimDetailEventCopyWith<$Res> {
  factory _$$DeleteClaimEventCopyWith(
          _$DeleteClaimEvent value, $Res Function(_$DeleteClaimEvent) then) =
      __$$DeleteClaimEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String claimId});
}

/// @nodoc
class __$$DeleteClaimEventCopyWithImpl<$Res>
    extends _$ClaimDetailEventCopyWithImpl<$Res, _$DeleteClaimEvent>
    implements _$$DeleteClaimEventCopyWith<$Res> {
  __$$DeleteClaimEventCopyWithImpl(
      _$DeleteClaimEvent _value, $Res Function(_$DeleteClaimEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimId = null,
  }) {
    return _then(_$DeleteClaimEvent(
      claimId: null == claimId
          ? _value.claimId
          : claimId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteClaimEvent implements DeleteClaimEvent {
  const _$DeleteClaimEvent({required this.claimId});

  @override
  final String claimId;

  @override
  String toString() {
    return 'ClaimDetailEvent.deleteClaim(claimId: $claimId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteClaimEvent &&
            (identical(other.claimId, claimId) || other.claimId == claimId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, claimId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteClaimEventCopyWith<_$DeleteClaimEvent> get copyWith =>
      __$$DeleteClaimEventCopyWithImpl<_$DeleteClaimEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String claimId) deleteClaim,
  }) {
    return deleteClaim(claimId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String claimId)? deleteClaim,
  }) {
    return deleteClaim?.call(claimId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String claimId)? deleteClaim,
    required TResult orElse(),
  }) {
    if (deleteClaim != null) {
      return deleteClaim(claimId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeleteClaimEvent value) deleteClaim,
  }) {
    return deleteClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeleteClaimEvent value)? deleteClaim,
  }) {
    return deleteClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeleteClaimEvent value)? deleteClaim,
    required TResult orElse(),
  }) {
    if (deleteClaim != null) {
      return deleteClaim(this);
    }
    return orElse();
  }
}

abstract class DeleteClaimEvent implements ClaimDetailEvent {
  const factory DeleteClaimEvent({required final String claimId}) =
      _$DeleteClaimEvent;

  @override
  String get claimId;
  @override
  @JsonKey(ignore: true)
  _$$DeleteClaimEventCopyWith<_$DeleteClaimEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
