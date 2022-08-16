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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/iden3/polygonid-flutter-sdk/issues

## Usage

To start using this package first import it in your Dart file.

```dart
import 'package:polygonid_flutter_sdk/polygonid_sdk.dart';
```

