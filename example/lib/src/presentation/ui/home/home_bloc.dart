import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PolygonIdSdk _polygonIdSdk;

  HomeBloc(this._polygonIdSdk) : super(const HomeState.initial()) {
    on<CreateIdentityHomeEvent>(_createIdentity);
    on<GetIdentifierHomeEvent>(_getIdentifier);
  }

  ///
  Future<void> _getIdentifier(
      GetIdentifierHomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    String? identifier = await _polygonIdSdk.identity.getCurrentIdentifier();
    emit(HomeState.loaded(identifier: identifier));
  }

  ///
  Future<void> _createIdentity(
      CreateIdentityHomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());

    try {
      String identifier = await _polygonIdSdk.identity.createIdentity();
      emit(HomeState.loaded(identifier: identifier));
    } on IdentityException catch (identityException) {
      emit(HomeState.error(message: identityException.error));
    } catch (_) {
      emit(const HomeState.error(message: CustomStrings.genericError));
    }
  }
}
