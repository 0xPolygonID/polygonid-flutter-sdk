// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i16;

import 'package:archive/archive.dart' as _i81;
import 'package:dio/dio.dart' as _i15;
import 'package:encrypt/encrypt.dart' as _i17;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i38;
import 'package:package_info_plus/package_info_plus.dart' as _i43;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/env_mapper.dart'
    as _i20;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filter_mapper.dart'
    as _i21;
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart'
    as _i22;
import 'package:polygonid_flutter_sdk/common/data/data_sources/package_info_datasource.dart'
    as _i44;
import 'package:polygonid_flutter_sdk/common/data/data_sources/storage_key_value_data_source.dart'
    as _i94;
import 'package:polygonid_flutter_sdk/common/data/repositories/config_repository_impl.dart'
    as _i110;
import 'package:polygonid_flutter_sdk/common/data/repositories/package_info_repository_impl.dart'
    as _i45;
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart' as _i52;
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart'
    as _i70;
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart'
    as _i120;
import 'package:polygonid_flutter_sdk/common/domain/repositories/package_info_repository.dart'
    as _i102;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart'
    as _i127;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart'
    as _i113;
import 'package:polygonid_flutter_sdk/common/domain/use_cases/set_env_use_case.dart'
    as _i138;
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart'
    as _i64;
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart'
    as _i46;
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart'
    as _i111;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i95;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart'
    as _i99;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart'
    as _i104;
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart'
    as _i86;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_info_mapper.dart'
    as _i9;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart'
    as _i85;
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart'
    as _i10;
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart'
    as _i28;
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart'
    as _i62;
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart'
    as _i121;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/add_did_profile_info_use_case.dart'
    as _i140;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i171;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i123;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_nonce_use_case.dart'
    as _i124;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i175;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart'
    as _i193;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_list_use_case.dart'
    as _i125;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_use_case.dart'
    as _i126;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart'
    as _i174;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i133;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart'
    as _i134;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_did_profile_info_use_case.dart'
    as _i135;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart'
    as _i137;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart'
    as _i139;
import 'package:polygonid_flutter_sdk/credential/libs/polygonidcore/pidcore_credential.dart'
    as _i47;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/iden3_message_data_source.dart'
    as _i29;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i96;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i105;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_did_profile_info_data_source.dart'
    as _i107;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i108;
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i93;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_inputs_mapper.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_proof_mapper.dart'
    as _i82;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/did_profile_info_interacted_did_filter_mapper.dart'
    as _i14;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_mapper.dart'
    as _i30;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_proof_mapper.dart'
    as _i90;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3comm_vp_proof_mapper.dart'
    as _i31;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart'
    as _i33;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_mapper.dart'
    as _i34;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/jwz_mapper.dart'
    as _i35;
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart'
    as _i57;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/did_profile_info_repository_impl.dart'
    as _i112;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i115;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i116;
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i117;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart'
    as _i122;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i128;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart'
    as _i129;
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart'
    as _i130;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart'
    as _i201;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i181;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/clean_schema_cache_use_case.dart'
    as _i141;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i192;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart'
    as _i182;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i142;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i183;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart'
    as _i184;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i23;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart'
    as _i172;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart'
    as _i194;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i195;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i196;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i24;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i88;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart'
    as _i143;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart'
    as _i145;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart'
    as _i89;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i146;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_schemas_use_case.dart'
    as _i147;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i180;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i178;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i179;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i187;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i131;
import 'package:polygonid_flutter_sdk/iden3comm/libs/polygonidcore/pidcore_iden3comm.dart'
    as _i48;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart'
    as _i18;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i36;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i97;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart'
    as _i37;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart'
    as _i61;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart'
    as _i132;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/secure_storage_profiles_data_source.dart'
    as _i109;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart'
    as _i118;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart'
    as _i92;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart'
    as _i91;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart'
    as _i68;
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart'
    as _i19;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart'
    as _i26;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart'
    as _i27;
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart'
    as _i32;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_mapper.dart'
    as _i101;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_dto_mapper.dart'
    as _i40;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_entity_mapper.dart'
    as _i41;
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_type_mapper.dart'
    as _i42;
import 'package:polygonid_flutter_sdk/identity/data/mappers/poseidon_hash_mapper.dart'
    as _i53;
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart'
    as _i54;
import 'package:polygonid_flutter_sdk/identity/data/mappers/q_mapper.dart'
    as _i60;
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart'
    as _i106;
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_type_mapper.dart'
    as _i63;
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart'
    as _i65;
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart'
    as _i66;
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_type_mapper.dart'
    as _i67;
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart'
    as _i148;
import 'package:polygonid_flutter_sdk/identity/data/repositories/smt_repository_impl.dart'
    as _i119;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart'
    as _i151;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart'
    as _i136;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i170;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i158;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i185;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i176;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart'
    as _i160;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i173;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i163;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i144;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart'
    as _i165;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i198;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i199;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i188;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i189;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i190;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i162;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i177;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i164;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i206;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i207;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i154;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i197;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i200;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i7;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i191;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i186;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i204;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/restore_profiles_use_case.dart'
    as _i205;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i169;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i150;
import 'package:polygonid_flutter_sdk/identity/libs/bjj/bjj.dart' as _i6;
import 'package:polygonid_flutter_sdk/identity/libs/polygonidcore/pidcore_identity.dart'
    as _i49;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_download_data_source.dart'
    as _i83;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/circuits_files_data_source.dart'
    as _i84;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/gist_mtproof_data_source.dart'
    as _i25;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i98;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/proof_circuit_data_source.dart'
    as _i55;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/prover_lib_data_source.dart'
    as _i59;
import 'package:polygonid_flutter_sdk/proof/data/data_sources/witness_data_source.dart'
    as _i72;
import 'package:polygonid_flutter_sdk/proof/data/mappers/circuit_type_mapper.dart'
    as _i8;
import 'package:polygonid_flutter_sdk/proof/data/mappers/gist_mtproof_mapper.dart'
    as _i114;
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart'
    as _i100;
import 'package:polygonid_flutter_sdk/proof/data/mappers/node_aux_mapper.dart'
    as _i39;
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_base_mapper.dart'
    as _i79;
import 'package:polygonid_flutter_sdk/proof/data/mappers/zkproof_mapper.dart'
    as _i80;
import 'package:polygonid_flutter_sdk/proof/data/repositories/proof_repository_impl.dart'
    as _i149;
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart'
    as _i152;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/cancel_download_circuits_use_case.dart'
    as _i155;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i156;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/download_circuits_use_case.dart'
    as _i157;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_zkproof_use_case.dart'
    as _i159;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_gist_mtproof_use_case.dart'
    as _i161;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i166;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/load_circuit_use_case.dart'
    as _i167;
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart'
    as _i153;
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart'
    as _i56;
import 'package:polygonid_flutter_sdk/proof/libs/polygonidcore/pidcore_proof.dart'
    as _i50;
import 'package:polygonid_flutter_sdk/proof/libs/prover/prover.dart' as _i58;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/auth_v2/witness_auth.dart'
    as _i71;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/mtp_v2/witness_mtp.dart'
    as _i73;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i74;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/sig_v2/witness_sig.dart'
    as _i75;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i76;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/v3/witness_v3.dart'
    as _i77;
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/v3_onchain/witness_v3_onchain.dart'
    as _i78;
import 'package:polygonid_flutter_sdk/sdk/credential.dart' as _i202;
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart' as _i209;
import 'package:polygonid_flutter_sdk/sdk/error_handling.dart' as _i87;
import 'package:polygonid_flutter_sdk/sdk/iden3comm.dart' as _i203;
import 'package:polygonid_flutter_sdk/sdk/identity.dart' as _i208;
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart' as _i51;
import 'package:polygonid_flutter_sdk/sdk/polygonid_flutter_channel.dart'
    as _i103;
import 'package:polygonid_flutter_sdk/sdk/proof.dart' as _i168;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i69;

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
    gh.lazySingletonAsync<_i13.Database>(() => databaseModule.database());
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
    gh.factory<_i12.DestinationPathDataSource>(
        () => _i12.DestinationPathDataSource(gh<_i12.CreatePathWrapper>()));
    gh.factory<_i14.DidProfileInfoInteractedDidFilterMapper>(
        () => _i14.DidProfileInfoInteractedDidFilterMapper());
    gh.factory<_i15.Dio>(() => networkModule.dio);
    gh.factoryAsync<_i16.Directory>(
        () => filesManagerModule.applicationDocumentsDirectory);
    gh.factoryParam<_i17.Encrypter, _i17.Key, dynamic>(
      (
        key,
        _,
      ) =>
          encryptionModule.encryptAES(key),
      instanceName: 'encryptAES',
    );
    gh.factory<_i18.EncryptionDbDataSource>(
        () => _i18.EncryptionDbDataSource());
    gh.factory<_i19.EncryptionKeyMapper>(() => _i19.EncryptionKeyMapper());
    gh.factory<_i20.EnvMapper>(() => _i20.EnvMapper());
    gh.factory<_i21.FilterMapper>(() => _i21.FilterMapper());
    gh.factory<_i22.FiltersMapper>(
        () => _i22.FiltersMapper(gh<_i21.FilterMapper>()));
    gh.factory<_i23.GetFetchRequestsUseCase>(
        () => _i23.GetFetchRequestsUseCase());
    gh.factory<_i24.GetIden3MessageTypeUseCase>(
        () => _i24.GetIden3MessageTypeUseCase());
    gh.factory<_i25.GistMTProofDataSource>(() => _i25.GistMTProofDataSource());
    gh.factory<_i26.HashMapper>(() => _i26.HashMapper());
    gh.factory<_i27.HexMapper>(() => _i27.HexMapper());
    gh.factory<_i28.IdFilterMapper>(() => _i28.IdFilterMapper());
    gh.factory<_i29.Iden3MessageDataSource>(
        () => _i29.Iden3MessageDataSource());
    gh.factory<_i30.Iden3MessageTypeMapper>(
        () => _i30.Iden3MessageTypeMapper());
    gh.factory<_i31.Iden3commVPProofMapper>(
        () => _i31.Iden3commVPProofMapper());
    gh.factory<_i32.IdentityDTOMapper>(() => _i32.IdentityDTOMapper());
    gh.factory<_i33.InteractionIdFilterMapper>(
        () => _i33.InteractionIdFilterMapper());
    gh.factory<_i34.InteractionMapper>(() => _i34.InteractionMapper());
    gh.factory<_i35.JWZMapper>(() => _i35.JWZMapper());
    gh.factory<_i36.LibBabyJubJubDataSource>(
        () => _i36.LibBabyJubJubDataSource(gh<_i6.BabyjubjubLib>()));
    gh.factory<_i37.LocalContractFilesDataSource>(
        () => _i37.LocalContractFilesDataSource());
    gh.factory<_i38.Logger>(() => loggerModule.logger);
    gh.factory<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
      () => databaseModule.identityStateStore,
      instanceName: 'identityStateStore',
    );
    gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
    gh.factory<_i39.NodeAuxMapper>(() => _i39.NodeAuxMapper());
    gh.factory<_i40.NodeTypeDTOMapper>(() => _i40.NodeTypeDTOMapper());
    gh.factory<_i41.NodeTypeEntityMapper>(() => _i41.NodeTypeEntityMapper());
    gh.factory<_i42.NodeTypeMapper>(() => _i42.NodeTypeMapper());
    gh.lazySingletonAsync<_i43.PackageInfo>(() => platformModule.packageInfo);
    gh.factoryAsync<_i44.PackageInfoDataSource>(() async =>
        _i44.PackageInfoDataSource(await getAsync<_i43.PackageInfo>()));
    gh.factoryAsync<_i45.PackageInfoRepositoryImpl>(() async =>
        _i45.PackageInfoRepositoryImpl(
            await getAsync<_i44.PackageInfoDataSource>()));
    gh.factory<_i46.PolygonIdCore>(() => _i46.PolygonIdCore());
    gh.factory<_i47.PolygonIdCoreCredential>(
        () => _i47.PolygonIdCoreCredential());
    gh.factory<_i48.PolygonIdCoreIden3comm>(
        () => _i48.PolygonIdCoreIden3comm());
    gh.factory<_i49.PolygonIdCoreIdentity>(() => _i49.PolygonIdCoreIdentity());
    gh.factory<_i50.PolygonIdCoreProof>(() => _i50.PolygonIdCoreProof());
    gh.factory<_i51.PolygonIdSdk>(() => channelModule.polygonIdSdk);
    gh.factory<_i52.PolygonIdSdkLogger>(() => loggerModule.sdkLogger);
    gh.factory<_i53.PoseidonHashMapper>(
        () => _i53.PoseidonHashMapper(gh<_i27.HexMapper>()));
    gh.factory<_i54.PrivateKeyMapper>(() => _i54.PrivateKeyMapper());
    gh.factory<_i55.ProofCircuitDataSource>(
        () => _i55.ProofCircuitDataSource());
    gh.lazySingleton<_i56.ProofGenerationStepsStreamManager>(
        () => _i56.ProofGenerationStepsStreamManager());
    gh.factory<_i57.ProofRequestFiltersMapper>(
        () => _i57.ProofRequestFiltersMapper());
    gh.factory<_i58.ProverLib>(() => _i58.ProverLib());
    gh.factory<_i59.ProverLibWrapper>(() => _i59.ProverLibWrapper());
    gh.factory<_i60.QMapper>(() => _i60.QMapper());
    gh.factory<_i61.RemoteIdentityDataSource>(
        () => _i61.RemoteIdentityDataSource());
    gh.factory<_i62.RevocationStatusMapper>(
        () => _i62.RevocationStatusMapper());
    gh.factory<_i63.RhsNodeTypeMapper>(() => _i63.RhsNodeTypeMapper());
    gh.factoryParam<_i13.SembastCodec, String, dynamic>((
      privateKey,
      _,
    ) =>
        databaseModule.getCodec(privateKey));
    gh.lazySingleton<_i64.StacktraceManager>(() => _i64.StacktraceManager());
    gh.factory<_i65.StateIdentifierMapper>(() => _i65.StateIdentifierMapper());
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.interactionStore,
      instanceName: 'interactionStore',
    );
    gh.factory<_i13.StoreRef<String, dynamic>>(
      () => databaseModule.keyValueStore,
      instanceName: 'keyValueStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.profileStore,
      instanceName: 'profilesStore',
    );
    gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.didProfileInfoStore,
      instanceName: 'didProfileInfoStore',
    );
    gh.factory<_i66.TreeStateMapper>(() => _i66.TreeStateMapper());
    gh.factory<_i67.TreeTypeMapper>(() => _i67.TreeTypeMapper());
    gh.factory<_i68.WalletLibWrapper>(() => _i68.WalletLibWrapper());
    gh.factoryParam<_i69.Web3Client, _i70.EnvEntity, dynamic>((
      env,
      _,
    ) =>
        networkModule.web3client(env));
    gh.factory<_i71.WitnessAuthV2Lib>(() => _i71.WitnessAuthV2Lib());
    gh.factory<_i72.WitnessIsolatesWrapper>(
        () => _i72.WitnessIsolatesWrapper());
    gh.factory<_i73.WitnessMTPV2Lib>(() => _i73.WitnessMTPV2Lib());
    gh.factory<_i74.WitnessMTPV2OnchainLib>(
        () => _i74.WitnessMTPV2OnchainLib());
    gh.factory<_i75.WitnessSigV2Lib>(() => _i75.WitnessSigV2Lib());
    gh.factory<_i76.WitnessSigV2OnchainLib>(
        () => _i76.WitnessSigV2OnchainLib());
    gh.factory<_i77.WitnessV3Lib>(() => _i77.WitnessV3Lib());
    gh.factory<_i78.WitnessV3OnchainLib>(() => _i78.WitnessV3OnchainLib());
    gh.factory<_i79.ZKProofBaseMapper>(() => _i79.ZKProofBaseMapper());
    gh.factory<_i80.ZKProofMapper>(() => _i80.ZKProofMapper());
    gh.factory<_i81.ZipDecoder>(() => filesManagerModule.zipDecoder());
    gh.factory<_i82.AuthProofMapper>(() => _i82.AuthProofMapper(
          gh<_i26.HashMapper>(),
          gh<_i39.NodeAuxMapper>(),
        ));
    gh.factory<_i83.CircuitsDownloadDataSource>(
        () => _i83.CircuitsDownloadDataSource(gh<_i15.Dio>()));
    gh.factoryAsync<_i84.CircuitsFilesDataSource>(() async =>
        _i84.CircuitsFilesDataSource(await getAsync<_i16.Directory>()));
    gh.factory<_i85.ClaimMapper>(() => _i85.ClaimMapper(
          gh<_i10.ClaimStateMapper>(),
          gh<_i9.ClaimInfoMapper>(),
        ));
    gh.factory<_i86.ClaimStoreRefWrapper>(() => _i86.ClaimStoreRefWrapper(
        gh<_i13.StoreRef<String, Map<String, Object?>>>(
            instanceName: 'claimStore')));
    gh.factory<_i87.ErrorHandling>(
        () => _i87.ErrorHandling(gh<_i64.StacktraceManager>()));
    gh.factory<_i88.GetIden3MessageUseCase>(() => _i88.GetIden3MessageUseCase(
          gh<_i24.GetIden3MessageTypeUseCase>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i89.GetProofQueryUseCase>(
        () => _i89.GetProofQueryUseCase(gh<_i64.StacktraceManager>()));
    gh.factory<_i90.Iden3commProofMapper>(() => _i90.Iden3commProofMapper(
          gh<_i79.ZKProofBaseMapper>(),
          gh<_i31.Iden3commVPProofMapper>(),
        ));
    gh.factory<_i91.IdentitySMTStoreRefWrapper>(() =>
        _i91.IdentitySMTStoreRefWrapper(
            gh<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
                instanceName: 'identityStateStore')));
    gh.factory<_i92.IdentityStoreRefWrapper>(() => _i92.IdentityStoreRefWrapper(
        gh<_i13.StoreRef<String, Map<String, Object?>>>(
            instanceName: 'identityStore')));
    gh.factory<_i93.InteractionStoreRefWrapper>(() =>
        _i93.InteractionStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'interactionStore')));
    gh.factory<_i94.KeyValueStoreRefWrapper>(() => _i94.KeyValueStoreRefWrapper(
        gh<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
    gh.factory<_i95.LibPolygonIdCoreCredentialDataSource>(() =>
        _i95.LibPolygonIdCoreCredentialDataSource(
            gh<_i47.PolygonIdCoreCredential>()));
    gh.factory<_i96.LibPolygonIdCoreIden3commDataSource>(() =>
        _i96.LibPolygonIdCoreIden3commDataSource(
            gh<_i48.PolygonIdCoreIden3comm>()));
    gh.factory<_i97.LibPolygonIdCoreIdentityDataSource>(() =>
        _i97.LibPolygonIdCoreIdentityDataSource(
            gh<_i49.PolygonIdCoreIdentity>()));
    gh.factory<_i98.LibPolygonIdCoreWrapper>(
        () => _i98.LibPolygonIdCoreWrapper(gh<_i50.PolygonIdCoreProof>()));
    gh.factory<_i99.LocalClaimDataSource>(() => _i99.LocalClaimDataSource(
        gh<_i95.LibPolygonIdCoreCredentialDataSource>()));
    gh.factory<_i100.MTProofMapper>(() => _i100.MTProofMapper(
          gh<_i26.HashMapper>(),
          gh<_i39.NodeAuxMapper>(),
        ));
    gh.factory<_i101.NodeMapper>(() => _i101.NodeMapper(
          gh<_i42.NodeTypeMapper>(),
          gh<_i41.NodeTypeEntityMapper>(),
          gh<_i40.NodeTypeDTOMapper>(),
          gh<_i26.HashMapper>(),
        ));
    gh.factoryAsync<_i102.PackageInfoRepository>(() async =>
        repositoriesModule.packageInfoRepository(
            await getAsync<_i45.PackageInfoRepositoryImpl>()));
    gh.factory<_i103.PolygonIdFlutterChannel>(
        () => _i103.PolygonIdFlutterChannel(
              gh<_i51.PolygonIdSdk>(),
              gh<_i3.MethodChannel>(),
            ));
    gh.factory<_i59.ProverLibDataSource>(
        () => _i59.ProverLibDataSource(gh<_i59.ProverLibWrapper>()));
    gh.factory<_i104.RemoteClaimDataSource>(() => _i104.RemoteClaimDataSource(
          gh<_i11.Client>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i105.RemoteIden3commDataSource>(
        () => _i105.RemoteIden3commDataSource(
              gh<_i11.Client>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factory<_i106.RhsNodeMapper>(
        () => _i106.RhsNodeMapper(gh<_i63.RhsNodeTypeMapper>()));
    gh.factory<_i107.SecureDidProfileInfoStoreRefWrapper>(() =>
        _i107.SecureDidProfileInfoStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'didProfileInfoStore')));
    gh.factory<_i108.SecureInteractionStoreRefWrapper>(() =>
        _i108.SecureInteractionStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'interactionStore')));
    gh.factory<_i107.SecureStorageDidProfileInfoDataSource>(() =>
        _i107.SecureStorageDidProfileInfoDataSource(
            gh<_i107.SecureDidProfileInfoStoreRefWrapper>()));
    gh.factory<_i108.SecureStorageInteractionDataSource>(() =>
        _i108.SecureStorageInteractionDataSource(
            gh<_i108.SecureInteractionStoreRefWrapper>()));
    gh.factory<_i109.SecureStorageProfilesStoreRefWrapper>(() =>
        _i109.SecureStorageProfilesStoreRefWrapper(
            gh<_i13.StoreRef<String, Map<String, Object?>>>(
                instanceName: 'profilesStore')));
    gh.factory<_i86.StorageClaimDataSource>(
        () => _i86.StorageClaimDataSource(gh<_i86.ClaimStoreRefWrapper>()));
    gh.factoryAsync<_i92.StorageIdentityDataSource>(
        () async => _i92.StorageIdentityDataSource(
              await getAsync<_i13.Database>(),
              gh<_i92.IdentityStoreRefWrapper>(),
            ));
    gh.factoryAsync<_i93.StorageInteractionDataSource>(
        () async => _i93.StorageInteractionDataSource(
              await getAsync<_i13.Database>(),
              gh<_i93.InteractionStoreRefWrapper>(),
            ));
    gh.factoryAsync<_i94.StorageKeyValueDataSource>(
        () async => _i94.StorageKeyValueDataSource(
              await getAsync<_i13.Database>(),
              gh<_i94.KeyValueStoreRefWrapper>(),
            ));
    gh.factory<_i91.StorageSMTDataSource>(
        () => _i91.StorageSMTDataSource(gh<_i91.IdentitySMTStoreRefWrapper>()));
    gh.factory<_i68.WalletDataSource>(
        () => _i68.WalletDataSource(gh<_i68.WalletLibWrapper>()));
    gh.factory<_i72.WitnessDataSource>(
        () => _i72.WitnessDataSource(gh<_i72.WitnessIsolatesWrapper>()));
    gh.factoryAsync<_i110.ConfigRepositoryImpl>(
        () async => _i110.ConfigRepositoryImpl(
              await getAsync<_i94.StorageKeyValueDataSource>(),
              gh<_i20.EnvMapper>(),
            ));
    gh.factory<_i111.CredentialRepositoryImpl>(
        () => _i111.CredentialRepositoryImpl(
              gh<_i104.RemoteClaimDataSource>(),
              gh<_i86.StorageClaimDataSource>(),
              gh<_i99.LocalClaimDataSource>(),
              gh<_i85.ClaimMapper>(),
              gh<_i22.FiltersMapper>(),
              gh<_i28.IdFilterMapper>(),
            ));
    gh.factory<_i112.DidProfileInfoRepositoryImpl>(
        () => _i112.DidProfileInfoRepositoryImpl(
              gh<_i107.SecureStorageDidProfileInfoDataSource>(),
              gh<_i22.FiltersMapper>(),
              gh<_i14.DidProfileInfoInteractedDidFilterMapper>(),
            ));
    gh.factoryAsync<_i113.GetPackageNameUseCase>(() async =>
        _i113.GetPackageNameUseCase(
            await getAsync<_i102.PackageInfoRepository>()));
    gh.factory<_i114.GistMTProofMapper>(() => _i114.GistMTProofMapper(
          gh<_i100.MTProofMapper>(),
          gh<_i26.HashMapper>(),
        ));
    gh.factory<_i115.Iden3commCredentialRepositoryImpl>(
        () => _i115.Iden3commCredentialRepositoryImpl(
              gh<_i105.RemoteIden3commDataSource>(),
              gh<_i57.ProofRequestFiltersMapper>(),
              gh<_i85.ClaimMapper>(),
            ));
    gh.factory<_i116.Iden3commRepositoryImpl>(
        () => _i116.Iden3commRepositoryImpl(
              gh<_i29.Iden3MessageDataSource>(),
              gh<_i105.RemoteIden3commDataSource>(),
              gh<_i96.LibPolygonIdCoreIden3commDataSource>(),
              gh<_i36.LibBabyJubJubDataSource>(),
              gh<_i5.AuthResponseMapper>(),
              gh<_i4.AuthInputsMapper>(),
              gh<_i82.AuthProofMapper>(),
              gh<_i114.GistMTProofMapper>(),
              gh<_i60.QMapper>(),
              gh<_i35.JWZMapper>(),
              gh<_i90.Iden3commProofMapper>(),
            ));
    gh.factoryAsync<_i117.InteractionRepositoryImpl>(
        () async => _i117.InteractionRepositoryImpl(
              gh<_i108.SecureStorageInteractionDataSource>(),
              await getAsync<_i93.StorageInteractionDataSource>(),
              gh<_i34.InteractionMapper>(),
              gh<_i22.FiltersMapper>(),
              gh<_i33.InteractionIdFilterMapper>(),
            ));
    gh.factory<_i98.LibPolygonIdCoreProofDataSource>(() =>
        _i98.LibPolygonIdCoreProofDataSource(
            gh<_i98.LibPolygonIdCoreWrapper>()));
    gh.factory<_i118.SMTDataSource>(() => _i118.SMTDataSource(
          gh<_i27.HexMapper>(),
          gh<_i36.LibBabyJubJubDataSource>(),
          gh<_i91.StorageSMTDataSource>(),
        ));
    gh.factory<_i119.SMTRepositoryImpl>(() => _i119.SMTRepositoryImpl(
          gh<_i118.SMTDataSource>(),
          gh<_i91.StorageSMTDataSource>(),
          gh<_i36.LibBabyJubJubDataSource>(),
          gh<_i101.NodeMapper>(),
          gh<_i26.HashMapper>(),
          gh<_i100.MTProofMapper>(),
          gh<_i67.TreeTypeMapper>(),
          gh<_i66.TreeStateMapper>(),
        ));
    gh.factory<_i109.SecureStorageProfilesDataSource>(() =>
        _i109.SecureStorageProfilesDataSource(
            gh<_i109.SecureStorageProfilesStoreRefWrapper>()));
    gh.factoryAsync<_i120.ConfigRepository>(() async => repositoriesModule
        .configRepository(await getAsync<_i110.ConfigRepositoryImpl>()));
    gh.factory<_i121.CredentialRepository>(() => repositoriesModule
        .credentialRepository(gh<_i111.CredentialRepositoryImpl>()));
    gh.factory<_i122.DidProfileInfoRepository>(() => repositoriesModule
        .didProfileInfoRepository(gh<_i112.DidProfileInfoRepositoryImpl>()));
    gh.factory<_i123.GetAuthClaimUseCase>(() => _i123.GetAuthClaimUseCase(
          gh<_i121.CredentialRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i124.GetClaimRevocationNonceUseCase>(() =>
        _i124.GetClaimRevocationNonceUseCase(gh<_i121.CredentialRepository>()));
    gh.factory<_i125.GetDidProfileInfoListUseCase>(() =>
        _i125.GetDidProfileInfoListUseCase(
            gh<_i122.DidProfileInfoRepository>()));
    gh.factory<_i126.GetDidProfileInfoUseCase>(() =>
        _i126.GetDidProfileInfoUseCase(gh<_i122.DidProfileInfoRepository>()));
    gh.factoryAsync<_i127.GetEnvUseCase>(() async => _i127.GetEnvUseCase(
          await getAsync<_i120.ConfigRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i128.Iden3commCredentialRepository>(() =>
        repositoriesModule.iden3commCredentialRepository(
            gh<_i115.Iden3commCredentialRepositoryImpl>()));
    gh.factory<_i129.Iden3commRepository>(() => repositoriesModule
        .iden3commRepository(gh<_i116.Iden3commRepositoryImpl>()));
    gh.factoryAsync<_i130.InteractionRepository>(() async =>
        repositoriesModule.interactionRepository(
            await getAsync<_i117.InteractionRepositoryImpl>()));
    gh.factoryAsync<_i131.ListenAndStoreNotificationUseCase>(() async =>
        _i131.ListenAndStoreNotificationUseCase(
            await getAsync<_i130.InteractionRepository>()));
    gh.factoryAsync<_i132.RPCDataSource>(
        () async => _i132.RPCDataSource(await getAsync<_i127.GetEnvUseCase>()));
    gh.factory<_i133.RemoveAllClaimsUseCase>(() => _i133.RemoveAllClaimsUseCase(
          gh<_i121.CredentialRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i134.RemoveClaimsUseCase>(() => _i134.RemoveClaimsUseCase(
          gh<_i121.CredentialRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i135.RemoveDidProfileInfoUseCase>(() =>
        _i135.RemoveDidProfileInfoUseCase(
            gh<_i122.DidProfileInfoRepository>()));
    gh.factory<_i136.SMTRepository>(
        () => repositoriesModule.smtRepository(gh<_i119.SMTRepositoryImpl>()));
    gh.factory<_i137.SaveClaimsUseCase>(() => _i137.SaveClaimsUseCase(
          gh<_i121.CredentialRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factoryAsync<_i138.SetEnvUseCase>(() async =>
        _i138.SetEnvUseCase(await getAsync<_i120.ConfigRepository>()));
    gh.factory<_i139.UpdateClaimUseCase>(() => _i139.UpdateClaimUseCase(
          gh<_i121.CredentialRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i140.AddDidProfileInfoUseCase>(() =>
        _i140.AddDidProfileInfoUseCase(gh<_i122.DidProfileInfoRepository>()));
    gh.factory<_i141.CleanSchemaCacheUseCase>(
        () => _i141.CleanSchemaCacheUseCase(gh<_i129.Iden3commRepository>()));
    gh.factory<_i142.GetAuthChallengeUseCase>(
        () => _i142.GetAuthChallengeUseCase(
              gh<_i129.Iden3commRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factory<_i143.GetJWZUseCase>(() => _i143.GetJWZUseCase(
          gh<_i129.Iden3commRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i144.GetLatestStateUseCase>(() => _i144.GetLatestStateUseCase(
          gh<_i136.SMTRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factory<_i145.GetProofQueryContextUseCase>(
        () => _i145.GetProofQueryContextUseCase(
              gh<_i128.Iden3commCredentialRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factory<_i146.GetProofRequestsUseCase>(
        () => _i146.GetProofRequestsUseCase(
              gh<_i145.GetProofQueryContextUseCase>(),
              gh<_i89.GetProofQueryUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factory<_i147.GetSchemasUseCase>(() =>
        _i147.GetSchemasUseCase(gh<_i128.Iden3commCredentialRepository>()));
    gh.factoryAsync<_i148.IdentityRepositoryImpl>(
        () async => _i148.IdentityRepositoryImpl(
              gh<_i68.WalletDataSource>(),
              gh<_i61.RemoteIdentityDataSource>(),
              await getAsync<_i92.StorageIdentityDataSource>(),
              await getAsync<_i132.RPCDataSource>(),
              gh<_i37.LocalContractFilesDataSource>(),
              gh<_i36.LibBabyJubJubDataSource>(),
              gh<_i97.LibPolygonIdCoreIdentityDataSource>(),
              gh<_i18.EncryptionDbDataSource>(),
              gh<_i12.DestinationPathDataSource>(),
              gh<_i27.HexMapper>(),
              gh<_i54.PrivateKeyMapper>(),
              gh<_i32.IdentityDTOMapper>(),
              gh<_i106.RhsNodeMapper>(),
              gh<_i65.StateIdentifierMapper>(),
              gh<_i101.NodeMapper>(),
              gh<_i19.EncryptionKeyMapper>(),
              gh<_i109.SecureStorageProfilesDataSource>(),
            ));
    gh.factoryAsync<_i149.ProofRepositoryImpl>(
        () async => _i149.ProofRepositoryImpl(
              gh<_i72.WitnessDataSource>(),
              gh<_i59.ProverLibDataSource>(),
              gh<_i98.LibPolygonIdCoreProofDataSource>(),
              gh<_i25.GistMTProofDataSource>(),
              gh<_i55.ProofCircuitDataSource>(),
              gh<_i61.RemoteIdentityDataSource>(),
              gh<_i37.LocalContractFilesDataSource>(),
              gh<_i83.CircuitsDownloadDataSource>(),
              await getAsync<_i132.RPCDataSource>(),
              gh<_i8.CircuitTypeMapper>(),
              gh<_i80.ZKProofMapper>(),
              gh<_i85.ClaimMapper>(),
              gh<_i62.RevocationStatusMapper>(),
              gh<_i82.AuthProofMapper>(),
              gh<_i114.GistMTProofMapper>(),
              await getAsync<_i84.CircuitsFilesDataSource>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factory<_i150.RemoveIdentityStateUseCase>(
        () => _i150.RemoveIdentityStateUseCase(
              gh<_i136.SMTRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i151.IdentityRepository>(() async => repositoriesModule
        .identityRepository(await getAsync<_i148.IdentityRepositoryImpl>()));
    gh.factoryAsync<_i152.ProofRepository>(() async => repositoriesModule
        .proofRepository(await getAsync<_i149.ProofRepositoryImpl>()));
    gh.factoryAsync<_i153.ProveUseCase>(() async => _i153.ProveUseCase(
          await getAsync<_i152.ProofRepository>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factoryAsync<_i154.SignMessageUseCase>(() async =>
        _i154.SignMessageUseCase(await getAsync<_i151.IdentityRepository>()));
    gh.factoryAsync<_i155.CancelDownloadCircuitsUseCase>(() async =>
        _i155.CancelDownloadCircuitsUseCase(
            await getAsync<_i152.ProofRepository>()));
    gh.factoryAsync<_i156.CircuitsFilesExistUseCase>(() async =>
        _i156.CircuitsFilesExistUseCase(
            await getAsync<_i152.ProofRepository>()));
    gh.factoryAsync<_i157.DownloadCircuitsUseCase>(() async =>
        _i157.DownloadCircuitsUseCase(await getAsync<_i152.ProofRepository>()));
    gh.factoryAsync<_i158.FetchStateRootsUseCase>(() async =>
        _i158.FetchStateRootsUseCase(
            await getAsync<_i151.IdentityRepository>()));
    gh.factoryAsync<_i159.GenerateZKProofUseCase>(
        () async => _i159.GenerateZKProofUseCase(
              await getAsync<_i152.ProofRepository>(),
              await getAsync<_i153.ProveUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i160.GetDidUseCase>(() async =>
        _i160.GetDidUseCase(await getAsync<_i151.IdentityRepository>()));
    gh.factoryAsync<_i161.GetGistMTProofUseCase>(
        () async => _i161.GetGistMTProofUseCase(
              await getAsync<_i152.ProofRepository>(),
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i160.GetDidUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i162.GetIdentitiesUseCase>(
        () async => _i162.GetIdentitiesUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i163.GetIdentityAuthClaimUseCase>(
        () async => _i163.GetIdentityAuthClaimUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i123.GetAuthClaimUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i164.GetPrivateKeyUseCase>(
        () async => _i164.GetPrivateKeyUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i165.GetPublicKeysUseCase>(
        () async => _i165.GetPublicKeysUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i166.IsProofCircuitSupportedUseCase>(() async =>
        _i166.IsProofCircuitSupportedUseCase(
            await getAsync<_i152.ProofRepository>()));
    gh.factoryAsync<_i167.LoadCircuitUseCase>(
        () async => _i167.LoadCircuitUseCase(
              await getAsync<_i152.ProofRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i168.Proof>(() async => _i168.Proof(
          await getAsync<_i159.GenerateZKProofUseCase>(),
          await getAsync<_i157.DownloadCircuitsUseCase>(),
          await getAsync<_i156.CircuitsFilesExistUseCase>(),
          gh<_i56.ProofGenerationStepsStreamManager>(),
          await getAsync<_i155.CancelDownloadCircuitsUseCase>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factoryAsync<_i169.CreateIdentityStateUseCase>(
        () async => _i169.CreateIdentityStateUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i136.SMTRepository>(),
              await getAsync<_i163.GetIdentityAuthClaimUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i170.FetchIdentityStateUseCase>(
        () async => _i170.FetchIdentityStateUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i160.GetDidUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i171.GenerateNonRevProofUseCase>(
        () async => _i171.GenerateNonRevProofUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i121.CredentialRepository>(),
              await getAsync<_i170.FetchIdentityStateUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i172.GetFiltersUseCase>(
        () async => _i172.GetFiltersUseCase(
              gh<_i128.Iden3commCredentialRepository>(),
              await getAsync<_i166.IsProofCircuitSupportedUseCase>(),
              gh<_i146.GetProofRequestsUseCase>(),
            ));
    gh.factoryAsync<_i173.GetGenesisStateUseCase>(
        () async => _i173.GetGenesisStateUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i136.SMTRepository>(),
              await getAsync<_i163.GetIdentityAuthClaimUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i174.GetNonRevProofUseCase>(
        () async => _i174.GetNonRevProofUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i121.CredentialRepository>(),
              await getAsync<_i170.FetchIdentityStateUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i175.GetClaimRevocationStatusUseCase>(
        () async => _i175.GetClaimRevocationStatusUseCase(
              gh<_i121.CredentialRepository>(),
              await getAsync<_i171.GenerateNonRevProofUseCase>(),
              await getAsync<_i174.GetNonRevProofUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i176.GetDidIdentifierUseCase>(
        () async => _i176.GetDidIdentifierUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i173.GetGenesisStateUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i177.GetIdentityUseCase>(
        () async => _i177.GetIdentityUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i160.GetDidUseCase>(),
              await getAsync<_i176.GetDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i178.GetInteractionsUseCase>(
        () async => _i178.GetInteractionsUseCase(
              await getAsync<_i130.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i179.RemoveInteractionsUseCase>(
        () async => _i179.RemoveInteractionsUseCase(
              await getAsync<_i130.InteractionRepository>(),
              await getAsync<_i177.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i180.AddInteractionUseCase>(
        () async => _i180.AddInteractionUseCase(
              await getAsync<_i130.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(
        () async => _i181.CheckProfileAndDidCurrentEnvUseCase(
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i176.GetDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i182.GenerateIden3commProofUseCase>(
        () async => _i182.GenerateIden3commProofUseCase(
              await getAsync<_i151.IdentityRepository>(),
              gh<_i136.SMTRepository>(),
              await getAsync<_i152.ProofRepository>(),
              await getAsync<_i153.ProveUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
              gh<_i123.GetAuthClaimUseCase>(),
              await getAsync<_i161.GetGistMTProofUseCase>(),
              await getAsync<_i160.GetDidUseCase>(),
              await getAsync<_i154.SignMessageUseCase>(),
              gh<_i144.GetLatestStateUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i183.GetAuthInputsUseCase>(
        () async => _i183.GetAuthInputsUseCase(
              await getAsync<_i177.GetIdentityUseCase>(),
              gh<_i123.GetAuthClaimUseCase>(),
              await getAsync<_i154.SignMessageUseCase>(),
              await getAsync<_i161.GetGistMTProofUseCase>(),
              gh<_i144.GetLatestStateUseCase>(),
              gh<_i129.Iden3commRepository>(),
              await getAsync<_i151.IdentityRepository>(),
              gh<_i136.SMTRepository>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i184.GetAuthTokenUseCase>(
        () async => _i184.GetAuthTokenUseCase(
              await getAsync<_i167.LoadCircuitUseCase>(),
              gh<_i143.GetJWZUseCase>(),
              gh<_i142.GetAuthChallengeUseCase>(),
              await getAsync<_i183.GetAuthInputsUseCase>(),
              await getAsync<_i153.ProveUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(
        () async => _i185.GetCurrentEnvDidIdentifierUseCase(
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i176.GetDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i186.GetProfilesUseCase>(
        () async => _i186.GetProfilesUseCase(
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i187.UpdateInteractionUseCase>(
        () async => _i187.UpdateInteractionUseCase(
              await getAsync<_i130.InteractionRepository>(),
              gh<_i7.CheckProfileValidityUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i180.AddInteractionUseCase>(),
            ));
    gh.factoryAsync<_i188.BackupIdentityUseCase>(
        () async => _i188.BackupIdentityUseCase(
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i189.CheckIdentityValidityUseCase>(
        () async => _i189.CheckIdentityValidityUseCase(
              await getAsync<_i164.GetPrivateKeyUseCase>(),
              await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i190.CreateIdentityUseCase>(
        () async => _i190.CreateIdentityUseCase(
              await getAsync<_i165.GetPublicKeysUseCase>(),
              await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i191.CreateProfilesUseCase>(
        () async => _i191.CreateProfilesUseCase(
              await getAsync<_i165.GetPublicKeysUseCase>(),
              await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i192.FetchAndSaveClaimsUseCase>(
        () async => _i192.FetchAndSaveClaimsUseCase(
              gh<_i128.Iden3commCredentialRepository>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i176.GetDidIdentifierUseCase>(),
              gh<_i23.GetFetchRequestsUseCase>(),
              await getAsync<_i184.GetAuthTokenUseCase>(),
              gh<_i137.SaveClaimsUseCase>(),
              await getAsync<_i175.GetClaimRevocationStatusUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i193.GetClaimsUseCase>(() async => _i193.GetClaimsUseCase(
          gh<_i121.CredentialRepository>(),
          await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factoryAsync<_i194.GetIden3commClaimsRevNonceUseCase>(
        () async => _i194.GetIden3commClaimsRevNonceUseCase(
              gh<_i128.Iden3commCredentialRepository>(),
              await getAsync<_i193.GetClaimsUseCase>(),
              gh<_i124.GetClaimRevocationNonceUseCase>(),
              await getAsync<_i166.IsProofCircuitSupportedUseCase>(),
              gh<_i146.GetProofRequestsUseCase>(),
            ));
    gh.factoryAsync<_i195.GetIden3commClaimsUseCase>(
        () async => _i195.GetIden3commClaimsUseCase(
              gh<_i128.Iden3commCredentialRepository>(),
              await getAsync<_i193.GetClaimsUseCase>(),
              await getAsync<_i175.GetClaimRevocationStatusUseCase>(),
              gh<_i124.GetClaimRevocationNonceUseCase>(),
              gh<_i139.UpdateClaimUseCase>(),
              await getAsync<_i166.IsProofCircuitSupportedUseCase>(),
              gh<_i146.GetProofRequestsUseCase>(),
              gh<_i8.CircuitTypeMapper>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i196.GetIden3commProofsUseCase>(
        () async => _i196.GetIden3commProofsUseCase(
              await getAsync<_i152.ProofRepository>(),
              await getAsync<_i195.GetIden3commClaimsUseCase>(),
              await getAsync<_i182.GenerateIden3commProofUseCase>(),
              await getAsync<_i166.IsProofCircuitSupportedUseCase>(),
              gh<_i146.GetProofRequestsUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
              gh<_i56.ProofGenerationStepsStreamManager>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i197.UpdateIdentityUseCase>(
        () async => _i197.UpdateIdentityUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i190.CreateIdentityUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
            ));
    gh.factoryAsync<_i198.AddIdentityUseCase>(
        () async => _i198.AddIdentityUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i190.CreateIdentityUseCase>(),
              await getAsync<_i169.CreateIdentityStateUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i199.AddNewIdentityUseCase>(
        () async => _i199.AddNewIdentityUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i198.AddIdentityUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i200.AddProfileUseCase>(
        () async => _i200.AddProfileUseCase(
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i197.UpdateIdentityUseCase>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i191.CreateProfilesUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i201.AuthenticateUseCase>(
        () async => _i201.AuthenticateUseCase(
              gh<_i129.Iden3commRepository>(),
              await getAsync<_i196.GetIden3commProofsUseCase>(),
              await getAsync<_i176.GetDidIdentifierUseCase>(),
              await getAsync<_i184.GetAuthTokenUseCase>(),
              await getAsync<_i127.GetEnvUseCase>(),
              await getAsync<_i113.GetPackageNameUseCase>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i56.ProofGenerationStepsStreamManager>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i202.Credential>(() async => _i202.Credential(
          gh<_i137.SaveClaimsUseCase>(),
          await getAsync<_i193.GetClaimsUseCase>(),
          gh<_i134.RemoveClaimsUseCase>(),
          await getAsync<_i175.GetClaimRevocationStatusUseCase>(),
          gh<_i139.UpdateClaimUseCase>(),
          gh<_i64.StacktraceManager>(),
        ));
    gh.factoryAsync<_i203.Iden3comm>(() async => _i203.Iden3comm(
          await getAsync<_i192.FetchAndSaveClaimsUseCase>(),
          gh<_i88.GetIden3MessageUseCase>(),
          gh<_i147.GetSchemasUseCase>(),
          await getAsync<_i201.AuthenticateUseCase>(),
          await getAsync<_i172.GetFiltersUseCase>(),
          await getAsync<_i195.GetIden3commClaimsUseCase>(),
          await getAsync<_i194.GetIden3commClaimsRevNonceUseCase>(),
          await getAsync<_i196.GetIden3commProofsUseCase>(),
          await getAsync<_i178.GetInteractionsUseCase>(),
          await getAsync<_i180.AddInteractionUseCase>(),
          await getAsync<_i179.RemoveInteractionsUseCase>(),
          await getAsync<_i187.UpdateInteractionUseCase>(),
          gh<_i141.CleanSchemaCacheUseCase>(),
          gh<_i64.StacktraceManager>(),
          gh<_i140.AddDidProfileInfoUseCase>(),
          gh<_i126.GetDidProfileInfoUseCase>(),
          gh<_i125.GetDidProfileInfoListUseCase>(),
          gh<_i135.RemoveDidProfileInfoUseCase>(),
        ));
    gh.factoryAsync<_i204.RemoveProfileUseCase>(
        () async => _i204.RemoveProfileUseCase(
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i197.UpdateIdentityUseCase>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              await getAsync<_i191.CreateProfilesUseCase>(),
              gh<_i150.RemoveIdentityStateUseCase>(),
              gh<_i133.RemoveAllClaimsUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i205.RestoreProfilesUseCase>(
        () async => _i205.RestoreProfilesUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i197.UpdateIdentityUseCase>(),
            ));
    gh.factoryAsync<_i206.RemoveIdentityUseCase>(
        () async => _i206.RemoveIdentityUseCase(
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i186.GetProfilesUseCase>(),
              await getAsync<_i204.RemoveProfileUseCase>(),
              gh<_i150.RemoveIdentityStateUseCase>(),
              gh<_i133.RemoveAllClaimsUseCase>(),
              await getAsync<_i181.CheckProfileAndDidCurrentEnvUseCase>(),
              gh<_i64.StacktraceManager>(),
            ));
    gh.factoryAsync<_i207.RestoreIdentityUseCase>(
        () async => _i207.RestoreIdentityUseCase(
              await getAsync<_i198.AddIdentityUseCase>(),
              await getAsync<_i177.GetIdentityUseCase>(),
              await getAsync<_i151.IdentityRepository>(),
              await getAsync<_i185.GetCurrentEnvDidIdentifierUseCase>(),
              await getAsync<_i205.RestoreProfilesUseCase>(),
            ));
    gh.factoryAsync<_i208.Identity>(() async => _i208.Identity(
          await getAsync<_i189.CheckIdentityValidityUseCase>(),
          await getAsync<_i164.GetPrivateKeyUseCase>(),
          await getAsync<_i199.AddNewIdentityUseCase>(),
          await getAsync<_i207.RestoreIdentityUseCase>(),
          await getAsync<_i188.BackupIdentityUseCase>(),
          await getAsync<_i177.GetIdentityUseCase>(),
          await getAsync<_i162.GetIdentitiesUseCase>(),
          await getAsync<_i206.RemoveIdentityUseCase>(),
          await getAsync<_i176.GetDidIdentifierUseCase>(),
          await getAsync<_i154.SignMessageUseCase>(),
          await getAsync<_i170.FetchIdentityStateUseCase>(),
          await getAsync<_i200.AddProfileUseCase>(),
          await getAsync<_i186.GetProfilesUseCase>(),
          await getAsync<_i204.RemoveProfileUseCase>(),
          await getAsync<_i160.GetDidUseCase>(),
          gh<_i64.StacktraceManager>(),
        ));
    return this;
  }
}

class _$PlatformModule extends _i209.PlatformModule {}

class _$NetworkModule extends _i209.NetworkModule {}

class _$DatabaseModule extends _i209.DatabaseModule {}

class _$FilesManagerModule extends _i209.FilesManagerModule {}

class _$EncryptionModule extends _i209.EncryptionModule {}

class _$LoggerModule extends _i209.LoggerModule {}

class _$ChannelModule extends _i209.ChannelModule {}

class _$RepositoriesModule extends _i209.RepositoriesModule {}
