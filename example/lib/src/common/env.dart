import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(name: 'Env', path: 'env')
abstract class Env {
  @EnviedField(varName: 'ENV_POLYGON_MUMBAI')
  static const String polygonMumbai = _Env.polygonMumbai;
}
