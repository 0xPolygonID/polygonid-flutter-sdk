import 'package:polygonid_flutter_sdk/iden3comm/abi/onchain_non_merkelized_issuer_base_abi.dart';
import 'package:polygonid_flutter_sdk/iden3comm/abi/state_abi.dart';
import 'package:wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

/// TODO: json is loaded from constant string, but it should be loaded from a file
/// to ensure sync with the .g.dart counterpart
class LocalContractFilesDataSource {
  // final AssetBundle _assetBundle;
  //
  // LocalContractFilesDataSource(this._assetBundle);

  DeployedContract loadStateContract(String address) {
    return DeployedContract(
      ContractAbi.fromJson(stateAbiJson, 'State'),
      EthereumAddress.fromHex(address),
    );
  }

  DeployedContract loadOnchainIssuerContract(
    String onchainNonMerkelizedIssuerBaseAddress,
  ) {
    return DeployedContract(
      ContractAbi.fromJson(
        onchainNonMerkelizedIssuerBaseAbiJson,
        'OnchainNonMerkelizedIssuerBase',
      ),
      EthereumAddress.fromHex(onchainNonMerkelizedIssuerBaseAddress),
    );
  }
}
