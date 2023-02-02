import 'package:country_code/country_code.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

import '../../domain/entities/proof_request_entity.dart';
import '../../domain/entities/request/auth/proof_scope_query_request.dart';

class ProofRequestFiltersMapper
    extends FromMapper<ProofRequestEntity, List<FilterEntity>> {
  @override
  List<FilterEntity> mapFrom(ProofRequestEntity from) {
    ProofScopeQueryRequest query = from.scope.query;

    List<FilterEntity> filters = [
      FilterEntity(
          name: 'credential.credentialSubject.type', value: query.type),
    ];
    if (query.allowedIssuers is List && query.allowedIssuers!.isNotEmpty) {
      if (query.allowedIssuers![0] != "*") {
        filters.add(FilterEntity(
            operator: FilterOperator.inList,
            name: 'issuer',
            value: query.allowedIssuers));
      }
    }

    if (query.credentialSubject != null) {
      Map<String, dynamic> request = query.credentialSubject!;

      request.forEach((key, map) {
        if (map != null && map is Map) {
          map.forEach((operator, value) {
            filters.addAll(
                _getFilterByOperator(key, operator, value, query.type!));
          });
        }
      });
    }

    return filters;
  }

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
          List<int> excluded = List<int>.from(value);
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
      case '\$ne':
        return [
          FilterEntity(
              operator: FilterOperator.nonEqual,
              name: 'credential.credentialSubject.$field', value: value)
        ];
      default:
        break;
    }

    return [];
  }
}
