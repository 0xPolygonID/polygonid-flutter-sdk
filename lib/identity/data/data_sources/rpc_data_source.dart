import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/env/sdk_env.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../libs/rhs/contract_parser.dart';

class RPCDataSource {
  final Web3Client web3Client;

  RPCDataSource(this.web3Client);

  /// Retrieve last state for a given identity.
  ///
  /// @param [id] identity - The base58 identifier string
  ///
  /// @returns [String] last state committed
  Future<String> getState(String id) async {
    try {
      /// FIXME: this should go into another DS
      final stateContract = await ContractParser.fromAssets(
          'StateABI.json', SdkEnv().idStateContractAddress, 'State');

      final transactionParameters = [
        Uint8ArrayUtils.leBuff2int(hexToBytes(id)),
      ];

      logger().d(transactionParameters);

      List<dynamic> result;

      result = await web3Client.call(
          contract: stateContract,
          function: _getState(stateContract),
          params: transactionParameters);

      if (result != null && result.isNotEmpty && result[0] is BigInt) {
        if (result[0] != BigInt.zero) {
          String resultString =
              bytesToHex(Uint8ArrayUtils.bigIntToBytes(result[0]));
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

  ContractFunction _getState(DeployedContract contract) =>
      contract.function('getState');
}
