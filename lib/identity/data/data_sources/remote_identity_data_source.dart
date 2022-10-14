import 'dart:convert';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../env/sdk_env.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../libs/rhs/state_contract.dart';

class RemoteIdentityDataSource {
  final Client client;

  RemoteIdentityDataSource(this.client);

  Future<List<dynamic>> fetchIdentityState({required String id}) async {
    try {
      Web3Client web3Client =
          Web3Client(SdkEnv().infuraUrl, client, socketConnector: () {
        return IOWebSocketChannel.connect(SdkEnv().infuraRdpUrl).cast<String>();
      });

      return StateContract(web3Client).getState(id);
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
