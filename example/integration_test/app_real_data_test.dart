import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
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
import 'package:uuid/uuid.dart';

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
              Routes.splashPath: (BuildContext context) => const SplashScreen(),
              Routes.homePath: (BuildContext context) => const HomeScreen(),
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
        expect(find.byKey(CustomWidgetsKeys.signWidget), findsNothing);
        await widgetTester.pumpAndSettle();

        // after tap on "create identity" button,
        // we expect to find identifier
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonCreateIdentity));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);
        expect(find.byKey(CustomWidgetsKeys.signWidget), findsOneWidget);

        // we expect to be able to remove the identity
        // so we expect to find the remove button
        expect(find.byKey(CustomWidgetsKeys.homeScreenButtonRemoveIdentity),
            findsOneWidget);

        // after tap on "remove identity" button,
        // we expect not to find identifier
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonRemoveIdentity));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsOneWidget);
        expect(find.byKey(CustomWidgetsKeys.signWidget), findsNothing);

        // after tap on "create identity" button,
        // we expect to find identifier again
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonCreateIdentity));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);
        expect(find.byKey(CustomWidgetsKeys.signWidget), findsOneWidget);

        //  then by clicking on the "next action" button,
        //  we expect to navigate to authentication page
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.homeScreenButtonNextAction));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text(CustomStrings.authDescription), findsOneWidget);
        await widgetTester.pumpAndSettle();

        // we simulate the qrCode scanning, we cannot mock it because
        // it change everytime and also it expire
        String iden3Message = await _getAuthenticationIden3MessageFromApi();
        await widgetTester
            .tap(find.byKey(CustomWidgetsKeys.authScreenButtonConnect));
        await widgetTester.pumpAndSettle();

        key.currentState?.pop(iden3Message);
        await widgetTester.pumpAndSettle();

        // with the iden3message scanned
        // we expect to authenticate succesfully
        await widgetTester.pumpAndSettle(const Duration(seconds: 3));
        expect(find.text(CustomStrings.authSuccess), findsOneWidget);
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
Future<String> _getAuthenticationIden3MessageFromApi() async {
  Uuid uuid = const Uuid();
  String randomUuid = uuid.v1();
  Uri uri = Uri.parse("https://api-staging.polygonid.com/v1/zk-sign-in");
  String params = jsonEncode({"loginId": randomUuid});
  http.Response response = await http.post(
    uri,
    headers: {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: params,
  );
  return response.body;
}
