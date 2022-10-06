import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

class ClaimDetailBloc extends Bloc<ClaimDetailEvent, ClaimDetailState> {
  final PolygonIdSdk _polygonIdSdk;

  ClaimDetailBloc(this._polygonIdSdk)
      : super(const ClaimDetailState.initial()) {
    on<DeleteClaimEvent>(_deleteClaimEvent);
  }

  ///
  Future<void> _deleteClaimEvent(
    DeleteClaimEvent event,
    Emitter<ClaimDetailState> emit,
  ) async {
    emit(const ClaimDetailState.loading());

    try {
      await _polygonIdSdk.credential.removeClaims(ids: [event.claimId]);
      emit(const ClaimDetailState.claimDeleted());
    } catch (_) {
      emit(const ClaimDetailState.error(CustomStrings.claimRemovingError));
    }
  }
}
