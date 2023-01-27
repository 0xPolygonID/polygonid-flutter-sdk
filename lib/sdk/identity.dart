import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';

import '../identity/domain/entities/identity_entity.dart';
import '../identity/domain/entities/private_identity_entity.dart';
import '../identity/domain/use_cases/check_identity_validity_use_case.dart';
import '../identity/domain/use_cases/fetch_identity_state_use_case.dart';
import '../identity/domain/use_cases/get_did_identifier_use_case.dart';
import '../identity/domain/use_cases/get_identity_use_case.dart';
import '../identity/domain/use_cases/remove_identity_use_case.dart';
import '../identity/domain/use_cases/sign_message_use_case.dart';

abstract class PolygonIdSdkIdentity {
  /// Creates and stores an [IdentityEntity] from a secret
  /// if it doesn't exist already in the Polygon ID Sdk.
  /// If [secret] is omitted or null, a random one will be used to create a new identity.
  /// Return an identity as a [PrivateIdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<PrivateIdentityEntity> createIdentity(
      {String? secret, required blockchain, required network});

  /// Restores an [IdentityEntity] from a secret and an encrypted backup database
  /// associated to the identity
  /// Return an identity as a [PrivateIdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<PrivateIdentityEntity> restoreIdentity(
      {required String secret, required String encryptedIdentityDb});

  /// Gets an [IdentityEntity] from an identifier.
  /// Returns an identity as a [PrivateIdentityEntity] or [IdentityEntity]
  /// if privateKey is ommited or invalid.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The Identity's [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<IdentityEntity> getIdentity({required String did, String? privateKey});

  /// Get a list of public info of [IdentityEntity] associated to the identities stored in the Polygon ID Sdk.
  /// Return an list of [IdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  Future<List<IdentityEntity>> getIdentities();

  /// Remove the previously stored identity associated with the identifier
  ///
  /// the [did] is the unique id of the identity
  ///
  /// Identity [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  ///
  /// Throws [IdentityException] if an error occurs.
  Future<void> removeIdentity(
      {required String did, required String privateKey});

  /// Returns the identifier derived from a privateKey
  ///
  /// The Identity's [publicKey]
  Future<String> getDidIdentifier({
    required String privateKey,
    required String blockchain,
    required String network,
  });

  /// Returns the identity state from a did
  ///
  /// The [did] is the unique id of the identity
  Future<String> getState(String did);

  /// Updates the identity state
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The Identity's [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  Future<void> updateState({
    required String state,
    required String did,
    required String privateKey,
  });

  /// Sign a message through a identity's private key.
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  /// and [message] is the message to sign. Returns a string representing the signature.
  Future<String> sign({required String privateKey, required String message});

  // Profiles
  Future<void> addProfile(
      {required String privateKey, required int profileNonce});

  Future<void> removeProfile(
      {required String privateKey, required int profileNonce});

  Future<List<int>> getProfiles({required String privateKey});
}

@injectable
class Identity implements PolygonIdSdkIdentity {
  final CheckIdentityValidityUseCase _checkIdentityValidityUseCase;
  final CreateAndSaveIdentityUseCase _createAndSaveIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  //final GetIdentitiesUseCase _getIdentitiesUseCase;
  final RemoveIdentityUseCase _removeIdentityUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;

  Identity(
    this._checkIdentityValidityUseCase,
    this._createAndSaveIdentityUseCase,
    this._getIdentityUseCase,
    this._removeIdentityUseCase,
    this._getDidIdentifierUseCase,
    this._signMessageUseCase,
    this._fetchIdentityStateUseCase,
);

  Future<void> checkIdentityValidity(
      {required String secret, required blockchain, required network}) async {
    return _checkIdentityValidityUseCase.execute(
        param: CheckIdentityValidityParam(
            secret: secret, blockchain: blockchain, network: network));
  }

  /// Creates and store an [IdentityEntity] from a secret
  /// if it doesn't exist already in the Polygon ID Sdk.
  /// If [secret] is omitted or null, a random one will be used to create a new identity.
  /// Return an identity as a [PrivateIdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<PrivateIdentityEntity> createIdentity(
      {String? secret, required blockchain, required network}) async {
    return _createAndSaveIdentityUseCase.execute(
        param: CreateAndSaveIdentityParam(
            blockchain: blockchain, network: network, secret: secret));
  }

  /// Restores an [IdentityEntity] from a secret and an encrypted backup database
  /// associated to the identity
  /// Return an identity as a [PrivateIdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the secret is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  @override
  Future<PrivateIdentityEntity> restoreIdentity(
      {required String secret, required String encryptedIdentityDb}) {
    // TODO: implement restoreIdentity
    throw UnknownIdentityException("");
  }

  /// Gets an [IdentityEntity] from an identifier.
  /// Returns an identity as a [PrivateIdentityEntity] or [IdentityEntity] if privateKey is ommited or invalid.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the private key is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  @override
  Future<IdentityEntity> getIdentity(
      {required String did, String? privateKey}) async {
    return _getIdentityUseCase.execute(
        param: GetIdentityParam(did: did, privateKey: privateKey));
  }

  /// Get a list of public info of [IdentityEntity] associated to the identities stored in the Polygon ID Sdk.
  /// Return an list of [IdentityEntity].
  /// Throws [IdentityException] if an error occurs.
  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }

  /// Remove the previously stored identity associated with the identifier
  ///
  /// the [did] is the unique id of the identity
  ///
  /// Identity [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  ///
  /// Throws [IdentityException] if an error occurs.
  @override
  Future<void> removeIdentity(
      {required String did, required String privateKey}) {
    return _removeIdentityUseCase.execute(
        param: RemoveIdentityParam(did: did, privateKey: privateKey));
  }

  /// Sign a message through a identity's private key.
  /// The [privateKey] is a string
  /// and [message] is the message to sign. Returns a string representing the signature.
  @override
  Future<String> sign(
      {required String privateKey, required String message}) async {
    return _signMessageUseCase.execute(
        param: SignMessageParam(privateKey, message));
  }

  /// Returns the did derived from a publicKey
  ///
  /// The Identity's [privateKey]
  @override
  Future<String> getDidIdentifier(
      {required String privateKey,
      required String blockchain,
      required String network}) {
    return _getDidIdentifierUseCase.execute(
        param: GetDidIdentifierParam(
      privateKey: privateKey,
      blockchain: blockchain,
      network: network,
    ));
  }

  /// Returns the identity state from a did
  ///
  /// The [did] is the unique id of the identity
  @override
  Future<String> getState(String did) {
    return _fetchIdentityStateUseCase.execute(param: did);
  }

  /// Updates the identity state
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The Identity's [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  /// using the claims associated to the identity
  @override
  Future<void> updateState(
      {required String state,
      required String did,
      required String privateKey}) {
    // TODO: implement updateState
    throw UnimplementedError();
  }

  /// Profile
  @override
  Future<void> addProfile(
      {required String privateKey, required int profileNonce}) {
    // TODO: implement addProfile
    throw UnimplementedError();
  }

  @override
  Future<List<int>> getProfiles({required String privateKey}) {
    // TODO: implement getProfiles
    throw UnimplementedError();
  }

  @override
  Future<void> removeProfile(
      {required String privateKey, required int profileNonce}) {
    // TODO: implement removeProfile
    throw UnimplementedError();
  }
}
