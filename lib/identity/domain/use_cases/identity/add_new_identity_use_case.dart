import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';

class AddNewIdentityParam {
  final String? seed;
  final String? privateKey;

  AddNewIdentityParam._({
    this.seed,
    this.privateKey,
  });

  AddNewIdentityParam.seed(String? seed) : this._(seed: seed);

  AddNewIdentityParam.privateKey(String privateKey)
      : this._(privateKey: privateKey);
}

class AddNewIdentityUseCase
    extends FutureUseCase<AddNewIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final AddIdentityUseCase _addIdentityUseCase;
  final StacktraceManager _stacktraceManager;

  AddNewIdentityUseCase(
    this._identityRepository,
    this._addIdentityUseCase,
    this._stacktraceManager,
  );

  @override
  Future<PrivateIdentityEntity> execute({
    required AddNewIdentityParam param,
  }) async {
    return Future(() async {
      final String privateKey;
      if (param.privateKey != null) {
        privateKey = param.privateKey!;
      } else {
        privateKey = await _identityRepository.getPrivateKey(
          secret: param.seed,
        );
      }

      final publicKeys = _identityRepository.getPublicKeys(
        bjjPrivateKey: privateKey,
      );
      final identity = await _addIdentityUseCase.execute(
        param: AddIdentityParam(
          bjjPublicKey: publicKeys,
          encryptionKey: privateKey,
        ),
      );

      _stacktraceManager.logTrace(
          "[AddNewIdentityUseCase] New Identity created and saved with did: ${identity.did}, for key $param");

      return PrivateIdentityEntity(
        did: identity.did,
        publicKey: identity.publicKey,
        profiles: identity.profiles,
        privateKey: privateKey,
      );
    }).catchError((error) {
      _stacktraceManager.logError("[AddNewIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
