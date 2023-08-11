import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetClaimsParam {
  final List<FilterEntity>? filters;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  GetClaimsParam({
    this.filters,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class GetClaimsUseCase
    extends FutureUseCase<GetClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final StacktraceStreamManager _stacktraceStreamManager;

  GetClaimsUseCase(
    this._credentialRepository,
    this._getCurrentEnvDidIdentifierUseCase,
    this._getIdentityUseCase,
    this._stacktraceStreamManager,
  );

  @override
  Future<List<ClaimEntity>> execute({required GetClaimsParam param}) async {
    // if profileNonce is zero, return all profiles credentials,
    // if profileNonce > 0 then return only credentials from that profile
    if (param.profileNonce >= GENESIS_PROFILE_NONCE) {
      // TODO check param.did and did from profile nonce are the same or return exception
      String did = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: param.profileNonce));
      return _credentialRepository
          .getClaims(
              filters: param.filters,
              genesisDid: param.genesisDid,
              privateKey: param.privateKey)
          .then((claims) {
        logger().i("[GetClaimsUseCase] Claims: $claims");
        _stacktraceStreamManager.addTrace("[GetClaimsUseCase] Claims: $claims");
        return claims;
      }).catchError((error) {
        _stacktraceStreamManager.addTrace("[GetClaimsUseCase] Error: $error");
        _stacktraceStreamManager.addError("[GetClaimsUseCase] Error: $error");
        logger().e("[GetClaimsUseCase] Error: $error");
        throw error;
      });
    } else {
      _stacktraceStreamManager.addTrace(
          "[GetClaimsUseCase] Invalid profile nonce: ${param.profileNonce}");
      _stacktraceStreamManager.addError(
          "[GetClaimsUseCase] Invalid profile nonce: ${param.profileNonce}");
      throw InvalidProfileException(param.profileNonce);
    }
  }
}
