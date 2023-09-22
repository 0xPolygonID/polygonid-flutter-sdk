// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i15;

import 'package:archive/archive.dart' as _i78;
import 'package:dio/dio.dart' as _i14;
import 'package:encrypt/encrypt.dart' as _i16;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i37;
import 'package:package_info_plus/package_info_plus.dart' as _i42;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/env_mapper.dart'
    as _i19;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filter_mapper.dart'
    as _i20;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart'
    as _i21;
import 'package:polygonid_flutter_sdk/common/data/data_sources/package_info_datasource.dart'
    as _i43;
import 'package:polygonid_flutter_sdk/common/data/data_sources/storage_key_value_data_source.dart'
    as _i90;
import 'package:polygonid_flutter_sdk/common/data/repositories/config_repository_impl.dart'
    as _i104;
import 'package:polygonid_flutter_sdk/common/data/repositories/package_info_repository_impl.dart'
    as _i44;
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart' as _i51;
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart'
    as _i69;
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart'
    as _i113;
import 'package:polygonid_flutter_sdk/common/domain/repositories/package_info_repository.dart'
    as _i98;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart'
    as _i117;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart'
    as _i106;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/set_env_use_case.dart'
    as _i127;
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart'
    as _i63;
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart'
    as _i45;
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart'
    as _i105;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i91;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart'
    as _i95;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart'
    as _i100;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart'
    as _i83;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_info_mapper.dart'
    as _i9;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart'
    as _i82;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart'
    as _i10;
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart'
    as _i27;
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart'
    as _i61;
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart'
    as _i114;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i159;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i115;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_nonce_use_case.dart'
    as _i116;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i163;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart'
    as _i181;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart'
    as _i162;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i123;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart'
    as _i124;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart'
    as _i126;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart'
    as _i128;
import 'package:polygonid_flutter_sdk/credential/libs/polygonidcore/pidcore_credential.dart'
    as _i46;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/iden3_message_data_source.dart'
    as _i28;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i92;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i101;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i103;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i89;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_inputs_mapper.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart'
    as _i79;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_mapper.dart'
    as _i29;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_proof_mapper.dart'
    as _i86;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_vp_proof_mapper.dart'
    as _i30;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart'
    as _i32;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_mapper.dart'
    as _i33;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/jwz_mapper.dart'
    as _i34;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart'
    as _i56;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i108;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i109;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i110;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i118;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart'
    as _i119;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart'
    as _i120;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart'
    as _i189;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i169;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/clean_schema_cache_use_case.dart'
    as _i129;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i180;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart'
    as _i170;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i130;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i171;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart'
    as _i172;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i22;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart'
    as _i160;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart'
    as _i182;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i183;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i184;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i23;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i84;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart'
    as _i131;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart'
    as _i133;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart'
    as _i85;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i134;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_schemas_use_case.dart'
    as _i135;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i168;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i166;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i167;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i175;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i121;
import 'package:polygonid_flutter_sdk/iden3comm/libs/polygonidcore/pidcore_iden3comm.dart'
    as _i47;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart'
    as _i17;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i35;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i93;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart'
    as _i36;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart'
    as _i60;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart'
    as _i122;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart'
    as _i111;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart'
    as _i88;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart'
    as _i87;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart'
    as _i67;
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart'
    as _i18;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart'
    as _i25;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart'
    as _i26;
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart'
    as _i31;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_mapper.dart'
    as _i97;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_dto_mapper.dart'
    as _i39;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_entity_mapper.dart'
    as _i40;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_mapper.dart'
    as _i41;
import 'package:polygonid_flutter_sdk/identity/data/mappers/poseidon_hash_mapper.dart'
    as _i52;
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart'
    as _i53;
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart'
    as _i59;
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart'
    as _i102;
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_type_mapper.dart'
    as _i62;
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart'
    as _i64;
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart'
    as _i65;
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_type_mapper.dart'
    as _i66;
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart'
    as _i136;
import 'package:polygonid_flutter_sdk/identity/data/repositories/smt_repository_impl.dart'
    as _i112;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart'
    as _i139;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart'
    as _i125;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i158;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i146;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i173;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i164;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart'
    as _i148;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i161;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i151;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i132;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart'
    as _i153;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i186;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i187;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i176;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i177;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i178;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i150;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i165;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i152;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i194;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i193;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i142;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i185;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i188;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i7;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i179;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i174;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i192;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i157;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i138;
import 'package:polygonid_flutter_sdk/identity/libs/bjj/bjj.dart' as _i6;
import 'package:polygonid_flutter_sdk/identity/libs/polygonidcore/pidcore_identity.dart'
    as _i48;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart'
    as _i80;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart'
    as _i81;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart'
    as _i24;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i94;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/proof_circuit_data_source.dart'
    as _i54;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart'
    as _i58;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart'
    as _i71;
import 'package:polygonid_flutter_sdk/proof/data/mappers/circuit_type_mapper.dart'
    as _i8;
import 'package:polygonid_flutter_sdk/proof/data/mappers/gist_mtproof_mapper.dart'
    as _i107;
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart'
    as _i96;
import 'package:polygonid_flutter_sdk/proof/data/mappers/node_aux_mapper.dart'
    as _i38;
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_base_mapper.dart'
    as _i76;
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_mapper.dart'
    as _i77;
import 'package:polygonid_flutter_sdk/proof/data/repositories/proof_repository_impl.dart'
    as _i137;
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart'
    as _i140;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/cancel_download_circuits_use_case.dart'
    as _i143;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i144;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart'
    as _i145;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_zkproof_use_case.dart'
    as _i147;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart'
    as _i149;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i154;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/load_circuit_use_case.dart'
    as _i155;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart'
    as _i141;
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart'
    as _i55;
import 'package:polygonid_flutter_sdk/proof/libs/polygonidcore/pidcore_proof.dart'
    as _i49;
import 'package:polygonid_flutter_sdk/proof/libs/prover/prover.dart' as _i57;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/auth_v2/witness_auth.dart'
    as _i70;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/mtp_v2/witness_mtp.dart'
    as _i72;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i73;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/sig_v2/witness_sig.dart'
    as _i74;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i75;
import 'package:polygonid_flutter_sdk/sdk/credential.dart' as _i190;
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart' as _i196;
import 'package:polygonid_flutter_sdk/sdk/iden3comm.dart' as _i191;
import 'package:polygonid_flutter_sdk/sdk/identity.dart' as _i195;
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart' as _i50;
import 'package:polygonid_flutter_sdk/sdk/polygonid_flutter_channel.dart'
    as _i99;
import 'package:polygonid_flutter_sdk/sdk/proof.dart' as _i156;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i68;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt $initSDKGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final platformModule = _$PlatformModule();
    final networkModule = _$NetworkModule();
    final databaseModule = _$DatabaseModule();
    final filesManagerModule = _$FilesManagerModule();
    final encryptionModule = _$EncryptionModule();
    final loggerModule = _$LoggerModule();
    final channelModule = _$ChannelModule();
    final repositoriesModule = _$RepositoriesModule();
    gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
    gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
    gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
    gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
    gh.factory<_i7.CheckProfileValidityUseCase>(
        () => _i7.CheckProfileValidityUseCase());
    gh.factory<_i8.CircuitTypeMapper>(() => _i8.CircuitTypeMapper());
    gh.factory<_i9.ClaimInfoMapper>(() => _i9.ClaimInfoMapper());
    gh.factory<_i10.ClaimStateMapper>(() => _i10.ClaimStateMapper());
    gh.factory<_i11.Client>(() => networkModule.client);
    gh.factory<_i12.CreatePathWrapper>(() => _i12.CreatePathWrapper());
    gh.factoryParamAsync<_i13.Database, String?, String?>(
      (
        identifier,
        privateKey,
      ) =>
          databaseModule.identityDatabase(
        identifier,
        privateKey,
      ),
      instanceName: 'polygonIdSdkIdentity',
    );
    gh.lazySingletonAsync<_i13.Database>(() => databaseModule.database());
    gh.factory<_i12.DestinationPathDataSource>(
        () => _i12.DestinationPathDataSource(gh<_i12.CreatePathWrapper>()));
    gh.factory<_i14.Dio>(() => networkModule.dio);
    gh.factoryAsync<_i15.Directory>(
        () => filesManagerModule.applicationDocumentsDirectory);
    gh.factoryParam<_i16.Encrypter, _i16.Key, dynamic>(
      (
        key,
        _,
      ) =>
          encryptionModule.encryptAES(key),
      instanceName: 'encryptAES',
    );
    gh.factory<_i17.EncryptionDbDataSource>(
        () => _i17.EncryptionDbDataSource());
    gh.factory<_i18.EncryptionKeyMapper>(() => _i18.EncryptionKeyMapper());
    gh.factory<_i19.EnvMapper>(() => _i19.EnvMapper());
    gh.factory<_i20.FilterMapper>(() => _i20.FilterMapper());
    gh.factory<_i21.FiltersMapper>(
        () => _i21.FiltersMapper(gh<_i20.FilterMapper>()));
    gh.factory<_i22.GetFetchRequestsUseCase>(
        () => _i22.GetFetchRequestsUseCase());
    gh.factory<_i23.GetIden3MessageTypeUseCase>(
        () => _i23.GetIden3MessageTypeUseCase());
    gh.factory<_i24.GistMTProofDataSource>(() => _i24.GistMTProofDataSource());
    gh.factory<_i25.HashMapper>(() => _i25.HashMapper());
    gh.factory<_i26.HexMapper>(() => _i26.HexMapper());
    gh.factory<_i27.IdFilterMapper>(() => _i27.IdFilterMapper());
    gh.factory<_i28.Iden3MessageDataSource>(
        () => _i28.Iden3MessageDataSource());
    gh.factory<_i29.Iden3MessageTypeMapper>(
        () => _i29.Iden3MessageTypeMapper());
    gh.factory<_i30.Iden3commVPProofMapper>(
        () => _i30.Iden3commVPProofMapper());
    gh.factory<_i31.IdentityDTOMapper>(() => _i31.IdentityDTOMapper());
    gh.factory<_i32.InteractionIdFilterMapper>(
        () => _i32.InteractionIdFilterMapper());
    gh.factory<_i33.InteractionMapper>(() => _i33.InteractionMapper());
    gh.factory<_i34.JWZMapper>(() => _i34.JWZMapper());
    gh.factory<_i35.LibBabyJubJubDataSource>(
        () => _i35.LibBabyJubJubDataSource(gh<_i6.BabyjubjubLib>()));
    gh.factory<_i36.LocalContractFilesDataSource>(
        () => _i36.LocalContractFilesDataSource());
    gh.factory<_i37.Logger>(() => loggerModule.logger);
    gh.factory<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
      () => databaseModule.identityStateStore,
      instanceName: 'identityStateStore',
    );
    gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
    gh.factory<_i38.NodeAuxMapper>(() => _i38.NodeAuxMapper());
    gh.factory<_i39.NodeTypeDTOMapper>(() => _i39.NodeTypeDTOMapper());
    gh.factory<_i40.NodeTypeEntityMapper>(() => _i40.NodeTypeEntityMapper());
    gh.factory<_i41.NodeTypeMapper>(() => _i41.NodeTypeMapper());
    gh.lazySingletonAsync<_i42.PackageInfo>(() => platformModule.packageInfo);
    gh.factoryAsync<_i43.PackageInfoDataSource>(() async =>
        _i43.PackageInfoDataSource(await getAsync<_i42.PackageInfo>()));
    gh.factoryAsync<_i44.PackageInfoRepositoryImpl>(() async =>
        _i44.PackageInfoRepositoryImpl(
            await getAsync<_i43.PackageInfoDataSource>()));
    gh.factory<_i45.PolygonIdCore>(() => _i45.PolygonIdCore());
    gh.factory<_i46.PolygonIdCoreCredential>(
        () => _i46.PolygonIdCoreCredential());
    gh.factory<_i47.PolygonIdCoreIden3comm>(
        () => _i47.PolygonIdCoreIden3comm());
    gh.factory<_i48.PolygonIdCoreIdentity>(() => _i48.PolygonIdCoreIdentity());
    gh.factory<_i49.PolygonIdCoreProof>(() => _i49.PolygonIdCoreProof());
    gh.factory<_i50.PolygonIdSdk>(() => channelModule.polygonIdSdk);
    gh.factory<_i51.PolygonIdSdkLogger>(() => loggerModule.sdkLogger);
    gh.factory<_i52.PoseidonHashMapper>(
        () => _i52.PoseidonHashMapper(gh<_i26.HexMapper>()));
    gh.factory<_i53.PrivateKeyMapper>(() => _i53.PrivateKeyMapper());
    gh.factory<_i54.ProofCircuitDataSource>(
        () => _i54.ProofCircuitDataSource());
    gh.lazySingleton<_i55.ProofGenerationStepsStreamManager>(
        () => _i55.ProofGenerationStepsStreamManager());
    gh.factory<_i56.ProofRequestFiltersMapper>(
        () => _i56.ProofRequestFiltersMapper());
    gh.factory<_i57.ProverLib>(() => _i57.ProverLib());
    gh.factory<_i58.ProverLibWrapper>(() => _i58.ProverLibWrapper());
    gh.factory<_i59.QMapper>(() => _i59.QMapper());
    gh.factory<_i60.RemoteIdentityDataSource>(
        () => _i60.RemoteIdentityDataSource());
    gh.factory<_i61.RevocationStatusMapper>(
        () => _i61.RevocationStatusMapper());
    gh.factory<_i62.RhsNodeTypeMapper>(() => _i62.RhsNodeTypeMapper());
    gh.factoryParam<_i13.SembastCodec, String, dynamic>((
      privateKey,
      _,
    ) =>
        databaseModule.getCodec(privateKey));
    gh.lazySingleton<_i63.StacktraceManager>(() => _i63.StacktraceManager());
    gh.factory<_i64.StateIdentifierMapper>(() => _i64.StateIdentifierMapper());
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.interactionStore,
      instanceName: 'interactionStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore',
    );
    gh.factory<_i13.StoreRef<String, dynamic>>(
      () => databaseModule.keyValueStore,
      instanceName: 'keyValueStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore',
    );
    gh.factory<_i65.TreeStateMapper>(() => _i65.TreeStateMapper());
    gh.factory<_i66.TreeTypeMapper>(() => _i66.TreeTypeMapper());
    gh.factory<_i67.WalletLibWrapper>(() => _i67.WalletLibWrapper());
    gh.factoryParam<_i68.Web3Client, _i69.EnvEntity, dynamic>((
      env,
      _,
    ) =>
        networkModule.web3client(env));
    gh.factory<_i70.WitnessAuthV2Lib>(() => _i70.WitnessAuthV2Lib());
    gh.factory<_i71.WitnessIsolatesWrapper>(
        () => _i71.WitnessIsolatesWrapper());
    gh.factory<_i72.WitnessMTPV2Lib>(() => _i72.WitnessMTPV2Lib());
    gh.factory<_i73.WitnessMTPV2OnchainLib>(
        () => _i73.WitnessMTPV2OnchainLib());
    gh.factory<_i74.WitnessSigV2Lib>(() => _i74.WitnessSigV2Lib());
    gh.factory<_i75.WitnessSigV2OnchainLib>(
        () => _i75.WitnessSigV2OnchainLib());
    gh.factory<_i76.ZKProofBaseMapper>(() => _i76.ZKProofBaseMapper());
    gh.factory<_i77.ZKProofMapper>(() => _i77.ZKProofMapper());
    gh.factory<_i78.ZipDecoder>(() => filesManagerModule.zipDecoder());
    gh.factory<_i79.AuthProofMapper>(() => _i79.AuthProofMapper(
          gh<_i25.HashMapper>(),
          gh<_i38.NodeAuxMapper>(),
        ));
    gh.lazySingleton<_i80.CircuitsDownloadDataSource>(
        () => _i80.CircuitsDownloadDataSource(gh<_i14.Dio>()));
    gh.factoryAsync<_i81.CircuitsFilesDataSource>(() async =>
        _i81.CircuitsFilesDataSource(await getAsync<_i15.Directory>()));
    gh.factory<_i82.ClaimMapper>(() => _i82.ClaimMapper(
          gh<_i10.ClaimStateMapper>(),
          gh<_i9.ClaimInfoMapper>(),
        ));
    gh.factory<_i83.ClaimStoreRefWrapper>(() => _i83.ClaimStoreRefWrapper(
        gh<_i13.StoreRef<String, Map<String, Object?>>>(
            instanceName: 'claimStore')));
    gh.factory<_i84.GetIden3MessageUseCase>(() => _i84.GetIden3MessageUseCase(
          gh<_i23.GetIden3MessageTypeUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i85.GetProofQueryUseCase>(
        () => _i85.GetProofQueryUseCase(gh<_i63.StacktraceManager>()));
    gh.factory<_i86.Iden3commProofMapper>(() => _i86.Iden3commProofMapper(
          gh<_i76.ZKProofBaseMapper>(),
          gh<_i30.Iden3commVPProofMapper>(),
        ));
    gh.factory<_i87.IdentitySMTStoreRefWrapper>(() =>
        _i87.IdentitySMTStoreRefWrapper(
            gh<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
                instanceName: 'identityStateStore')));
    gh.factory<_i88.IdentityStoreRefWrapper>(() => _i88.IdentityStoreRefWrapper(
        gh<_i13.StoreRef<String, Map<String, Object?>>>(
            instanceName: 'identityStore')));
    gh.factory<_i89.InteractionStoreRefWrapper>(() =>
        _i89.InteractionStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'interactionStore')));
    gh.factory<_i90.KeyValueStoreRefWrapper>(() => _i90.KeyValueStoreRefWrapper(
        gh<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
    gh.factory<_i91.LibPolygonIdCoreCredentialDataSource>(() =>
        _i91.LibPolygonIdCoreCredentialDataSource(
            gh<_i46.PolygonIdCoreCredential>()));
    gh.factory<_i92.LibPolygonIdCoreIden3commDataSource>(() =>
        _i92.LibPolygonIdCoreIden3commDataSource(
            gh<_i47.PolygonIdCoreIden3comm>()));
    gh.factory<_i93.LibPolygonIdCoreIdentityDataSource>(() =>
        _i93.LibPolygonIdCoreIdentityDataSource(
            gh<_i48.PolygonIdCoreIdentity>()));
    gh.factory<_i94.LibPolygonIdCoreWrapper>(
        () => _i94.LibPolygonIdCoreWrapper(gh<_i49.PolygonIdCoreProof>()));
    gh.factory<_i95.LocalClaimDataSource>(() => _i95.LocalClaimDataSource(
        gh<_i91.LibPolygonIdCoreCredentialDataSource>()));
    gh.factory<_i96.MTProofMapper>(() => _i96.MTProofMapper(
          gh<_i25.HashMapper>(),
          gh<_i38.NodeAuxMapper>(),
        ));
    gh.factory<_i97.NodeMapper>(() => _i97.NodeMapper(
          gh<_i41.NodeTypeMapper>(),
          gh<_i40.NodeTypeEntityMapper>(),
          gh<_i39.NodeTypeDTOMapper>(),
          gh<_i25.HashMapper>(),
        ));
    gh.factoryAsync<_i98.PackageInfoRepository>(() async =>
        repositoriesModule.packageInfoRepository(
            await getAsync<_i44.PackageInfoRepositoryImpl>()));
    gh.factory<_i99.PolygonIdFlutterChannel>(() => _i99.PolygonIdFlutterChannel(
          gh<_i50.PolygonIdSdk>(),
          gh<_i3.MethodChannel>(),
        ));
    gh.factory<_i58.ProverLibDataSource>(
        () => _i58.ProverLibDataSource(gh<_i58.ProverLibWrapper>()));
    gh.factory<_i100.RemoteClaimDataSource>(() => _i100.RemoteClaimDataSource(
          gh<_i11.Client>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i101.RemoteIden3commDataSource>(
        () => _i101.RemoteIden3commDataSource(
              gh<_i11.Client>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factory<_i102.RhsNodeMapper>(
        () => _i102.RhsNodeMapper(gh<_i62.RhsNodeTypeMapper>()));
    gh.factory<_i103.SecureInteractionStoreRefWrapper>(() =>
        _i103.SecureInteractionStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'interactionStore')));
    gh.factory<_i103.SecureStorageInteractionDataSource>(() =>
        _i103.SecureStorageInteractionDataSource(
            gh<_i103.SecureInteractionStoreRefWrapper>()));
    gh.factory<_i83.StorageClaimDataSource>(
        () => _i83.StorageClaimDataSource(gh<_i83.ClaimStoreRefWrapper>()));
    gh.factoryAsync<_i88.StorageIdentityDataSource>(
        () async => _i88.StorageIdentityDataSource(
              await getAsync<_i13.Database>(),
              gh<_i88.IdentityStoreRefWrapper>(),
            ));
    gh.factoryAsync<_i89.StorageInteractionDataSource>(
        () async => _i89.StorageInteractionDataSource(
              await getAsync<_i13.Database>(),
              gh<_i89.InteractionStoreRefWrapper>(),
            ));
    gh.factoryAsync<_i90.StorageKeyValueDataSource>(
        () async => _i90.StorageKeyValueDataSource(
              await getAsync<_i13.Database>(),
              gh<_i90.KeyValueStoreRefWrapper>(),
            ));
    gh.factory<_i87.StorageSMTDataSource>(
        () => _i87.StorageSMTDataSource(gh<_i87.IdentitySMTStoreRefWrapper>()));
    gh.factory<_i67.WalletDataSource>(
        () => _i67.WalletDataSource(gh<_i67.WalletLibWrapper>()));
    gh.factory<_i71.WitnessDataSource>(
        () => _i71.WitnessDataSource(gh<_i71.WitnessIsolatesWrapper>()));
    gh.factoryAsync<_i104.ConfigRepositoryImpl>(
        () async => _i104.ConfigRepositoryImpl(
              await getAsync<_i90.StorageKeyValueDataSource>(),
              gh<_i19.EnvMapper>(),
            ));
    gh.factory<_i105.CredentialRepositoryImpl>(
        () => _i105.CredentialRepositoryImpl(
              gh<_i100.RemoteClaimDataSource>(),
              gh<_i83.StorageClaimDataSource>(),
              gh<_i95.LocalClaimDataSource>(),
              gh<_i82.ClaimMapper>(),
              gh<_i21.FiltersMapper>(),
              gh<_i27.IdFilterMapper>(),
            ));
    gh.factoryAsync<_i106.GetPackageNameUseCase>(() async =>
        _i106.GetPackageNameUseCase(
            await getAsync<_i98.PackageInfoRepository>()));
    gh.factory<_i107.GistMTProofMapper>(() => _i107.GistMTProofMapper(
          gh<_i96.MTProofMapper>(),
          gh<_i25.HashMapper>(),
        ));
    gh.factory<_i108.Iden3commCredentialRepositoryImpl>(
        () => _i108.Iden3commCredentialRepositoryImpl(
              gh<_i101.RemoteIden3commDataSource>(),
              gh<_i56.ProofRequestFiltersMapper>(),
              gh<_i82.ClaimMapper>(),
            ));
    gh.factory<_i109.Iden3commRepositoryImpl>(
        () => _i109.Iden3commRepositoryImpl(
              gh<_i28.Iden3MessageDataSource>(),
              gh<_i101.RemoteIden3commDataSource>(),
              gh<_i92.LibPolygonIdCoreIden3commDataSource>(),
              gh<_i35.LibBabyJubJubDataSource>(),
              gh<_i5.AuthResponseMapper>(),
              gh<_i4.AuthInputsMapper>(),
              gh<_i79.AuthProofMapper>(),
              gh<_i107.GistMTProofMapper>(),
              gh<_i59.QMapper>(),
              gh<_i34.JWZMapper>(),
              gh<_i86.Iden3commProofMapper>(),
            ));
    gh.factoryAsync<_i110.InteractionRepositoryImpl>(
        () async => _i110.InteractionRepositoryImpl(
              gh<_i103.SecureStorageInteractionDataSource>(),
              await getAsync<_i89.StorageInteractionDataSource>(),
              gh<_i33.InteractionMapper>(),
              gh<_i21.FiltersMapper>(),
              gh<_i32.InteractionIdFilterMapper>(),
            ));
    gh.factory<_i94.LibPolygonIdCoreProofDataSource>(() =>
        _i94.LibPolygonIdCoreProofDataSource(
            gh<_i94.LibPolygonIdCoreWrapper>()));
    gh.factory<_i111.SMTDataSource>(() => _i111.SMTDataSource(
          gh<_i26.HexMapper>(),
          gh<_i35.LibBabyJubJubDataSource>(),
          gh<_i87.StorageSMTDataSource>(),
        ));
    gh.factory<_i112.SMTRepositoryImpl>(() => _i112.SMTRepositoryImpl(
          gh<_i111.SMTDataSource>(),
          gh<_i87.StorageSMTDataSource>(),
          gh<_i35.LibBabyJubJubDataSource>(),
          gh<_i97.NodeMapper>(),
          gh<_i25.HashMapper>(),
          gh<_i96.MTProofMapper>(),
          gh<_i66.TreeTypeMapper>(),
          gh<_i65.TreeStateMapper>(),
        ));
    gh.factoryAsync<_i113.ConfigRepository>(() async => repositoriesModule
        .configRepository(await getAsync<_i104.ConfigRepositoryImpl>()));
    gh.factory<_i114.CredentialRepository>(() => repositoriesModule
        .credentialRepository(gh<_i105.CredentialRepositoryImpl>()));
    gh.factory<_i115.GetAuthClaimUseCase>(() => _i115.GetAuthClaimUseCase(
          gh<_i114.CredentialRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i116.GetClaimRevocationNonceUseCase>(() =>
        _i116.GetClaimRevocationNonceUseCase(gh<_i114.CredentialRepository>()));
    gh.factoryAsync<_i117.GetEnvUseCase>(() async => _i117.GetEnvUseCase(
          await getAsync<_i113.ConfigRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i118.Iden3commCredentialRepository>(() =>
        repositoriesModule.iden3commCredentialRepository(
            gh<_i108.Iden3commCredentialRepositoryImpl>()));
    gh.factory<_i119.Iden3commRepository>(() => repositoriesModule
        .iden3commRepository(gh<_i109.Iden3commRepositoryImpl>()));
    gh.factoryAsync<_i120.InteractionRepository>(() async =>
        repositoriesModule.interactionRepository(
            await getAsync<_i110.InteractionRepositoryImpl>()));
    gh.factoryAsync<_i121.ListenAndStoreNotificationUseCase>(() async =>
        _i121.ListenAndStoreNotificationUseCase(
            await getAsync<_i120.InteractionRepository>()));
    gh.factoryAsync<_i122.RPCDataSource>(
        () async => _i122.RPCDataSource(await getAsync<_i117.GetEnvUseCase>()));
    gh.factory<_i123.RemoveAllClaimsUseCase>(() => _i123.RemoveAllClaimsUseCase(
          gh<_i114.CredentialRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i124.RemoveClaimsUseCase>(() => _i124.RemoveClaimsUseCase(
          gh<_i114.CredentialRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i125.SMTRepository>(
        () => repositoriesModule.smtRepository(gh<_i112.SMTRepositoryImpl>()));
    gh.factory<_i126.SaveClaimsUseCase>(() => _i126.SaveClaimsUseCase(
          gh<_i114.CredentialRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i127.SetEnvUseCase>(() async =>
        _i127.SetEnvUseCase(await getAsync<_i113.ConfigRepository>()));
    gh.factory<_i128.UpdateClaimUseCase>(() => _i128.UpdateClaimUseCase(
          gh<_i114.CredentialRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i129.CleanSchemaCacheUseCase>(
        () => _i129.CleanSchemaCacheUseCase(gh<_i119.Iden3commRepository>()));
    gh.factory<_i130.GetAuthChallengeUseCase>(
        () => _i130.GetAuthChallengeUseCase(
              gh<_i119.Iden3commRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factory<_i131.GetJWZUseCase>(() => _i131.GetJWZUseCase(
          gh<_i119.Iden3commRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i132.GetLatestStateUseCase>(() => _i132.GetLatestStateUseCase(
          gh<_i125.SMTRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factory<_i133.GetProofQueryContextUseCase>(
        () => _i133.GetProofQueryContextUseCase(
              gh<_i118.Iden3commCredentialRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factory<_i134.GetProofRequestsUseCase>(
        () => _i134.GetProofRequestsUseCase(
              gh<_i133.GetProofQueryContextUseCase>(),
              gh<_i85.GetProofQueryUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factory<_i135.GetSchemasUseCase>(() =>
        _i135.GetSchemasUseCase(gh<_i118.Iden3commCredentialRepository>()));
    gh.factoryAsync<_i136.IdentityRepositoryImpl>(
        () async => _i136.IdentityRepositoryImpl(
              gh<_i67.WalletDataSource>(),
              gh<_i60.RemoteIdentityDataSource>(),
              await getAsync<_i88.StorageIdentityDataSource>(),
              await getAsync<_i122.RPCDataSource>(),
              gh<_i36.LocalContractFilesDataSource>(),
              gh<_i35.LibBabyJubJubDataSource>(),
              gh<_i93.LibPolygonIdCoreIdentityDataSource>(),
              gh<_i17.EncryptionDbDataSource>(),
              gh<_i12.DestinationPathDataSource>(),
              gh<_i26.HexMapper>(),
              gh<_i53.PrivateKeyMapper>(),
              gh<_i31.IdentityDTOMapper>(),
              gh<_i102.RhsNodeMapper>(),
              gh<_i64.StateIdentifierMapper>(),
              gh<_i97.NodeMapper>(),
              gh<_i18.EncryptionKeyMapper>(),
            ));
    gh.factoryAsync<_i137.ProofRepositoryImpl>(
        () async => _i137.ProofRepositoryImpl(
              gh<_i71.WitnessDataSource>(),
              gh<_i58.ProverLibDataSource>(),
              gh<_i94.LibPolygonIdCoreProofDataSource>(),
              gh<_i24.GistMTProofDataSource>(),
              gh<_i54.ProofCircuitDataSource>(),
              gh<_i60.RemoteIdentityDataSource>(),
              gh<_i36.LocalContractFilesDataSource>(),
              gh<_i80.CircuitsDownloadDataSource>(),
              await getAsync<_i122.RPCDataSource>(),
              gh<_i8.CircuitTypeMapper>(),
              gh<_i77.ZKProofMapper>(),
              gh<_i82.ClaimMapper>(),
              gh<_i61.RevocationStatusMapper>(),
              gh<_i79.AuthProofMapper>(),
              gh<_i107.GistMTProofMapper>(),
              await getAsync<_i81.CircuitsFilesDataSource>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factory<_i138.RemoveIdentityStateUseCase>(
        () => _i138.RemoveIdentityStateUseCase(
              gh<_i125.SMTRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i139.IdentityRepository>(() async => repositoriesModule
        .identityRepository(await getAsync<_i136.IdentityRepositoryImpl>()));
    gh.factoryAsync<_i140.ProofRepository>(() async => repositoriesModule
        .proofRepository(await getAsync<_i137.ProofRepositoryImpl>()));
    gh.factoryAsync<_i141.ProveUseCase>(() async => _i141.ProveUseCase(
          await getAsync<_i140.ProofRepository>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i142.SignMessageUseCase>(() async =>
        _i142.SignMessageUseCase(await getAsync<_i139.IdentityRepository>()));
    gh.factoryAsync<_i143.CancelDownloadCircuitsUseCase>(() async =>
        _i143.CancelDownloadCircuitsUseCase(
            await getAsync<_i140.ProofRepository>()));
    gh.factoryAsync<_i144.CircuitsFilesExistUseCase>(() async =>
        _i144.CircuitsFilesExistUseCase(
            await getAsync<_i140.ProofRepository>()));
    gh.factoryAsync<_i145.DownloadCircuitsUseCase>(() async =>
        _i145.DownloadCircuitsUseCase(await getAsync<_i140.ProofRepository>()));
    gh.factoryAsync<_i146.FetchStateRootsUseCase>(() async =>
        _i146.FetchStateRootsUseCase(
            await getAsync<_i139.IdentityRepository>()));
    gh.factoryAsync<_i147.GenerateZKProofUseCase>(
        () async => _i147.GenerateZKProofUseCase(
              await getAsync<_i140.ProofRepository>(),
              await getAsync<_i141.ProveUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i148.GetDidUseCase>(() async =>
        _i148.GetDidUseCase(await getAsync<_i139.IdentityRepository>()));
    gh.factoryAsync<_i149.GetGistMTProofUseCase>(
        () async => _i149.GetGistMTProofUseCase(
              await getAsync<_i140.ProofRepository>(),
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i148.GetDidUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i150.GetIdentitiesUseCase>(
        () async => _i150.GetIdentitiesUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i151.GetIdentityAuthClaimUseCase>(
        () async => _i151.GetIdentityAuthClaimUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i115.GetAuthClaimUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i152.GetPrivateKeyUseCase>(
        () async => _i152.GetPrivateKeyUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i153.GetPublicKeysUseCase>(
        () async => _i153.GetPublicKeysUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i154.IsProofCircuitSupportedUseCase>(() async =>
        _i154.IsProofCircuitSupportedUseCase(
            await getAsync<_i140.ProofRepository>()));
    gh.factoryAsync<_i155.LoadCircuitUseCase>(
        () async => _i155.LoadCircuitUseCase(
              await getAsync<_i140.ProofRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i156.Proof>(() async => _i156.Proof(
          await getAsync<_i147.GenerateZKProofUseCase>(),
          await getAsync<_i145.DownloadCircuitsUseCase>(),
          await getAsync<_i144.CircuitsFilesExistUseCase>(),
          gh<_i55.ProofGenerationStepsStreamManager>(),
          await getAsync<_i143.CancelDownloadCircuitsUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i157.CreateIdentityStateUseCase>(
        () async => _i157.CreateIdentityStateUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i125.SMTRepository>(),
              await getAsync<_i151.GetIdentityAuthClaimUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i158.FetchIdentityStateUseCase>(
        () async => _i158.FetchIdentityStateUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i148.GetDidUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i159.GenerateNonRevProofUseCase>(
        () async => _i159.GenerateNonRevProofUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i114.CredentialRepository>(),
              await getAsync<_i158.FetchIdentityStateUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i160.GetFiltersUseCase>(
        () async => _i160.GetFiltersUseCase(
              gh<_i118.Iden3commCredentialRepository>(),
              await getAsync<_i154.IsProofCircuitSupportedUseCase>(),
              gh<_i134.GetProofRequestsUseCase>(),
            ));
    gh.factoryAsync<_i161.GetGenesisStateUseCase>(
        () async => _i161.GetGenesisStateUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i125.SMTRepository>(),
              await getAsync<_i151.GetIdentityAuthClaimUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i162.GetNonRevProofUseCase>(
        () async => _i162.GetNonRevProofUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i114.CredentialRepository>(),
              await getAsync<_i158.FetchIdentityStateUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i163.GetClaimRevocationStatusUseCase>(
        () async => _i163.GetClaimRevocationStatusUseCase(
              gh<_i114.CredentialRepository>(),
              await getAsync<_i159.GenerateNonRevProofUseCase>(),
              await getAsync<_i162.GetNonRevProofUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i164.GetDidIdentifierUseCase>(
        () async => _i164.GetDidIdentifierUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i161.GetGenesisStateUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i165.GetIdentityUseCase>(
        () async => _i165.GetIdentityUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i148.GetDidUseCase>(),
              await getAsync<_i164.GetDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i166.GetInteractionsUseCase>(
        () async => _i166.GetInteractionsUseCase(
              await getAsync<_i120.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i167.RemoveInteractionsUseCase>(
        () async => _i167.RemoveInteractionsUseCase(
              await getAsync<_i120.InteractionRepository>(),
              await getAsync<_i165.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i168.AddInteractionUseCase>(
        () async => _i168.AddInteractionUseCase(
              await getAsync<_i120.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(
        () async => _i169.CheckProfileAndDidCurrentEnvUseCase(
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i164.GetDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i170.GenerateIden3commProofUseCase>(
        () async => _i170.GenerateIden3commProofUseCase(
              await getAsync<_i139.IdentityRepository>(),
              gh<_i125.SMTRepository>(),
              await getAsync<_i140.ProofRepository>(),
              await getAsync<_i141.ProveUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
              gh<_i115.GetAuthClaimUseCase>(),
              await getAsync<_i149.GetGistMTProofUseCase>(),
              await getAsync<_i148.GetDidUseCase>(),
              await getAsync<_i142.SignMessageUseCase>(),
              gh<_i132.GetLatestStateUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i171.GetAuthInputsUseCase>(
        () async => _i171.GetAuthInputsUseCase(
              await getAsync<_i165.GetIdentityUseCase>(),
              gh<_i115.GetAuthClaimUseCase>(),
              await getAsync<_i142.SignMessageUseCase>(),
              await getAsync<_i149.GetGistMTProofUseCase>(),
              gh<_i132.GetLatestStateUseCase>(),
              gh<_i119.Iden3commRepository>(),
              await getAsync<_i139.IdentityRepository>(),
              gh<_i125.SMTRepository>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i172.GetAuthTokenUseCase>(
        () async => _i172.GetAuthTokenUseCase(
              await getAsync<_i155.LoadCircuitUseCase>(),
              gh<_i131.GetJWZUseCase>(),
              gh<_i130.GetAuthChallengeUseCase>(),
              await getAsync<_i171.GetAuthInputsUseCase>(),
              await getAsync<_i141.ProveUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(
        () async => _i173.GetCurrentEnvDidIdentifierUseCase(
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i164.GetDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i174.GetProfilesUseCase>(
        () async => _i174.GetProfilesUseCase(
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i175.UpdateInteractionUseCase>(
        () async => _i175.UpdateInteractionUseCase(
              await getAsync<_i120.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i168.AddInteractionUseCase>(),
            ));
    gh.factoryAsync<_i176.BackupIdentityUseCase>(
        () async => _i176.BackupIdentityUseCase(
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i177.CheckIdentityValidityUseCase>(
        () async => _i177.CheckIdentityValidityUseCase(
              await getAsync<_i152.GetPrivateKeyUseCase>(),
              await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i178.CreateIdentityUseCase>(
        () async => _i178.CreateIdentityUseCase(
              await getAsync<_i153.GetPublicKeysUseCase>(),
              await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i179.CreateProfilesUseCase>(
        () async => _i179.CreateProfilesUseCase(
              await getAsync<_i153.GetPublicKeysUseCase>(),
              await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i180.FetchAndSaveClaimsUseCase>(
        () async => _i180.FetchAndSaveClaimsUseCase(
              gh<_i118.Iden3commCredentialRepository>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i164.GetDidIdentifierUseCase>(),
              gh<_i22.GetFetchRequestsUseCase>(),
              await getAsync<_i172.GetAuthTokenUseCase>(),
              gh<_i126.SaveClaimsUseCase>(),
              await getAsync<_i163.GetClaimRevocationStatusUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i181.GetClaimsUseCase>(() async => _i181.GetClaimsUseCase(
          gh<_i114.CredentialRepository>(),
          await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
          await getAsync<_i165.GetIdentityUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i182.GetIden3commClaimsRevNonceUseCase>(
        () async => _i182.GetIden3commClaimsRevNonceUseCase(
              gh<_i118.Iden3commCredentialRepository>(),
              await getAsync<_i181.GetClaimsUseCase>(),
              gh<_i116.GetClaimRevocationNonceUseCase>(),
              await getAsync<_i154.IsProofCircuitSupportedUseCase>(),
              gh<_i134.GetProofRequestsUseCase>(),
            ));
    gh.factoryAsync<_i183.GetIden3commClaimsUseCase>(
        () async => _i183.GetIden3commClaimsUseCase(
              gh<_i118.Iden3commCredentialRepository>(),
              await getAsync<_i181.GetClaimsUseCase>(),
              await getAsync<_i163.GetClaimRevocationStatusUseCase>(),
              gh<_i116.GetClaimRevocationNonceUseCase>(),
              gh<_i128.UpdateClaimUseCase>(),
              await getAsync<_i154.IsProofCircuitSupportedUseCase>(),
              gh<_i134.GetProofRequestsUseCase>(),
              gh<_i8.CircuitTypeMapper>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i184.GetIden3commProofsUseCase>(
        () async => _i184.GetIden3commProofsUseCase(
              await getAsync<_i140.ProofRepository>(),
              await getAsync<_i183.GetIden3commClaimsUseCase>(),
              await getAsync<_i170.GenerateIden3commProofUseCase>(),
              await getAsync<_i154.IsProofCircuitSupportedUseCase>(),
              gh<_i134.GetProofRequestsUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
              gh<_i55.ProofGenerationStepsStreamManager>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i185.UpdateIdentityUseCase>(
        () async => _i185.UpdateIdentityUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i178.CreateIdentityUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i186.AddIdentityUseCase>(
        () async => _i186.AddIdentityUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i178.CreateIdentityUseCase>(),
              await getAsync<_i157.CreateIdentityStateUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i187.AddNewIdentityUseCase>(
        () async => _i187.AddNewIdentityUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i186.AddIdentityUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i188.AddProfileUseCase>(
        () async => _i188.AddProfileUseCase(
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i185.UpdateIdentityUseCase>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i179.CreateProfilesUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i189.AuthenticateUseCase>(
        () async => _i189.AuthenticateUseCase(
              gh<_i119.Iden3commRepository>(),
              await getAsync<_i184.GetIden3commProofsUseCase>(),
              await getAsync<_i164.GetDidIdentifierUseCase>(),
              await getAsync<_i172.GetAuthTokenUseCase>(),
              await getAsync<_i117.GetEnvUseCase>(),
              await getAsync<_i106.GetPackageNameUseCase>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i55.ProofGenerationStepsStreamManager>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i190.Credential>(() async => _i190.Credential(
          gh<_i126.SaveClaimsUseCase>(),
          await getAsync<_i181.GetClaimsUseCase>(),
          gh<_i124.RemoveClaimsUseCase>(),
          await getAsync<_i163.GetClaimRevocationStatusUseCase>(),
          gh<_i128.UpdateClaimUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i191.Iden3comm>(() async => _i191.Iden3comm(
          await getAsync<_i180.FetchAndSaveClaimsUseCase>(),
          gh<_i84.GetIden3MessageUseCase>(),
          gh<_i135.GetSchemasUseCase>(),
          await getAsync<_i189.AuthenticateUseCase>(),
          await getAsync<_i160.GetFiltersUseCase>(),
          await getAsync<_i183.GetIden3commClaimsUseCase>(),
          await getAsync<_i182.GetIden3commClaimsRevNonceUseCase>(),
          await getAsync<_i184.GetIden3commProofsUseCase>(),
          await getAsync<_i166.GetInteractionsUseCase>(),
          await getAsync<_i168.AddInteractionUseCase>(),
          await getAsync<_i167.RemoveInteractionsUseCase>(),
          await getAsync<_i175.UpdateInteractionUseCase>(),
          gh<_i129.CleanSchemaCacheUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    gh.factoryAsync<_i192.RemoveProfileUseCase>(
        () async => _i192.RemoveProfileUseCase(
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i185.UpdateIdentityUseCase>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i179.CreateProfilesUseCase>(),
              gh<_i138.RemoveIdentityStateUseCase>(),
              gh<_i123.RemoveAllClaimsUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i193.RestoreIdentityUseCase>(
        () async => _i193.RestoreIdentityUseCase(
              await getAsync<_i186.AddIdentityUseCase>(),
              await getAsync<_i165.GetIdentityUseCase>(),
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i173.GetCurrentEnvDidIdentifierUseCase>(),
            ));
    gh.factoryAsync<_i194.RemoveIdentityUseCase>(
        () async => _i194.RemoveIdentityUseCase(
              await getAsync<_i139.IdentityRepository>(),
              await getAsync<_i174.GetProfilesUseCase>(),
              await getAsync<_i192.RemoveProfileUseCase>(),
              gh<_i138.RemoveIdentityStateUseCase>(),
              gh<_i123.RemoveAllClaimsUseCase>(),
              await getAsync<_i169.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i63.StacktraceManager>(),
            ));
    gh.factoryAsync<_i195.Identity>(() async => _i195.Identity(
          await getAsync<_i177.CheckIdentityValidityUseCase>(),
          await getAsync<_i152.GetPrivateKeyUseCase>(),
          await getAsync<_i187.AddNewIdentityUseCase>(),
          await getAsync<_i193.RestoreIdentityUseCase>(),
          await getAsync<_i176.BackupIdentityUseCase>(),
          await getAsync<_i165.GetIdentityUseCase>(),
          await getAsync<_i150.GetIdentitiesUseCase>(),
          await getAsync<_i194.RemoveIdentityUseCase>(),
          await getAsync<_i164.GetDidIdentifierUseCase>(),
          await getAsync<_i142.SignMessageUseCase>(),
          await getAsync<_i158.FetchIdentityStateUseCase>(),
          await getAsync<_i188.AddProfileUseCase>(),
          await getAsync<_i174.GetProfilesUseCase>(),
          await getAsync<_i192.RemoveProfileUseCase>(),
          await getAsync<_i148.GetDidUseCase>(),
          gh<_i63.StacktraceManager>(),
        ));
    return this;
  }
}

class _$PlatformModule extends _i196.PlatformModule {}

class _$NetworkModule extends _i196.NetworkModule {}

class _$DatabaseModule extends _i196.DatabaseModule {}

class _$FilesManagerModule extends _i196.FilesManagerModule {}

class _$EncryptionModule extends _i196.EncryptionModule {}

class _$LoggerModule extends _i196.LoggerModule {}

class _$ChannelModule extends _i196.ChannelModule {}

class _$RepositoriesModule extends _i196.RepositoriesModule {}
