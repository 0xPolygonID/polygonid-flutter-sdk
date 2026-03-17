import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreCredential extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreCredential(this._stacktraceManager);

  String createClaim(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: (response, in1, cfg, status) =>
          PolygonIdCore.nativePolygonIdCoreLib.PLGNCreateClaim(
            response,
            in1,
            status,
          ),
      methodName: 'PLGNCreateClaim',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  bool cacheCredential(String input, String? config) {
    callVoidCoreFunction(
      input: input,
      config: config,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNCacheCredentials,
      methodName: 'PLGNCacheCredentials',
      onError: _stacktraceManager.addError,
    );
    return true;
  }

  void cleanCache(String? config) {
    callVoidCoreFunction(
      config: config,
      function: (in1, cfg, status) =>
          PolygonIdCore.nativePolygonIdCoreLib.PLGNCleanCache2(
            cfg,
            status,
          ),
      methodName: 'PLGNCleanCache2',
      onError: _stacktraceManager.addError,
    );
  }

  String getW3CCredentialFromOnchainHex(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNW3CCredentialFromOnchainHex,
      methodName: 'PLGNW3CCredentialFromOnchainHex',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  String createW3CCredentialFromAnonAadhaarInputs(
    String input,
    String? config,
  ) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore
          .nativePolygonIdCoreLib
          .PLGNW3CCredentialFromAnonAadhaarInputs,
      methodName: 'PLGNW3CCredentialFromAnonAadhaarInputs',
      parse: (o) => o,
    );
  }

  String createW3CCredentialFromPassportInputs(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore
          .nativePolygonIdCoreLib
          .PLGNW3CCredentialFromPassportInputs,
      methodName: 'PLGNW3CCredentialFromPassportInputs',
      parse: (o) => o,
    );
  }

  String createCoreClaimFromW3CCredential(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNW3CCredentialToCoreClaim,
      methodName: 'PLGNW3CCredentialToCoreClaim',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  bool credentialStatusCheck(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNACredentialStatusCheck,
      methodName: 'PLGNACredentialStatusCheck',
      parse: (result) {
        return jsonDecode(result)['valid'] as bool? ?? false;
      },
    );
  }
}
