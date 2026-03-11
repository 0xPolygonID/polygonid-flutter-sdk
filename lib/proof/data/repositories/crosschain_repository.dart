import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/crosschain_resolver_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/universal_resolver_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/repositories/auth_inputs_unmarshaller.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/generate_inputs_response.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

typedef MessageWithSignature = ({BaseEIP712Message message, String signature});

@injectable
class CrosschainRepository {
  final ResolverDataSource _crosschainDataSource;
  final IdentityRepository _identityRepository;

  CrosschainRepository(this._crosschainDataSource, this._identityRepository);

  Future<List<MessageWithSignature>> getCrosschainStatesWithSignatures({
    required String universalResolverUrl,
    required List<PublicStatesInfo> stateInfo,
  }) async {
    final requests = <Future<List<ResolverResponse>>>[];
    for (final publicStatesInfo in stateInfo) {
      requests.add(
        _getCrosschainStates(
          universalResolverUrl: universalResolverUrl,
          publicStatesInfo: publicStatesInfo,
        ),
      );
    }

    final responses = await Future.wait(requests);

    final statesWithSignatures = responses
        .fold(<ResolverResponse>[], (a, b) => [...a, ...b])
        .where((m) => m.didResolutionMetadata.proof != null)
        .map((m) {
          final proof = m.didResolutionMetadata.proof!.first;
          return (message: proof.eip712.message, signature: proof.proofValue);
        })
        .toList();

    return statesWithSignatures;
  }

  Future<List<ResolverResponse>> _getCrosschainStates({
    required String universalResolverUrl,
    required PublicStatesInfo publicStatesInfo,
  }) async {
    final responses = <ResolverResponse>[];

    for (final state in publicStatesInfo.states) {
      final didDescription = await _identityRepository.describeId(
        id: BigInt.parse(state.id),
      );

      await _crosschainDataSource.getDidResolution(
        universalResolverUrl: universalResolverUrl,
        did: didDescription.did,
        state: state.state,
      );
    }

    for (final gistState in publicStatesInfo.gists) {
      final didDescription = await _identityRepository.describeId(
        id: BigInt.parse(gistState.id),
      );

      await _crosschainDataSource.getDidResolution(
        universalResolverUrl: universalResolverUrl,
        did: didDescription.did,
        gist: gistState.root,
      );
    }

    return responses;
  }

  Future<List<MessageWithSignature>>
  getCrosschainStatesWithSignaturesForProofs({
    required String universalResolverUrl,
    required List<Iden3commProofEntity> proofs,
    required EnvConfigEntity config,
  }) async {
    final universalResolverParams = proofs.map((proof) {
      return AuthInputsParser.toUniversalResolverParam(
        proof.circuitId,
        proof.pubSignals,
      );
    }).toList();

    final result = <MessageWithSignature>[];
    for (final param in universalResolverParams) {
      final issuerDid = (await _identityRepository.describeId(
        id: param.issuerID,
      )).did;

      final issuerState = await _getIssuerState(
        universalResolverUrl: universalResolverUrl,
        param: param,
        issuerDid: issuerDid,
      );

      final issuerStateAfterAddingCredential =
          await _getIssuerStateAfterAddingCredential(
            universalResolverUrl: universalResolverUrl,
            param: param,
            issuerDid: issuerDid,
          );

      final userState = await _getUserState(
        universalResolverUrl: universalResolverUrl,
        param: param,
        config: config,
      );

      result.addAll([
        if (issuerState != null) issuerState,
        if (issuerStateAfterAddingCredential != null)
          issuerStateAfterAddingCredential,
        if (userState != null) userState,
      ]);
    }

    return result;
  }

  Future<MessageWithSignature?> _getIssuerState({
    required String universalResolverUrl,
    required UniversalResolverParam param,
    required String issuerDid,
  }) async {
    final nonRevStateBytes = Uint8ArrayUtils.bigIntToBytes(
      param.issuerClaimNonRevState,
    );

    final didResolutionIssuer = await _crosschainDataSource.getDidResolution(
      universalResolverUrl: universalResolverUrl,
      did: issuerDid,
      state: nonRevStateBytes.bytesToHex(),
    );

    final didResolutionIssuerProof =
        didResolutionIssuer.didResolutionMetadata.proof?.firstOrNull;
    if (didResolutionIssuerProof == null) {
      return null;
    }

    return (
      message: didResolutionIssuerProof.eip712.message,
      signature: didResolutionIssuerProof.proofValue,
    );
  }

  Future<MessageWithSignature?> _getIssuerStateAfterAddingCredential({
    required String universalResolverUrl,
    required UniversalResolverParam param,
    required String issuerDid,
  }) async {
    final stateBytes = Uint8ArrayUtils.bigIntToBytes(param.issuerState);

    final didResolutionIssuerAfterAddingCredential = await _crosschainDataSource
        .getDidResolution(
          universalResolverUrl: universalResolverUrl,
          did: issuerDid,
          state: stateBytes.bytesToHex(),
        );

    final didResolutionIssuerAfterAddingCredentialProof =
        didResolutionIssuerAfterAddingCredential
            .didResolutionMetadata
            .proof
            ?.firstOrNull;
    if (didResolutionIssuerAfterAddingCredentialProof == null) {
      return null;
    }

    return (
      message: didResolutionIssuerAfterAddingCredentialProof.eip712.message,
      signature: didResolutionIssuerAfterAddingCredentialProof.proofValue,
    );
  }

  Future<MessageWithSignature?> _getUserState({
    required String universalResolverUrl,
    required UniversalResolverParam param,
    required EnvConfigEntity config,
  }) async {
    final userId = param.userID;
    final didDescription = await _identityRepository.describeId(id: userId);
    final didEntity = await PolygonIdSdk.I.identity.getDidEntity(
      did: didDescription.did,
    );

    final emptyDid = await _getDIDEmptyState(
      _identityRepository,
      didEntity,
      config,
    );

    final didResolutionUser = await _crosschainDataSource.getDidResolution(
      universalResolverUrl: universalResolverUrl,
      did: emptyDid,
      gist: param.gistRoot.toRadixString(16).padLeft(64, '0'),
    );

    final didResolutionUserProof =
        didResolutionUser.didResolutionMetadata.proof?.firstOrNull;
    if (didResolutionUserProof == null) {
      return null;
    }

    return (
      message: didResolutionUserProof.eip712.message,
      signature: didResolutionUserProof.proofValue,
    );
  }

  Future<String> _getDIDEmptyState(
    IdentityRepository identityRepo,
    DidEntity didEntity,
    EnvConfigEntity config,
  ) async {
    final didIdentifier = await identityRepo.getDidIdentifier(
      blockchain: didEntity.blockchain,
      network: didEntity.network,
      method: didEntity.method,
      claimsRoot: "0",
      profileNonce: BigInt.zero,
      config: config,
    );

    logger().i("DID Empty State: $didIdentifier");

    return didIdentifier;
  }
}
