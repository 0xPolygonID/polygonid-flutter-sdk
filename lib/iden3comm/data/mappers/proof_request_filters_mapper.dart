import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

class ProofRequestFiltersMapper
    extends FromMapper<ProofRequestEntity, List<FilterEntity>> {
  @override
  List<FilterEntity> mapFrom(ProofRequestEntity from) {
    ProofScopeQueryRequest query = from.scope.query;

    Map<String, dynamic>? context;
    try {
      context = from.context["@context"][0][query.type]["@context"];
    } catch (e) {
      throw UnsupportedSchemaException();
    }

    List<FilterEntity> filters = [
      FilterEntity(
          name: 'credential.credentialSubject.type', value: query.type!),
      /*FilterEntity(
          operator: FilterOperator.equalsAnyInList,
          name: 'credential.@context',
          value: query.context!),*/
    ];
    if (query.allowedIssuers != null &&
        query.allowedIssuers is List &&
        query.allowedIssuers!.isNotEmpty) {
      if (query.allowedIssuers![0] != "*") {
        filters.add(FilterEntity(
            operator: FilterOperator.inList,
            name: 'issuer',
            value: query.allowedIssuers!));
      }
    }

    if (query.skipClaimRevocationCheck == null ||
        query.skipClaimRevocationCheck == false) {
      filters.add(FilterEntity(
          operator: FilterOperator.nonEqual,
          name: 'state',
          value: ClaimState.revoked.name));
    }

    if (query.credentialSubject != null) {
      Map<String, dynamic> request = query.credentialSubject!;
      request.forEach((key, map) {
        if (map != null && map is Map && map.isNotEmpty && context != null) {
          String type = getValueFromNestedString(context, key);
          map.forEach((operator, value) {
            if (type.contains("boolean")) {
              FilterEntity? booleanFilter =
                  _getBooleanFiltersByOperator(key, operator, value);
              if (booleanFilter != null) {
                filters.add(booleanFilter);
              }
            } else if (type.contains("string")) {
              if (operator == '\$in' || operator == '\$nin') {
                List<dynamic> values = List.from(value);
                List<String> stringList =
                    values.map((e) => e.toString()).toList();
                filters.addAll(_getFilterByOperator(key, operator, stringList));
              } else {
                filters.addAll(
                    _getFilterByOperator(key, operator, value.toString()));
              }
            } else {
              filters.addAll(_getFilterByOperator(key, operator, value));
            }
          });
        }
      });
    }

    return filters;
  }

  ///
  String getValueFromNestedString(
      Map<String, dynamic> contextMap, String nestedKey) {
    List<String> keys = nestedKey.split('.');
    dynamic value = contextMap;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value[key].containsKey("@context")) {
        value = value[key]["@context"];
      } else if (value is Map<String, dynamic> &&
          value[key].containsKey("@type")) {
        value = value[key]["@type"];
        break;
      } else {
        break;
      }
    }
    return value;
  }

  List<FilterEntity> _getFilterByOperator(field, operator, value) {
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
        if (value is List) {
          return [
            FilterEntity(
                operator: FilterOperator.inList,
                name: 'credential.credentialSubject.$field',
                value: value)
          ];
        } else {
          return [
            FilterEntity(
                operator: FilterOperator.inList,
                name: 'credential.credentialSubject.$field',
                value: [value])
          ];
        }
      case '\$nin':
        return List.from(value)
            .map((item) => FilterEntity(
                name: 'credential.credentialSubject.$field',
                value: item,
                operator: FilterOperator.nonEqual))
            .toList();
      case '\$ne':
        return [
          FilterEntity(
              operator: FilterOperator.nonEqual,
              name: 'credential.credentialSubject.$field',
              value: value)
        ];
      default:
        break;
    }

    return [];
  }

  FilterEntity? _getBooleanFiltersByOperator(field, operator, value) {
    var trueValues = [true, "true", 1];
    var falseValues = [false, "false", 0];
    if (value is int) {
      if (operator == '\$eq') {
        if (value == 0) {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        }
      } else if (operator == '\$ne') {
        if (value == 0) {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        }
      }
    } else if (value is String) {
      if (operator == '\$eq') {
        if (value == "false") {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        }
      } else if (operator == '\$ne') {
        if (value == "false") {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        }
      }
    } else if (value is bool) {
      if (operator == '\$eq') {
        if (value == false) {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        }
      } else if (operator == '\$ne') {
        if (value == false) {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: trueValues);
        } else {
          return FilterEntity(
              operator: FilterOperator.inList,
              name: 'credential.credentialSubject.$field',
              value: falseValues);
        }
      }
    }
    return null;
  }
}
