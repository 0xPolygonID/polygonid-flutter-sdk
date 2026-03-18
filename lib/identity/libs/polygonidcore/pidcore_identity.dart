import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreIdentity extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreIdentity(this._stacktraceManager);

  /// PLGNNewGenesisID returns the genesis ID
  String calculateGenesisId(String input, String config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNNewGenesisID,
      methodName: 'PLGNNewGenesisID',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  /// PLGNNewGenesisIDFromEth returns the genesis ID from an Ethereum address
  String calculateGenesisIdFromEth(String input, String config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNNewGenesisIDFromEth,
      methodName: 'PLGNNewGenesisIDFromEth',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  /// PLGNProfileID returns the profile ID from genesis ID and profile nonce
  String calculateProfileId(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: (response, in1, cfg, status) =>
          PolygonIdCore.nativePolygonIdCoreLib.PLGNProfileID(
            response,
            in1,
            status,
          ),
      methodName: 'PLGNProfileID',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  /// PLGNIDToInt returns the ID as a big int string
  /// Input should be a valid JSON object: string enclosed by double quotes.
  /// Output is a valid JSON object too: string enclosed by double quotes.
  String convertIdToBigInt(String input) {
    return callGenericCoreFunction(
      input: () => input,
      function: (response, in1, cfg, status) {
        return PolygonIdCore.nativePolygonIdCoreLib.PLGNIDToInt(
          response,
          in1,
          status,
        );
      },
      methodName: 'PLGNIDToInt',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }

  /// PLGNDescribeID
  String describeId(String input, String? config) {
    return callGenericCoreFunction(
      input: () => input,
      config: config,
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNDescribeID,
      methodName: 'PLGNDescribeID',
      onError: _stacktraceManager.addError,
      parse: (result) => result,
    );
  }
}
