import 'package:polygonid_flutter_sdk/common/kms/store/types.dart';

/// builds key path
///
/// @param {KmsKeyType} keyType - key type
/// @param {string} keyID - key id
/// @returns string path
String keyPath(KmsKeyType keyType, String keyID) {
  const basePath = '';
  return basePath + keyType.name + ':' + keyID;
}
