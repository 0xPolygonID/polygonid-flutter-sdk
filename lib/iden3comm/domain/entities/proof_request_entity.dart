import 'package:flutter/foundation.dart';

import 'request/auth/proof_scope_request.dart';

class ProofRequestEntity {
  final ProofScopeRequest scope;
  final Map<String, dynamic> context;
  final ProofQueryParamEntity queryParam;

  ProofRequestEntity(this.scope, this.context, this.queryParam);

  @override
  String toString() =>
      "[ProofRequestEntity] {scope: $scope, context: $context, queryParam: $queryParam}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofRequestEntity &&
          runtimeType == other.runtimeType &&
          scope == other.scope &&
          context == other.context &&
          queryParam == other.queryParam;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProofQueryParamEntity {
  final String field;
  final List<dynamic> values;
  final int operator;

  ProofQueryParamEntity(this.field, this.values, this.operator);

  @override
  String toString() =>
      "[ProofQueryParamEntity] {field: $field, values: $values, operator: $operator}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofQueryParamEntity &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          listEquals(values, other.values) &&
          operator == other.operator;

  @override
  int get hashCode => runtimeType.hashCode;
}
