# Authentication with Polygon ID Flutter SDK

This document provides an explanation on how to authenticate with the Polygon ID Flutter SDK using the `authenticate` method.

## Preparatory steps

### 1. Install the Polygon ID Mobile SDK Plugin:
- Add the plugin as a dependency in your project's pubspec.yaml file:
   ```yaml
   dependencies:
     polygonid_flutter_sdk:
       git:
         url: ssh://git@github.com/0xPolygonID/polygonid-flutter-sdk.git
         ref: main
   ```

### 2. Prepare the EnvEntity object:
- To initialize the SDK, create an EnvEntity object with the following information:
  ```dart
  EnvEntity(
   blockchain: "polygon",
   network: "mumbai",
   web3Url: "https://polygon-mumbai.infura.io/v3/",
   web3RdpUrl: "wss://polygon-mumbai.infura.io/v3/",
   web3ApiKey: "YOUR_API_KEY"
   idStateContract: 0x134B1BE34911E39A8397ec6289782989729807a4),
  ```


### 3. Initialize the PolygonIdSdk:
- By calling `await PolygonIdSdk.init(env: envEntityCreatedPreviously);`, you can initialize the SDK and use it later by accessing `PolygonIdSdk.I` without the need to reinitialize every time.

### 4. Download the Circuits:
- On the first app launch (only once), perform the download of the necessary circuits for the SDK using `PolygonIdSdk.I.proof.initCircuitsDownloadAndGetInfoStream`.

### 5. Add an Identity:
- Use `await PolygonIdSdk.I.identity.addIdentity();` to add an identity and store the genesisDid DID (Decentralized Identifier) and private key, which will be required for the subsequent authentication step.

Remember to replace "YOUR_API_KEY" with your actual API key provided by Infura at https://app.infura.io/dashboard and activate "polygon add on". These steps will allow you to install the plugin, initialize the SDK, download the circuits, and add an identity to proceed with the authentication.

## Authentication

Authentication is a process that allows a user (or an identity) to prove their identity to an issuer or verifier, who needs to validate the user's claims about their identity.

To perform authentication, you will need to use the `authenticate` method of the Polygon ID Flutter SDK.

Here's the method:

```dart
Future<void> authenticate({
  required Iden3MessageEntity message,
  required String genesisDid,
  BigInt? profileNonce,
  required String privateKey,
  String? pushToken,
});
```
The method parameters are explained below:

- `message` (required) - The iden3comm message entity
- `genesisDid` (required) - The unique id of the identity
- `profileNonce` (optional) - The nonce of the profile used from identity to obtain the did identifier
- `privateKey` (required) - The key used to access all sensitive info from the identity and to perform operations such as generating proofs
- `pushToken` (optional) - The push notification registration token so the issuer/verifier can send notifications to the identity

## Example

An example of the `Iden3MessageEntity` object to be passed to the `authenticate` method is:

```json
{
  "id": "2199c31a-cfa6-489f-8ad9-f2202990314d",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "thid": "2199c31a-cfa6-489f-8ad9-f2202990314d",
  "body": {
    "callbackUrl": "https://self-hosted-testing-testnet-backend-platform.polygonid.me/api/callback?sessionId=402116",
    "reason": "test flow",
    "scope": []
  },
  "from": "did:polygonid:polygon:mumbai:2qFXmNqGWPrLqDowKz37Gq2FETk4yQwVUVUqeBLmf9"
}
```

This JSON object can be obtained by scanning a QR code, for instance from [https://issuer-demo-testing-testnet.polygonid.me/auth-qr](https://issuer-demo-testing-testnet.polygonid.me/auth-qr)
The `Iden3MessageEntity` can be obtained by passing the scanned String to this sdk methods:
```dart
Iden3MessageEntity message = await PolygonIdSdk.I.iden3comm.getIden3Message(
  message: "YOUR_SCANNED_STRING"
);
```


## Practical usage
```dart
await PolygonIdSdk.I.iden3comm.authenticate(
message: Iden3MessageEntity(
id: "2199c31a-cfa6-489f-8ad9-f2202990314d",
typ: "application/iden3comm-plain-json",
type: "https://iden3-communication.io/authorization/1.0/request",
thid: "2199c31a-cfa6-489f-8ad9-f2202990314d",
body: Iden3MessageBodyEntity(
callbackUrl: "https://self-hosted-testing-testnet-backend-platform.polygonid.me/api/callback?sessionId=402116",
reason: "test flow",
scope: []
),
from: "did:polygonid:polygon:mumbai:2qFXmNqGWPrLqDowKz37Gq2FETk4yQwVUVUqeBLmf9"
),
genesisDid: "YOUR_GENESIS_DID",
profileNonce: "YOUR_PROFILE_NONCE",
privateKey: "YOUR_PRIVATE_KEY",
pushToken: "PUSH_NOTIFICATION_TOKEN"
);
```

Please note that you need to replace "YOUR_GENESIS_DID", "YOUR_PROFILE_NONCE", "YOUR_PRIVATE_KEY", and "PUSH_NOTIFICATION_TOKEN" with the appropriate values.

For any issue, please refer to the [Polygon ID Flutter SDK's issue tracker](https://github.com/iden3/polygonid-flutter-sdk/issues).