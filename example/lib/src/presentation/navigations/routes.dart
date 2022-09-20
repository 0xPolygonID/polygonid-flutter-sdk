import 'package:flutter/widgets.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/widgets/claims.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/widgets/auth.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/widgets/home.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/qrcode_scanner.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/widgets/splash.dart';

class Routes {
  static const String initialPath = "/";
  static const String splashPath = "/splash";
  static const String introPath = "/intro";
  static const String homePath = "/home";
  static const String claimsPath = "/claims";
  static const String qrCodeScannerPath = "/qrcode_scanner";
  static const String authPath = "/auth";

  ///
  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      initialPath: _splashRoute(),
      splashPath: _splashRoute(),
      homePath: _homeRoute(),
      qrCodeScannerPath: _qrCodeScannerRoute(),
      authPath: _authRoute(),
      claimsPath: _claimsRoute(),
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

  ///
  static WidgetBuilder _claimsRoute() {
    return (BuildContext context) => ClaimsScreen();
  }

  ///
  static WidgetBuilder _qrCodeScannerRoute() {
    return (BuildContext context) => const QRCodeScannerPage();
  }

  ///
  static WidgetBuilder _authRoute() {
    return (BuildContext context) => AuthScreen();
  }
}
