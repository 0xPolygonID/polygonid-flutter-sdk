import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/use_cases/fetch_and_saves_claims_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_event.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final FetchAndSavesClaimsUseCase _fetchAndSavesClaimsUseCase;
  final GetIdentifierUseCase _getIdentifierUseCase;
  final ClaimModelMapper _mapper;
  final PolygonIdSdk _polygonIdSdk;

  //MOCKED
  final _tempClaimEntity = ClaimEntity(
    issuer: "Polygon Service",
    identifier: "",
    expiration: "",
    data: {},
    type: "Date of Birth",
    state: ClaimState.active,
    id: "id",
  );

  ClaimsBloc(
    this._fetchAndSavesClaimsUseCase,
    this._getIdentifierUseCase,
    this._mapper,
    this._polygonIdSdk,
  ) : super(const ClaimsState.initial()) {
    on<FetchAndSaveClaimsEvent>(_fetchAndSaveClaims);
    on<GetClaimsEvent>(_getClaims);
    on<GetClaimsByIdsEvent>(_getClaimsByIds);
    on<RemoveClaimEvent>(_removeClaim);
    on<RemoveClaimsEvent>(_removeClaims);
    on<UpdateClaimEvent>(_updateClaim);
    on<ClickScanQrCodeEvent>(_handleClickScanQrCode);
    on<ScanQrCodeResponse>(_handleScanQrCodeResponse);
  }

  ///
  Future<void> _fetchAndSaveClaims(FetchAndSaveClaimsEvent event, Emitter<ClaimsState> emit) async {
    //String? identifier = await _getIdentifierUseCase.execute();

    /*const circuitDatPath = 'assets/auth/auth.dat';
    const circuitProvingKeyPath = 'assets/auth/auth.zkey';
    ByteData datFile = await rootBundle.load(circuitDatPath);
    ByteData zkeyFile = await rootBundle.load(circuitProvingKeyPath);

    final circuitData = [
      CircuitDataEntity(
        "auth",
        datFile.buffer.asUint8List(),
        zkeyFile.buffer.asUint8List(),
      ),
    ];*/

    /*final requestEntities = [
      CredentialRequestEntity(
        identifier,
        circuitData[0],
        url,
        id,
        thid,
        from,
      ),
    ];*/

    //List<ClaimEntity> claimList = await _fetchAndSavesClaimsUseCase.execute(param: requestEntities);
    emit(const ClaimsState.loading());

    //-- MOCKED
    List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];

    //-- MOCKED END

    List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();

    emit(ClaimsState.loadedClaims(claimModelList));
  }

  ///
  Future<void> _getClaims(GetClaimsEvent event, Emitter<ClaimsState> emit) async {
    List<FilterEntity>? filters = event.filters;
    try {
      //List<ClaimEntity> claimList = await _polygonIdSdk.credential.getClaims(filters: filters);
      List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];
      List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      emit(ClaimsState.loadedClaims(claimModelList));
    } on GetClaimsException catch (_) {
      emit(const ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _getClaimsByIds(GetClaimsByIdsEvent event, Emitter<ClaimsState> emit) async {
    List<String> ids = event.ids;
    try {
      //List<ClaimEntity> claimList = await _polygonIdSdk.credential.getClaimsByIds(ids: ids);
      List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];
      List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      emit(ClaimsState.loadedClaims(claimModelList));
    } on GetClaimsException catch (_) {
      emit(const ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      emit(const ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> _removeClaim(RemoveClaimEvent event, Emitter<ClaimsState> emit) async {
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
  Future<void> _removeClaims(RemoveClaimsEvent event, Emitter<ClaimsState> emit) async {
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
  Future<void> _updateClaim(UpdateClaimEvent event, Emitter<ClaimsState> emit) async {
    String id = event.id;
    String? issuer = event.issuer;
    String? identifier = event.identifier;
    ClaimState? state = event.state;
    String? expiration = event.expiration;
    String? type = event.type;
    Map<String, dynamic>? data = event.data;
    try {
      ClaimEntity updatedClaim = await _polygonIdSdk.credential.updateClaim(
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
  void _handleClickScanQrCode(ClickScanQrCodeEvent event, Emitter<ClaimsState> emit) {
    emit(const ClaimsState.navigateToQrCodeScanner());
  }

  ///
  void _handleScanQrCodeResponse(ScanQrCodeResponse event, Emitter<ClaimsState> emit) {
    String? qrCodeResponse = event.response;
    if (qrCodeResponse == null || qrCodeResponse.isEmpty) {
      emit(const ClaimsState.error("no qr code scanned"));
    }

    try {
      final Map<String, dynamic> data = jsonDecode(qrCodeResponse!);
      final Iden3Message iden3message = Iden3Message.fromJson(data);
      emit(ClaimsState.qrCodeScanned(iden3message));
    } catch (error) {
      emit(const ClaimsState.error("Scanned code is not valid"));
    }
  }
}
