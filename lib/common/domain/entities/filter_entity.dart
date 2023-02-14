enum FilterOperator {
  equal,
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
}
