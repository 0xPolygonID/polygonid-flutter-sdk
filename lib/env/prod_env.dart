import 'package:envied/envied.dart';

import 'sdk_env.dart';

part 'prod_env.g.dart';

@Envied(name: 'Env', path: '.env')
class ProdEnv implements SdkEnv {
  ProdEnv();

  @override
  @EnviedField(varName: 'NETWORK_NAME', obfuscate: true)
  final String networkName = _Env.networkName;
  @override
  @EnviedField(varName: 'NETWORK_ENV', obfuscate: true)
  final String networkEnv = _Env.networkEnv;
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
  @EnviedField(varName: 'REVERSE_HASH_SERVICE_URL', obfuscate: true)
  final String reverseHashServiceUrl = _Env.reverseHashServiceUrl;
  @override
  @EnviedField(varName: 'ID_STATE_CONTRACT_ADDR', obfuscate: true)
  final String idStateContractAddress = _Env.idStateContractAddress;
  @override
  @EnviedField(varName: 'GIST_PROOF_CONTRACT_ADDR', obfuscate: true)
  final String gistProofContractAddress = _Env.gistProofContractAddress;
  @override
  @EnviedField(varName: 'PUSH_URL', obfuscate: true)
  final String pushUrl = _Env.pushUrl;
}
