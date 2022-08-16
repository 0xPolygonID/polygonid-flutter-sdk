import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:polygonid_flutter_sdk_example/src/dependency_injection/dependencies_provider.dart' as di;
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/app.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_dimensions.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

import 'app_test.mocks.dart';

const String identifier = "retrievedIdentifier";

@GenerateMocks([IdentityRepository])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late MockIdentityRepository identityRepository;

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
        //app.main();
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

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder), findsNothing);

        await widgetTester.pumpAndSettle();

        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder), findsNothing);

        await widgetTester.pumpAndSettle();
      },
    );
  });

  group('app integration test with mocked data', () {
    setUpAll(() async {
      await di.init();
      identityRepository = MockIdentityRepository();
      await di.getIt.unregister<IdentityRepository>();
      di.getIt.registerLazySingleton<IdentityRepository>(() => identityRepository);
    });

    testWidgets(
      'initial state, splash screen and after n seconds navigate to home',
      (widgetTester) async {
        when(identityRepository.getCurrentIdentifier(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.value(null));
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
        //app.main();
        await widgetTester.pumpWidget(const App());
        await widgetTester.pumpAndSettle();

        AppState state = widgetTester.state(find.byType(App));

        NavigatorState navigatorState = state.navigatorKey.currentState!;
        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pump();
        when(identityRepository.getCurrentIdentifier(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.value(null));
        await widgetTester.pumpAndSettle();

        expect(find.text(CustomStrings.homeDescription), findsOneWidget);
        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder), findsOneWidget);
        expect(find.byKey(const ValueKey('identifier')), findsOneWidget);

        await widgetTester.pump();
        when(identityRepository.createIdentity(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.value(identifier));
        await widgetTester.tap(find.byType(ElevatedButton));
        await widgetTester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder), findsNothing);

        await widgetTester.pumpAndSettle();

        await widgetTester.pump();
        when(identityRepository.getCurrentIdentifier(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.value(identifier));
        await widgetTester.pump();
        navigatorState.pushReplacementNamed(Routes.homePath);

        await widgetTester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.text(CustomStrings.homeIdentifierSectionPlaceHolder), findsNothing);

        await widgetTester.pumpAndSettle();
      },
    );
  });
}
