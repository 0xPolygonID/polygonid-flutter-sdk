import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/kms/index.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';

@injectable
class AddEthIdentity {
  final IdentityRepository _identityRepository;
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final CreateIdentityStateUseCase _createIdentityStateUseCase;
  final StacktraceManager _stacktraceManager;

  AddEthIdentity(
    this._identityRepository,
    this._getSelectedChainUseCase,
    this._getEnvUseCase,
    this._createIdentityStateUseCase,
    this._stacktraceManager,
  );

  Future<IdentityEntity> addEthIdentity({
    required Secp256k1PublicKey ethPublicKey,
    required BjjPublicKey? bjjPublicKey,
    required String encryptionKey,
  }) async {
    final ethAddress = ethPublicKey.toEthAddress();

    final selectedChain = await _getSelectedChainUseCase.execute();
    final env = await _getEnvUseCase.execute();

    final genesisDid = await _getDid(
      ethAddress: ethAddress,
      chain: selectedChain,
      config: env.config,
    );

    IdentityEntity identity = IdentityEntity(
      did: genesisDid,
      publicKey: bjjPublicKey?.p.map((p) => p.toString()).toList() ?? [],
      type: IdentityType.ethereum,
      profiles: {
        GENESIS_PROFILE_NONCE: genesisDid,
      },
    );

    try {
      // Check if identity is already stored (already added)
      await _identityRepository.getIdentity(genesisDid: identity.did);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(
        did: identity.did,
        errorMessage: "Identity already exists with did: ${identity.did}",
      );
    } on UnknownIdentityException {
      // If identity doesn't exist, we save it
      await _identityRepository.storeIdentity(identity: identity);

      if (bjjPublicKey != null) {
        // create identity state for each profile did
        for (String profileDid in identity.profiles.values) {
          await _createIdentityStateUseCase.execute(
            param: CreateIdentityStateParam(
              did: profileDid,
              bjjPublicKey: bjjPublicKey.p.map((p) => p.toString()).toList(),
              encryptionKey: encryptionKey,
            ),
          );
        }
      }
    } catch (error) {
      logger().e("[AddIdentityUseCase] Error: $error");
      _stacktraceManager.addTrace("[AddIdentityUseCase] Error: $error");
      _stacktraceManager.addError("[AddIdentityUseCase] Error: $error");
      rethrow;
    }

    logger().i(
        "[AddIdentityUseCase] Identity created and saved with did: ${identity.did}, for key $bjjPublicKey");
    _stacktraceManager.addTrace(
        "[AddIdentityUseCase] Identity created and saved with did: ${identity.did}, for key $bjjPublicKey");

    return identity;
  }

  Future<String> _getDid({
    required String ethAddress,
    required ChainConfigEntity chain,
    required EnvConfigEntity config,
    BigInt? nonce,
  }) {
    nonce ??= GENESIS_PROFILE_NONCE;

    return _identityRepository.getEthDidIdentifier(
      ethAddress: ethAddress,
      blockchain: chain.blockchain,
      network: chain.network,
      profileNonce: nonce,
      config: config,
    );
  }
}
