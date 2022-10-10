import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/iden3comm/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetIdentifierUseCase _getIdentifierUseCase;
  final AuthenticateUseCase _authenticateUseCase;

  AuthBloc(this._getIdentifierUseCase, this._authenticateUseCase)
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
      final Map<String, dynamic> data = jsonDecode(qrCodeResponse!);
      final Iden3Message iden3message = Iden3Message.fromJson(data);
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
    String? identifier = await _getIdentifierUseCase.execute();

    if (identifier == null) {
      emit(const AuthState.error(
          "an identity is needed before trying to authenticate"));
      return;
    }

    try {
      await _authenticateUseCase.execute(
        param: AuthenticateParam(
          issuerMessage: iden3message,
          identifier: identifier,
        ),
      );

      emit(const AuthState.authenticated());
    } catch (error) {
      emit(AuthState.error(error.toString()));
    }
  }
}
