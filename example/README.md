# PolygonID Flutter SDK Example App

Demonstrates how to use the polygonid_flutter_sdk plugin.

**Contents**
1. [Setup](#setup)
2. [Examples](#examples)
   - [SDK initialization](#polygonid-sdk-initialization)
   - [Configuration](#configuration)
   - [Identity](#identity)
   - [Authentication](#authentication)
   - [Credential](#credential)
## Setup

### Install
1. Clone the `polygonid-flutter-sdk` repository.
2. Run `flutter pub get` from example directory.
3. Configure the environment per the instructions below.
4. Run `build_runner` to generate `.g.dart` files:
```bash
dart run build_runner build --delete-conflicting-outputs
```
5. After the previous steps, build and run the project.

## Examples

### PolygonId SDK initialization
Before you can start using the SDK, you need to initialise it and set the environment, otherwise a `PolygonIsSdkNotInitializedException` exception will be thrown.

See [the SDK environment](../README.md#environment) for more information.

### Configuration

In this example app we are using environment variable and Envied package to initialize the SDK. You can configure the application with the following [environment variables]:

- **`ENV_POLYGON_MAINNET`**: We use this to setup the sdk environment.<br/>
  Default: `{"ipfsUrl":"https://[YOUR-IPFS-API-KEY]:[YOUR-IPFS-API-KEY-SECRET]@ipfs.infura.io:5001","pushUrl":"https://push-staging.polygonid.com/api/v1","chainConfigs":{"137":{"rpcUrl":"https://polygon-mainnet.infura.io/v3/YOUR_WEB3_API_KEY","stateContractAddr":"0x624ce98D2d27b20b8f8d521723Df8fC4db71D79D"},"80001":{"rpcUrl":"https://polygon-mumbai.infura.io/v3/YOUR_WEB3_API_KEY","stateContractAddr":"0x134B1BE34911E39A8397ec6289782989729807a4"},"80002":{"rpcUrl":"https://polygon-amoy.infura.io/v3/YOUR_WEB3_API_KEY","stateContractAddr":"0x1a4cC30f2aA0377b0c3bc9848766D90cb4404124"}},"didMethods":[],"stacktraceEncryptionKey":"ENCRYPTION_KEY"}`

To be able to run the app, you will need to create a `.env` file in the root of the project and read configurations from there. You can copy the sample environment config (env.sample) as a starting point (replace with your own values).
```bash
make config
```

Once the `.env` file is created and successfully configured, run `build_runner` to generate the `env.g.dart` file:
```bash
dart run build_runner build --delete-conflicting-outputs
```

See [the SDK Usage](../README.md#usage) for more information.

### Identity
#### Add identity
If not yet created, add an identity via `identity.addIdentity();`
```dart
Future<void> addIdentity() async {
  PrivateIdentityEntity identity = await PolygonIdSdk.I.identity.addIdentity(
     secret: secretKey,
  );
}
```
- `secret` param in the `addIdentity()` is optional, if not passed there will be one generated randomly.
- it is recommended to securely save the `privateKey` generated with `addIdentity()`, this will often be used within the sdk methods as a security system, you can find the `privateKey` in the `PrivateIdentityEntity` object.

#### Get identifier
Get the DID identifier from previously created identity via `identity.getDidIdentifier();` by passing as param the `privateKey`, `blockchain` and `network`.
```dart
Future<void> getDidIdentifier() async {
  String privateKey = privateIdentityEntity.privateKey;
  String didIdentifier = await PolygonIdSdk.I.identity.getDidIdentifier(
     privateKey: privateKey,
     blockchain: blockchain,
     network: network,
  );
}
```

#### Remove identity
To remove an `identity` call `identity.removeIdentity()`, the `privateKey` and the `genesisDid` of the `identity` you want to remove are needed.
```dart
Future<void> removeIdentity({
  required String privateKey,
  required String genesisDid,
}) async {
   await PolygonIdSdk.I.identity.removeIdentity(
      privateKey: privateKey,
      genesisDid: genesisDid,
   );
}
```
- `genesisDid` is the unique id of the identity which profileNonce is 0.

#### Sign a message
To sign a message with your `privateKey` call `identity.sign()`, with the `message` and `privateKey`. (The `message` String must be an Hex or a Int otherwise an Exception will be thrown)
A `signature` containing a `BigInt` is returned as a String.
```dart
Future<void> sign({
  required String privateKey,
  required String message,
}) async {
  String signature = await PolygonIdSdk.I.identity.sign(
    privateKey: privateKey,
    message: message,
  );
}
```

#### Backup identity
To backup an identity call `identity.backupIdentity()`, with the `privateKey` and `genesisDid`.
An encrypted Identity's Databases is returned.
```dart
Future<String> backupIdentity({
  required String genesisDid,
  required String privateKey,
}){
  return PolygonIdSdk.I.identity.backupIdentity(
    genesisDid: genesisDid,
    privateKey: privateKey,
  );
}
```

#### Restore identity
To restore an identity call `identity.restoreIdentity()`, with the `privateKey`, `genesisDid` and the `encryptedDb`.
```dart
Future<void> restoreIdentity({
  required String genesisDid,
  required String privateKey,
  String? encryptedDb,
}) async {
  await PolygonIdSdk.I.identity.restoreIdentity(
    genesisDid: genesisDid,
    privateKey: privateKey,
    encryptedDb: encryptedDb,
  );
}
```

#### Check identity validity
To check if an identity is valid call `identity.checkIdentityValidity()`, with the `secret`.
if the identity is valid, the method will complete successfully, otherwise an Exception will be thrown.
```dart
Future<void> checkIdentityValidity({
  required String secret,
}) async {
  return PolygonIdSdk.I.identity.checkIdentityValidity(
    secret: secret,
  );
}
```

### Authentication
After the identity has been created, it can be used to perform an authentication.

#### Iden3Message
Communication between the various actors takes place through `iden3message` object, provided for example by a QR Code, in order to facilitate the translation from `String` to `Iden3message`, it is possible to use this method of the SDK `iden3comm.getIden3Message()`, providing the `String` message as param.
```dart
Iden3MessageEntity getIden3MessageFromString(String message){
  return PolygonIdSdk.I.iden3comm.getIden3Message(message: message);
}
```

#### Authenticate
In order to authenticate, you will need to pass the following parameters, `iden3message` related to the authentication request, the `genesisDid`, the `profileNonce` (optional), the `privateKey`, and the `pushToken` (optional).'
```dart
Future<void> authenticate({
  required Iden3MessageEntity iden3message,
  required String genesisDid,
  BigInt? profileNonce,
  required String privateKey,
  String? pushToken
}) async {
  await PolygonIdSdk.I.iden3comm.authenticate(
    iden3message: iden3message,
    genesisDid: genesisDid,
    profileNonce: profileNonce,
    privateKey: privateKey,
    pushToken: pushToken,
  );
}
```

### Credential
The credential consists of **claims**, to retrieve them from an **Issuer** and save them in the **wallet** is possible to use `iden3comm.fetchAndSaveClaims()` method, these **claims** will later be used to **prove** one's **Identity** in a **Verifier**. Saved **claims** can be `updated` or `removed` later.

#### Fetch and Save Claims
From the **iden3message** obtained from **Issuer**, you can pass it as `OfferIden3MessageEntity` to the `fetchAndSaveClaims` method along with the `did` and `privateKey`.
```dart
Future<void> fetchAndSaveClaims({
  required OfferIden3MessageEntity message,
  required String did,
  required String privateKey,
}) async {
  await PolygonIdSdk.I.iden3comm.fetchAndSaveClaims(
    message: message,
    did: did,
    privateKey: privateKey,
  );
}

```

#### Get Claims
It is possible to retrieve **claims** saved on the sdk through the use of the `credential.getClaims()`, with `filters` as optional param, `genesisDid` and `privateKey` are mandatory fields.
```dart
Future<void> getClaims({
  List<FilterEntity>? filters,
  required String genesisDid,
  required String privateKey,
}) async {
  List<ClaimEntity> claimList = await PolygonIdSdk.I.claim.getClaims(
    filters: filters,
    genesisDid: genesisDid,
    privateKey: privateKey,
  );
}
```

#### Get Claims by id
If you want to obtain specific **claims** by knowing the **ids**, you can use the sdk method `credential.getClaimsByIds()`, passing the desired `ids`, `genesisDid` and `privateKey` as parameters.
```dart
Future<void> getClaimsByIds({
  required List<String> claimIds,
  required String genesisDid,
  required String privateKey,
}) async {
  List<ClaimEntity> claimList = await PolygonIdSdk.I.credential.getClaimsByIds(
    claimIds: claimIds,
    genesisDid: genesisDid,
    privateKey: privateKey,
  );
}
```

#### Remove single Claim
To **remove** a **claim**, simply call the `credential.removeClaim()` with the `id` of the **claim** you want to remove, you must also pass the `genesisDid` and `privateKey`.
```dart
Future<void> removeClaim({
  required String claimId,
  required String genesisDid,
  required String privateKey,
}) async {
  await PolygonIdSdk.I.credential.removeClaim(
    claimId: claimId,
    genesisDid: genesisDid,
    privateKey: privateKey,
  );
}
```

#### Remove multiple Claims
If you want to **remove** a series of **claims**, you have to pass a list of `ids` and call  `credential.removeClaims()`.
```dart
Future<void> removeClaims({
  required List<String> claimIds,
  required String genesisDid,
  required String privateKey,
}) async {
  await PolygonIdSdk.I.credential.removeClaims(
    claimIds: claimIds,
    genesisDid: genesisDid,
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
```dart
Future<void> updateClaim({
  required String claimId,
  required String genesisDid,
  required String privateKey,
  String? issuer,
  ClaimState? state,
  String? expiration,
  String? type,
  Map<String, dynamic>? data,
}) async {
  await PolygonIdSdk.I.credential.updateClaim(
    claimId: claimId,
    genesisDid: genesisDid,
    privateKey: privateKey,
    issuer: issuer,
    state: state,
    expiration: expiration,
    type: type,
    data: data,
  );
}
```
