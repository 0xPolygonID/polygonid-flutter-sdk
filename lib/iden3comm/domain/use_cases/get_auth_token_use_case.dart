import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../constants.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../identity/data/mappers/did_mapper.dart';
import '../../../identity/domain/entities/node_entity.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../identity/domain/repositories/smt_repository.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';
import '../../../proof/domain/entities/gist_proof_entity.dart';
import '../../../proof/domain/entities/proof_entity.dart';
import '../../../proof/domain/repositories/proof_repository.dart';
import '../../../proof/domain/use_cases/get_gist_proof_use_case.dart';
import '../repositories/iden3comm_repository.dart';

class GetAuthTokenParam {
  final String did;
  final int profileNonce;
  final String privateKey;
  final String message;

  GetAuthTokenParam(
    this.did,
    this.profileNonce,
    this.privateKey,
    this.message,
  );
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final Iden3commRepository _iden3commRepository;
  final CredentialRepository _credentialRepository;
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final DidMapper _didMapper;
  final GetGistProofUseCase _getGistProofUseCase;

  GetAuthTokenUseCase(
      this._iden3commRepository,
      this._proofRepository,
      this._credentialRepository,
      this._identityRepository,
      this._smtRepository,
      this._didMapper,
      this._getGistProofUseCase);

  @override
  Future<String> execute({required GetAuthTokenParam param}) async {
    var identityEntity = await _identityRepository.getPrivateIdentity(
        did: param.did, privateKey: param.privateKey);

    CircuitDataEntity authData =
        await _proofRepository.loadCircuitFiles("authV2");
    List<String> authClaimChildren = await _credentialRepository.getAuthClaim(
        publicKey: identityEntity.publicKey);
    NodeEntity authClaimNode =
        await _identityRepository.getAuthClaimNode(children: authClaimChildren);

    ProofEntity incProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        storeName: claimsTreeStoreName,
        identifier: param.did,
        privateKey: param.privateKey);

    ProofEntity nonRevProof = await _smtRepository.generateProof(
        key: authClaimNode.hash,
        storeName: revocationTreeStoreName,
        identifier: param.did,
        privateKey: param.privateKey);

    // hash of clatr, revtr, rootr
    Map<String, dynamic> treeState = await _identityRepository.getLatestState(
        did: param.did, privateKey: param.privateKey);

    var didMap = _didMapper.mapFrom(param.did);
    String idBigInt =
        await _identityRepository.convertIdToBigInt(id: didMap.identifier);

    GistProofEntity gistProof =
        await _getGistProofUseCase.execute(param: idBigInt);

    return _iden3commRepository
        .getAuthToken(
      identity: identityEntity,
      profileNonce: param.profileNonce,
      authClaim: authClaimChildren,
      authData: authData,
      incProof: incProof,
      nonRevProof: nonRevProof,
      gistProof: gistProof,
      treeState: treeState,
      message: param.message,
    )
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Auth token: $token");

      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");

      throw error;
    });
  }
}
