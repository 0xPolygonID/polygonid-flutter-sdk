class ClaimUtils {
  static String separateByCamelCaseString(String s) {
    String result = " ";
    List<String> words =
        s.split(RegExp("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])"));
    for (var element in words) {
      result += "$element ";
    }
    result = result.substring(1, result.length - 1);
    return result;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
