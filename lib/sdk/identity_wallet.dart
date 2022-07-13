import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/use_cases/get_identity_use_case.dart';

import '../domain/identity/use_cases/sign_message_use_case.dart';

@injectable
class IdentityWallet {
  final GetIdentityUseCase _getIdentityUseCase;
  final SignMessageUseCase _signMessageUseCase;

  IdentityWallet(this._getIdentityUseCase, this._signMessageUseCase);

  /// Get an [Identity] from a private key.
  /// If [privateKey] is ommited or null, a random one will be used to create a new identity.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// Be aware the private key is internally converted to a 32 length bytes array
  /// in order to be compatible with the SDK. The following rules will be applied:
  /// - If the byte array is not 32 length, it will be padded with 0s.
  /// - If the byte array is longer than 32, an exception will be thrown.
  Future<Identity> createIdentity({String? privateKey}) async {
    return _getIdentityUseCase.execute(param: privateKey);
  }

  /// Sign a message with a private key and return the signature.
  /// Throws [IdentityException] if an error occurs.
  ///
  /// The private key is internally converted to a 32 length bytes array with the
  /// same rules as in [createIdentity].
  Future<String> sign(
      {required String privateKey, required String message}) async {
    return _signMessageUseCase.execute(
        param: SignMessageParam(privateKey, message));
  }
}
