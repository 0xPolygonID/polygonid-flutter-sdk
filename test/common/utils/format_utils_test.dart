import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/utils/format_utils.dart';

void main() {
  group('FormatUtils', () {
    test(
        'convertSnakeCaseToCamelCase should return empty map when input is empty',
        () {
      final result = FormatUtils.convertSnakeCaseToCamelCase({});
      expect(result, {});
    });

    test('convertSnakeCaseToCamelCase should convert snake_case to camelCase',
        () {
      final result =
          FormatUtils.convertSnakeCaseToCamelCase({'snake_case': 'value'});
      expect(result, {'snakeCase': 'value'});
    });

    test('convertSnakeCaseToCamelCase should handle multiple snake_case keys',
        () {
      final result = FormatUtils.convertSnakeCaseToCamelCase(
          {'snake_case_one': 'value1', 'snake_case_two': 'value2'});
      expect(result, {'snakeCaseOne': 'value1', 'snakeCaseTwo': 'value2'});
    });

    test('convertSnakeCaseToCamelCase should not modify camelCase keys', () {
      final result =
          FormatUtils.convertSnakeCaseToCamelCase({'camelCase': 'value'});
      expect(result, {'camelCase': 'value'});
    });

    test(
        'convertSnakeCaseToCamelCase should handle mixed snake_case and camelCase keys',
        () {
      final result = FormatUtils.convertSnakeCaseToCamelCase(
          {'snake_case': 'value1', 'camelCase': 'value2'});
      expect(result, {'snakeCase': 'value1', 'camelCase': 'value2'});
    });
  });
}
