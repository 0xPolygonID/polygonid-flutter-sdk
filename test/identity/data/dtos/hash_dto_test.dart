import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'dart:typed_data';

void main() {
  group('HashDTO', () {
    test('== operator should return true when data fields are equal', () {
      final data1 = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO1 = HashDTO(data: data1);

      final data2 = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO2 = HashDTO(data: data2);

      expect(hashDTO1 == hashDTO2, isTrue);
    });

    test('== operator should return false when data fields are not equal', () {
      final data1 = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO1 = HashDTO(data: data1);

      final data2 = Uint8List.fromList([6, 7, 8, 9, 10]);
      final hashDTO2 = HashDTO(data: data2);

      expect(hashDTO1 == hashDTO2, isFalse);
    });

    test(
        '== operator should return false when data fields have different lengths',
        () {
      final data1 = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO1 = HashDTO(data: data1);

      final data2 = Uint8List.fromList([1, 2, 3, 4, 5, 6]);
      final hashDTO2 = HashDTO(data: data2);

      expect(hashDTO1 == hashDTO2, isFalse);
    });

    test('toBigInt should return correct BigInt value', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO = HashDTO(data: data);

      final expectedBigInt = BigInt.parse('21542142465');
      expect(hashDTO.toBigInt(), equals(expectedBigInt));
    });

    test('testBit should return correct bit value', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final hashDTO = HashDTO(data: data);

      expect(hashDTO.testBit(0), isTrue);
      expect(hashDTO.testBit(1), isFalse);
    });
  });
}
