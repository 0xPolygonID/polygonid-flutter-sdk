import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart'
    as di;
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/widgets/auth.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/widgets/claims.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/widgets/home.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/widgets/splash.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_widgets_keys.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('complete flow with live data', () {
    setUpAll(() async {
      await di.init();
    });
    testWidgets(
      'best case use case, create identity, get identifier, authenticate and then navigate to claims page',
      (WidgetTester widgetTester) async {
        final key = GlobalKey<NavigatorState>();
        await widgetTester.pumpWidget(
          MaterialApp(
            navigatorKey: key,
            initialRoute: Routes.splashPath,
            routes: {
              Routes.splashPath: (BuildContext context) => SplashScreen(),
              Routes.homePath: (BuildContext context) => HomeScreen(),
              Routes.authPath: (BuildContext context) => AuthScreen(),
              Routes.qrCodeScannerPath: (BuildContext context) => Container(),
              Routes.claimsPath: (BuildContext context) => ClaimsScreen(),
            },
          ),
        );
        await widgetTester.pump();
        await widgetTester.pumpAndSettle();

        // we start from the Splash screen
        expect(find.byType(SvgPicture), findsOneWidget);
        await widgetTester.pumpAndSettle(CustomDimensions.splashDuration);

        // after navigate to home, initially we expect not to find the identifier
        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        expect(find.byKey(const ValueKey('identifier')), findsOneWidget);
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsOneWidget);
        await widgetTester.pumpAndSettle();

        // after tap on "create identity" button,
        // we expect to find identifier
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonCreateIdentity));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        //  then by clicking on the "next action" button,
        //  we expect to navigate to authentication page
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonNextAction));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.authDescription), findsOneWidget);
        await widgetTester.pumpAndSettle();

        // we simulate the qrCode scanning, we cannot mock it because
        // it change everytime and also it expire
        String iden3Message = await _getIden3MessageFromJsonFile();
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.authScreenButtonConnect));
        await widgetTester.pumpAndSettle();
        key.currentState?.pop(iden3Message);
        await widgetTester.pumpAndSettle();

        // with the iden3message scanned
        // we expect to authenticate succesfully
        await widgetTester.pumpAndSettle(const Duration(seconds: 3));
        expect(find.text('Authenticated successfully'), findsOneWidget);
        await widgetTester.pumpAndSettle();

        // then, we navigate to the claims list screen
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.authScreenButtonNextAction));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.claimsDescription), findsOneWidget);
        expect(find.text(CustomStrings.claimsListNoResult), findsOneWidget);

        //end
        await widgetTester.pumpAndSettle();
      },
    );
  });
}

///
Future<String> _getIden3MessageFromJsonFile() async {
  String appTestData =
      await rootBundle.loadString('integration_test/data/app_test_data.json');
  Map<String, dynamic> json = jsonDecode(appTestData);
  Map<String, dynamic> iden3Message = json['authIden3Message'];
  return jsonEncode(iden3Message);
}
