# Frequently Asked Questions
- [I'm getting `PolygonIdSdkNotInitializedException` while calling `PolygonIdSdk` methods](#polygonid-sdk-not-initialized-exception)
- [`FetchGistProofException`](#fetch-gist-proof-exception)
- [Error adding claim](#error-adding-claim)
- [PathNotFoundException (cannot open file, path = '*.dat')](#path-not-found-exception)
- [Supported devices](#supported-devices)

<a name="polygonid-sdk-not-initialized-exception"></a>
## I'm getting `PolygonIdSdkNotInitializedException` while calling `PolygonIdSdk` methods

before you can use the sdk's methods, you must initialise it
```dart
await PolygonIdSdk.init(env: EnvEntity());
```
after which you can use it by invoking its instance
```dart
PolygonIdSdk.I.identity.addIdentity()
```

<a name="fetch-gist-proof-exception"></a>
## `FetchGistProofException`

- Check that the circuits files have been downloaded correctly using the method:
```dart
bool downloaded = await PolygonIdSdk.I.proof.isAlreadyDownloadedCircuitsFromServer();
```

- Check the correctness of your `idStateContract` of the EnvEntity you passed on SDK initialization

- Check that the `web3ApiKey` of the EnvEntity you passed on SDK initialization is up and running at your web3 service provider (e.g. [infura](https://app.infura.io/dashboard))

<a name="error-adding-claim"></a>
## Error adding claim
the most common error regarding `error adding claim` is to use an identity of one `network` over a service provider of another network, for example, I have created an identity using the `mumbai` network of the `polygon` blockchain, but I am trying to authenticate with an issuer using the `main` network.
Check your `DID` and compare it with the `DID` of the service provider you want to connect to.

<a name="path-not-found-exception"></a>
## PathNotFoundException (cannot open file, path = '*.dat')

This error occurs when the circuits required for creating the 'proof' have not been downloaded.
- First check that your app has the necessary permissions to access, read and write to local storage.
- Check that the circuits files have been downloaded correctly using the method:
```dart
bool downloaded = await PolygonIdSdk.I.proof.isAlreadyDownloadedCircuitsFromServer();
```
- If not yet downloaded, download them using the `download circuits` method of the SDK
```dart
PolygonIdSdk.I.proof.initCircuitsDownloadAndGetInfoStream()
```

<a name="supported-devices"></a>
## Supported devices
- **iOS:** only the devices with `iphone-ipad-minimum-performance-a12` are supported,
  list of devices available at this link: https://developer.apple.com/support/required-device-capabilities
- **Android:** only the devices with architecture `arm64-v8a` and `x86_64` are supported, and a minimum `21 (Lollipop 5.0)` api version of Android