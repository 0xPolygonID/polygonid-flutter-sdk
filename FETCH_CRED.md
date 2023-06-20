# Fetch and Save Credentials

## Preparatory steps

Please follow these [steps here](https://github.com/0xPolygonID/polygonid-flutter-sdk/blob/sdk-methods-docs/AUTH.md) if you have not already done so, in order to correctly initialise the sdk and authenticate yourself on an issuer provider

## Fetch and Save method

The Polygon ID Flutter SDK provides an easy-to-use method for fetching a list of [ClaimEntity](https://github.com/0xPolygonID/polygonid-flutter-sdk/blob/develop/lib/credential/domain/entities/claim_entity.dart) objects from an issuer (like https://issuer-demo-testing-testnet.polygonid.me/) and storing them in the Polygon ID SDK.

This process is handled with the `fetchAndSaveClaims` function:

```dart
Future<List<ClaimEntity>> fetchAndSaveClaims({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey
});
```

The parameters to provide to this function are:

- `message`: an `Iden3MessageEntity` object, which contains the iden3comm message entity.
- `genesisDid`: a `String` representing the unique id of the identity.
- `profileNonce`: a `BigInt` (optional) representing the nonce of the profile used from identity to obtain the did identifier.
- `privateKey`: a `String` used to access all sensitive info from the identity and also to perform operations like generating proofs.

Here's an example of a JSON object returned by an issuer:

```json
{
  "id": "731fbb15-25cd-4148-88da-895f0ccfd78a",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/1.0/offer",
  "thid": "731fbb15-25cd-4148-88da-895f0ccfd78a",
  "body": {
    "url": "https://issuer-testing-testnet.polygonid.me/v1/agent",
    "credentials": [
      {
        "id": "6240925f-05f8-11ee-9dc5-0242ac180005",
        "description": "KYCAgeCredential"
      }
    ]
  },
  "from": "did:polygonid:polygon:mumbai:2qFXmNqGWPrLqDowKz37Gq2FETk4yQwVUVUqeBLmf9",
  "to": "did:polygonid:polygon:mumbai:2qKaEw4sFmKD1JA59fnXA3d6BTeAsdyeEkVRs37W8P"
}
```

The `Iden3MessageEntity` can be obtained by passing the scanned String to this sdk methods:
```dart
Iden3MessageEntity message = await PolygonIdSdk.I.iden3comm.getIden3Message(
  message: "YOUR_SCANNED_STRING"
);
```

After using the `fetchAndSaveClaims` function, the list of credentials will be stored in the Polygon ID SDK. You can retrieve these credentials using the `getClaims` function:

```dart
Future<List<ClaimEntity>> getClaims({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String privateKey
});
```

This function returns a list of `ClaimEntity` objects associated with the identity, previously stored in the Polygon ID SDK. You can filter this list using the `filters` parameter. It also requires the `genesisDid` and `privateKey` parameters, as described above.

This handling of credentials simplifies the process, making it easier to fetch, store, and retrieve credentials in your application. For further information and usage examples, please refer to the [Polygon ID Wallet SDK Documentation](https://0xpolygonid.github.io/tutorials/wallet/wallet-sdk/polygonid-sdk/credential/api/fetch-and-save-claims/).
