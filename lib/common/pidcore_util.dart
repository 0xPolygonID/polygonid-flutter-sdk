import 'dart:convert';
import 'dart:isolate';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreUtil extends PolygonIdCore {
  String validateAttestationDocument(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNValidateAttestationDocument,
      methodName: 'PLGNValidateAttestationDocument',
      parse: (result) => result,
    );
  }

  String anonPack(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNAAnonPack,
      methodName: 'PLGNAAnonPack',
      parse: (result) {
        return result;
      },
    );
  }

  String anonUnpack(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNAAnonUnpack,
      methodName: 'PLGNAAnonUnpack',
      parse: (result) {
        return result;
      },
    );
  }

  String decryptJwe(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNDecryptJWE,
      methodName: 'PLGNDecryptJWE',
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
      methodName: 'PLGNDecryptEncryptedCredential',
      parse: (result) {
        return result;
      },
    );
  }

  bool verifyProof(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNVerifyProof,
      methodName: 'PLGNVerifyProof',
      parse: (result) {
        return jsonDecode(result)['valid'] as bool? ?? false;
      },
    );
  }

  // Async version running heavy native verification in a background isolate
  Future<String> verifyAuthResponse(String input) async {
    // Capture current env config before spawning isolate (late static vars are isolate-local)
    final config = PolygonIdCore.envConfigJson;
    return Isolate.run(
      () => callGenericCoreFunction(
        input: () => input,
        function: PolygonIdCore.nativePolygonIdCoreLib.PLGNVerifyAuthResponse,
        methodName: 'PLGNVerifyAuthResponse',
        config: config,
        parse: (res) => res,
      ),
    );
  }

  bool verifyAnonAadhaarQR(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNVerifyAnonAadhaarQR,
      methodName: 'PLGNVerifyAnonAadhaarQR',
      parse: (result) {
        return jsonDecode(result)['isValid'] as bool? ?? false;
      },
    );
  }
}
