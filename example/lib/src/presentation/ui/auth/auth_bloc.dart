import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'dart:math';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/secure_storage.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/common/widgets/profile_radio_button.dart';
import 'package:polygonid_flutter_sdk_example/utils/secure_storage_keys.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PolygonIdSdk _polygonIdSdk;
  static const PROFILE_NONCE_KEY = "profileNonce";

  AuthBloc(this._polygonIdSdk) : super(const AuthState.initial()) {
    on<ClickScanQrCodeEvent>(_handleClickScanQrCode);
    on<ScanQrCodeResponse>(_handleScanQrCodeResponse);
  }

  ///
  Stream<String> get proofGenerationStepsStream =>
      _polygonIdSdk.proof.proofGenerationStepsStream();

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
      final Iden3MessageEntity iden3message = await _polygonIdSdk.iden3comm
          .getIden3Message(message: qrCodeResponse);
      emit(AuthState.loaded(iden3message));

      String? privateKey =
          await SecureStorage.read(key: SecureStorageKeys.privateKey);

      if (privateKey == null) {
        emit(const AuthState.error("no private key found"));
        return;
      }

      await _authenticate(
        iden3message: iden3message,
        privateKey: privateKey,
        profile: event.profile,
        emit: emit,
      );
    } catch (error) {
      emit(const AuthState.error("Scanned code is not valid"));
    }
  }

  BigInt _randomNonce() {
    final random = Random.secure();
    const int size = 248;
    BigInt value = BigInt.from(0);
    for (var i = 0; i < size; i++) {
      value = value << 1;
      if (random.nextBool()) {
        value = value | BigInt.from(1);
      }
    }
    if (value == BigInt.from(0)) {
      return _randomNonce();
    }
    return value;
  }

  // TODO: Delete this
  Future<void> _cleanupProfileInfo({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    Map<BigInt, String> profilesToDelete = await _polygonIdSdk.identity
        .getProfiles(genesisDid: did, privateKey: privateKey);
    for (var nonce in profilesToDelete.keys) {
      if (nonce != BigInt.zero) {
        await _polygonIdSdk.identity.removeProfile(
            genesisDid: did, privateKey: privateKey, profileNonce: nonce);
      }
    }
    profilesToDelete = await _polygonIdSdk.identity
        .getProfiles(genesisDid: did, privateKey: privateKey);
    logger().i("profilesToDelete: $profilesToDelete");

    await _polygonIdSdk.iden3comm.removeDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from);
  }

  Future<BigInt?> _lookupNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    Map readInfo = await _polygonIdSdk.iden3comm.getDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from);
    logger().i("info from $from: $readInfo");

    return (readInfo[PROFILE_NONCE_KEY] != null)
        ? BigInt.parse(readInfo[PROFILE_NONCE_KEY])
        : null;
  }

  Future<BigInt> _generateNewNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    BigInt nonce = _randomNonce();
    logger().i("Generating new nonce for $from: $nonce");

    await _polygonIdSdk.identity.addProfile(
        genesisDid: did, privateKey: privateKey, profileNonce: nonce);

    Map<String, dynamic> info = {
      PROFILE_NONCE_KEY: nonce.toString(),
    };
    await _polygonIdSdk.iden3comm.addDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from, info: info);

    return nonce;
  }

  Future<BigInt> _getPrivateProfileNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    final nonceLookup =
        await _lookupNonce(did: did, privateKey: privateKey, from: from);

    if (nonceLookup != null) {
      logger().i("Found nonce for $from: $nonceLookup");
      return nonceLookup;
    }

    return _generateNewNonce(did: did, privateKey: privateKey, from: from);
  }

  ///
  Future<void> _authenticate({
    required Iden3MessageEntity iden3message,
    required String privateKey,
    required SelectedProfile profile,
    required Emitter<AuthState> emit,
  }) async {
    emit(const AuthState.loading());

    EnvEntity envEntity = await _polygonIdSdk.getEnv();

    String? did = await _polygonIdSdk.identity.getDidIdentifier(
        privateKey: privateKey,
        blockchain: envEntity.blockchain,
        network: envEntity.network);

    try {
      final BigInt nonce = profile == SelectedProfile.public
          ? GENESIS_PROFILE_NONCE
          : await _getPrivateProfileNonce(
              did: did, privateKey: privateKey, from: iden3message.from);
      await _polygonIdSdk.iden3comm.authenticate(
        message: iden3message,
        genesisDid: did,
        privateKey: privateKey,
        profileNonce: nonce,
      );

      emit(const AuthState.authenticated());
    } catch (error) {
      emit(AuthState.error(error.toString()));
    }
  }
}
