// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i52;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i76;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i59;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i74;

import '../../common/data/data_sources/env_datasource.dart' as _i13;
import '../../common/data/data_sources/package_info_datasource.dart' as _i58;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i92;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i60;
import '../../common/domain/repositories/config_repository.dart' as _i28;
import '../../common/domain/repositories/package_info_repository.dart' as _i35;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i27;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i34;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i61;
import '../../credential/data/credential_repository_impl.dart' as _i110;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i99;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i103;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i75;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i10;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i8;
import '../../credential/data/mappers/claim_mapper.dart' as _i91;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i17;
import '../../credential/data/mappers/filters_mapper.dart' as _i18;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i41;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i81;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i23;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i94;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i97;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i25;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i29;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i38;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i79;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i85;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i62;
import '../../env/sdk_env.dart' as _i14;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i100;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i77;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i70;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i118;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i21;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i116;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i20;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i31;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i32;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i36;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i37;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i112;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i63;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i48;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i49;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i50;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i101;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i51;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i53;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i78;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i73;
import '../../identity/data/data_sources/smt_data_source.dart' as _i107;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i46;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i45;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i86;
import '../../identity/data/mappers/bigint_mapper.dart' as _i6;
import '../../identity/data/mappers/did_mapper.dart' as _i12;
import '../../identity/data/mappers/hash_mapper.dart' as _i39;
import '../../identity/data/mappers/hex_mapper.dart' as _i40;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i44;
import '../../identity/data/mappers/node_mapper.dart' as _i104;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i55;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i56;
import '../../identity/data/mappers/node_type_mapper.dart' as _i57;
import '../../identity/data/mappers/private_key_mapper.dart' as _i66;
import '../../identity/data/mappers/proof_mapper.dart' as _i69;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i106;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i82;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i84;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i113;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i108;
import '../../identity/domain/repositories/identity_repository.dart' as _i16;
import '../../identity/domain/repositories/smt_repository.dart' as _i24;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i15;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i96;
import '../../identity/domain/use_cases/get_auth_claim_use_case.dart' as _i19;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i26;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i33;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i80;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i83;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i42;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i64;
import '../../proof/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i3;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i102;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i54;
import '../../proof/data/data_sources/prepare_inputs_data_source.dart' as _i105;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i67;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i72;
import '../../proof/data/data_sources/witness_data_source.dart' as _i88;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof/data/mappers/proof_mapper.dart' as _i68;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i115;
import '../../proof/domain/repositories/proof_repository.dart' as _i22;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i111;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i30;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i47;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i65;
import '../../proof/libs/prover/prover.dart' as _i71;
import '../../proof/libs/witnesscalc/auth/witness_auth.dart' as _i87;
import '../../proof/libs/witnesscalc/mtp/witness_mtp.dart' as _i89;
import '../../proof/libs/witnesscalc/sig/witness_sig.dart' as _i90;
import '../credential.dart' as _i109;
import '../iden3comm.dart' as _i117;
import '../identity.dart' as _i98;
import '../mappers/iden3_message_type_mapper.dart' as _i43;
import '../proof.dart' as _i114; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AtomicQueryInputsWrapper>(
      () => _i3.AtomicQueryInputsWrapper());
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.BigIntMapper>(() => _i6.BigIntMapper());
  gh.factory<_i7.CircuitTypeMapper>(() => _i7.CircuitTypeMapper());
  gh.factory<_i8.ClaimInfoMapper>(() => _i8.ClaimInfoMapper());
  gh.factory<_i9.ClaimStateMapper>(() => _i9.ClaimStateMapper());
  gh.factory<_i10.ClaimStoreRefWrapper>(() => _i10.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i12.DidMapper>(() => _i12.DidMapper());
  gh.factory<_i13.EnvDataSource>(() => _i13.EnvDataSource(get<_i14.SdkEnv>()));
  gh.factory<_i15.FetchStateRootsUseCase>(
      () => _i15.FetchStateRootsUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i17.FilterMapper>(() => _i17.FilterMapper());
  gh.factory<_i18.FiltersMapper>(
      () => _i18.FiltersMapper(get<_i17.FilterMapper>()));
  gh.factory<_i19.GetAuthClaimUseCase>(
      () => _i19.GetAuthClaimUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i20.GetAuthTokenUseCase>(() => _i20.GetAuthTokenUseCase(
        get<_i21.Iden3commRepository>(),
        get<_i22.ProofRepository>(),
        get<_i23.CredentialRepository>(),
        get<_i16.IdentityRepository>(),
        get<_i24.SMTRepository>(),
        get<_i12.DidMapper>(),
      ));
  gh.factory<_i25.GetClaimsUseCase>(
      () => _i25.GetClaimsUseCase(get<_i23.CredentialRepository>()));
  gh.factory<_i26.GetDidIdentifierUseCase>(
      () => _i26.GetDidIdentifierUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i27.GetEnvConfigUseCase>(
      () => _i27.GetEnvConfigUseCase(get<_i28.ConfigRepository>()));
  gh.factory<_i29.GetFetchRequestsUseCase>(
      () => _i29.GetFetchRequestsUseCase());
  gh.factory<_i30.GetGistProofUseCase>(() => _i30.GetGistProofUseCase(
        get<_i22.ProofRepository>(),
        get<_i27.GetEnvConfigUseCase>(),
      ));
  gh.factory<_i31.GetIden3MessageTypeUseCase>(
      () => _i31.GetIden3MessageTypeUseCase());
  gh.factory<_i32.GetIden3MessageUseCase>(() =>
      _i32.GetIden3MessageUseCase(get<_i31.GetIden3MessageTypeUseCase>()));
  gh.factory<_i33.GetIdentityUseCase>(
      () => _i33.GetIdentityUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i34.GetPackageNameUseCase>(
      () => _i34.GetPackageNameUseCase(get<_i35.PackageInfoRepository>()));
  gh.factory<_i36.GetProofQueryUseCase>(() => _i36.GetProofQueryUseCase());
  gh.factory<_i37.GetProofRequestsUseCase>(
      () => _i37.GetProofRequestsUseCase(get<_i36.GetProofQueryUseCase>()));
  gh.factory<_i38.GetVocabsUseCase>(
      () => _i38.GetVocabsUseCase(get<_i23.CredentialRepository>()));
  gh.factory<_i39.HashMapper>(() => _i39.HashMapper());
  gh.factory<_i40.HexMapper>(() => _i40.HexMapper());
  gh.factory<_i41.IdFilterMapper>(() => _i41.IdFilterMapper());
  gh.factory<_i42.Iden3CoreLib>(() => _i42.Iden3CoreLib());
  gh.factory<_i43.Iden3MessageTypeMapper>(() => _i43.Iden3MessageTypeMapper());
  gh.factory<_i44.IdentityDTOMapper>(() => _i44.IdentityDTOMapper());
  gh.factory<_i45.IdentitySMTStoreRefWrapper>(() =>
      _i45.IdentitySMTStoreRefWrapper(
          get<Map<String, _i11.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i46.IdentityStoreRefWrapper>(() => _i46.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i47.IsProofCircuitSupportedUseCase>(
      () => _i47.IsProofCircuitSupportedUseCase(get<_i22.ProofRepository>()));
  gh.factory<_i48.JWZIsolatesWrapper>(() => _i48.JWZIsolatesWrapper());
  gh.factory<_i49.LibBabyJubJubDataSource>(
      () => _i49.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i50.LibIdentityDataSource>(
      () => _i50.LibIdentityDataSource(get<_i42.Iden3CoreLib>()));
  gh.factory<_i51.LocalContractFilesDataSource>(
      () => _i51.LocalContractFilesDataSource(get<_i52.AssetBundle>()));
  gh.factory<_i53.LocalIdentityDataSource>(
      () => _i53.LocalIdentityDataSource());
  gh.factory<_i54.LocalProofFilesDataSource>(
      () => _i54.LocalProofFilesDataSource());
  gh.factory<_i55.NodeTypeDTOMapper>(() => _i55.NodeTypeDTOMapper());
  gh.factory<_i56.NodeTypeEntityMapper>(() => _i56.NodeTypeEntityMapper());
  gh.factory<_i57.NodeTypeMapper>(() => _i57.NodeTypeMapper());
  gh.factory<_i58.PackageInfoDataSource>(
      () => _i58.PackageInfoDataSource(get<_i59.PackageInfo>()));
  gh.factory<_i60.PackageInfoRepositoryImpl>(
      () => _i60.PackageInfoRepositoryImpl(get<_i58.PackageInfoDataSource>()));
  gh.factory<_i61.PolygonIdCore>(() => _i61.PolygonIdCore());
  gh.factory<_i62.PolygonIdCoreCredential>(
      () => _i62.PolygonIdCoreCredential());
  gh.factory<_i63.PolygonIdCoreIden3comm>(() => _i63.PolygonIdCoreIden3comm());
  gh.factory<_i64.PolygonIdCoreIdentity>(() => _i64.PolygonIdCoreIdentity());
  gh.factory<_i65.PolygonIdCoreProof>(() => _i65.PolygonIdCoreProof());
  gh.factory<_i66.PrivateKeyMapper>(() => _i66.PrivateKeyMapper());
  gh.factory<_i67.ProofCircuitDataSource>(() => _i67.ProofCircuitDataSource());
  gh.factory<_i68.ProofMapper>(() => _i68.ProofMapper());
  gh.factory<_i69.ProofMapper>(() => _i69.ProofMapper(get<_i39.HashMapper>()));
  gh.factory<_i70.ProofRequestFiltersMapper>(
      () => _i70.ProofRequestFiltersMapper());
  gh.factory<_i71.ProverLib>(() => _i71.ProverLib());
  gh.factory<_i72.ProverLibWrapper>(() => _i72.ProverLibWrapper());
  gh.factory<_i73.RPCDataSource>(
      () => _i73.RPCDataSource(get<_i74.Web3Client>()));
  gh.factory<_i75.RemoteClaimDataSource>(
      () => _i75.RemoteClaimDataSource(get<_i76.Client>()));
  gh.factory<_i77.RemoteIden3commDataSource>(
      () => _i77.RemoteIden3commDataSource(get<_i76.Client>()));
  gh.factory<_i78.RemoteIdentityDataSource>(
      () => _i78.RemoteIdentityDataSource());
  gh.factory<_i79.RemoveClaimsUseCase>(
      () => _i79.RemoveClaimsUseCase(get<_i23.CredentialRepository>()));
  gh.factory<_i80.RemoveIdentityUseCase>(
      () => _i80.RemoveIdentityUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i81.RevocationStatusMapper>(() => _i81.RevocationStatusMapper());
  gh.factory<_i82.RhsNodeTypeMapper>(() => _i82.RhsNodeTypeMapper());
  gh.factory<_i83.SignMessageUseCase>(
      () => _i83.SignMessageUseCase(get<_i16.IdentityRepository>()));
  gh.factory<_i84.StateIdentifierMapper>(() => _i84.StateIdentifierMapper());
  gh.factory<_i10.StorageClaimDataSource>(
      () => _i10.StorageClaimDataSource(get<_i10.ClaimStoreRefWrapper>()));
  gh.factory<_i46.StorageIdentityDataSource>(
      () => _i46.StorageIdentityDataSource(
            get<_i11.Database>(),
            get<_i46.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i45.StorageSMTDataSource>(
      () => _i45.StorageSMTDataSource(get<_i45.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i85.UpdateClaimUseCase>(
      () => _i85.UpdateClaimUseCase(get<_i23.CredentialRepository>()));
  gh.factory<_i86.WalletLibWrapper>(() => _i86.WalletLibWrapper());
  gh.factory<_i87.WitnessAuthLib>(() => _i87.WitnessAuthLib());
  gh.factory<_i88.WitnessIsolatesWrapper>(() => _i88.WitnessIsolatesWrapper());
  gh.factory<_i89.WitnessMtpLib>(() => _i89.WitnessMtpLib());
  gh.factory<_i90.WitnessSigLib>(() => _i90.WitnessSigLib());
  gh.factory<_i91.ClaimMapper>(() => _i91.ClaimMapper(
        get<_i9.ClaimStateMapper>(),
        get<_i8.ClaimInfoMapper>(),
      ));
  gh.factory<_i92.ConfigRepositoryImpl>(
      () => _i92.ConfigRepositoryImpl(get<_i13.EnvDataSource>()));
  gh.factory<_i93.CreateAndSaveIdentityUseCase>(
      () => _i93.CreateAndSaveIdentityUseCase(
            get<_i16.IdentityRepository>(),
            get<_i23.CredentialRepository>(),
            get<_i27.GetEnvConfigUseCase>(),
          ));
  gh.factory<_i94.FetchAndSaveClaimsUseCase>(
      () => _i94.FetchAndSaveClaimsUseCase(
            get<_i29.GetFetchRequestsUseCase>(),
            get<_i20.GetAuthTokenUseCase>(),
            get<_i23.CredentialRepository>(),
          ));
  gh.factory<_i95.FetchIdentityStateUseCase>(
      () => _i95.FetchIdentityStateUseCase(
            get<_i16.IdentityRepository>(),
            get<_i27.GetEnvConfigUseCase>(),
          ));
  gh.factory<_i96.GenerateNonRevProofUseCase>(
      () => _i96.GenerateNonRevProofUseCase(
            get<_i16.IdentityRepository>(),
            get<_i23.CredentialRepository>(),
            get<_i27.GetEnvConfigUseCase>(),
            get<_i95.FetchIdentityStateUseCase>(),
          ));
  gh.factory<_i97.GetClaimRevocationStatusUseCase>(
      () => _i97.GetClaimRevocationStatusUseCase(
            get<_i23.CredentialRepository>(),
            get<_i16.IdentityRepository>(),
            get<_i96.GenerateNonRevProofUseCase>(),
          ));
  gh.factory<_i98.Identity>(() => _i98.Identity(
        get<_i93.CreateAndSaveIdentityUseCase>(),
        get<_i33.GetIdentityUseCase>(),
        get<_i80.RemoveIdentityUseCase>(),
        get<_i26.GetDidIdentifierUseCase>(),
        get<_i83.SignMessageUseCase>(),
        get<_i95.FetchIdentityStateUseCase>(),
      ));
  gh.factory<_i99.LibPolygonIdCoreCredentialDataSource>(() =>
      _i99.LibPolygonIdCoreCredentialDataSource(
          get<_i62.PolygonIdCoreCredential>()));
  gh.factory<_i100.LibPolygonIdCoreIden3commDataSource>(() =>
      _i100.LibPolygonIdCoreIden3commDataSource(
          get<_i63.PolygonIdCoreIden3comm>()));
  gh.factory<_i101.LibPolygonIdCoreIdentityDataSource>(() =>
      _i101.LibPolygonIdCoreIdentityDataSource(
          get<_i64.PolygonIdCoreIdentity>()));
  gh.factory<_i102.LibPolygonIdCoreProofDataSource>(() =>
      _i102.LibPolygonIdCoreProofDataSource(get<_i65.PolygonIdCoreProof>()));
  gh.factory<_i103.LocalClaimDataSource>(() => _i103.LocalClaimDataSource(
      get<_i99.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i104.NodeMapper>(() => _i104.NodeMapper(
        get<_i57.NodeTypeMapper>(),
        get<_i56.NodeTypeEntityMapper>(),
        get<_i55.NodeTypeDTOMapper>(),
        get<_i39.HashMapper>(),
      ));
  gh.factory<_i105.PrepareInputsWrapper>(() =>
      _i105.PrepareInputsWrapper(get<_i102.LibPolygonIdCoreProofDataSource>()));
  gh.factory<_i72.ProverLibDataSource>(
      () => _i72.ProverLibDataSource(get<_i72.ProverLibWrapper>()));
  gh.factory<_i106.RhsNodeMapper>(
      () => _i106.RhsNodeMapper(get<_i82.RhsNodeTypeMapper>()));
  gh.factory<_i107.SMTDataSource>(() => _i107.SMTDataSource(
        get<_i40.HexMapper>(),
        get<_i49.LibBabyJubJubDataSource>(),
        get<_i45.StorageSMTDataSource>(),
      ));
  gh.factory<_i108.SMTRepositoryImpl>(() => _i108.SMTRepositoryImpl(
        get<_i107.SMTDataSource>(),
        get<_i45.StorageSMTDataSource>(),
        get<_i49.LibBabyJubJubDataSource>(),
        get<_i104.NodeMapper>(),
        get<_i39.HashMapper>(),
        get<_i69.ProofMapper>(),
      ));
  gh.factory<_i86.WalletDataSource>(
      () => _i86.WalletDataSource(get<_i86.WalletLibWrapper>()));
  gh.factory<_i88.WitnessDataSource>(
      () => _i88.WitnessDataSource(get<_i88.WitnessIsolatesWrapper>()));
  gh.factory<_i109.Credential>(() => _i109.Credential(
        get<_i94.FetchAndSaveClaimsUseCase>(),
        get<_i25.GetClaimsUseCase>(),
        get<_i79.RemoveClaimsUseCase>(),
        get<_i85.UpdateClaimUseCase>(),
      ));
  gh.factory<_i110.CredentialRepositoryImpl>(
      () => _i110.CredentialRepositoryImpl(
            get<_i75.RemoteClaimDataSource>(),
            get<_i10.StorageClaimDataSource>(),
            get<_i99.LibPolygonIdCoreCredentialDataSource>(),
            get<_i49.LibBabyJubJubDataSource>(),
            get<_i50.LibIdentityDataSource>(),
            get<_i103.LocalClaimDataSource>(),
            get<_i91.ClaimMapper>(),
            get<_i18.FiltersMapper>(),
            get<_i41.IdFilterMapper>(),
            get<_i104.NodeMapper>(),
            get<_i81.RevocationStatusMapper>(),
          ));
  gh.factory<_i111.GenerateProofUseCase>(() => _i111.GenerateProofUseCase(
        get<_i22.ProofRepository>(),
        get<_i23.CredentialRepository>(),
        get<_i97.GetClaimRevocationStatusUseCase>(),
      ));
  gh.factory<_i112.GetProofsUseCase>(() => _i112.GetProofsUseCase(
        get<_i22.ProofRepository>(),
        get<_i16.IdentityRepository>(),
        get<_i25.GetClaimsUseCase>(),
        get<_i111.GenerateProofUseCase>(),
        get<_i47.IsProofCircuitSupportedUseCase>(),
        get<_i37.GetProofRequestsUseCase>(),
      ));
  gh.factory<_i113.IdentityRepositoryImpl>(() => _i113.IdentityRepositoryImpl(
        get<_i86.WalletDataSource>(),
        get<_i50.LibIdentityDataSource>(),
        get<_i49.LibBabyJubJubDataSource>(),
        get<_i101.LibPolygonIdCoreIdentityDataSource>(),
        get<_i99.LibPolygonIdCoreCredentialDataSource>(),
        get<_i100.LibPolygonIdCoreIden3commDataSource>(),
        get<_i102.LibPolygonIdCoreProofDataSource>(),
        get<_i107.SMTDataSource>(),
        get<_i78.RemoteIdentityDataSource>(),
        get<_i46.StorageIdentityDataSource>(),
        get<_i73.RPCDataSource>(),
        get<_i51.LocalContractFilesDataSource>(),
        get<_i103.LocalClaimDataSource>(),
        get<_i40.HexMapper>(),
        get<_i66.PrivateKeyMapper>(),
        get<_i44.IdentityDTOMapper>(),
        get<_i106.RhsNodeMapper>(),
        get<_i104.NodeMapper>(),
        get<_i84.StateIdentifierMapper>(),
        get<_i12.DidMapper>(),
      ));
  gh.factory<_i105.PrepareInputsDataSource>(
      () => _i105.PrepareInputsDataSource(get<_i105.PrepareInputsWrapper>()));
  gh.factory<_i114.Proof>(() => _i114.Proof(get<_i111.GenerateProofUseCase>()));
  gh.factory<_i115.ProofRepositoryImpl>(() => _i115.ProofRepositoryImpl(
        get<_i88.WitnessDataSource>(),
        get<_i72.ProverLibDataSource>(),
        get<_i54.LocalProofFilesDataSource>(),
        get<_i102.LibPolygonIdCoreProofDataSource>(),
        get<_i67.ProofCircuitDataSource>(),
        get<_i78.RemoteIdentityDataSource>(),
        get<_i7.CircuitTypeMapper>(),
        get<_i70.ProofRequestFiltersMapper>(),
        get<_i68.ProofMapper>(),
        get<_i91.ClaimMapper>(),
        get<_i73.RPCDataSource>(),
        get<_i51.LocalContractFilesDataSource>(),
        get<_i81.RevocationStatusMapper>(),
      ));
  gh.factory<_i116.AuthenticateUseCase>(() => _i116.AuthenticateUseCase(
        get<_i21.Iden3commRepository>(),
        get<_i112.GetProofsUseCase>(),
        get<_i20.GetAuthTokenUseCase>(),
        get<_i27.GetEnvConfigUseCase>(),
        get<_i34.GetPackageNameUseCase>(),
        get<_i26.GetDidIdentifierUseCase>(),
      ));
  gh.factory<_i117.Iden3comm>(() => _i117.Iden3comm(
        get<_i38.GetVocabsUseCase>(),
        get<_i116.AuthenticateUseCase>(),
        get<_i112.GetProofsUseCase>(),
        get<_i32.GetIden3MessageUseCase>(),
      ));
  gh.factory<_i48.JWZDataSource>(() => _i48.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i86.WalletDataSource>(),
        get<_i105.PrepareInputsDataSource>(),
        get<_i48.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i118.Iden3commRepositoryImpl>(() => _i118.Iden3commRepositoryImpl(
        get<_i77.RemoteIden3commDataSource>(),
        get<_i100.LibPolygonIdCoreIden3commDataSource>(),
        get<_i48.JWZDataSource>(),
        get<_i40.HexMapper>(),
        get<_i69.ProofMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  return get;
}
