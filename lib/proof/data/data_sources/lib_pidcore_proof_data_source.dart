import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_proof_dto.dart';

import '../../libs/polygonidcore/pidcore_proof.dart';
import '../dtos/atomic_query_inputs_param.dart';

@injectable
class LibPolygonIdCoreWrapper {
  final PolygonIdCoreProof _polygonIdCoreProof;

  LibPolygonIdCoreWrapper(this._polygonIdCoreProof);

  Future<String> getProofInputs(
      AtomicQueryInputsParam atomicQueryInputsParam) async {
    return compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
  }

  Future<String> _computeAtomicQueryInputs(AtomicQueryInputsParam param) {
    String result;

    switch (param.type) {
      case AtomicQueryInputsType.mtp:
        result =
            _polygonIdCoreProof.getMTProofInputs(jsonEncode(param.toJson()));
        break;
      case AtomicQueryInputsType.sig:
        result =
            _polygonIdCoreProof.getSigProofInputs(jsonEncode(param.toJson()));
        break;
      case AtomicQueryInputsType.mtponchain:
        result = _polygonIdCoreProof
            .getMTPOnchainProofInputs(jsonEncode(param.toJson()));
        break;
        break;
      case AtomicQueryInputsType.sigonchain:
        result = _polygonIdCoreProof
            .getSigOnchainProofInputs(jsonEncode(param.toJson()));
        break;
    }

    return Future.value(result);
  }

  String proofFromSmartContract(String input) {
    return _polygonIdCoreProof.proofFromSmartContract(input);
  }
}

class LibPolygonIdCoreProofDataSource {
  final LibPolygonIdCoreWrapper _libPolygonIdCoreWrapper;

  LibPolygonIdCoreProofDataSource(
    this._libPolygonIdCoreWrapper,
  );

  String proofFromSC(String input) {
    /*{
      "root":
          "17039823904837071705763545555283546217751326723169195059364451777353741017328",
      "siblings": [
        "14989532119404983961115670288381063073891118401716735992353404523801340288158",
        "15817549995119513546413395894800310537308858548528902759332598606866792105384",
        "20955911300871905860419417343337237575819647673394656670247178513070221579793",
        "7345857457589225232320640926291449425076936633178262764678572453063445218154",
        "13941064550735375985967548290421702932981128763694428458881182266843384273940",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0"
      ],
      "oldKey": "10",
      "oldValue": "20",
      "isOld0": false,
      "key":
          "13625694351531357880063798347796487002182037278253017013343168668336623401886",
      "value": "0",
      "fnc": "1"
    }*/

    String output = _libPolygonIdCoreWrapper.proofFromSmartContract(input);
    logger().d("proofFromSmartContract: $output");
    //{"root":"17039823904837071705763545555283546217751326723169195059364451777353741017328","proof":{"existence":false,"siblings":["14989532119404983961115670288381063073891118401716735992353404523801340288158","15817549995119513546413395894800310537308858548528902759332598606866792105384","20955911300871905860419417343337237575819647673394656670247178513070221579793","7345857457589225232320640926291449425076936633178262764678572453063445218154","13941064550735375985967548290421702932981128763694428458881182266843384273940","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],"node_aux":{"key":"10","value":"20"}}}
    return output;
  }

  Future<String> getProofInputs({
    required String id,
    required int profileNonce,
    required int claimSubjectProfileNonce,
    List<String>? authClaim,
    Map<String, dynamic>? incProof,
    Map<String, dynamic>? nonRevProof,
    Map<String, dynamic>? treeState,
    Map<String, dynamic>? gistProof,
    String? challenge,
    String? signature,
    required ClaimInfoDTO credential,
    required ProofScopeRequest request,
  }) {
    AtomicQueryInputsType type = AtomicQueryInputsType.mtp;

    if (request.circuitId == "credentialAtomicQueryMTPV2") {
      type = AtomicQueryInputsType.mtp;
    } else if (request.circuitId == "credentialAtomicQueryMTPV2OnChain") {
      type = AtomicQueryInputsType.mtponchain;
    } else if (request.circuitId == "credentialAtomicQuerySigV2") {
      type = AtomicQueryInputsType.sig;
    } else if (request.circuitId == "credentialAtomicQuerySigV2OnChain") {
      type = AtomicQueryInputsType.sigonchain;
    }

    return _libPolygonIdCoreWrapper.getProofInputs(AtomicQueryInputsParam(
      type: type,
      id: id,
      profileNonce: profileNonce,
      claimSubjectProfileNonce: claimSubjectProfileNonce,
      authClaim: authClaim,
      incProof: incProof,
      nonRevProof: nonRevProof,
      treeState: treeState,
      gistProof: gistProof,
      challenge: challenge,
      signature: signature,
      credential: credential,
      request: request,
    ));
  }
}
