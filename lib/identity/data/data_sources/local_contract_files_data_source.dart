import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';

class LocalContractFilesDataSource {
  Future<DeployedContract> loadStateContract(String address) {
    return rootBundle
        .loadString('packages/polygonid_flutter_sdk/lib/assets/StateABI.json')
        .then((json) => DeployedContract(
            ContractAbi.fromJson(jsonEncode(jsonDecode(json)["abi"]), 'State'),
            EthereumAddress.fromHex(address)));
  }
}
