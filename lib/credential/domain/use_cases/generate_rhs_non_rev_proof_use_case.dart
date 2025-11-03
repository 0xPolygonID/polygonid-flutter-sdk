import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart';

class GenerateRHSNonRevProofParam {
  final CredentialEntity claim;
  final Map<String, dynamic>? nonRevProof;

  GenerateRHSNonRevProofParam({required this.claim, this.nonRevProof});
}

class GenerateRHSNonRevProofUseCase
    extends FutureUseCase<GenerateRHSNonRevProofParam, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;
  final CredentialMapper _credentialMapper;
  final StacktraceManager _stacktraceManager;

  GenerateRHSNonRevProofUseCase(
    this._identityRepository,
    this._credentialRepository,
    this._fetchIdentityStateUseCase,
    this._credentialMapper,
    this._stacktraceManager,
  );

  @override
  Future<Map<String, dynamic>> execute({
    required GenerateRHSNonRevProofParam param,
  }) async {
    try {
      final issuerId = await _credentialRepository.getIssuerIdentifier(
        claim: param.claim,
      );
      final identityState = await _fetchIdentityStateUseCase.execute(
        param: issuerId,
      );

      final existingNonRevProof = param.nonRevProof;
      if (existingNonRevProof != null &&
          existingNonRevProof.isNotEmpty &&
          identityState == existingNonRevProof["issuer"]["state"]) {
        _stacktraceManager.addTrace(
          "[GenerateNonRevProofUseCase] Non rev proof",
        );
        return param.nonRevProof!;
      }

      final credential = _credentialMapper.mapTo(param.claim);

      final nonceAndUrl = await Future.wait<dynamic>([
        _credentialRepository.getRevocationNonce(credential: credential),
        _credentialRepository.getRevocationUrl(credential: credential),
      ]);
      final nonce = BigInt.from(nonceAndUrl[0]);
      final baseUrl = nonceAndUrl[1] as String;

      final nonRevProof = await _identityRepository.getRHSNonRevProof(
        identityState: identityState,
        nonce: nonce,
        baseUrl: baseUrl,
        cachedNonRevProof: param.nonRevProof,
      );
      _stacktraceManager.logTrace("[GenerateNonRevProofUseCase] Non rev proof");

      return nonRevProof;
    } catch (error) {
      _stacktraceManager.logError("[GenerateNonRevProofUseCase] Error: $error");
      rethrow;
    }
  }
}
