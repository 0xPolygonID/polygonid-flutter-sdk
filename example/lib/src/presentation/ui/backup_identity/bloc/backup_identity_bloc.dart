import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/secure_storage.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/bloc/backup_identity_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/bloc/backup_identity_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/secure_storage_keys.dart';

class BackupIdentityBloc
    extends Bloc<BackupIdentityEvent, BackupIdentityState> {
  final PolygonIdSdk _polygonIdSdk;

  BackupIdentityBloc(this._polygonIdSdk)
      : super(const BackupIdentityState.initial()) {
    on<BackupIdentity>(_handleBackupIdentity);
  }

  ///
  Future<void> _handleBackupIdentity(
      BackupIdentity event, Emitter<BackupIdentityState> emit) async {
    emit(const BackupIdentityState.loading());

    // Get private key from secure storage
    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    // Check if private key is null otherwise emit error
    if (privateKey == null) {
      emit(const BackupIdentityState.error('Private key not found'));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String? genesisDid = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (genesisDid.isEmpty) {
      emit(const BackupIdentityState.error(
          "without an identity is impossible to do the backup"));
      return;
    }

    try {
      // get backup
      String backup = await _polygonIdSdk.identity
          .backupIdentity(genesisDid: genesisDid, privateKey: privateKey);

      // write backup to secure storage just for example purpose
      await SecureStorage.write(
          key: SecureStorageKeys.backupKey, value: backup);

      // emit success state
      emit(BackupIdentityState.success(backup));
    } catch (e) {
      emit(BackupIdentityState.error(e.toString()));
    }
  }
}
