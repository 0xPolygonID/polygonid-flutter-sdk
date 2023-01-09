import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'encryption_db_data_source_test.mocks.dart';

final Map<String, Object?> data = {"theField": "theValue"};
final key = Key.fromBase16("12345678901234567890123456789012");
const String encryptedData = "theEncryptedData";
final iv = IV.fromLength(16);

MockEncrypter encrypter = MockEncrypter();

// Tested instance
EncryptionDbDataSource encryptionDbDataSource = EncryptionDbDataSource();

@GenerateMocks([Encrypter])
void main() {
  setUp(() {
    if (getItSdk.isRegistered<Encrypter>(instanceName: 'encryptAES')) {
      getItSdk.unregister<Encrypter>(instanceName: 'encryptAES');
    }

    getItSdk.registerFactoryParam<Encrypter, Key, void>(
      (param1, __) => encrypter,
      instanceName: 'encryptAES',
    );

    when(encrypter.encrypt(any, iv: anyNamed('iv')))
        .thenAnswer((_) => Encrypted(Uint8List(32)));
    when(encrypter.decrypt64(any, iv: anyNamed('iv')))
        .thenReturn(jsonEncode(data));
  });

  group("Encrypt claims db", () {
    test(
        "Given a valid param, when I call encryptData, then I expect the result to be returned",
        () async {
      // When
      final result = encryptionDbDataSource.encryptData(
        data: data,
        key: key,
      );

      // Then
      expect(result, isA<String>());

      // Verify
      var captured = verify(encrypter.encrypt(
        captureAny,
        iv: captureAnyNamed('iv'),
      )).captured;

      expect(captured[0], jsonEncode(data));
      expect(captured[1], iv);
    });
  });

  group("Decrypt claims db", () {
    test(
        "Given a valid param, when I call decryptData, then I expect the result to be returned",
        () async {
      // When
      final result = encryptionDbDataSource.decryptData(
        encryptedData: encryptedData,
        key: key,
      );

      // Then
      expect(result, isA<Map<String, Object?>>());
      expect(result, data);

      // Verify
      var captured = verify(encrypter.decrypt64(
        captureAny,
        iv: captureAnyNamed('iv'),
      )).captured;

      expect(captured[0], encryptedData);
      expect(captured[1], iv);
    });
  });
}
