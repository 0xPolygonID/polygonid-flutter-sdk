import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PolygonIdSdk _polygonIdSdk;
  AuthBloc(this._polygonIdSdk) : super(const AuthState.initial()) {
    on<AuthEvent>(_handleAuthEvent);
  }

  Future<void> _handleAuthEvent(AuthEvent event, Emitter<AuthState> emit) async {
    event.when(
      clickScanQrCode: () {
        _handleClickScanQrCode(emit);
      },
      onScanQrCodeResponse: (String? qrCodeResponse) {
        _handleScanQrCodeResponse(emit, qrCodeResponse);
      },
    );
  }

  ///
  void _handleClickScanQrCode(Emitter<AuthState> emit) {
    emit(const AuthState.navigateToQrCodeScanner());
  }

  ///
  Future<void> _handleScanQrCodeResponse(Emitter<AuthState> emit, String? qrCodeResponse) async {
    if (qrCodeResponse == null || qrCodeResponse.isEmpty) {
      emit(const AuthState.error("no qr code scanned"));
    }

    try {
      final Map<String, dynamic> data = jsonDecode(qrCodeResponse!);
      final Iden3Message iden3message = Iden3Message.fromJson(data);
      emit(AuthState.loaded(iden3message));
      await _authenticate(qrCodeResponse);
    } catch (error) {
      emit(const AuthState.error("Scanned code is not valid"));
    }
  }

  ///
  Future<String> _getAuthToken() {
    //return _polygonIdSdk.identity.getAuthToken(identifier: identifier, message: message);
    return Future.value("");
  }

  ///
  Future<void>_authenticate(String iden3message) async {
    String? identifier = await _polygonIdSdk.identity.getCurrentIdentifier();

    await _polygonIdSdk.identity.authenticate(issuerMessage: iden3message, identifier: identifier!);
  }
}
