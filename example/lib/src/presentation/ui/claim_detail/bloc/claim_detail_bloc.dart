import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/secure_storage.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/secure_storage_keys.dart';

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
      String? privateKey =
          await SecureStorage.read(key: SecureStorageKeys.privateKey);

      if (privateKey == null) {
        emit(const ClaimDetailState.error("no private key found"));
        return;
      }

      EnvEntity envEntity = await _polygonIdSdk.getEnv();

      String? did = await _polygonIdSdk.identity.getDidIdentifier(
          privateKey: privateKey,
          blockchain: envEntity.blockchain,
          network: envEntity.network);

      await _polygonIdSdk.credential.removeClaims(
        claimIds: [event.claimId],
        genesisDid: did,
        privateKey: privateKey,
      );

      emit(const ClaimDetailState.claimDeleted());
    } catch (_) {
      emit(const ClaimDetailState.error(CustomStrings.claimRemovingError));
    }
  }
}
