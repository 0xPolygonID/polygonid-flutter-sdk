import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class IPFSUtils {
  static Future<String> getIpfsFileUrl(String fileHash) async {
    if (fileHash.startsWith('ipfs://')) {
      fileHash = fileHash.replaceFirst('ipfs://', '');
    }

    final getEnvUseCase = getItSdk<GetEnvUseCase>();
    final env = await getEnvUseCase.execute();

    return "${env.ipfsGatewayUrl}/ipfs/$fileHash";
  }
}
