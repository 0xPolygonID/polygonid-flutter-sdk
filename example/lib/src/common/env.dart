import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'ENV_POLYGON')
  static const String polygonEnv = _Env.polygonEnv;
}
