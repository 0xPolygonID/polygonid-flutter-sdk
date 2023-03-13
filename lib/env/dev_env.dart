import 'package:envied/envied.dart';

import 'sdk_env.dart';

part 'dev_env.g.dart';

@Envied(name: 'Env', path: '.env.dev')
class DevEnv implements SdkEnv {
  @override
  @EnviedField(varName: 'PUSH_URL', obfuscate: true)
  final String pushUrl = _Env.pushUrl;
}
