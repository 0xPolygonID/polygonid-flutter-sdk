List<String> parseContext(dynamic json) {
  if (json is String) {
    return [json];
  } else if (json is List) {
    return json.map((e) => e.toString()).toList();
  } else {
    throw Exception('Invalid @context format');
  }
}
