import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class AddNewIdentityUseCase
    extends FutureUseCase<String?, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final AddIdentityUseCase _addIdentityUseCase;
  final StacktraceManager _stacktraceManager;

  AddNewIdentityUseCase(
    this._identityRepository,
    this._addIdentityUseCase,
    this._stacktraceManager,
  );

  @override
  Future<PrivateIdentityEntity> execute({String? param}) {
    // Get the privateKey
    return _identityRepository
        .getPrivateKey(secret: param)
        // Create and save the identity
        .then((privateKey) => _addIdentityUseCase.execute(
            param: AddIdentityParam(privateKey: privateKey)))
        .then((identity) {
      logger().i(
          "[AddNewIdentityUseCase] New Identity created and saved with did: ${identity.did}, for key $param");
      _stacktraceManager.addTrace(
          "[AddNewIdentityUseCase] New Identity created and saved with did: ${identity.did}, for key $param");

      return identity;
    }).catchError((error) {
      logger().e("[AddNewIdentityUseCase] Error: $error");
      _stacktraceManager.addTrace("[AddNewIdentityUseCase] Error: $error");
      _stacktraceManager.addError("[AddNewIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
