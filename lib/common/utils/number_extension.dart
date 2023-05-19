extension ListRound on List {
  List deepDoubleToInt() {
    return map((value) {
      if (value is Map<String, dynamic>) {
        return value.deepDoubleToInt();
      }

      if (value is List) {
        return value.deepDoubleToInt();
      }

      return value is double && !value.hasDecimals() ? value.floor() : value;
    }).toList();
  }
}

extension MapRound on Map<String, dynamic> {
  Map<String, dynamic> deepDoubleToInt() {
    return map((key, value) {
      if (value is Map<String, dynamic>) {
        return MapEntry(key, value.deepDoubleToInt());
      }

      if (value is List) {
        return MapEntry(key, value.deepDoubleToInt());
      }

      return MapEntry(
          key, value is double && !value.hasDecimals() ? value.floor() : value);
    });
  }
}

extension DoubleRound on double {
  bool hasDecimals() {
    return this % 1 != 0;
  }
}
