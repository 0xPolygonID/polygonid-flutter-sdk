class ProofRequestEntity {
  final String id;
  final String circuitId;
  final bool optional;
  final Map<String, dynamic> info;
  final ProofQueryParamEntity queryParam;

  ProofRequestEntity(
      this.id, this.circuitId, this.optional, this.info, this.queryParam);
}

class ProofQueryParamEntity {
  final String field;
  final List<int> values;
  final int operator;

  ProofQueryParamEntity(this.field, this.values, this.operator);
}
