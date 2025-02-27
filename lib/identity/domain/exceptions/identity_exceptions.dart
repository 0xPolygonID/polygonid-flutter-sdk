import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class IdentityException extends PolygonIdSDKException {
  IdentityException({required super.errorMessage, super.error});
}

class TooLongPrivateKeyException extends PolygonIdSDKException {
  TooLongPrivateKeyException({required super.errorMessage, super.error});
}

class IdentityAlreadyExistsException extends PolygonIdSDKException {
  final String did;

  IdentityAlreadyExistsException({
    required this.did,
    required super.errorMessage,
    super.error,
  });
}

class ProfileAlreadyExistsException extends PolygonIdSDKException {
  final String genesisDid;
  final BigInt profileNonce;

  ProfileAlreadyExistsException({
    required this.genesisDid,
    required this.profileNonce,
    required super.errorMessage,
    super.error,
  });
}

class UnknownProfileException extends PolygonIdSDKException {
  final BigInt profileNonce;

  UnknownProfileException({
    required this.profileNonce,
    required super.errorMessage,
    super.error,
  });
}

class UnknownIdentityException extends PolygonIdSDKException {
  final String did;

  UnknownIdentityException({
    required this.did,
    required super.errorMessage,
    super.error,
  });
}

class InvalidPrivateKeyException extends PolygonIdSDKException {
  final String privateKey;

  InvalidPrivateKeyException({
    required this.privateKey,
    required super.errorMessage,
    super.error,
  });
}

class InvalidProfileException extends PolygonIdSDKException {
  final BigInt profileNonce;

  InvalidProfileException({
    required this.profileNonce,
    required super.errorMessage,
    super.error,
  });

  dynamic get error {
    if (profileNonce == BigInt.zero) {
      return "Genesis profile can't be modified";
    } else if (profileNonce.isNegative) {
      return "Profile nonce can't be negative";
    }

    return "Invalid profile";
  }
}

class FetchIdentityStateException extends PolygonIdSDKException {
  FetchIdentityStateException({required super.errorMessage, super.error});
}

class FetchStateRootsException extends PolygonIdSDKException {
  FetchStateRootsException({required super.errorMessage, super.error});
}

class NonRevProofException extends PolygonIdSDKException {
  NonRevProofException({required super.errorMessage, super.error});
}

class DidNotMatchCurrentEnvException extends PolygonIdSDKException {
  final String did;
  final String rightDid;

  DidNotMatchCurrentEnvException({
    required this.did,
    required this.rightDid,
    required super.errorMessage,
    super.error,
  });
}
