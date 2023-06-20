# Authentication with Polygon ID Flutter SDK

This document provides an explanation on how to authenticate with the Polygon ID Flutter SDK using the `authenticate` method.

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