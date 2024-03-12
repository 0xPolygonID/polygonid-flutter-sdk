import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'DEFAULT_ENV')
  static const String defaultEnvironment = _Env.defaultEnvironment;

  @EnviedField(varName: 'PINATA_GATEWAY')
  static const String pinataGateway = _Env.pinataGateway;

  @EnviedField(varName: 'PINATA_GATEWAY_TOKEN')
  static const String pinataGatewayToken = _Env.pinataGatewayToken;

  @EnviedField(varName: 'STACKTRACE_ENCRYPTION_KEY')
  static const String stacktraceEncryptionKey = _Env.stacktraceEncryptionKey;
}
