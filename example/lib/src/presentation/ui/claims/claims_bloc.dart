import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/secure_storage.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/nonce_utils.dart';
import 'package:polygonid_flutter_sdk_example/utils/secure_storage_keys.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final ClaimModelMapper _mapper;
  final PolygonIdSdk _polygonIdSdk;

  ClaimsBloc(
    this._mapper,
    this._polygonIdSdk,
  ) : super(const ClaimsState.initial()) {
    on<FetchAndSaveClaimsEvent>(_fetchAndSaveClaims);
    on<GetClaimsEvent>(_getClaims);
    on<GetClaimsByIdsEvent>(_getClaimsByIds);
    on<RemoveClaimEvent>(_removeClaim);
    on<RemoveClaimsEvent>(_removeClaims);
    on<RemoveAllClaimsEvent>(_removeAllClaims);
    on<UpdateClaimEvent>(_updateClaim);
    on<ClickScanQrCodeEvent>(_handleClickScanQrCode);
    on<ScanQrCodeResponse>(_handleScanQrCodeResponse);
    on<OnClickClaim>(_handleClickClaim);
    on<OnClaimDetailRemoveResponse>(_handleRemoveClaimResponse);
  }

  ///
  Future<void> _fetchAndSaveClaims(
      FetchAndSaveClaimsEvent event, Emitter<ClaimsState> emit) async {
    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String didIdentifier = await _polygonIdSdk.identity.getDidIdentifier(
        privateKey: privateKey,
        blockchain: env.blockchain,
        network: env.network);

    emit(const ClaimsState.loading());

    Iden3MessageEntity iden3message = event.iden3message;
    if (event.iden3message.messageType != Iden3MessageType.credentialOffer) {
      emit(const ClaimsState.error("Read message is not of type offer"));
      return;
    }

    BigInt nonce = await NonceUtils(_polygonIdSdk).lookupNonce(
            did: didIdentifier,
            privateKey: privateKey,
            from: iden3message.from) ??
        GENESIS_PROFILE_NONCE;

    try {
      List<ClaimEntity> claimList =
          await _polygonIdSdk.iden3comm.fetchAndSaveClaims(
        message: event.iden3message as OfferIden3MessageEntity,
        genesisDid: didIdentifier,
        profileNonce: nonce,
        privateKey: privateKey,
      );

      if (claimList.isNotEmpty) {
        add(const GetClaimsEvent());
      }
    } catch (exception) {
      emit(const ClaimsState.error(CustomStrings.iden3messageGenericError));
    }
  }

  ///
  Future<void> _getClaims(
      GetClaimsEvent event, Emitter<ClaimsState> emit) async {
    emit(const ClaimsState.loading());

    List<FilterEntity>? filters = event.filters;

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String did = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to remove credential"));
      return;
    }

    try {
      List<ClaimEntity> claimList = await _polygonIdSdk.credential.getClaims(
        filters: filters,
        genesisDid: did,
        privateKey: privateKey,
      );

      List<ClaimModel> claimModelList =
          claimList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      emit(ClaimsState.loadedClaims(claimModelList));
    } on GetClaimsException catch (_) {
      emit(const ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _getClaimsByIds(
      GetClaimsByIdsEvent event, Emitter<ClaimsState> emit) async {
    emit(const ClaimsState.loading());

    List<String> ids = event.ids;

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String did = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to remove credential"));
      return;
    }

    try {
      List<ClaimEntity> claimList =
          await _polygonIdSdk.credential.getClaimsByIds(
        claimIds: ids,
        genesisDid: did,
        privateKey: privateKey,
      );

      List<ClaimModel> claimModelList =
          claimList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      emit(ClaimsState.loadedClaims(claimModelList));
    } on GetClaimsException catch (_) {
      emit(const ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _removeClaim(
      RemoveClaimEvent event, Emitter<ClaimsState> emit) async {
    String id = event.id;

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String did = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to remove credential"));
      return;
    }

    try {
      await _polygonIdSdk.credential.removeClaim(
        claimId: id,
        genesisDid: did,
        privateKey: privateKey,
      );
      add(const GetClaimsEvent());
    } on RemoveClaimsException catch (_) {
      emit(const ClaimsState.error("error while removing credential"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _removeClaims(
      RemoveClaimsEvent event, Emitter<ClaimsState> emit) async {
    List<String> ids = event.ids;

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String did = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to remove claims"));
      return;
    }
    try {
      await _polygonIdSdk.credential.removeClaims(
        claimIds: ids,
        genesisDid: did,
        privateKey: privateKey,
      );
      add(const GetClaimsEvent());
    } on RemoveClaimsException catch (_) {
      emit(const ClaimsState.error("error while removing claims"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _updateClaim(
      UpdateClaimEvent event, Emitter<ClaimsState> emit) async {
    String id = event.id;
    String? issuer = event.issuer;
    String? did = event.did;
    ClaimState? state = event.state;
    String? expiration = event.expiration;
    String? type = event.type;
    Map<String, dynamic>? data = event.data;

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    if (did == null || did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to update a credential"));
      return;
    }
    try {
      await _polygonIdSdk.credential.updateClaim(
        claimId: id,
        issuer: issuer,
        genesisDid: did,
        state: state,
        expiration: expiration,
        type: type,
        data: data,
        privateKey: privateKey,
      );

      add(const GetClaimsEvent());
    } on UpdateClaimException catch (_) {
      emit(const ClaimsState.error("error while updating credential"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  void _handleClickScanQrCode(
      ClickScanQrCodeEvent event, Emitter<ClaimsState> emit) {
    emit(const ClaimsState.navigateToQrCodeScanner());
  }

  ///
  Future<void> _handleScanQrCodeResponse(
      ScanQrCodeResponse event, Emitter<ClaimsState> emit) async {
    String? qrCodeResponse = event.response;
    if (qrCodeResponse == null || qrCodeResponse.isEmpty) {
      emit(const ClaimsState.error("no qr code scanned"));
    }

    try {
      final Iden3MessageEntity iden3message = await _polygonIdSdk.iden3comm
          .getIden3Message(message: qrCodeResponse!);
      emit(ClaimsState.qrCodeScanned(iden3message));
    } catch (error) {
      emit(const ClaimsState.error("Scanned code is not valid"));
    }
  }

  ///
  void _handleClickClaim(OnClickClaim event, Emitter<ClaimsState> emit) {
    emit(const ClaimsState.loading());
    emit(ClaimsState.navigateToClaimDetail(event.claimModel));
  }

  ///
  void _handleRemoveClaimResponse(
      OnClaimDetailRemoveResponse event, Emitter<ClaimsState> emit) {
    bool removed = event.removed ?? false;

    if (!removed) {
      return;
    }

    add(const GetClaimsEvent());
  }

  ///
  Future<void> _removeAllClaims(
      RemoveAllClaimsEvent event, Emitter<ClaimsState> emit) async {
    emit(const ClaimsState.loading());

    String? privateKey =
        await SecureStorage.read(key: SecureStorageKeys.privateKey);

    if (privateKey == null) {
      emit(const ClaimsState.error("Private key not found"));
      return;
    }

    EnvEntity env = await _polygonIdSdk.getEnv();

    String did = await _polygonIdSdk.identity.getDidIdentifier(
      privateKey: privateKey,
      blockchain: env.blockchain,
      network: env.network,
    );

    if (did.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to remove all claims"));
      return;
    }

    try {
      List<ClaimEntity> claimList = await _polygonIdSdk.credential.getClaims(
        genesisDid: did,
        privateKey: privateKey,
      );

      List<String> claimIds = claimList.map((claim) => claim.id).toList();
      await _polygonIdSdk.credential.removeClaims(
        claimIds: claimIds,
        genesisDid: did,
        privateKey: privateKey,
      );
      add(const GetClaimsEvent());
    } catch (_) {
      emit(const ClaimsState.error("error while removing claims"));
    }
  }
}
