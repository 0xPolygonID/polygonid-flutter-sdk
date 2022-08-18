# PolygonID Flutter SDK Example App

Demonstrates how to use the polygonid_flutter_sdk plugin.

**Contents**
1. [Setup](#setup)
2. [Examples](#examples)
   - [Identity](#identity)

## Setup

### Install
1. Clone the `polygonid-flutter-sdk` repository.
2. Run `flutter pub get` from example directory.
3. After the previous steps, build and run the project.

## Examples

### Identity
#### Overview
1. Initialize PoligonID sdk inside dependency injection initializer with `await PolygonIdSdk.init();`
2. Checks the existence of a previously created identifier via `identity.getCurrentIdentifier();`
3. If not yet created, create an identity via `identity.createIdentity(privateKey: privateKey);`
   - `privateKey` if not passed there will be one generated randomly.
4. The SDK will take care of keeping the `identifier` safetely saved.