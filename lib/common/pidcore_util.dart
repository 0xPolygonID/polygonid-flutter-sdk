import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreUtil extends PolygonIdCore {
  Map<String, dynamic> validateAttestationDocument(String attestationDocument) {
    return callGenericCoreFunction(
      input: () => jsonEncode({"attestation_document": attestationDocument}),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNValidateAttestationDocument,
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json;
      },
    );
  }

  String anonPack(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNAAnonPack,
      parse: (result) {
        return result;
      },
    );
  }

  String anonUnpack(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNAAnonUnpack,
      parse: (result) {
        return result;
      },
    );
  }

  String decryptJwe(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNDecryptJWE,
      parse: (result) {
        return result;
      },
    );
  }

  String decryptEncryptedCredential(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNDecryptEncryptedCredential,
      parse: (result) {
        return result;
      },
    );
  }

  bool verifyProof(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNVerifyProof,
      parse: (result) {
        return jsonDecode(result)['valid'] as bool? ?? false;
      },
    );
  }
}
