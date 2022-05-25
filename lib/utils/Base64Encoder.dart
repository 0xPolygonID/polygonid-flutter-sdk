import 'dart:convert';

class Base64Encoder {
  /// Encode in Base64, removing "=" padding
  String encode() {
    return base64Url.encode(utf8.encode(jsonEncode(this))).split("=").first;
  }
}
