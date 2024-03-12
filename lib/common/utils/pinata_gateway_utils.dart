import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class PinataGatewayUtils {
  Future<String?> retrievePinataGatewayUrlFromEnvironment({
    required String fileHash,
  }) async {
    try {
      GetEnvUseCase getEnvUseCase = await getItSdk.getAsync<GetEnvUseCase>();
      EnvEntity env = await getEnvUseCase.execute();
      if (env.pinataGateway != null &&
          env.pinataGateway!.isNotEmpty &&
          env.pinataGatewayToken != null &&
          env.pinataGatewayToken!.isNotEmpty) {
        String url =
            "${env.pinataGateway}/ipfs/$fileHash?pinataGatewayToken=${env.pinataGatewayToken}";
        return url;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
