import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/bloc/check_identity_validity_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/bloc/check_identity_validity_state.dart';

class CheckIdentityValidityBloc
    extends Bloc<CheckIdentityValidityEvent, CheckIdentityValidityState> {
  final PolygonIdSdk _polygonIdSdk;

  CheckIdentityValidityBloc(this._polygonIdSdk)
      : super(const CheckIdentityValidityState.initial()) {
    on<CheckIdentityValidity>(_handleCheckIdentityValidity);
    on<ResetCheckIdentityValidity>(_handleReset);
  }

  ///
  Future<void> _handleCheckIdentityValidity(
    CheckIdentityValidity event,
    Emitter<CheckIdentityValidityState> emit,
  ) async {
    emit(const CheckIdentityValidityState.loading());
    await _polygonIdSdk.identity
        .checkIdentityValidity(secret: event.secret)
        .then((value) {
      emit(const CheckIdentityValidityState.success());
    }).catchError((error) {
      emit(CheckIdentityValidityState.error(error.toString()));
    });
  }

  Future<void> _handleReset(ResetCheckIdentityValidity event,
      Emitter<CheckIdentityValidityState> emit) async {
    emit(const CheckIdentityValidityState.initial());
  }
}
