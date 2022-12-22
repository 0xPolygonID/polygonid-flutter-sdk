import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/revocation_status.dart';

import '../../../identity/data/dtos/proof_dto.dart';
import '../dtos/prepare_inputs_param.dart';
import 'lib_pidcore_proof_data_source.dart';

@injectable
class PrepareInputsWrapper {
  final LibPolygonIdCoreProofDataSource _libPolygonIdCoreProofDataSource;

  PrepareInputsWrapper(this._libPolygonIdCoreProofDataSource);

  Future<String?> authInputs(PrepareInputsParam prepareInputsParam) async {
    return await compute(_computePrepareInputs, prepareInputsParam);
  }

  ///
  Future<String?> queryInputsFromMTP(
      PrepareInputsParam prepareInputsParam) async {
    return await compute(_computePrepareInputs, prepareInputsParam);
  }

  ///
  Future<String?> queryInputsFromSIG(
      PrepareInputsParam prepareInputsParam) async {
    return await compute(_computePrepareInputs, prepareInputsParam);
  }

  ///
  Future<String> _computePrepareInputs(PrepareInputsParam param) {
    Future<String> result;

    //switch (param.type) {
    //  case PrepareInputsType.auth:
    // TODO:
    result = "" as Future<
        String>; /*prepareAuthInputs(
      did: param.did,
      profileNonce: param.profileNonce,
      authClaim: param.authClaim,
      incProof: param.incProof,
      nonRevProof: param.nonRevProof,
      gistProof: param.gistProof,
      treeState: param.treeState,
      challenge: param.challenge,
      signature: param.signature,
    );*/
    /*  break;
      case PrepareInputsType.mtp:
        /*result = _iden3coreLib.prepareAtomicQueryMTPInputs(
            param.challenge,
            param.pubX,
            param.pubY,
            param.signature,
            param.credential,
            param.jsonLDDocument,
            param.schema,
            param.key,
            param.values,
            param.operator,
            param.revocationStatus);*/
        break;
      case PrepareInputsType.sig:
        /*result = _iden3coreLib.prepareAtomicQuerySigInputs(
          param.challenge,
          param.pubX,
          param.pubY,
          param.signature,
          param.credential,
          param.jsonLDDocument,
          param.schema,
          param.key,
          param.values,
          param.operator,
          param.revocationStatus,
        );*/
        break;
    }*/

    return result;
  }
}

///
class PrepareInputsDataSource {
  final PrepareInputsWrapper _prepareInputsWrapper;

  PrepareInputsDataSource(this._prepareInputsWrapper);

  /*@override
  Future<String> prepareAuthInputs({
    required String did,
    required int profileNonce,
    required List<String> authClaim,
    required ProofDTO incProof,
    required ProofDTO nonRevProof,
    required ProofDTO gistProof,
    required Map<String, dynamic> treeState,
    required String challenge,
    required String signature,
  }) async {
    String authInputs = _libPolygonIdCoreIden3commDataSource.prepareAuthInputs(
        did: did,
        profileNonce: profileNonce,
        authClaim: authClaim,
        incProof: {
          "existence": incProof.existence,
          "siblings":
          incProof.siblings.map((hashDTO) => hashDTO.toString()).toList()
        },
        nonRevProof: {
          "existence": nonRevProof.existence,
          "siblings":
          nonRevProof.siblings.map((hashDTO) => hashDTO.toString()).toList()
        },
        gistProof: gistProof.toJson(),
        treeState: treeState,
        challenge: challenge,
        signature: signature);
    return authInputs;
  }*/

  Future<String?> prepareAuthInputs(
      {required String did,
      required int profileNonce,
      required List<String> authClaim,
      required ProofDTO incProof,
      required ProofDTO nonRevProof,
      required ProofDTO gistProof,
      required Map<String, dynamic> treeState,
      required String challenge,
      required String signature}) async {
    var authInputsParam = PrepareInputsParam(
      PrepareInputsType.auth,
      did,
      profileNonce,
      authClaim,
      incProof,
      nonRevProof,
      gistProof,
      treeState,
      challenge,
      signature,
    );
    String? authInputs =
        await _prepareInputsWrapper.authInputs(authInputsParam);
    return authInputs;
  }

  ///
  Future<String?> prepareAtomicQueryInputs(
    String challenge,
    ClaimInfoDTO claimInfo,
    String circuitId,
    String key,
    List<int> values,
    int operator,
    RevocationStatus claimRevocationStatus,
    String pubX,
    String pubY,
    String signature,
  ) async {
    // TODO
    return "";

    // schema
    /*String schemaId = claimInfo.credentialSchema.id;
    String schemaUrl = schemaId;
    if (schemaId.toLowerCase().startsWith("ipfs://")) {
      String fileHash = schemaId.toLowerCase().replaceFirst("ipfs://", "");
      schemaUrl = "https://ipfs.io/ipfs/$fileHash";
    }
    var uri = Uri.parse(schemaUrl);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    String? queryInputs;
    if (circuitId == "credentialAtomicQueryMTP") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(
          AtomicQueryInputsType.mtp,
          challenge,
          pubX,
          pubY,
          signature,
          claimInfo,
          json.encode(claimInfo.toJson()),
          schema,
          key,
          values,
          operator,
          claimRevocationStatus);
      queryInputs = await _atomicQueryInputsWrapper
          .queryInputsFromMTP(atomicQueryInputsParam);
    } else if (circuitId == "credentialAtomicQuerySig") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(
          AtomicQueryInputsType.sig,
          challenge,
          pubX,
          pubY,
          signature,
          claimInfo,
          json.encode(claimInfo.toJson()),
          schema,
          key,
          values,
          operator,
          claimRevocationStatus);
      // Issuer auth claim revocation status
      queryInputs = await _atomicQueryInputsWrapper
          .queryInputsFromSIG(atomicQueryInputsParam);
    }

    return queryInputs;*/
  }
}
