import 'dart:convert';

class Base64Encoder {
  /// Encode to Base64, removing "=" padding
  String encode() {
    return Base64Util.encode64(jsonEncode(this));
  }
}

class Base64Util {
  static String encode64(dynamic object) {
    return base64Url.encode(utf8.encode(object)).split("=").first;
  }

  /// Shortcut for [Base64Encoder.encode]
  static String encode<T extends Base64Encoder>(T object) {
    return object.encode();
  }

  /// Decode from Base64, adding "=" padding
  static String decode(String data) {
    var modulo = data.length % 4;

    return utf8.decode(base64Url.decode(
        data.padRight(data.length + (modulo > 0 ? 4 - modulo : 0), "=")));
  }
}
