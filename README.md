# polygonid_flutter_sdk

[![pub package](https://img.shields.io/badge/pub-2.1.1-orange)](https://pub.dev/packages/polygonid_flutter_sdk)
[![build](https://github.com/iden3/polygonid-flutter-sdk/workflows/polygonid_flutter_sdk/badge.svg)](https://github.com/iden3/polygonid-flutter-sdk/actions?query=workflow%3Apolygonid_flutter_sdk)
[![codecov](https://codecov.io/gh/iden3/polygonid-flutter-sdk/branch/develop/graph/badge.svg?token=0SI0XWGXKL)](https://codecov.io/gh/iden3/polygonid-flutter-sdk)
[![license](https://img.shields.io/badge/License-agpl-blue.svg)](https://github.com/iden3/polygonid-flutter-sdk/blob/master/LICENSE)

## Description

This is a flutter Plugin for PolygonID Mobile SDK (https://polygon.technology/polygon-id) This plugin provides a cross-platform tool (iOS, Android) to communicate with the PolygonID platform.

## Installation

To use this plugin, add `polygonid_flutter_sdk` as a [dependency](https://flutter.io/using-packages/) in your `pubspec.yaml` file like this

```yaml
dependencies:
  polygonid_flutter_sdk: ^x.y.z
```
This will get you the latest version.

If you want to test a specific branch of the repository, pull `polygonid_flutter_sdk` like this

```yaml
dependencies:
  polygonid_flutter_sdk:
      git:
        url: ssh://git@github.com/iden3/polygonid-flutter-sdk.git
        ref: branchPathName
```

# Environment
### App side
You need to set the environment you are working on in the SDK.

You can either set the environment during initialization (with `env` parameter) or later with [PolygonIdSdk.setEnv()](lib/sdk/polygon_id_sdk.dart#L62).

The environment object is [EnvEntity](lib/common/domain/entities/env_entity.dart) with:
```
  final String blockchain; # The name of the blockchain (eg: polygon)
  final String network; # The network of the blockchain (eg: mumbai)
  final String web3Url; # URL of the blockchain (eg: https://polygon-mumbai.infura.io/v3/)
  final String web3RdpUrl; # RDP URL (eg: wss://polygon-mumbai.infura.io/v3/)
  final String web3ApiKey; # The API key of the web3 URL service (eg: a536514602ea4e22a2e9007b6e9dbc63)
  final String idStateContract; # The ID state contract (eg: 0x453A1BC32122E39A8398ec6288783389730807a5)
  final String pushUrl; # The push notification URL (eg: https://push.service.io/api/v1)
```

An example of initialization:
```dart
import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

Future<void> main() async {
  await PolygonIdSdk.init(env: EnvEntity(
      blockchain: 'polygon',
      network: 'mumbai',
      web3Url: 'https://polygon-mumbai.infura.io/v3/'
      web3RdpUrl: 'wss://polygon-mumbai.infura.io/v3/'
      web3ApiKey: 'a536514602ea4e22a2e9007b6e9dbc63'
      idStateContract: '0x453A1BC32122E39A8398ec6288783389730807a5'
      pushUrl: 'https://push.service.io/api/v1',
  ));
  runApp(const App());
}
```

You can get the current env using [PolygonIdSdk.getEnv()](lib/sdk/polygon_id_sdk.dart#L66).



# Deploy and check
### Deploy
1. Clone this repository.
2. run `build_runner` to generate `.g.dart` files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/iden3/polygonid-flutter-sdk/issues

## Usage

To start using this package first import it in your Dart file.

```dart
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
```

## Notes

P.S. Using iOS simulator for testing wallet sdk is right now under maintenance and will be available soon.

