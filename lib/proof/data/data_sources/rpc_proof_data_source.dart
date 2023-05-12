import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/assets/state.g.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class RPCProofDataSource {
  /// Retrieve gist proof.
  ///
  /// @param [web3Client] web3client
  /// @param [id] identity - The id as bigint
  /// @param [gistContract] the ABI contract
  ///
  /// @returns [String] gist proof
  Future<String> getGistProof(
      Web3Client web3Client, String id, DeployedContract gistContract) async {
    try {
      /// TODO: replace to autegenerated code to interact with SC
      //var state = State(address: gistContract.address, client: web3Client);
      //dynamic res = await state.getGISTProof(BigInt.parse(id));
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
        var siblings =
            (result[0][2] as List).map((bigInt) => bigInt.toString()).toList();

        final String resultString = jsonEncode({
          "root": result[0][0].toString(),
          "existence": result[0][1].toString() == "true" ? true : false,
          "siblings": siblings,
          "index": result[0][3].toString(),
          "value": result[0][4].toString(),
          "auxExistence": result[0][5].toString() == "true" ? true : false,
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
