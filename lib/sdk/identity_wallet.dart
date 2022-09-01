import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/authenticate_use_case.dart';

import '../identity/domain/entities/identity_entity.dart';
import '../identity/domain/use_cases/create_identity_use_case.dart';
import '../identity/domain/use_cases/get_auth_token_use_case.dart';
import '../identity/domain/use_cases/get_current_identifier_use_case.dart';
import '../identity/domain/use_cases/get_identity_use_case.dart';
import '../identity/domain/use_cases/remove_current_identity_use_case.dart';
import '../identity/domain/use_cases/sign_message_use_case.dart';
import '../proof_generation/domain/entities/circuit_data_entity.dart';

@injectable
class IdentityWallet {
  final CreateIdentityUseCase _createIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetCurrentIdentifierUseCase _getCurrentIdentifierUseCase;
  final RemoveCurrentIdentityUseCase _removeCurrentIdentityUseCase;
  final AuthenticateUseCase _authenticateUseCase;

  IdentityWallet(this._createIdentityUseCase,
      this._getIdentityUseCase,
      this._signMessageUseCase,
      this._getAuthTokenUseCase,
      this._getCurrentIdentifierUseCase,
      this._removeCurrentIdentityUseCase,
      this._authenticateUseCase,);

  /// Create and store an [IdentityEntity] from a private key.
  /// If [privateKey] is omitted or null, a random one will be used to create a new identity.
  /// Return an identifier as a String.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the private key is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<String> createIdentity({String? privateKey}) async {
    return _createIdentityUseCase.execute(param: privateKey);
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
  /// TODO: to be removed to not expose sensitive information
  /// (here for back compatibility).
  Future<IdentityEntity> getIdentity({String? privateKey}) async {
    return _getIdentityUseCase.execute(param: privateKey);
  }

  /// Sign a message through an identifier.
  /// The [identifier] is a string returned when creating an identity with [createIdentity]
  /// and [message] is the message to sign. Returns a string representing the signature.
  Future<String> sign(
      {required String identifier, required String message}) async {
    return _signMessageUseCase.execute(
        param: SignMessageParam(identifier, message));
  }

  /// Get a string auth token through an identifier
  /// The [identifier] is a string returned when creating an identity with [createIdentity]
  /// and [circuitData] describes data about the used circuit, see [CircuitDataEntity].
  /// [message] will be fully integrated on the resulting encoded string (follow JWZ standard).
  /// See [JWZ].
  Future<String> getAuthToken(
      {required String identifier,
      required CircuitDataEntity circuitData,
      required String message}) {
    return _getAuthTokenUseCase.execute(
        param: GetAuthTokenParam(identifier, circuitData, message));
  }

  /// As the SDK support only one identity for the moment, we return the last
  /// known identifier (stored when creating an identity via [createIdentity]).
  Future<String?> getCurrentIdentifier() {
    return _getCurrentIdentifierUseCase.execute();
  }

  /// As the SDK support only one identity for the moment, we remove the identity
  /// associated with the last known identifier (stored when creating
  /// an identity via [createIdentity]).
  Future<void> removeCurrentIdentity() {
    return _removeCurrentIdentityUseCase.execute();
  }


  ///AUTHENTICATION
  /// get iden3message from qr code and transform it as string "message" #3 through _getAuthMessage(data)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  Future<bool> authenticate({required String scannedAuthQrCode, required CircuitDataEntity circuitDataEntity}) {
    return _authenticateUseCase.execute(param: AuthenticateParam(authQrCodeResult: scannedAuthQrCode, circuitDataEntity: circuitDataEntity));
  }
}
