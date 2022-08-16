import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygonid_flutter_sdk_example/src/dependency_injection/dependencies_provider.dart' as di;
import 'package:polygonid_flutter_sdk_example/src/presentation/app.dart';

Future<void> main() async {
  //Dependency Injection initialization
  await di.init();

  //
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}

/*class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    var sdk = PolygonIdSdk.I;

    sdk.identity.createIdentity(privateKey: "thePrivateKeyy").then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('$_platformVersion\n'),
        ),
      ),
    );
  }
}*/
