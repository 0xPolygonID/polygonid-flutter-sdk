import 'package:envied/envied.dart';

import 'sdk_env.dart';

part 'prod_env.g.dart';

@Envied(name: 'Env', path: '.env')
class ProdEnv implements SdkEnv {
  @override
  @EnviedField(varName: 'PUSH_URL', obfuscate: true)
  final String pushUrl = _Env.pushUrl;
}
