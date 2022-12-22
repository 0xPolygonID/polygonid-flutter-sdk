import 'package:injectable/injectable.dart';

@injectable
class AtomicQueryInputsWrapper {
  //final Iden3CoreLib _iden3coreLib;

  //AtomicQueryInputsWrapper(this._iden3coreLib);

  ///
  /*Future<String?> queryInputsFromMTP(
      AtomicQueryInputsParam atomicQueryInputsParam) async {
    return await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
  }

  ///
  Future<String?> queryInputsFromSIG(
      AtomicQueryInputsParam atomicQueryInputsParam) async {
    return await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
  }

  ///
  Future<String> _computeAtomicQueryInputs(AtomicQueryInputsParam param) {
    String result;

    switch (param.type) {
      case AtomicQueryInputsType.mtp:
        result = _iden3coreLib.prepareAtomicQueryMTPInputs(
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
            param.revocationStatus);
        break;

      case AtomicQueryInputsType.sig:
        result = _iden3coreLib.prepareAtomicQuerySigInputs(
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
        );
        break;
    }

    return Future.value(result);
  }
}

///
class AtomicQueryInputsDataSource {
  final AtomicQueryInputsWrapper _atomicQueryInputsWrapper;

  AtomicQueryInputsDataSource(this._atomicQueryInputsWrapper);

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
    // schema
    String schemaId = claimInfo.credentialSchema.id;
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

    return queryInputs;
  }*/
}
