import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

part 'claims_event.freezed.dart';

@freezed
class ClaimsEvent with _$ClaimsEvent {
  const factory ClaimsEvent.fetchAndSaveClaims(
      {required Iden3MessageEntity iden3message}) = FetchAndSaveClaimsEvent;

  const factory ClaimsEvent.getClaims({List<FilterEntity>? filters}) =
      GetClaimsEvent;

  const factory ClaimsEvent.getClaimsByIds({required List<String> ids}) =
      GetClaimsByIdsEvent;

  const factory ClaimsEvent.removeClaim({required String id}) =
      RemoveClaimEvent;

  const factory ClaimsEvent.removeClaims({required List<String> ids}) =
      RemoveClaimsEvent;

  const factory ClaimsEvent.removeAllClaims() = RemoveAllClaimsEvent;

  const factory ClaimsEvent.updateClaim({
    required String id,
    String? issuer,
    String? did,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
  }) = UpdateClaimEvent;

  const factory ClaimsEvent.clickScanQrCode() = ClickScanQrCodeEvent;

  const factory ClaimsEvent.onScanQrCodeResponse(String? response) =
      ScanQrCodeResponse;

  const factory ClaimsEvent.onClickClaim(ClaimModel claimModel) = OnClickClaim;

  const factory ClaimsEvent.onClaimDetailRemoveResponse(bool? removed) =
      OnClaimDetailRemoveResponse;
}
