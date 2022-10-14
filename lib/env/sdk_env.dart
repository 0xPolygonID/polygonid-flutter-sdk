import 'dev_env.dart';
import 'prod_env.dart';
import 'sdk_env_fields.dart';

abstract class SdkEnv implements SdkEnvFields {
  /// NOTE: This is here just as an example!
  ///
  /// In a Flutter app you would normally import this like so
  /// import 'package:flutter/foundation.dart';
  static const kDebugMode = true;

  factory SdkEnv() => _instance;

  static const SdkEnv _instance = kDebugMode ? DevEnv() : ProdEnv();
}
