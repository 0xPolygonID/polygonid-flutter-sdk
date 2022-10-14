import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../env/sdk_env.dart';
import 'contract_parser.dart';

class StateContract {
  final Web3Client web3Client;

  StateContract(this.web3Client);

  /// Retrieve last state for a given identity.
  ///
  /// @param [id] identity - The compressed amount to be withdrawn
  ///
  /// @returns [String] last state committed
  Future<List<dynamic>> getState(String id) async {
    final stateContract = await ContractParser.fromAssets(
        'StateABI.json', SdkEnv().idStateContractAddress, 'State');

    final transactionParameters = [hexToBytes('0x')];

    logger().d(transactionParameters);

    List<dynamic> result;
    try {
      result = await web3Client.call(
          contract: stateContract,
          function: _getState(stateContract),
          params: transactionParameters);

      logger().d(result);
      return result;
    } catch (e) {
      logger().e(e.toString());
      rethrow;
    }
  }

  ContractFunction _getState(DeployedContract contract) =>
      contract.function('getState');
}
