# Generating a Proof with Polygon ID SDK

Generating a proof is a critical process in a credential-based system. After you have successfully fetched and saved credentials using the Polygon ID SDK, you can generate a proof for authentication with a verifier.

To authenticate yourself with a verifier provider, you will need to have previously completed all the [preparatory steps](https://github.com/0xPolygonID/polygonid-flutter-sdk/blob/sdk-methods-docs/AUTH.md) and [have credentials in your wallet](https://github.com/0xPolygonID/polygonid-flutter-sdk/blob/sdk-methods-docs/FETCH_CRED.md). Once these prerequisites are met, you can connect to a verifier, like the test one at `https://verifier-testing.polygonid.me/`, and use the `authenticate` method.

This time, however, the `Iden3MessageEntity` will have a different format:

```json
{
  "id":"385f246d-080a-4e32-941f-ad76595332b1",
  "typ":"application/iden3comm-plain-json",
  "type":"https://iden3-communication.io/authorization/1.0/request",
  "thid":"385f246d-080a-4e32-941f-ad76595332b1",
  "body":{
    "callbackUrl":"https://self-hosted-testing-testnet-backend-platform.polygonid.me/api/callback?sessionId=229765",
    "reason":"test flow",
    "scope":[
      {
        "id":1,
        "circuitId":"credentialAtomicQuerySigV2",
        "query":{
          "allowedIssuers":["*"],
          "context":"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld",
          "credentialSubject":{
            "birthday":{
              "$lt":20000101
            }
          },
          "type":"KYCAgeCredential"
        }
      }
    ]
  },
  "from":"did:polygonid:polygon:mumbai:2qFXmNqGWPrLqDowKz37Gq2FETk4yQwVUVUqeBLmf9"
}
```

The `authenticate` method will be used the same way as when you authenticated your identity with the test issuer:

```dart
Future<void> authenticate({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? pushToken,
});
```

Remember to replace the `message`, `genesisDid`, `profileNonce` (if needed), and `privateKey` parameters with the correct values. The `pushToken` parameter is optional.

The `Iden3MessageEntity` can be obtained by passing the scanned String to this sdk methods:
```dart
Iden3MessageEntity message = await PolygonIdSdk.I.iden3comm.getIden3Message(
  message: "YOUR_SCANNED_STRING"
);
```

After you send the request and the operation is successful, the verifier will use the callback URL specified in the message to return the result of the verification process.