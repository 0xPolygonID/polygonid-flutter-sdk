import 'dart:convert';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../libs/iden3core/iden3core.dart';
import '../../libs/rhs/state_contract.dart';

class RemoteIdentityDataSource {
  final Client client;
  final Web3Client web3Client;
  final Iden3CoreLib iden3CoreLib;

  RemoteIdentityDataSource(this.client, this.web3Client, this.iden3CoreLib);

  Future<String> fetchIdentityState({required String id}) async {
    try {
      return StateContract(web3Client, iden3CoreLib).getState(id);
    } catch (error) {
      logger().e('identity state error: $error');
      throw FetchIdentityStateException(error);
    }
  }

  Future<RhsNodeDTO> fetchStateRoots({required String url}) async {
    try {
      //fetch rhs state and save it
      String rhsId = url;
      String rhsUrl = rhsId;
      if (rhsId.toLowerCase().startsWith("ipfs://")) {
        String fileHash = rhsId.toLowerCase().replaceFirst("ipfs://", "");
        rhsUrl = "https://ipfs.io/ipfs/$fileHash";
      }
      var rhsUri = Uri.parse(rhsUrl);
      var rhsResponse = await get(rhsUri);
      if (rhsResponse.statusCode == 200) {
        Map<String, dynamic>? rhsNode = json.decode(rhsResponse.body);
        RhsNodeDTO rhsNodeResponse = RhsNodeDTO.fromJson(rhsNode!);
        logger().d('rhs node: ${rhsNodeResponse.toString()}');
        return rhsNodeResponse;
      } else {
        throw NetworkException(rhsResponse);
      }
    } catch (error) {
      logger().e('state roots error: $error');
      throw FetchStateRootsException(error);
    }
  }
}
