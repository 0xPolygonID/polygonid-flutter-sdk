abstract interface class JsonEncodable {
  /// Converts the object to a JSON-encodable map.
  Map<String, dynamic> toJson();
}
