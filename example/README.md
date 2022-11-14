# PolygonID Flutter SDK Example App

Demonstrates how to use the polygonid_flutter_sdk plugin.

**Contents**
1. [Setup](#setup)
2. [Examples](#examples)
   - [SDK initialization](#polygonid-sdk-initialization)
   - [Identity](#identity)
   - [Authentication](#authentication)
   - [Credential](#credential)
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

### Credential
The credential consists of **claims**, to retrieve them from an **Issuer** and save them in the **wallet** is possible to use `iden3comm.fetchAndSaveClaims()` method, these **claims** will later be used to **prove** one's **Identity** in a **Verifier**. Saved **claims** can be `updated` or `removed` later.

#### Fetch and Save Claims
From the **iden3message** obtained from **Issuer**, you can build a `CredentialRequestEntity` object, composed by `identifier`, `url` for the **callback**, `credential id`, **iden3message**'s `thid` and `from` field, then for fetch and save claim you'll need a `CredentialRequestEntity` list, the `identifier` and `privateKey`.
```
Future<void> fetchAndSaveClaims({
  required Iden3MessageEntity iden3message,
  required String identifier,
  required String privateKey,
}) async {
  Map<String, dynamic>? messageBody = iden3message.body;

  // url for the callback
  final String callbackUrl = messageBody['url'];
  // credentials
  List<dynamic> credentials = messageBody['credentials'];
  List<CredentialRequestEntity> credentialRequestEntityList =
      credentials.map((credential) {
    String credentialId = credential['id'];
    return CredentialRequestEntity(
      identifier,
      callbackUrl,
      credentialId,
      iden3message.thid,
      iden3message.from,
    );
  }).toList();
  
  await sdk.iden3comm.fetchAndSaveClaims(
    credentialRequests: credentialRequestEntityList,
    identifier: identifier,
    privateKey: privateKey,
  );
}

```

#### Get Claims
It is possible to retrieve **claims** saved on the sdk through the use of the `credential.getClaims()`, with `filters` as optional param, `identifier` and `privateKey` are mandatory fields.
```
Future<void> getAllClaims({
  List<FilterEntity>? filters,
  required String identifier,
  required String privateKey,
}) async {
  List<ClaimEntity> claimList = await sdk.claim.getAllClaims(
    filters: filters,
    identifier: identifier,
    privateKey: privateKey,
  );
}
```

#### Get Claims by id
If you want to obtain specific **claims** by knowing the **ids**, you can use the sdk method `credential.getClaimsByIds()`, passing the desired `ids`, `identifier` and `privateKey` as parameters.
```
Future<void> getClaimsByIds({
  required List<String> claimIds,
  required String identifier,
  required String privateKey,
}) async {
  List<ClaimEntity> claimList = await sdk.credential.getClaimsByIds(
    claimIds: claimIds,
    identifier: identifier,
    privateKey: privateKey,
  );
}
```

#### Remove single Claim
To **remove** a **claim**, simply call the `credential.removeClaim()` with the `id` of the **claim** you want to remove, you must also pass the `identifier` and `privateKey`.
```
Future<void> removeClaim({
  required String claimId,
  required String identifier,
  required String privateKey,
}) async {
  await sdk.credential.removeClaim(
    claimId: claimId,
    identifier: identifier,
    privateKey: privateKey,
  );
}
```

#### Remove multiple Claims
If you want to **remove** a series of **claims**, you have to pass a list of `ids` and call  `credential.removeClaims()`.
```
Future<void> removeClaims({
  required List<String> claimIds,
  required String identifier,
  required String privateKey,
}) async {
  await sdk.credential.removeClaims(
    claimIds: claimIds,
    identifier: identifier,
    privateKey: privateKey,
  );
}
```

#### Update Claim
It is also possible to **update** a **claim** through `credential.updateClaim()`.   
**Attention**: as stated in the documentation of this method, only the `info` field can be updated, in addition a validation is performed from the data layer:
> Update the Claim associated to the [id] in storage  
> Be aware only the [ClaimEntity.info] will be updated.  
> and [data] is subject to validation by the data layer
```
Future<void> updateClaim({
  required String claimId,
  required String identifier,
  required String privateKey,
  String? issuer,
  ClaimState? state,
  String? expiration,
  String? type,
  Map<String, dynamic>? data,
}) async {
  PolygonIdSdk sdk = PolygonIdSdk.I;
  await sdk.credential.updateClaim(
    id: claimId,
    identifier: identifier,
    privateKey: privateKey,
    issuer: issuer,
    state: state,
    expiration: expiration,
    type: type,
    data: data,
  );
}
```