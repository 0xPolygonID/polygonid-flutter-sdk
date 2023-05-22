import 'dart:convert';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';

/// TODO: json is loaded from constant string, but it should be loaded from a file
/// to ensure sync with the .g.dart counterpart
class LocalContractFilesDataSource {
  // final AssetBundle _assetBundle;
  //
  // LocalContractFilesDataSource(this._assetBundle);

  Future<DeployedContract> loadStateContract(String address) {
    return
        // _assetBundle
        //   .loadString('packages/polygonid_flutter_sdk/lib/assets/state.abi.json')
        Future.value(stateAbiJson).then((json) => DeployedContract(
            ContractAbi.fromJson(jsonEncode(jsonDecode(json)["abi"]), 'State'),
            EthereumAddress.fromHex(address)));
  }
}
