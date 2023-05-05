import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/assets/state.g.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class RPCIdentityDataSource {
  final GetEnvUseCase _getEnvUseCase;

  RPCIdentityDataSource(this._getEnvUseCase);

  /// Retrieve last state for a given identity.
  ///
  /// @param [id] identity - The base58 identifier string
  /// @param [stateContract] the ABI contract
  ///
  /// @returns [String] last state committed
  Future<String> getState(String id, DeployedContract stateContract) async {
    EnvEntity env = await _getEnvUseCase.execute();
    Web3Client web3Client = getItSdk.get(param1: env);
    try {
      var state = State(address: stateContract.address, client: web3Client);
      BigInt idBigInt = Uint8ArrayUtils.leBuff2int(hexToBytes(id));
      logger().d(idBigInt);

      List<dynamic> result = await state.getStateInfoById(idBigInt);

      if (result != null &&
          result.isNotEmpty &&
          result.length == 7 &&
          result[1] is BigInt) {
        if (result[1] != BigInt.zero) {
          // state
          String resultString =
              bytesToHex(Uint8ArrayUtils.bigIntToBytes(result[1]));
          logger().d(resultString);
          return resultString;
        }
      }
      return "";
    } catch (e) {
      logger().e(e.toString());
      rethrow;
    }
  }
}
