enum FilterOperator {
  equal,
  equalsAnyInList,
  greater,
  lesser,
  greaterEqual,
  lesserEqual,
  inList,
  or,
  nonEqual
}

class FilterEntity {
  final FilterOperator operator;
  final String name;
  final dynamic value;

  FilterEntity(
      {this.operator = FilterOperator.equal,
      required this.name,
      required this.value});

  factory FilterEntity.fromJson(Map<String, dynamic> json) {
    return FilterEntity(
      operator: FilterOperator.values
          .firstWhere((e) => e.toString() == json['operator']),
      name: json['name'],
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'operator': operator.toString(),
      'name': name,
      'value': value,
    };
  }
}
