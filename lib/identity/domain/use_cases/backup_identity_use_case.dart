import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'create_and_save_identity_use_case.dart';
import 'export_identity_use_case.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';
import 'get_identity_use_case.dart';
import 'import_identity_use_case.dart';

class BackupIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;

  BackupIdentityParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
  });
}

class BackupIdentityUseCase
    extends FutureUseCase<BackupIdentityParam, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final ExportIdentityUseCase _exportIdentityUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._exportIdentityUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<Map<int, String>> execute({required BackupIdentityParam param}) async {
    try {
      Map<int, String> result = {};
      String genesisDid = await _getDidIdentifierUseCase.execute(
          param: GetDidIdentifierParam(
        privateKey: param.privateKey,
        blockchain: param.blockchain,
        network: param.network,
      ));

      IdentityEntity identity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
        did: genesisDid,
      ));

      identity.profiles.forEach((profileNonce, profileDid) async {
        result[profileNonce] = await _exportIdentityUseCase.execute(
            param: ExportIdentityParam(
          privateKey: param.privateKey,
          did: profileDid,
        ));
      });

      logger().i(
          "[BackupIdentityUseCase] Identity backed up with did: ${identity.did}, for key $param");
      return result;
    } catch (error) {
      logger().e("[BackupIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
