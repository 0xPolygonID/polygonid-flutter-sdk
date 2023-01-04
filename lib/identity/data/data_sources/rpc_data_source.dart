import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class RPCDataSource {
  final Web3Client web3Client;

  RPCDataSource(this.web3Client);

  /// Retrieve last state for a given identity.
  ///
  /// @param [id] identity - The base58 identifier string
  /// @param [stateContract] the ABI contract
  ///
  /// @returns [String] last state committed
  Future<String> getState(String id, DeployedContract stateContract) async {
    try {
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

  /// Retrieve gist proof.
  ///
  /// @param [id] identity - The id as bigint
  /// @param [gistContract] the ABI contract
  ///
  /// @returns [String] gist proof
  Future<String> getGistProof(String id, DeployedContract gistContract) async {
    try {
      final transactionParameters = [
        BigInt.parse(id),
      ];

      logger().d(transactionParameters);

      List<dynamic> result;

      result = await web3Client.call(
          contract: gistContract,
          function: _getGistProof(gistContract),
          params: transactionParameters);

      if (result != null &&
          result.isNotEmpty &&
          result[0] is List &&
          result[0].length == 8) {
        final String resultString = jsonEncode({
          "root": result[0][0].toString(),
          "existence": result[0][2].toString() == "0" ? false : true,
          "siblings": (result[0][1] as List)
              .map((bigInt) => bigInt.toString())
              .toList(),
          "index": result[0][3].toString(),
          "value": result[0][7].toString(),
          "auxExistence": result[0][5].toString() == "0" ? false : true,
          "auxIndex": result[0][6].toString(),
          "auxValue": result[0][7].toString(),
        });
        logger().d(resultString);
        return resultString;
      }
      return "";
    } catch (e) {
      logger().e(e.toString());
      rethrow;
    }
  }

  ContractFunction _getGistProof(DeployedContract contract) =>
      contract.function('getGISTProof');
}
