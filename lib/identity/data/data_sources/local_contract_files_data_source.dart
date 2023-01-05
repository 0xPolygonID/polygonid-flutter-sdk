import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';

class LocalContractFilesDataSource {
  final AssetBundle _assetBundle;

  LocalContractFilesDataSource(this._assetBundle);

  Future<DeployedContract> loadStateContract(String address) {
    return _assetBundle
        .loadString('packages/polygonid_flutter_sdk/lib/assets/state.abi.json')
        .then((json) => DeployedContract(
            ContractAbi.fromJson(jsonEncode(jsonDecode(json)["abi"]), 'State'),
            EthereumAddress.fromHex(address)));
  }

  Future<DeployedContract> loadGistContract(String address) {
    return _assetBundle
        .loadString('packages/polygonid_flutter_sdk/lib/assets/gist.abi.json')
        .then((json) => DeployedContract(
            ContractAbi.fromJson(jsonEncode(jsonDecode(json)["abi"]), 'Gist'),
            EthereumAddress.fromHex(address)));
  }
}
