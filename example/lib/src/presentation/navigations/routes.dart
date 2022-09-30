import 'package:flutter/widgets.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/widgets/home.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/widgets/splash.dart';

class Routes {
  static const String initialPath = "/";
  static const String splashPath = "/splash";
  static const String introPath = "/intro";
  static const String homePath = "/home";

  ///
  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      initialPath: _splashRoute(),
      splashPath: _splashRoute(),
      homePath: _homeRoute(),
    };
  }

  ///
  static WidgetBuilder _splashRoute() {
    return (BuildContext context) => SplashScreen();
  }

  ///
  static WidgetBuilder _homeRoute() {
    return (BuildContext context) => HomeScreen();
  }
}
