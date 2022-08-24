import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/common/bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthState> {
  AuthBloc() {
    changeState(AuthState.init());
  }

  Future<void> getIden3messageFromQrScanning(BuildContext context) async {
    changeState(AuthState.loading());
    String? scanningResult = await Navigator.pushNamed(context, Routes.qrCodeScannerPath) as String?;

    if (scanningResult == null) {
      changeState(AuthState.error("no qr code scanned"));
      return;
    }

    try {
      final Map<String, dynamic> data = jsonDecode(scanningResult);
      final Iden3Message iden3message = Iden3Message.fromJson(data);
      changeState(AuthState.loaded(iden3message));

      String getAuthToken = await _getAuthToken();
    } catch (error) {
      changeState(AuthState.error("Scanned code is not valid"));
    }
  }

  ///
  Future<String> _getAuthToken() {
    //PolygonIdSdk.I.identity.getAuthToken(identifier: identifier, circuitData: circuitData, message: message)
    return Future.value("");
  }
}
