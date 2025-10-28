import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';

void main() {
  group('parseRsaPublicKeyFromPem', () {
    // Generated 512-bit key variants (short for test) using OpenSSL.
    const pkcs1Pem =
        '-----BEGIN RSA PUBLIC KEY-----\nMEgCQQC+CqMyB9vGleqguXed0jNA5L7XA24otManvNfw+cxM8If6LrPhBwj5m/XL\nFVvpWEhDMd5BpLsXFePDYOlg8397AgMBAAE=\n-----END RSA PUBLIC KEY-----';

    // The PKCS#8 file from openssl rsa -pubout includes header lines but our earlier terminal output truncated BEGIN line accidentally.
    // Reconstruct proper PKCS#8 PEM.
    const pkcs8Pem =
        '-----BEGIN PUBLIC KEY-----\nMFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAL4KozIH28aV6qC5d53SM0DkvtcDbii0\nxqe81/D5zEzwh/ous+EHCPmb9csVW+lYSEMx3kGkuxcV48Ng6WDzf3sCAwEAAQ==\n-----END PUBLIC KEY-----';

    test('parses PKCS#1 RSA public key', () {
      final key = parseRsaPublicKeyFromPem(pkcs1Pem);
      expect(key, isA<RSAPublicKey>());
      expect(key.exponent, isNotNull);
      expect(key.modulus!.bitLength, greaterThan(400));
    });

    test('parses PKCS#8 RSA public key', () {
      final key = parseRsaPublicKeyFromPem(pkcs8Pem);
      expect(key, isA<RSAPublicKey>());
      expect(key.exponent, isNotNull);
      expect(key.modulus!.bitLength, greaterThan(400));
    });

    test('throws on malformed key', () {
      expect(
        () => parseRsaPublicKeyFromPem(
          '-----BEGIN PUBLIC KEY-----\nAAAA\n-----END PUBLIC KEY-----',
        ),
        throwsException,
      );
    });
  });
}
