import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/generate_inputs_response.dart';

@injectable
class PolygonIdCoreProof extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreProof(this._stacktraceManager);

  String proofFromSmartContract(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: (response, in1, cfg, status) =>
          PolygonIdCore.nativePolygonIdCoreLib.PLGNProofFromSmartContract(
            response,
            in1,
            status,
          ),
      methodName: 'PLGNProofFromSmartContract',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  GenerateInputsResponse generateInputs(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNAGenerateInputs,
      methodName: 'PLGNAGenerateInputs',
      parse: (result) {
        return GenerateInputsResponse.fromJson(jsonDecode(result));
      },
    );
  }
}
