# PolygonID Flutter SDK Example App

Demonstrates how to use the polygonid_flutter_sdk plugin.

**Contents**
1. [Setup](#setup)
2. [Examples](#examples)
   - [SDK initialization](#polygonid-sdk-initialization)
   - [Identity](#identity)
   - [Authentication](#authentication)

## Setup

### Install
1. Clone the `polygonid-flutter-sdk` repository.
2. Run `flutter pub get` from example directory.
3. After the previous steps, build and run the project.

## Examples

### PolygonId SDK initialization
Before you can start using the SDK, you need to initialise it, otherwise a `PolygonIsSdkNotInitializedException` exception will be thrown.  
For convenience you can initialise it in the main class like that:
```
import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

Future<void> main() async {
  await PolygonIdSdk.init();
  runApp(const App());
}
```

### Identity
#### Create identity
If not yet created, create an identity via `identity.createIdentity();`
```
Future<void> createIdentity() async {
  //we get the sdk instance previously initialized
  final sdk = PolygonIdSdk.I;
  PrivateIdentityEntity identity = await sdk.identity.createIdentity(secret: secretKey);
}
```
- `secret` param in the `createIdentity()` is optional, if not passed there will be one generated randomly.
- it is recommended to securely save the `privateKey` generated with `createIdentity()`, this will often be used within the sdk methods as a security system, you can find the `privateKey` in the `PrivateIdentityEntity` object.

#### Get identifier
Get the identifier from previously created identity via `identity.getIdentifier();` by passing as param the `privateKey`.
```
Future<void> getIdentifier() async {
  String privateKey = privateIdentityEntity.privateKey;
  String identifier = await sdk.identity.getIdentifier(privateKey: privateKey);
}
```

#### Remove identity
To remove an `identity` call `identity.removeIdentity()`, the `privateKey` and the `identifier` of the `identity` you want to remove are needed.
```
Future<void> removeIdentity({
  required String privateKey,
  required String identifier,
}) async {
  await sdk.identity.removeIdentity(
    privateKey: privateKey,
    identifier: identifier,
  );

```

### Authentication
After the identity has been created, it can be used to perform an authentication.

#### Iden3Message
Communication between the various actors takes place through `iden3message` object, provided for example by a QR Code, in order to facilitate the translation from `String` to `Iden3message`, it is possible to use this method of the SDK `iden3comm.getIden3Message()`, providing the `String` message as param.
```
Iden3MessageEntity getIden3MessageFromString(String message){
  return sdk.iden3comm.getIden3Message(message: message);
}
```

#### Authenticate
In order to authenticate, you will need to pass the following parameters, `iden3message` related to the authentication request, the `identifier` and the `privateKey`
```
Future<void> authenticate({
  required Iden3MessageEntity iden3message,
  required String identifier,
  required String privateKey,
}) async {
  await sdk.iden3comm.authenticate(
    iden3message: iden3message,
    identifier: identifier,
    privateKey: privateKey,
  );
}
```