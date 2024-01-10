class FormatUtils {
  static Map<String, dynamic> convertSnakeCaseToCamelCase(
      Map<String, dynamic> map) {
    var newMap = <String, dynamic>{};
    map.forEach((key, value) {
      var newKey = key.replaceAllMapped(
          RegExp(r'_([a-zA-Z])'), (Match m) => m[1]!.toUpperCase());
      newMap[newKey] = value;
    });
    return newMap;
  }
}
