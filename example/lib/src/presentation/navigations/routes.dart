import 'package:flutter/widgets.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/backup_identity/widgets/backup_identity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/check_identity_validity/widgets/check_identity_validity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/widgets/claim_detail.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/widgets/claims.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/widgets/auth.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/widgets/home.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/qrcode_scanner/widgets/qrcode_scanner.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/restore_identity/widgets/restore_identity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/widgets/sign.dart';
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
  static const String signMessagePath = "/sign_message";
  static const String checkIdentityValidityPath = "/check_identity_validity";
  static const String backupIdentityPath = "/backup_identity";
  static const String restoreIdentityPath = "/restore_identity";

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
      signMessagePath: _signMessageRoute(),
      checkIdentityValidityPath: _checkIdentityValidityRoute(),
      backupIdentityPath: _backupIdentityRoute(),
      restoreIdentityPath: _restoreIdentityRoute(),
    };
  }

  ///
  static WidgetBuilder _splashRoute() {
    return (BuildContext context) => const SplashScreen();
  }

  ///
  static WidgetBuilder _homeRoute() {
    return (BuildContext context) => const HomeScreen();
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

  ///
  static WidgetBuilder _signMessageRoute() {
    return (BuildContext context) => SignWidget();
  }

  ///
  static WidgetBuilder _checkIdentityValidityRoute() {
    return (BuildContext context) => const CheckIdentityValidityScreen();
  }

  ///
  static WidgetBuilder _backupIdentityRoute() {
    return (BuildContext context) => const BackupIdentityScreen();
  }

  ///
  static WidgetBuilder _restoreIdentityRoute() {
    return (BuildContext context) => const RestoreIdentityScreen();
  }
}
