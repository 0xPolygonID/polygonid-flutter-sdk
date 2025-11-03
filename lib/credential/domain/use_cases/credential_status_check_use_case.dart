import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

class CredentialStatusCheckUseCase
    extends FutureUseCase<CredentialEntity, bool> {
  final LibPolygonIdCoreCredentialDataSource _credentialDS;
  final CredentialMapper _credentialMapper;

  CredentialStatusCheckUseCase(this._credentialDS, this._credentialMapper);

  @override
  Future<bool> execute({required CredentialEntity param}) async {
    final credential = _credentialMapper.mapTo(param);

    return _credentialDS.credentialStatusCheck(
      issuerDid: param.issuer,
      profileDid: param.did,
      credentialStatus: credential.info.credentialStatus.toJson(),
    );
  }
}
