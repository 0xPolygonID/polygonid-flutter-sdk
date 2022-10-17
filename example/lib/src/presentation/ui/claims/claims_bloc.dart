import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final Iden3MessageMapper _iden3messageMapper;
  final ClaimModelMapper _mapper;
  final PolygonIdSdk _polygonIdSdk;

  ClaimsBloc(
    this._iden3messageMapper,
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
    String? identifier = await _polygonIdSdk.identity.getCurrentIdentifier();

    if (identifier == null || identifier.isEmpty) {
      emit(const ClaimsState.error(
          "without an identity is impossible to fetch claims"));
      return;
    }

    emit(const ClaimsState.loading());

    Iden3MessageEntity iden3message = event.iden3message;
    Map<String, dynamic>? messageBody = iden3message.body;

    if (messageBody == null) {
      emit(const ClaimsState.error("error in the readed message"));
      return;
    }

    // LOCAL FILES
    const circuitDatPath = 'assets/auth/auth.dat';
    const circuitProvingKeyPath = 'assets/auth/auth.zkey';
    ByteData datFile = await rootBundle.load(circuitDatPath);
    ByteData zkeyFile = await rootBundle.load(circuitProvingKeyPath);
    List<Uint8List> circuitFiles = [
      datFile.buffer.asUint8List(),
      zkeyFile.buffer.asUint8List(),
    ];
    var circuitData =
        CircuitDataEntity('auth', circuitFiles[0], circuitFiles[1]);

    String url = messageBody['url'];
    List<dynamic> credentials = messageBody['credentials'];

    List<CredentialRequestEntity> credentialRequestEntityList = [];
    for (Map<String, dynamic> credential in credentials) {
      String id = credential['id'];

      var entity = CredentialRequestEntity(
        identifier,
        circuitData,
        url,
        id,
        iden3message.thid!,
        iden3message.from!,
      );

      credentialRequestEntityList.add(entity);
    }

    List<ClaimEntity> claimList = await _polygonIdSdk.credential
        .fetchAndSaveClaims(credentialRequests: credentialRequestEntityList);

    if (claimList.isNotEmpty) {
      add(const GetClaimsEvent());
    }
  }

  ///
  Future<void> _getClaims(
      GetClaimsEvent event, Emitter<ClaimsState> emit) async {
    emit(const ClaimsState.loading());

    List<FilterEntity>? filters = event.filters;

    try {
      List<ClaimEntity> claimList =
          await _polygonIdSdk.credential.getClaims(filters: filters);

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

    try {
      List<ClaimEntity> claimList =
          await _polygonIdSdk.credential.getClaimsByIds(ids: ids);

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
    try {
      await _polygonIdSdk.credential.removeClaim(id: id);
      add(const GetClaimsEvent());
    } on RemoveClaimsException catch (_) {
      emit(const ClaimsState.error("error while removing claim"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _removeClaims(
      RemoveClaimsEvent event, Emitter<ClaimsState> emit) async {
    List<String> ids = event.ids;
    try {
      await _polygonIdSdk.credential.removeClaims(ids: ids);
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
    String? identifier = event.identifier;
    ClaimState? state = event.state;
    String? expiration = event.expiration;
    String? type = event.type;
    Map<String, dynamic>? data = event.data;
    try {
      await _polygonIdSdk.credential.updateClaim(
        id: id,
        issuer: issuer,
        identifier: identifier,
        state: state,
        expiration: expiration,
        type: type,
        data: data,
      );

      add(const GetClaimsEvent());
    } on UpdateClaimException catch (_) {
      emit(const ClaimsState.error("error while updating claim"));
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
  void _handleScanQrCodeResponse(
      ScanQrCodeResponse event, Emitter<ClaimsState> emit) {
    String? qrCodeResponse = event.response;
    if (qrCodeResponse == null || qrCodeResponse.isEmpty) {
      emit(const ClaimsState.error("no qr code scanned"));
    }

    try {
      final Iden3MessageEntity iden3message =
          _iden3messageMapper.mapFrom(qrCodeResponse!);
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
    try {
      List<ClaimEntity> claimList = await _polygonIdSdk.credential.getClaims();
      List<String> claimIds = claimList.map((claim) => claim.id).toList();
      await _polygonIdSdk.credential.removeClaims(ids: claimIds);
      add(const GetClaimsEvent());
    } catch (_) {
      emit(const ClaimsState.error("error while removing claims"));
    }
  }
}
