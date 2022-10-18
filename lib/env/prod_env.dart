// lib/env/env.dart
import 'package:envied/envied.dart';

import 'sdk_env.dart';
import 'sdk_env_fields.dart';

part 'prod_env.g.dart';

@Envied(name: 'Env', path: '.env')
class ProdEnv implements SdkEnv, SdkEnvFields {
  ProdEnv();

  @override
  @EnviedField(varName: 'POLYGONID_ACCESS_MESSAGE', obfuscate: true)
  final String polygonIdAccessMessage = _Env.polygonIdAccessMessage;
  @override
  @EnviedField(varName: 'INFURA_URL', obfuscate: true)
  final String infuraUrl = _Env.infuraUrl;
  @override
  @EnviedField(varName: 'INFURA_RDP_URL', obfuscate: true)
  final String infuraRdpUrl = _Env.infuraRdpUrl;
  @override
  @EnviedField(varName: 'INFURA_API_KEY', obfuscate: true)
  final String infuraApiKey = _Env.infuraApiKey;
  @override
  @EnviedField(varName: 'ID_STATE_CONTRACT_ADDR', obfuscate: true)
  final String idStateContractAddress = _Env.idStateContractAddress;
}
