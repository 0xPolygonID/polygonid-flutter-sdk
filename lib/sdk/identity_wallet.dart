import 'package:injectable/injectable.dart';

import '../identity/domain/entities/identity_entity.dart';
import '../identity/domain/entities/private_identity_entity.dart';
import '../identity/domain/use_cases/create_identity_use_case.dart';
import '../identity/domain/use_cases/fetch_identity_state_use_case.dart';
import '../identity/domain/use_cases/get_identifier_use_case.dart';
import '../identity/domain/use_cases/get_identity_use_case.dart';
import '../identity/domain/use_cases/remove_identity_use_case.dart';
import '../identity/domain/use_cases/sign_message_use_case.dart';

abstract class PolygonIdSdkIdentity {
  /// Create and store an [IdentityEntity] from a secret
  /// if it doesn't exist already in the Polygon ID Sdk.
  /// If [secret] is omitted or null, a random one will be used to create a new identity.
  /// Return an identifier and a bjj private key as a Pair<String,String>.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Identifier is the unique id of the identity
  ///
  /// bjj Private Key is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<PrivateIdentityEntity> createIdentity({String? secret});

  /// Get an [IdentityEntity] from a secret
  /// if it already exist in the Polygon ID Sdk.
  /// Return an identifier and a bjj private key as a Pair<String,String>.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Identifier is the unique id of the identity
  ///
  /// bjj Private Key is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<IdentityEntity> getIdentity(String secret);

  /// Get a list of identifiers associated to the identities stored in the Polygon ID Sdk.
  /// Return an list of identifiers as a String.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Identifier is the unique id of the identity
  ///
  Future<List<String>> getIdentities();
}

@injectable
class IdentityWallet {
  final CreateIdentityUseCase _createIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final RemoveIdentityUseCase _removeIdentityUseCase;
  final GetIdentifierUseCase _getIdentifierUseCase;
  final SignMessageUseCase _signMessageUseCase;

  // TODO: remove
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;

  IdentityWallet(
    this._createIdentityUseCase,
    this._getIdentityUseCase,
    this._removeIdentityUseCase,
    this._getIdentifierUseCase,
    this._signMessageUseCase,
    this._fetchIdentityStateUseCase,
  );

  /// Create and store an [IdentityEntity] from a secret
  /// if it doesn't exist already in the Polygon ID Sdk.
  /// If [secret] is omitted or null, a random one will be used to create a new identity.
  /// Return an identity as a IdentityEntity.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<PrivateIdentityEntity> createIdentity(
      {String? secret,
      bool isStored = true,
      bool replaceStored = false}) async {
    return _createIdentityUseCase.execute(
        param: CreateIdentityParam(
      secret: secret,
      isStored: isStored,
      replaceStored: replaceStored,
    ));
  }

  /// Get an [IdentityEntity] from a private key.
  /// If [privateKey] is omitted or null, a random one will be used to create a new identity.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the private key is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  ///
  Future<IdentityEntity> getIdentity(
      {required String identifier, String? privateKey}) async {
    return _getIdentityUseCase.execute(
        param:
            GetIdentityParam(identifier: identifier, privateKey: privateKey));
  }

  /// Remove the identity associated with the identifier
  /// (stored when creating an identity via [createIdentity]).
  Future<void> removeIdentity(
      {required String identifier, required String privateKey}) {
    return _removeIdentityUseCase.execute(
        param: RemoveIdentityParam(
            identifier: identifier, privateKey: privateKey));
  }

  /// Sign a message through a privateKey.
  /// The [privateKey] is a string
  /// and [message] is the message to sign. Returns a string representing the signature.
  Future<String> sign(
      {required String privateKey, required String message}) async {
    return _signMessageUseCase.execute(
        param: SignMessageParam(privateKey, message));
  }

  /// Returns the identifier from derived from a privateKey
  Future<String> getIdentifier({required String privateKey}) {
    return _getIdentifierUseCase.execute(
        param: GetIdentifierParam(
      privateKey: privateKey,
    ));
  }

  Future<String> fetchIdentityState(String id) {
    return _fetchIdentityStateUseCase.execute(param: id);
  }
}
