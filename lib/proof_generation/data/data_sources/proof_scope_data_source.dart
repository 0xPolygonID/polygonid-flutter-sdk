import 'package:country_code/country_code.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';

enum SupportedCircuits { mtp, sig }

class ProofScopeDataSource {
  static const Map<SupportedCircuits, String> _supportedCircuits = {
    SupportedCircuits.mtp: "credentialAtomicQueryMTP",
    SupportedCircuits.sig: "credentialAtomicQuerySig",
  };

  ///
  List<ProofScopeRequest> filteredProofScopeRequestList(
      List<ProofScopeRequest> proofScopeRequestList) {
    return proofScopeRequestList
        .where(
            (scope) => scope.rules?.query != null && _circuitIsSupported(scope))
        .toList();
  }

  ///
  List<FilterEntity> proofScopeRulesQueryRequestFilters(
      ProofScopeRulesQueryRequest proofScopeRulesQueryRequest) {
    List<FilterEntity> filters = [
      FilterEntity(
          name: 'credential.credentialSchema.type',
          value: proofScopeRulesQueryRequest.schema!.type),
    ];
    if (proofScopeRulesQueryRequest.allowedIssuers is List &&
        proofScopeRulesQueryRequest.allowedIssuers!.isNotEmpty) {
      if (proofScopeRulesQueryRequest.allowedIssuers![0] != "*") {
        filters.add(FilterEntity(
            operator: FilterOperator.inList,
            name: 'issuer',
            value: proofScopeRulesQueryRequest.allowedIssuers));
      }
    }

    if (proofScopeRulesQueryRequest.req != null) {
      Map<String, dynamic> request = proofScopeRulesQueryRequest.req!;

      request.forEach((key, map) {
        if (map != null && map is Map) {
          map.forEach((operator, value) {
            filters.addAll(_getFilterByOperator(key, operator, value,
                proofScopeRulesQueryRequest.schema!.type!));
          });
        }
      });
    }

    return filters;
  }

  ///
  List<FilterEntity> _getFilterByOperator(field, operator, value, schema) {
    switch (operator) {
      case '\$eq':
        return [
          FilterEntity(
              name: 'credential.credentialSubject.$field', value: value)
        ];
      case '\$lt':
        return [
          FilterEntity(
              operator: FilterOperator.lesser,
              name: 'credential.credentialSubject.$field',
              value: value)
        ];
      case '\$gt':
        return [
          FilterEntity(
              operator: FilterOperator.greater,
              name: 'credential.credentialSubject.$field',
              value: value)
        ];
      case '\$in':
        List<int> values = [];
        List<dynamic> included = value;
        for (int val in included) {
          values.add(val);
        }
        return [
          FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: values)
        ];
      case '\$nin':
        if (schema == "KYCAgeCredential" || schema == "AgeCredential") {
          List<int> excluded = value as List<int>;
          excluded.sort((a, b) => a.compareTo(b));
          FilterEntity lower = FilterEntity(
              operator: FilterOperator.lesser,
              name: 'credential.credentialSubject.$field',
              value: excluded[0]);
          FilterEntity higher = FilterEntity(
              operator: FilterOperator.greater,
              name: 'credential.credentialSubject.$field',
              value: excluded[1]);
          return [
            FilterEntity(
                operator: FilterOperator.or, name: '', value: [lower, higher])
          ];
        } else if (schema == "KYCCountryOfResidenceCredential" ||
            schema == "CountryOfResidenceCredential") {
          List<int> values = [];
          List<dynamic> excluded = value;
          for (var countryCode in CountryCode.values) {
            int country = countryCode.numeric;
            if (!excluded.contains(country)) {
              values.add(country);
            }
          }
          return [
            FilterEntity(
                operator: FilterOperator.inList,
                name: 'credential.credentialSubject.$field',
                value: values)
          ];
        }
        break;

      default:
        break;
    }

    return [];
  }

  ///
  bool _circuitIsSupported(ProofScopeRequest scopeRequest) {
    return _supportedCircuits.values.contains(scopeRequest.circuit_id) &&
        (scopeRequest.optional == null || !scopeRequest.optional!);
  }
}
