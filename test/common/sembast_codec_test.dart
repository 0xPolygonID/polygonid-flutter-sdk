import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/utils/encrypt_sembast_codec.dart';

void main() {
  final encryptionKey =
      '0dcf64285bc0528f11de371e41b776875009cd7b3fb55978fa6af94fb4ade925';
  final codec = getEncryptSembastCodec(encryptionKey: encryptionKey);

  final expectedEncoded = 'Q9v0c0O/l0F/jHdcskF2Ww4MiBsp5ZM5ZaHm20XyYQy6Tl8=';
  final expectedDecoded = {"signature": "EncryptType.salsa20"};

  group('test sembast codec', () {
    test('test encryption', () {
      final encoded = codec.codec?.encoder.convert(expectedDecoded);

      expect(encoded, expectedEncoded);
    });

    test('test decryption', () {
      final decoded = codec.codec?.decoder.convert(expectedEncoded);

      expect(decoded, expectedDecoded);
    });
  });
}
