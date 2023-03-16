import '../../../../common/domain/error_exception.dart';

class IdentityException extends ErrorException {
  IdentityException(error) : super(error);
}

class TooLongPrivateKeyException implements Exception {}

class IdentityAlreadyExistsException implements Exception {
  final String did;

  IdentityAlreadyExistsException(this.did);
}

class ProfileAlreadyExistsException implements Exception {
  final String genesisDid;
  final int profileNonce;

  ProfileAlreadyExistsException(this.genesisDid, this.profileNonce);
}

class UnknownProfileException implements Exception {
  final int profileNonce;

  UnknownProfileException(this.profileNonce);
}

class UnknownIdentityException implements Exception {
  final String did;

  UnknownIdentityException(this.did);
}

class InvalidPrivateKeyException implements Exception {
  final String privateKey;

  InvalidPrivateKeyException(this.privateKey);
}

class InvalidProfileException extends ErrorException {
  final int profileNonce;

  InvalidProfileException(this.profileNonce, error)
      : super(() {
          if (profileNonce == 0) {
            return "Genesis profile can't be modified";
          } else if (profileNonce < 0) {
            return "Profile nonce can't be negative";
          }

          return "Invalid profile";
        });
}

class FetchIdentityStateException extends ErrorException {
  FetchIdentityStateException(error) : super(error);
}

class FetchStateRootsException extends ErrorException {
  FetchStateRootsException(error) : super(error);
}

class NonRevProofException extends ErrorException {
  NonRevProofException(error) : super(error);
}
