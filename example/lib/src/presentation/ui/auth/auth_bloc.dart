import 'package:bloc/bloc.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Iden3MessageMapper _iden3messageMapper;
  final PolygonIdSdk _polygonIdSdk;

  AuthBloc(this._iden3messageMapper, this._polygonIdSdk)
      : super(const AuthState.initial()) {
    on<ClickScanQrCodeEvent>(_handleClickScanQrCode);
    on<ScanQrCodeResponse>(_handleScanQrCodeResponse);
  }

  ///
  void _handleClickScanQrCode(
      ClickScanQrCodeEvent event, Emitter<AuthState> emit) {
    emit(const AuthState.navigateToQrCodeScanner());
  }

  ///
  Future<void> _handleScanQrCodeResponse(
      ScanQrCodeResponse event, Emitter<AuthState> emit) async {
    String? qrCodeResponse = event.response;
    if (qrCodeResponse == null || qrCodeResponse.isEmpty) {
      emit(const AuthState.error("no qr code scanned"));
      return;
    }

    try {
      final Iden3MessageEntity iden3message =
          _iden3messageMapper.mapFrom(qrCodeResponse);
      emit(AuthState.loaded(iden3message));

      await _authenticate(iden3message: qrCodeResponse, emit: emit);
    } catch (error) {
      emit(const AuthState.error("Scanned code is not valid"));
    }
  }

  ///
  Future<void> _authenticate({
    required String iden3message,
    required Emitter<AuthState> emit,
  }) async {
    emit(const AuthState.loading());
    String? identifier = await _polygonIdSdk.identity.getCurrentIdentifier();

    if (identifier == null) {
      emit(const AuthState.error(
          "an identity is needed before trying to authenticate"));
      return;
    }

    try {
      await _polygonIdSdk.iden3comm.authenticate(
        message: _polygonIdSdk.iden3comm.getIden3Message(message: iden3message),
        identifier: identifier,
      );

      emit(const AuthState.authenticated());
    } catch (error) {
      emit(AuthState.error(error.toString()));
    }
  }
}
