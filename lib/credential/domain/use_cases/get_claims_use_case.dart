import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetClaimsParam {
  final List<FilterEntity>? filters;
  final String did;
  final BigInt profileNonce;
  final String privateKey;

  GetClaimsParam({
    this.filters,
    required this.did,
    required this.profileNonce,
    required this.privateKey,
  });
}

class GetClaimsUseCase
    extends FutureUseCase<GetClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetClaimsUseCase(this._credentialRepository,
      this._getCurrentEnvDidIdentifierUseCase, this._getIdentityUseCase);

  @override
  Future<List<ClaimEntity>> execute({required GetClaimsParam param}) async {
    // if profileNonce is zero, return all profiles credentials,
    // if profileNonce > 0 then return only credentials from that profile
    if (param.profileNonce >= GENESIS_PROFILE_NONCE) {
      // TODO check param.did and did from profile nonce are the same or return exception
      String did = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: param.profileNonce));
      if (param.profileNonce > GENESIS_PROFILE_NONCE) {
        return _credentialRepository
            .getClaims(
                filters: param.filters, did: did, privateKey: param.privateKey)
            .then((claims) {
          logger().i("[GetClaimsUseCase] Claims: $claims");
          return claims;
        }).catchError((error) {
          logger().e("[GetClaimsUseCase] Error: $error");
          throw error;
        });
      } else {
        var identityEntity = await _getIdentityUseCase.execute(
            param: GetIdentityParam(
                genesisDid: did, privateKey: param.privateKey));
        List<ClaimEntity> result = [];
        for (var profileDid in identityEntity.profiles.values) {
          List<ClaimEntity> didClaims = await _credentialRepository
              .getClaims(
                  filters: param.filters,
                  did: profileDid,
                  privateKey: param.privateKey)
              .then((claims) {
            logger().i("[GetClaimsUseCase] Claims: $claims");
            return claims;
          }).catchError((error) {
            logger().e("[GetClaimsUseCase] Error: $error");
            throw error;
          });
          result.addAll(didClaims);
        }
        return result;
      }
    } else {
      throw InvalidProfileException(param.profileNonce);
    }
  }
}
