import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'DEFAULT_ENV')
  static const String defaultEnvironment = _Env.defaultEnvironment;

  @EnviedField(varName: 'STACKTRACE_ENCRYPTION_KEY')
  static const String stacktraceEncryptionKey = _Env.stacktraceEncryptionKey;

  @EnviedField(varName: 'IPFS_GATEWAY_URL')
  static const String ipfsGatewayUrl = _Env.ipfsGatewayUrl;
}
