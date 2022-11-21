import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/app.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart'
    as di;
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/widgets/auth.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

//import 'app_test.mocks.dart';

const String identifier = "retrievedIdentifier";
const String invalidQrCodeScanResponse = "invalidQrCodeScanResponse";
const String validQrCodeScanResponse =
    '{"id":"193546d2-db06-4c49-8e92-686dd5c92b23",'
    '"typ":"application/iden3comm-plain-json",'
    '"type":"https://iden3-communication.io/authorization/1.0/request",'
    '"thid":"193546d2-db06-4c49-8e92-686dd5c92b23",'
    '"body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=148757","reason":"test flow","scope":[]},'
    '"from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"}';

@GenerateMocks([])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  /// APP INTEGRATION TEST WITH MOCK DATA
  ///
  /*group('app integration test with mocked data', () {
    setUpAll(() async {
      await di.init();
    });

    /// SPLASH PAGE
    testWidgets(
      'initial state, splash screen and after n seconds navigate to home',
      (widgetTester) async {
        when(identityRepository.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(null));
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();
        expect(find.byType(SvgPicture), findsOneWidget);

        await widgetTester.pumpAndSettle(CustomDimensions.splashDuration);
        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        await widgetTester.pumpAndSettle();
      },
    );

    /// HOME PAGE
    testWidgets(
      'home screen test',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();

        AppState state = widgetTester.state(find.byType(App));

        NavigatorState navigatorState = state.navigatorKey.currentState!;
        navigatorState.pushReplacementNamed(Routes.homePath);

        // 1. getCurrentIdentifier() with identity not created yet case
        await widgetTester.pump();
        when(identityRepository.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(null));
        await widgetTester.pumpAndSettle();

        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsOneWidget);
        expect(find.byKey(const ValueKey('identifier')), findsOneWidget);

        // 2. exception while calling createIdentity()
        await widgetTester.pump();
        when(identityRepository.createIdentity()).thenAnswer(
            (realInvocation) => Future.error(IdentityException('error')));
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('error'), findsOneWidget);

        // 3. createIdentity() positive case
        await widgetTester.pump();
        when(identityRepository.createIdentity())
            .thenAnswer((realInvocation) => Future.value(identifier));
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        await widgetTester.pumpAndSettle();

        // 4. getCurrentIdentifier() positive case
        await widgetTester.pump();
        when(identityRepository.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(identifier));
        await widgetTester.pump();
        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder),
            findsNothing);

        await widgetTester.pumpAndSettle();
      },
    );

    /// AUTHENTICATION PAGE
    testWidgets(
      'authentication screen test',
      (WidgetTester widgetTester) async {
        final key = GlobalKey<NavigatorState>();
        await widgetTester.pumpWidget(
          MaterialApp(
            navigatorKey: key,
            initialRoute: Routes.authPath,
            routes: {
              Routes.authPath: (BuildContext context) => AuthScreen(),
              Routes.qrCodeScannerPath: (BuildContext context) => Container(),
            },
          ),
        );

        await widgetTester.pump();
        await widgetTester.pumpAndSettle();
        expect(find.text(CustomStrings.authDescription), findsOneWidget);

        await widgetTester.pump();

        await widgetTester.pumpAndSettle();

        // Tap to scan code and then return null from scanning page
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();

        key.currentState?.pop(null);
        await widgetTester.pumpAndSettle();

        expect(find.text('no qr code scanned'), findsOneWidget);

        //Tap to scan and then return an invalid qrCode
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();

        key.currentState?.pop(invalidQrCodeScanResponse);
        await widgetTester.pumpAndSettle();

        expect(find.text('Scanned code is not valid'), findsOneWidget);

        //Tap to scan and then return a valid qrCode but identity not yet created
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();

        when(identityRepository.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(null));

        key.currentState?.pop(validQrCodeScanResponse);
        await widgetTester.pumpAndSettle();

        expect(find.text('an identity is needed before trying to authenticate'),
            findsOneWidget);

        //Tap to scan and then return a valid qrCode
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();

        when(identityRepository.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(identifier));

        when(iden3commRepository.authenticate(
                issuerMessage: anyNamed('issuerMessage'),
                identifier: anyNamed('identifier')))
            .thenAnswer((realInvocation) => Future.value());

        key.currentState?.pop(validQrCodeScanResponse);
        await widgetTester.pumpAndSettle();

        expect(find.text('Authenticated successfully'), findsOneWidget);

        await widgetTester.pumpAndSettle();
      },
    );
  });*/
}
