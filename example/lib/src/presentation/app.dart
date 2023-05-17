import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/navigations/routes.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CustomStrings.appTitle,
      initialRoute: Routes.initialPath,
      routes: Routes.getRoutes(context),
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: CustomColors.primaryWhite,
        buttonTheme: const ButtonThemeData(
          buttonColor: CustomColors.primaryOrange,
          textTheme: ButtonTextTheme.accent,
        ),
      ),
    );
  }
}
