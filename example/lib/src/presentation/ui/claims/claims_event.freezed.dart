// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'claims_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClaimsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimsEventCopyWith<$Res> {
  factory $ClaimsEventCopyWith(
          ClaimsEvent value, $Res Function(ClaimsEvent) then) =
      _$ClaimsEventCopyWithImpl<$Res, ClaimsEvent>;
}

/// @nodoc
class _$ClaimsEventCopyWithImpl<$Res, $Val extends ClaimsEvent>
    implements $ClaimsEventCopyWith<$Res> {
  _$ClaimsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchAndSaveClaimsEventCopyWith<$Res> {
  factory _$$FetchAndSaveClaimsEventCopyWith(_$FetchAndSaveClaimsEvent value,
          $Res Function(_$FetchAndSaveClaimsEvent) then) =
      __$$FetchAndSaveClaimsEventCopyWithImpl<$Res>;
  @useResult
  $Res call({Iden3MessageEntity iden3message});
}

/// @nodoc
class __$$FetchAndSaveClaimsEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$FetchAndSaveClaimsEvent>
    implements _$$FetchAndSaveClaimsEventCopyWith<$Res> {
  __$$FetchAndSaveClaimsEventCopyWithImpl(_$FetchAndSaveClaimsEvent _value,
      $Res Function(_$FetchAndSaveClaimsEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iden3message = null,
  }) {
    return _then(_$FetchAndSaveClaimsEvent(
      iden3message: null == iden3message
          ? _value.iden3message
          : iden3message // ignore: cast_nullable_to_non_nullable
              as Iden3MessageEntity,
    ));
  }
}

/// @nodoc

class _$FetchAndSaveClaimsEvent implements FetchAndSaveClaimsEvent {
  const _$FetchAndSaveClaimsEvent({required this.iden3message});

  @override
  final Iden3MessageEntity iden3message;

  @override
  String toString() {
    return 'ClaimsEvent.fetchAndSaveClaims(iden3message: $iden3message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchAndSaveClaimsEvent &&
            (identical(other.iden3message, iden3message) ||
                other.iden3message == iden3message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, iden3message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchAndSaveClaimsEventCopyWith<_$FetchAndSaveClaimsEvent> get copyWith =>
      __$$FetchAndSaveClaimsEventCopyWithImpl<_$FetchAndSaveClaimsEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return fetchAndSaveClaims(iden3message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return fetchAndSaveClaims?.call(iden3message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (fetchAndSaveClaims != null) {
      return fetchAndSaveClaims(iden3message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return fetchAndSaveClaims(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return fetchAndSaveClaims?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (fetchAndSaveClaims != null) {
      return fetchAndSaveClaims(this);
    }
    return orElse();
  }
}

abstract class FetchAndSaveClaimsEvent implements ClaimsEvent {
  const factory FetchAndSaveClaimsEvent(
          {required final Iden3MessageEntity iden3message}) =
      _$FetchAndSaveClaimsEvent;

  Iden3MessageEntity get iden3message;
  @JsonKey(ignore: true)
  _$$FetchAndSaveClaimsEventCopyWith<_$FetchAndSaveClaimsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetClaimsEventCopyWith<$Res> {
  factory _$$GetClaimsEventCopyWith(
          _$GetClaimsEvent value, $Res Function(_$GetClaimsEvent) then) =
      __$$GetClaimsEventCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FilterEntity>? filters});
}

/// @nodoc
class __$$GetClaimsEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$GetClaimsEvent>
    implements _$$GetClaimsEventCopyWith<$Res> {
  __$$GetClaimsEventCopyWithImpl(
      _$GetClaimsEvent _value, $Res Function(_$GetClaimsEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = freezed,
  }) {
    return _then(_$GetClaimsEvent(
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<FilterEntity>?,
    ));
  }
}

/// @nodoc

class _$GetClaimsEvent implements GetClaimsEvent {
  const _$GetClaimsEvent({final List<FilterEntity>? filters})
      : _filters = filters;

  final List<FilterEntity>? _filters;
  @override
  List<FilterEntity>? get filters {
    final value = _filters;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ClaimsEvent.getClaims(filters: $filters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetClaimsEvent &&
            const DeepCollectionEquality().equals(other._filters, _filters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_filters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetClaimsEventCopyWith<_$GetClaimsEvent> get copyWith =>
      __$$GetClaimsEventCopyWithImpl<_$GetClaimsEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return getClaims(filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return getClaims?.call(filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (getClaims != null) {
      return getClaims(filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return getClaims(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return getClaims?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (getClaims != null) {
      return getClaims(this);
    }
    return orElse();
  }
}

abstract class GetClaimsEvent implements ClaimsEvent {
  const factory GetClaimsEvent({final List<FilterEntity>? filters}) =
      _$GetClaimsEvent;

  List<FilterEntity>? get filters;
  @JsonKey(ignore: true)
  _$$GetClaimsEventCopyWith<_$GetClaimsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetClaimsByIdsEventCopyWith<$Res> {
  factory _$$GetClaimsByIdsEventCopyWith(_$GetClaimsByIdsEvent value,
          $Res Function(_$GetClaimsByIdsEvent) then) =
      __$$GetClaimsByIdsEventCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> ids});
}

/// @nodoc
class __$$GetClaimsByIdsEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$GetClaimsByIdsEvent>
    implements _$$GetClaimsByIdsEventCopyWith<$Res> {
  __$$GetClaimsByIdsEventCopyWithImpl(
      _$GetClaimsByIdsEvent _value, $Res Function(_$GetClaimsByIdsEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$GetClaimsByIdsEvent(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$GetClaimsByIdsEvent implements GetClaimsByIdsEvent {
  const _$GetClaimsByIdsEvent({required final List<String> ids}) : _ids = ids;

  final List<String> _ids;
  @override
  List<String> get ids {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'ClaimsEvent.getClaimsByIds(ids: $ids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetClaimsByIdsEvent &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetClaimsByIdsEventCopyWith<_$GetClaimsByIdsEvent> get copyWith =>
      __$$GetClaimsByIdsEventCopyWithImpl<_$GetClaimsByIdsEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return getClaimsByIds(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return getClaimsByIds?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (getClaimsByIds != null) {
      return getClaimsByIds(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return getClaimsByIds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return getClaimsByIds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (getClaimsByIds != null) {
      return getClaimsByIds(this);
    }
    return orElse();
  }
}

abstract class GetClaimsByIdsEvent implements ClaimsEvent {
  const factory GetClaimsByIdsEvent({required final List<String> ids}) =
      _$GetClaimsByIdsEvent;

  List<String> get ids;
  @JsonKey(ignore: true)
  _$$GetClaimsByIdsEventCopyWith<_$GetClaimsByIdsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveClaimEventCopyWith<$Res> {
  factory _$$RemoveClaimEventCopyWith(
          _$RemoveClaimEvent value, $Res Function(_$RemoveClaimEvent) then) =
      __$$RemoveClaimEventCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RemoveClaimEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$RemoveClaimEvent>
    implements _$$RemoveClaimEventCopyWith<$Res> {
  __$$RemoveClaimEventCopyWithImpl(
      _$RemoveClaimEvent _value, $Res Function(_$RemoveClaimEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RemoveClaimEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveClaimEvent implements RemoveClaimEvent {
  const _$RemoveClaimEvent({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ClaimsEvent.removeClaim(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveClaimEvent &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveClaimEventCopyWith<_$RemoveClaimEvent> get copyWith =>
      __$$RemoveClaimEventCopyWithImpl<_$RemoveClaimEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return removeClaim(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return removeClaim?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeClaim != null) {
      return removeClaim(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return removeClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return removeClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeClaim != null) {
      return removeClaim(this);
    }
    return orElse();
  }
}

abstract class RemoveClaimEvent implements ClaimsEvent {
  const factory RemoveClaimEvent({required final String id}) =
      _$RemoveClaimEvent;

  String get id;
  @JsonKey(ignore: true)
  _$$RemoveClaimEventCopyWith<_$RemoveClaimEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveClaimsEventCopyWith<$Res> {
  factory _$$RemoveClaimsEventCopyWith(
          _$RemoveClaimsEvent value, $Res Function(_$RemoveClaimsEvent) then) =
      __$$RemoveClaimsEventCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> ids});
}

/// @nodoc
class __$$RemoveClaimsEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$RemoveClaimsEvent>
    implements _$$RemoveClaimsEventCopyWith<$Res> {
  __$$RemoveClaimsEventCopyWithImpl(
      _$RemoveClaimsEvent _value, $Res Function(_$RemoveClaimsEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$RemoveClaimsEvent(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$RemoveClaimsEvent implements RemoveClaimsEvent {
  const _$RemoveClaimsEvent({required final List<String> ids}) : _ids = ids;

  final List<String> _ids;
  @override
  List<String> get ids {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'ClaimsEvent.removeClaims(ids: $ids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveClaimsEvent &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveClaimsEventCopyWith<_$RemoveClaimsEvent> get copyWith =>
      __$$RemoveClaimsEventCopyWithImpl<_$RemoveClaimsEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return removeClaims(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return removeClaims?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeClaims != null) {
      return removeClaims(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return removeClaims(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return removeClaims?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeClaims != null) {
      return removeClaims(this);
    }
    return orElse();
  }
}

abstract class RemoveClaimsEvent implements ClaimsEvent {
  const factory RemoveClaimsEvent({required final List<String> ids}) =
      _$RemoveClaimsEvent;

  List<String> get ids;
  @JsonKey(ignore: true)
  _$$RemoveClaimsEventCopyWith<_$RemoveClaimsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveAllClaimsEventCopyWith<$Res> {
  factory _$$RemoveAllClaimsEventCopyWith(_$RemoveAllClaimsEvent value,
          $Res Function(_$RemoveAllClaimsEvent) then) =
      __$$RemoveAllClaimsEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RemoveAllClaimsEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$RemoveAllClaimsEvent>
    implements _$$RemoveAllClaimsEventCopyWith<$Res> {
  __$$RemoveAllClaimsEventCopyWithImpl(_$RemoveAllClaimsEvent _value,
      $Res Function(_$RemoveAllClaimsEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RemoveAllClaimsEvent implements RemoveAllClaimsEvent {
  const _$RemoveAllClaimsEvent();

  @override
  String toString() {
    return 'ClaimsEvent.removeAllClaims()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RemoveAllClaimsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return removeAllClaims();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return removeAllClaims?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeAllClaims != null) {
      return removeAllClaims();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return removeAllClaims(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return removeAllClaims?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (removeAllClaims != null) {
      return removeAllClaims(this);
    }
    return orElse();
  }
}

abstract class RemoveAllClaimsEvent implements ClaimsEvent {
  const factory RemoveAllClaimsEvent() = _$RemoveAllClaimsEvent;
}

/// @nodoc
abstract class _$$UpdateClaimEventCopyWith<$Res> {
  factory _$$UpdateClaimEventCopyWith(
          _$UpdateClaimEvent value, $Res Function(_$UpdateClaimEvent) then) =
      __$$UpdateClaimEventCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String id,
      String? issuer,
      String? identifier,
      ClaimState? state,
      String? expiration,
      String? type,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$UpdateClaimEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$UpdateClaimEvent>
    implements _$$UpdateClaimEventCopyWith<$Res> {
  __$$UpdateClaimEventCopyWithImpl(
      _$UpdateClaimEvent _value, $Res Function(_$UpdateClaimEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? issuer = freezed,
    Object? identifier = freezed,
    Object? state = freezed,
    Object? expiration = freezed,
    Object? type = freezed,
    Object? data = freezed,
  }) {
    return _then(_$UpdateClaimEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      issuer: freezed == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String?,
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ClaimState?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$UpdateClaimEvent implements UpdateClaimEvent {
  const _$UpdateClaimEvent(
      {required this.id,
      this.issuer,
      this.identifier,
      this.state,
      this.expiration,
      this.type,
      final Map<String, dynamic>? data})
      : _data = data;

  @override
  final String id;
  @override
  final String? issuer;
  @override
  final String? identifier;
  @override
  final ClaimState? state;
  @override
  final String? expiration;
  @override
  final String? type;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ClaimsEvent.updateClaim(id: $id, issuer: $issuer, identifier: $identifier, state: $state, expiration: $expiration, type: $type, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateClaimEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.expiration, expiration) ||
                other.expiration == expiration) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, issuer, identifier, state,
      expiration, type, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateClaimEventCopyWith<_$UpdateClaimEvent> get copyWith =>
      __$$UpdateClaimEventCopyWithImpl<_$UpdateClaimEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return updateClaim(id, issuer, identifier, state, expiration, type, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return updateClaim?.call(
        id, issuer, identifier, state, expiration, type, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (updateClaim != null) {
      return updateClaim(id, issuer, identifier, state, expiration, type, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return updateClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return updateClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (updateClaim != null) {
      return updateClaim(this);
    }
    return orElse();
  }
}

abstract class UpdateClaimEvent implements ClaimsEvent {
  const factory UpdateClaimEvent(
      {required final String id,
      final String? issuer,
      final String? identifier,
      final ClaimState? state,
      final String? expiration,
      final String? type,
      final Map<String, dynamic>? data}) = _$UpdateClaimEvent;

  String get id;
  String? get issuer;
  String? get identifier;
  ClaimState? get state;
  String? get expiration;
  String? get type;
  Map<String, dynamic>? get data;
  @JsonKey(ignore: true)
  _$$UpdateClaimEventCopyWith<_$UpdateClaimEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClickScanQrCodeEventCopyWith<$Res> {
  factory _$$ClickScanQrCodeEventCopyWith(_$ClickScanQrCodeEvent value,
          $Res Function(_$ClickScanQrCodeEvent) then) =
      __$$ClickScanQrCodeEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClickScanQrCodeEventCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$ClickScanQrCodeEvent>
    implements _$$ClickScanQrCodeEventCopyWith<$Res> {
  __$$ClickScanQrCodeEventCopyWithImpl(_$ClickScanQrCodeEvent _value,
      $Res Function(_$ClickScanQrCodeEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClickScanQrCodeEvent implements ClickScanQrCodeEvent {
  const _$ClickScanQrCodeEvent();

  @override
  String toString() {
    return 'ClaimsEvent.clickScanQrCode()';
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
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return clickScanQrCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return clickScanQrCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
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
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return clickScanQrCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return clickScanQrCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (clickScanQrCode != null) {
      return clickScanQrCode(this);
    }
    return orElse();
  }
}

abstract class ClickScanQrCodeEvent implements ClaimsEvent {
  const factory ClickScanQrCodeEvent() = _$ClickScanQrCodeEvent;
}

/// @nodoc
abstract class _$$ScanQrCodeResponseCopyWith<$Res> {
  factory _$$ScanQrCodeResponseCopyWith(_$ScanQrCodeResponse value,
          $Res Function(_$ScanQrCodeResponse) then) =
      __$$ScanQrCodeResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({String? response});
}

/// @nodoc
class __$$ScanQrCodeResponseCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$ScanQrCodeResponse>
    implements _$$ScanQrCodeResponseCopyWith<$Res> {
  __$$ScanQrCodeResponseCopyWithImpl(
      _$ScanQrCodeResponse _value, $Res Function(_$ScanQrCodeResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$ScanQrCodeResponse(
      freezed == response
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
    return 'ClaimsEvent.onScanQrCodeResponse(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanQrCodeResponse &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanQrCodeResponseCopyWith<_$ScanQrCodeResponse> get copyWith =>
      __$$ScanQrCodeResponseCopyWithImpl<_$ScanQrCodeResponse>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return onScanQrCodeResponse(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return onScanQrCodeResponse?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
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
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return onScanQrCodeResponse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return onScanQrCodeResponse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (onScanQrCodeResponse != null) {
      return onScanQrCodeResponse(this);
    }
    return orElse();
  }
}

abstract class ScanQrCodeResponse implements ClaimsEvent {
  const factory ScanQrCodeResponse(final String? response) =
      _$ScanQrCodeResponse;

  String? get response;
  @JsonKey(ignore: true)
  _$$ScanQrCodeResponseCopyWith<_$ScanQrCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnClickClaimCopyWith<$Res> {
  factory _$$OnClickClaimCopyWith(
          _$OnClickClaim value, $Res Function(_$OnClickClaim) then) =
      __$$OnClickClaimCopyWithImpl<$Res>;
  @useResult
  $Res call({ClaimModel claimModel});
}

/// @nodoc
class __$$OnClickClaimCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$OnClickClaim>
    implements _$$OnClickClaimCopyWith<$Res> {
  __$$OnClickClaimCopyWithImpl(
      _$OnClickClaim _value, $Res Function(_$OnClickClaim) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimModel = null,
  }) {
    return _then(_$OnClickClaim(
      null == claimModel
          ? _value.claimModel
          : claimModel // ignore: cast_nullable_to_non_nullable
              as ClaimModel,
    ));
  }
}

/// @nodoc

class _$OnClickClaim implements OnClickClaim {
  const _$OnClickClaim(this.claimModel);

  @override
  final ClaimModel claimModel;

  @override
  String toString() {
    return 'ClaimsEvent.onClickClaim(claimModel: $claimModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnClickClaim &&
            const DeepCollectionEquality()
                .equals(other.claimModel, claimModel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(claimModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnClickClaimCopyWith<_$OnClickClaim> get copyWith =>
      __$$OnClickClaimCopyWithImpl<_$OnClickClaim>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return onClickClaim(claimModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return onClickClaim?.call(claimModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (onClickClaim != null) {
      return onClickClaim(claimModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return onClickClaim(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return onClickClaim?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (onClickClaim != null) {
      return onClickClaim(this);
    }
    return orElse();
  }
}

abstract class OnClickClaim implements ClaimsEvent {
  const factory OnClickClaim(final ClaimModel claimModel) = _$OnClickClaim;

  ClaimModel get claimModel;
  @JsonKey(ignore: true)
  _$$OnClickClaimCopyWith<_$OnClickClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnClaimDetailRemoveResponseCopyWith<$Res> {
  factory _$$OnClaimDetailRemoveResponseCopyWith(
          _$OnClaimDetailRemoveResponse value,
          $Res Function(_$OnClaimDetailRemoveResponse) then) =
      __$$OnClaimDetailRemoveResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({bool? removed});
}

/// @nodoc
class __$$OnClaimDetailRemoveResponseCopyWithImpl<$Res>
    extends _$ClaimsEventCopyWithImpl<$Res, _$OnClaimDetailRemoveResponse>
    implements _$$OnClaimDetailRemoveResponseCopyWith<$Res> {
  __$$OnClaimDetailRemoveResponseCopyWithImpl(
      _$OnClaimDetailRemoveResponse _value,
      $Res Function(_$OnClaimDetailRemoveResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? removed = freezed,
  }) {
    return _then(_$OnClaimDetailRemoveResponse(
      freezed == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$OnClaimDetailRemoveResponse implements OnClaimDetailRemoveResponse {
  const _$OnClaimDetailRemoveResponse(this.removed);

  @override
  final bool? removed;

  @override
  String toString() {
    return 'ClaimsEvent.onClaimDetailRemoveResponse(removed: $removed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnClaimDetailRemoveResponse &&
            (identical(other.removed, removed) || other.removed == removed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, removed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnClaimDetailRemoveResponseCopyWith<_$OnClaimDetailRemoveResponse>
      get copyWith => __$$OnClaimDetailRemoveResponseCopyWithImpl<
          _$OnClaimDetailRemoveResponse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iden3MessageEntity iden3message)
        fetchAndSaveClaims,
    required TResult Function(List<FilterEntity>? filters) getClaims,
    required TResult Function(List<String> ids) getClaimsByIds,
    required TResult Function(String id) removeClaim,
    required TResult Function(List<String> ids) removeClaims,
    required TResult Function() removeAllClaims,
    required TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)
        updateClaim,
    required TResult Function() clickScanQrCode,
    required TResult Function(String? response) onScanQrCodeResponse,
    required TResult Function(ClaimModel claimModel) onClickClaim,
    required TResult Function(bool? removed) onClaimDetailRemoveResponse,
  }) {
    return onClaimDetailRemoveResponse(removed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult? Function(List<FilterEntity>? filters)? getClaims,
    TResult? Function(List<String> ids)? getClaimsByIds,
    TResult? Function(String id)? removeClaim,
    TResult? Function(List<String> ids)? removeClaims,
    TResult? Function()? removeAllClaims,
    TResult? Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult? Function()? clickScanQrCode,
    TResult? Function(String? response)? onScanQrCodeResponse,
    TResult? Function(ClaimModel claimModel)? onClickClaim,
    TResult? Function(bool? removed)? onClaimDetailRemoveResponse,
  }) {
    return onClaimDetailRemoveResponse?.call(removed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iden3MessageEntity iden3message)? fetchAndSaveClaims,
    TResult Function(List<FilterEntity>? filters)? getClaims,
    TResult Function(List<String> ids)? getClaimsByIds,
    TResult Function(String id)? removeClaim,
    TResult Function(List<String> ids)? removeClaims,
    TResult Function()? removeAllClaims,
    TResult Function(
            String id,
            String? issuer,
            String? identifier,
            ClaimState? state,
            String? expiration,
            String? type,
            Map<String, dynamic>? data)?
        updateClaim,
    TResult Function()? clickScanQrCode,
    TResult Function(String? response)? onScanQrCodeResponse,
    TResult Function(ClaimModel claimModel)? onClickClaim,
    TResult Function(bool? removed)? onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (onClaimDetailRemoveResponse != null) {
      return onClaimDetailRemoveResponse(removed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAndSaveClaimsEvent value) fetchAndSaveClaims,
    required TResult Function(GetClaimsEvent value) getClaims,
    required TResult Function(GetClaimsByIdsEvent value) getClaimsByIds,
    required TResult Function(RemoveClaimEvent value) removeClaim,
    required TResult Function(RemoveClaimsEvent value) removeClaims,
    required TResult Function(RemoveAllClaimsEvent value) removeAllClaims,
    required TResult Function(UpdateClaimEvent value) updateClaim,
    required TResult Function(ClickScanQrCodeEvent value) clickScanQrCode,
    required TResult Function(ScanQrCodeResponse value) onScanQrCodeResponse,
    required TResult Function(OnClickClaim value) onClickClaim,
    required TResult Function(OnClaimDetailRemoveResponse value)
        onClaimDetailRemoveResponse,
  }) {
    return onClaimDetailRemoveResponse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult? Function(GetClaimsEvent value)? getClaims,
    TResult? Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult? Function(RemoveClaimEvent value)? removeClaim,
    TResult? Function(RemoveClaimsEvent value)? removeClaims,
    TResult? Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult? Function(UpdateClaimEvent value)? updateClaim,
    TResult? Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult? Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult? Function(OnClickClaim value)? onClickClaim,
    TResult? Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
  }) {
    return onClaimDetailRemoveResponse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAndSaveClaimsEvent value)? fetchAndSaveClaims,
    TResult Function(GetClaimsEvent value)? getClaims,
    TResult Function(GetClaimsByIdsEvent value)? getClaimsByIds,
    TResult Function(RemoveClaimEvent value)? removeClaim,
    TResult Function(RemoveClaimsEvent value)? removeClaims,
    TResult Function(RemoveAllClaimsEvent value)? removeAllClaims,
    TResult Function(UpdateClaimEvent value)? updateClaim,
    TResult Function(ClickScanQrCodeEvent value)? clickScanQrCode,
    TResult Function(ScanQrCodeResponse value)? onScanQrCodeResponse,
    TResult Function(OnClickClaim value)? onClickClaim,
    TResult Function(OnClaimDetailRemoveResponse value)?
        onClaimDetailRemoveResponse,
    required TResult orElse(),
  }) {
    if (onClaimDetailRemoveResponse != null) {
      return onClaimDetailRemoveResponse(this);
    }
    return orElse();
  }
}

abstract class OnClaimDetailRemoveResponse implements ClaimsEvent {
  const factory OnClaimDetailRemoveResponse(final bool? removed) =
      _$OnClaimDetailRemoveResponse;

  bool? get removed;
  @JsonKey(ignore: true)
  _$$OnClaimDetailRemoveResponseCopyWith<_$OnClaimDetailRemoveResponse>
      get copyWith => throw _privateConstructorUsedError;
}
