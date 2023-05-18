extension ListRound on List {
  List deepFloor() {
    return map((value) {
      if (value is Map<String, dynamic>) {
        return value.deepFloor();
      }

      if (value is List) {
        return value.deepFloor();
      }

      return value is double ? value.floor() : value;
    }).toList();
  }
}

extension MapRound on Map<String, dynamic> {
  Map<String, dynamic> deepFloor() {
    return map((key, value) {
      if (value is Map<String, dynamic>) {
        return MapEntry(key, value.deepFloor());
      }

      if (value is List) {
        return MapEntry(key, value.deepFloor());
      }

      return MapEntry(key, value is double ? value.floor() : value);
    });
  }
}
