import 'package:flutter/widgets.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/widgets/claim_detail.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
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
  static const String claimDetailPath = "/claim_detail";

  ///
  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      initialPath: _splashRoute(),
      splashPath: _splashRoute(),
      homePath: _homeRoute(),
      qrCodeScannerPath: _qrCodeScannerRoute(),
      authPath: _authRoute(),
      claimsPath: _claimsRoute(),
      claimDetailPath: _claimDetailPath(),
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

  ///
  static WidgetBuilder _claimDetailPath() {
    return (BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as ClaimModel;
      return ClaimDetailScreen(claimModel: args);
    };
  }
}
