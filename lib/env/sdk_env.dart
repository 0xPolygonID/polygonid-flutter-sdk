import 'dev_env.dart';
import 'prod_env.dart';
import 'sdk_env_fields.dart';

abstract class SdkEnv implements SdkEnvFields {
  static const kDebugMode = true;

  factory SdkEnv() => _instance;

  static final SdkEnv _instance = kDebugMode ? DevEnv() : ProdEnv();
}
