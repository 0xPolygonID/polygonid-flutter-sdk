import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/common/widgets/profile_radio_button.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.clickScanQrCode(SelectedProfile profile) =
      ClickScanQrCodeEvent;
  const factory AuthEvent.onScanQrCodeResponse(
      String? response, SelectedProfile profile) = ScanQrCodeResponse;
}
