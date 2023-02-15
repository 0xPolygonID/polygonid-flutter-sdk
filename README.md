# polygonid_flutter_sdk

[![pub package](https://img.shields.io/badge/pub-1.0.0-orange)](https://pub.dev/packages/polygonid_flutter_sdk)
[![build](https://github.com/iden3/polygonid-flutter-sdk/workflows/polygonid_flutter_sdk/badge.svg)](https://github.com/iden3/polygonid-flutter-sdk/actions?query=workflow%3Apolygonid_flutter_sdk)
[![license](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/iden3/polygonid-flutter-sdk/blob/master/LICENSE)

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

# Env variables

### Required:
**NETWORK_NAME** - Blockchain name. <br />
**NETWORK_ENV** - Network name. <br />
**INFURA_URL** - Infura base url. <br />
**INFURA_RDP_URL** - Infura base rdp url. <br />
**INFURA_API_KEY** - Infura api key. <br />
**ID_STATE_CONTRACT_ADDR** - Identity state smart contract address. <br />

### Not required:

**PUSH_URL** - Polygon push gateway server base url. <br />

# Deploy and check
### Deploy
1. Clone this repository.
2. Generate `.env` and `.env.dev` files in the root folder of the project.
3. Add required env variables (example):
   ```bash
    NETWORK_NAME="polygon"
    NETWORK_ENV="mumbai"
    INFURA_URL="https://polygon-mumbai.infura.io/v3/"
    INFURA_RDP_URL="wss://polygon-mumbai.infura.io/v3/"
    INFURA_API_KEY="secret"
    ID_STATE_CONTRACT_ADDR="sc_address"
    PUSH_URL="push_url"
   ```
4. run `build_runner` to generate `.g.dart` files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/iden3/polygonid-flutter-sdk/issues

## Usage

To start using this package first import it in your Dart file.

```dart
import 'package:polygonid_flutter_sdk/polygonid_sdk.dart';
```

