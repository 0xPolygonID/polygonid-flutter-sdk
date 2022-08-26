import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/common/bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/use_cases/fetch_and_saves_claims_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/models/iden3_message.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';

class ClaimsBloc extends Bloc<ClaimsState> {
  final FetchAndSavesClaimsUseCase _fetchAndSavesClaimsUseCase;
  final GetIdentifierUseCase _getIdentifierUseCase;
  final ClaimModelMapper _mapper;

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

  ClaimsBloc(this._fetchAndSavesClaimsUseCase, this._getIdentifierUseCase, this._mapper);

  ///
  Future<void> fetchAndSaveClaims() async {
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
    changeState(ClaimsState.loading());

    //-- MOCKED
    List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];

    //-- MOCKED END

    List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();

    changeState(ClaimsState.loaded(claimModelList));
  }

  ///
  Future<void> getClaims({List<FilterEntity>? filters}) async {
    try {
      //List<ClaimEntity> claimList = await PolygonIdSdk.I.credential.getClaims(filters: filters);
      List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];
      List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      changeState(ClaimsState.loaded(claimModelList));
    } on GetClaimsException catch (_) {
      changeState(ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      changeState(ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> getClaimsByIds({required List<String> ids}) async {
    try {
      //List<ClaimEntity> claimList = await PolygonIdSdk.I.credential.getClaimsByIds(ids: ids);
      List<ClaimEntity> claimEntityList = [_tempClaimEntity, _tempClaimEntity, _tempClaimEntity];
      List<ClaimModel> claimModelList = claimEntityList.map((claimEntity) => _mapper.mapFrom(claimEntity)).toList();
      changeState(ClaimsState.loaded(claimModelList));
    } on GetClaimsException catch (_) {
      changeState(ClaimsState.error("error while retrieving claims"));
    } catch (_) {
      changeState(ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> removeClaim({required String id}) async {
    try {
      await PolygonIdSdk.I.credential.removeClaim(id: id);
      getClaims();
    } on RemoveClaimsException catch (_) {
      changeState(ClaimsState.error("error while removing claim"));
    } catch (_) {
      changeState(ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> removeClaims({required List<String> ids}) async {
    try {
      await PolygonIdSdk.I.credential.removeClaims(ids: ids);
      getClaims();
    } on RemoveClaimsException catch (_) {
      changeState(ClaimsState.error("error while removing claims"));
    } catch (_) {
      changeState(ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> updateClaim({
    required String id,
    String? issuer,
    String? identifier,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
  }) async {
    try {
      ClaimEntity updatedClaim = await PolygonIdSdk.I.credential.updateClaim(
        id: id,
        issuer: issuer,
        identifier: identifier,
        state: state,
        expiration: expiration,
        type: type,
        data: data,
      );

      //TODO @Raul @Flavien is it a good approach? if yes how to handle -1 indexWhere response?
      /*int index = this.state.claimList.indexWhere((element) => element.id == id);
      this.state.claimList[index] = updatedClaim;

      changeState(ClaimsState.loaded(this.state.claimList));*/
      getClaims();
    } on UpdateClaimException catch (_) {
      changeState(ClaimsState.error("error while updating claim"));
    } catch (_) {
      changeState(ClaimsState.error("generic error"));
    }
  }

  ///
  Future<void> getIden3messageFromQrScanning(BuildContext context) async {
    changeState(ClaimsState.loading());
    String? scanningResult = await Navigator.pushNamed(context, Routes.qrCodeScannerPath) as String?;

    if (scanningResult == null) {
      changeState(ClaimsState.error("no qr code scanned"));
      return;
    }

    try {
      final Map<String, dynamic> data = jsonDecode(scanningResult);
      final Iden3Message iden3message = Iden3Message.fromJson(data);

      fetchAndSaveClaims();
    } catch (error) {
      changeState(ClaimsState.error("Scanned code is not valid"));
    }
  }
}
