import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';

class PushServiceData with EquatableMixin {
  final String pushToken;
  final String serviceEndpoint;
  final String packageName;

  PushServiceData({
    required this.pushToken,
    required this.serviceEndpoint,
    required this.packageName,
  });

  @override
  List<Object?> get props => [pushToken, serviceEndpoint, packageName];
}

Future<String> fetchPushCipherText(
  PushServiceData data,
) async {
  var pushInfo = {
    "app_id": data.packageName, //"com.polygonid.wallet",
    "pushkey": data.pushToken,
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
    final publicKey = RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
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
