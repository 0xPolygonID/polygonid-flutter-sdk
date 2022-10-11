# PolygonID Flutter SDK Example App

Demonstrates how to use the polygonid_flutter_sdk plugin.

**Contents**
1. [Setup](#setup)
2. [Examples](#examples)
   - [Identity](#identity)
   - [Authentication](#authentication)
3. [Integration test](#integration-test)

## Setup

### Install
1. Clone the `polygonid-flutter-sdk` repository.
2. Run `flutter pub get` from example directory.
3. After the previous steps, build and run the project.

## Examples

### Identity
#### Overview
1. Initialize PoligonID sdk with `await PolygonIdSdk.init();`
2. Checks the existence of a previously created identifier via `identity.getCurrentIdentifier();`
3. If not yet created, create an identity via `identity.createIdentity(privateKey: privateKey);`
   - `privateKey` if not passed there will be one generated randomly.
4. The SDK will take care of keeping the `identifier` safetely saved.

### Authentication
#### Overview
1. Retrieve the previously created identifier via `identity.getCurrentIdentifier();`
2. Through an external service provide the authentication iden3Message String.
3. Authenticate using `iden3comm.authenticate(issuerMessage: issuerMessage, identifier: identifier);`

## Integration Test
For security reasons, to run integration tests with real data, the json file `app_test_data.json` in the `integration_test/data/` directory must be updated each time.