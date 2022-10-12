import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/app.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart'
    as di;
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/widgets/auth.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/common/widgets/button_next_action.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/widgets/home.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('app integration test with live data', () {
    setUpAll(() async {
      await di.init();
    });

    testWidgets(
      'initial state, splash screen and after n seconds navigate to home',
      (widgetTester) async {
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();
        expect(find.byType(SvgPicture), findsOneWidget);

        await widgetTester.pumpAndSettle(CustomDimensions.splashDuration);
        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        await widgetTester.pumpAndSettle();
      },
    );

    testWidgets(
      'home screen test',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();

        AppState state = widgetTester.state(find.byType(App));

        NavigatorState navigatorState = state.navigatorKey.currentState!;
        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pumpAndSettle();

        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        expect(find.byKey(const ValueKey('identifier')), findsOneWidget);

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        await widgetTester.pumpAndSettle();

        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        await widgetTester.pumpAndSettle();
      },
    );

    testWidgets(
      'identifier and authentication',
      (WidgetTester widgetTester) async {
        final key = GlobalKey<NavigatorState>();
        await widgetTester.pumpWidget(
          MaterialApp(
            navigatorKey: key,
            initialRoute: Routes.homePath,
            routes: {
              Routes.homePath: (BuildContext context) => HomeScreen(),
              Routes.authPath: (BuildContext context) => AuthScreen(),
              Routes.qrCodeScannerPath: (BuildContext context) => Container(),
            },
          ),
        );
        await widgetTester.pump();
        await widgetTester.pumpAndSettle();

        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        expect(find.byKey(const ValueKey('identifier')), findsOneWidget);

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(ButtonNextAction));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.authDescription), findsOneWidget);

        await widgetTester.pump();

        await widgetTester.pumpAndSettle();

        String iden3Message = await _getIden3MessageFromJsonFile();

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();

        key.currentState?.pop(iden3Message);

        await widgetTester.pumpAndSettle();

        await widgetTester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.text('Authenticated successfully'), findsOneWidget);
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
