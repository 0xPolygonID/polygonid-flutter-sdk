import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';

class CommonMocks {
  static String name = "theName";
  static String did = "did:polygonid:polygon:mumbai:$id";
  static String id = "theId";
  static String identifier = "theIdentifier";
  static String privateKey = "thePrivateKey";
  static Map<BigInt, String> profiles = {
    BigInt.zero: "${did}0",
    BigInt.one: "${did}1"
  };
  static String walletPrivateKey = "theWalletPrivateKey";
  static String pubX = "thePubX";
  static String pubY = "thePubY";
  static List<String> pubKeys = [pubX, pubY];
  static String message = "theMessage";
  static String signature = "theSignature";
  static String challenge = "theChallenge";
  static String authClaim = "theAuthClaim";
  static String state = "theState";
  static String thid = "theThid";
  static String to = "theTo";
  static String from = "theFrom";
  static String typ = "theTyp";
  static String token = "theToken";
  static String url = "theUrl";
  static String circuitId = "credentialAtomicQuerySig";
  static String field = "theField";
  static String issuer = "theIssuer";
  static String type = "KYCAgeCredential";
  static List<int> intValues = [0, 1, 2];
  static List<BigInt> bigIntValues = [BigInt.zero, BigInt.one, BigInt.two];
  static int operator = 4;
  static String config = "theConfig";
  static BigInt nonce = BigInt.one;
  static BigInt genesisNonce = BigInt.zero;
  static BigInt negativeNonce = BigInt.from(-1);
  static Map<String, dynamic> aMap = {
    'the': {'very': 'nice map'},
    'yep': 4
  };
  static Uint8List aBytes = Uint8List(32);
  static String hash = "theHash";
  static Exception exception = Exception(message);
  static String blockchain = "theBlockchain";
  static String network = "theNetwork";

  static FilterEntity filter = FilterEntity(name: name, value: aMap);

  static Key key = Key.fromLength(3);

  static Map<String, dynamic> envJson = {
    'blockchain': name,
    'network': network,
    'web3Url': url,
    'web3RdpUrl': url,
    'web3ApiKey': id,
    'idStateContract': message,
    'pushUrl': url,
    'ipfsUrl': url,
  };

  static EnvEntity env = EnvEntity(
    blockchain: name,
    network: network,
    web3Url: url,
    web3RdpUrl: url,
    web3ApiKey: id,
    idStateContract: message,
    pushUrl: url,
    ipfsUrl: url,
  );

  static String expiration = "2050-01-01T00:00:00Z";

  static String credentialRawValue = "{\"the\": \"value\"}";
}
