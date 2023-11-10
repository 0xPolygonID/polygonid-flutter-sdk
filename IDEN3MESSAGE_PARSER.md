# Iden3Message Parser

## Introduction

With the latest update, the content of the QR code provided by the Issuer or Verifier could be in three different formats:
- Url (iden3comm://?request_uri=)
- Base64 encoded (iden3comm://?i_m=)
- RAW Json format (json)

## Code Snippet
to parse the qr code content, you can use the following code snippet as an example:

```dart
class QrcodeParserUtils {
  final PolygonIdSdk _polygonIdSdk;

  QrcodeParserUtils(this._polygonIdSdk);

  Future<Iden3MessageEntity> getIden3MessageFromQrCode(String message) async {
    try {
      String rawMessage = message;
      if (message.startsWith("iden3comm://?i_m")) {
        rawMessage = await _getMessageFromBase64(message);
      }

      if (message.startsWith("iden3comm://?request_uri")) {
        rawMessage = await _getMessageFromRemote(message);
      }

      Iden3MessageEntity? _iden3Message =
      await _polygonIdSdk.iden3comm.getIden3Message(message: rawMessage);
      return _iden3Message;
    } catch (error) {
      throw Exception("Error while processing the QR code");
    }
  }

  Future<String> _getMessageFromRemote(String message) async {
    try {
      message = message.replaceAll("iden3comm://?request_uri=", "");
      http.Response response = await http.get(Uri.parse(message));
      if (response.statusCode != 200) {
        throw Exception("Error while getting the message from the remote");
      }
      return response.body;
    } catch (error) {
      throw Exception("Error while getting the message from the remote");
    }
  }
  
  Future<String> _getMessageFromBase64(String message) async {
    try {
      message = message.replaceAll("iden3comm://?i_m=", "");
      String decodedMessage = String.fromCharCodes(base64.decode(message));
      return decodedMessage;
    } catch (error) {
      throw Exception("Error while getting the message from the base64");
    }
  }
}
```