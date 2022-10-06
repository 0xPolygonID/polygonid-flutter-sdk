import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/app.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart'
    as di;
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

import 'app_test.mocks.dart';

const String identifier = "retrievedIdentifier";
const String qrCodeScanResponse = "qrCodeScanResponse";

@GenerateMocks([
  IdentityRepository,
  PolygonIdSdk,
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late MockIdentityRepository identityRepository;
  late MockPolygonIdSdk polygonIdSdk;

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
  });

  /// APP INTEGRATION TEST WITH MOCK DATA
  ///
  group('app integration test with mocked data', () {
    setUpAll(() async {
      await di.init();
      identityRepository = MockIdentityRepository();
      polygonIdSdk = MockPolygonIdSdk();

      await di.getIt.unregister<PolygonIdSdk>();
      await di.getIt.unregister<IdentityRepository>();
      di.getIt.registerLazySingleton<PolygonIdSdk>(() => polygonIdSdk);
      di.getIt
          .registerLazySingleton<IdentityRepository>(() => identityRepository);
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
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();

        AppState state = widgetTester.state(find.byType(App));
        NavigatorState navigatorState = state.navigatorKey.currentState!;
        navigatorState.pushReplacementNamed(Routes.authPath);

        await widgetTester.pump();
        await widgetTester.pumpAndSettle();
        expect(find.text(CustomStrings.authDescription), findsOneWidget);

        await widgetTester.pump();

        when(polygonIdSdk.identity.getCurrentIdentifier())
            .thenAnswer((realInvocation) => Future.value(null));

        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle();
        navigatorState.pop(null);
        await widgetTester.pumpAndSettle();

        expect(find.text('no qr code scanned'), findsOneWidget);

        await widgetTester.pumpAndSettle();
      },
    );
  });
}
