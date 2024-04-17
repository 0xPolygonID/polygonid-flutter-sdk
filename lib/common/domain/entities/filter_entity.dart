enum FilterOperator {
  equal,
  equalsAnyInList,
  greater,
  lesser,
  greaterEqual,
  lesserEqual,
  inList,
  or,
  nonEqual,
  between,
  nonbetween,
  exists,
}

class FilterEntity {
  final FilterOperator operator;
  final String name;
  final Object value;

  FilterEntity(
      {this.operator = FilterOperator.equal,
      required this.name,
      required this.value});

  factory FilterEntity.fromJson(Map<String, dynamic> json) {
    return FilterEntity(
      operator:
          FilterOperator.values.firstWhere((e) => e.name == json['operator']),
      name: json['name'],
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'operator': operator.name,
      'name': name,
      'value': value,
    };
  }

  @override
  String toString() =>
      "[FilterEntity] {operator: $operator, name: $name, value: $value}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterEntity &&
          runtimeType == other.runtimeType &&
          operator == other.operator &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => operator.hashCode ^ name.hashCode ^ value.hashCode;
}
