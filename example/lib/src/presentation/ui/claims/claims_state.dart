import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

part 'claims_state.freezed.dart';

@freezed
class ClaimsState with _$ClaimsState {
  const factory ClaimsState.initial() = InitialClaimsState;

  const factory ClaimsState.loading() = LoadingDataClaimsState;

  const factory ClaimsState.navigateToQrCodeScanner() =
      NavigateToQrCodeScannerClaimsState;

  const factory ClaimsState.qrCodeScanned(Iden3MessageEntity iden3message) =
      QrCodeScannedClaimsState;

  const factory ClaimsState.loadedClaims(List<ClaimModel> claimList) =
      LoadedDataClaimsState;

  const factory ClaimsState.error(String message) = ErrorClaimsState;

  const factory ClaimsState.navigateToClaimDetail(ClaimModel claimModel) =
      NavigateToClaimDetailClaimState;
}
