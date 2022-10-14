// lib/env/env.dart
import 'package:envied/envied.dart';

import 'sdk_env.dart';
import 'sdk_env_fields.dart';

part 'dev_env.g.dart';

@Envied(name: 'Env', path: '.env.dev')
class DevEnv implements SdkEnv, SdkEnvFields {
  const DevEnv();

  @override
  @EnviedField(varName: 'POLYGONID_ACCESS_MESSAGE')
  final String polygonIdAccessMessage = _Env.polygonIdAccessMessage;
  @override
  @EnviedField(varName: 'INFURA_URL')
  final String infuraUrl = _Env.infuraUrl;
  @override
  @EnviedField(varName: 'INFURA_RDP_URL')
  final String infuraRdpUrl = _Env.infuraRdpUrl;
  @override
  @EnviedField(varName: 'INFURA_API_KEY')
  final String infuraApiKey = _Env.infuraApiKey;
  @override
  @EnviedField(varName: 'ID_STATE_CONTRACT_ADDR')
  final String idStateContractAddress = _Env.idStateContractAddress;
}
