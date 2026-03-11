import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:equatable/equatable.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'package:pointycastle/asn1.dart'; // for ASN1 parsing

class PushServiceData with EquatableMixin {
  final String pushToken;
  final String serviceEndpoint;
  final String packageName;
  final String? uniqueId;

  PushServiceData({
    required this.pushToken,
    required this.serviceEndpoint,
    required this.packageName,
    this.uniqueId,
  });

  @override
  List<Object?> get props => [
        pushToken,
        serviceEndpoint,
        packageName,
        uniqueId,
      ];
}

/// Parses an RSA public key from a PEM string supporting both
/// 'BEGIN PUBLIC KEY' (PKCS#8 SubjectPublicKeyInfo) and
/// 'BEGIN RSA PUBLIC KEY' (PKCS#1) formats using pointycastle ASN1.
RSAPublicKey parseRsaPublicKeyFromPem(String pem) {
  final normalized = pem
      .replaceAll('\r', '')
      .split('\n')
      .where((line) =>
          line.isNotEmpty &&
          !line.startsWith('-----BEGIN') &&
          !line.startsWith('-----END'))
      .join('');
  final derBytes = base64.decode(normalized);
  final parser = ASN1Parser(derBytes);
  final topLevelSeq = parser.nextObject();
  if (topLevelSeq is! ASN1Sequence) {
    throw ArgumentError('Top level ASN.1 object is not a SEQUENCE');
  }
  final elements = topLevelSeq.elements ?? [];

  // PKCS#8: SEQUENCE { SEQUENCE algorithm, BIT STRING publicKey }
  if (elements.length == 2 && elements[0] is ASN1Sequence && elements[1] is ASN1BitString) {
    final bitString = elements[1] as ASN1BitString;
    // Use valueBytes (raw) and skip first byte (unused bits count) if length > 0.
    final raw = bitString.valueBytes ?? Uint8List(0);
    if (raw.isEmpty) {
      throw ArgumentError('Empty BIT STRING for public key');
    }
    final keyBytes = raw.sublist(1); // skip unused bits count byte
    final keyParser = ASN1Parser(keyBytes);
    final keySeqObj = keyParser.nextObject();
    if (keySeqObj is! ASN1Sequence) {
      throw ArgumentError('Public key BIT STRING does not contain a SEQUENCE');
    }
    final keyElements = keySeqObj.elements ?? [];
    if (keyElements.length < 2 || keyElements[0] is! ASN1Integer || keyElements[1] is! ASN1Integer) {
      throw ArgumentError('RSAPublicKey sequence malformed');
    }
    final modulus = (keyElements[0] as ASN1Integer).integer!;
    final exponent = (keyElements[1] as ASN1Integer).integer!;
    return RSAPublicKey(modulus, exponent);
  }

  // PKCS#1: SEQUENCE { INTEGER modulus, INTEGER publicExponent }
  if (elements.length >= 2 && elements[0] is ASN1Integer && elements[1] is ASN1Integer) {
    final modulus = (elements[0] as ASN1Integer).integer!;
    final exponent = (elements[1] as ASN1Integer).integer!;
    return RSAPublicKey(modulus, exponent);
  }

  throw ArgumentError('Unsupported or malformed RSA public key PEM format');
}

Future<String> fetchPushCipherText(
  PushServiceData data,
) async {
  var pushInfo = {
    "app_id": data.packageName, // "com.polygonid.wallet",
    "pushkey": data.pushToken,
    if (data.uniqueId != null) "unique_id": data.uniqueId,
  };

  Dio dio = Dio();
  final dir = await getApplicationDocumentsDirectory();
  dio.interceptors.add(
    DioCacheInterceptor(
      options: CacheOptions(
        store: HiveCacheStore(dir.path),
        policy: CachePolicy.request,
        maxStale: const Duration(days: 7),
        priority: CachePriority.high,
      ),
    ),
  );

  var publicKeyResponse = await dio.get(
    Uri.parse("${data.serviceEndpoint}/public").toString(),
  );

  if (publicKeyResponse.statusCode == 200 ||
      publicKeyResponse.statusCode == 304) {
    String publicKeyPem = publicKeyResponse.data;
    final publicKey = parseRsaPublicKeyFromPem(publicKeyPem);
    final encrypter = OAEPEncoding.withCustomDigest(
      () => SHA512Digest(),
      RSAEngine(),
    );
    encrypter.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    Uint8List encrypted = encrypter.process(
      Uint8List.fromList(json.encode(pushInfo).codeUnits),
    );
    return base64.encode(encrypted);
  } else {
    throw NetworkException(
      statusCode: publicKeyResponse.statusCode ?? 0,
      errorMessage:
          "Error fetching public key: ${publicKeyResponse.statusMessage}",
    );
  }
}
