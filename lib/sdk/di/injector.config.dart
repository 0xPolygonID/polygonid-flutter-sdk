// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i35;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i58;

import '../../common/data/data_sources/env_datasource.dart' as _i66;
import '../../common/data/data_sources/package_info_datasource.dart' as _i36;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i76;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i37;
import '../../common/domain/repositories/config_repository.dart' as _i82;
import '../../common/domain/repositories/package_info_repository.dart' as _i73;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i85;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i78;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i38;
import '../../credential/data/credential_repository_impl.dart' as _i77;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i69;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i50;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i65;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i8;
import '../../credential/data/mappers/claim_mapper.dart' as _i64;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i13;
import '../../credential/data/mappers/filters_mapper.dart' as _i14;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i22;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i53;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i83;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i108;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i102;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i84;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i15;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i86;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i90;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i91;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i39;
import '../../env/sdk_env.dart' as _i55;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i70;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i51;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i47;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i87;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i92;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i112;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i101;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i16;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i17;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i18;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i19;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i110;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i40;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i26;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i27;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i28;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i71;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i29;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i30;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i52;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i74;
import '../../identity/data/data_sources/smt_data_source.dart' as _i80;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i68;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i67;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i57;
import '../../identity/data/mappers/bigint_mapper.dart' as _i6;
import '../../identity/data/mappers/did_mapper.dart' as _i12;
import '../../identity/data/mappers/hash_mapper.dart' as _i20;
import '../../identity/data/mappers/hex_mapper.dart' as _i21;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i25;
import '../../identity/data/mappers/node_mapper.dart' as _i72;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i32;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i33;
import '../../identity/data/mappers/node_type_mapper.dart' as _i34;
import '../../identity/data/mappers/private_key_mapper.dart' as _i43;
import '../../identity/data/mappers/proof_mapper.dart' as _i45;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i75;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i54;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i56;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i88;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i81;
import '../../identity/domain/repositories/identity_repository.dart' as _i93;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i97;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i98;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i99;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i100;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i103;
import '../../identity/domain/use_cases/get_gist_proof_use_case.dart' as _i104;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i105;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i106;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i95;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i96;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i23;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i41;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i63;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i31;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i44;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i49;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i60;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i46;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i79;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i89;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i109;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i94;
import '../../proof_generation/libs/polygonidcore/pidcore_proof.dart' as _i42;
import '../../proof_generation/libs/prover/prover.dart' as _i48;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i59;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i61;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i62;
import '../credential.dart' as _i113;
import '../iden3comm.dart' as _i114;
import '../identity.dart' as _i107;
import '../mappers/iden3_message_type_mapper.dart' as _i24;
import '../proof.dart' as _i111;
import 'injector.dart' as _i115; // ignore_for_file: unnecessary_lambdas

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
  final platformModule = _$PlatformModule();
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final sdk = _$Sdk();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.BigIntMapper>(() => _i6.BigIntMapper());
  gh.factory<_i7.CircuitTypeMapper>(() => _i7.CircuitTypeMapper());
  gh.factory<_i8.ClaimInfoMapper>(() => _i8.ClaimInfoMapper());
  gh.factory<_i9.ClaimStateMapper>(() => _i9.ClaimStateMapper());
  gh.factory<_i10.Client>(() => networkModule.client);
  gh.factoryParamAsync<_i11.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i11.Database>(() => databaseModule.database());
  gh.factory<_i12.DidMapper>(() => _i12.DidMapper());
  gh.factory<_i13.FilterMapper>(() => _i13.FilterMapper());
  gh.factory<_i14.FiltersMapper>(
      () => _i14.FiltersMapper(get<_i13.FilterMapper>()));
  gh.factory<_i15.GetFetchRequestsUseCase>(
      () => _i15.GetFetchRequestsUseCase());
  gh.factory<_i16.GetIden3MessageTypeUseCase>(
      () => _i16.GetIden3MessageTypeUseCase());
  gh.factory<_i17.GetIden3MessageUseCase>(() =>
      _i17.GetIden3MessageUseCase(get<_i16.GetIden3MessageTypeUseCase>()));
  gh.factory<_i18.GetProofQueryUseCase>(() => _i18.GetProofQueryUseCase());
  gh.factory<_i19.GetProofRequestsUseCase>(
      () => _i19.GetProofRequestsUseCase(get<_i18.GetProofQueryUseCase>()));
  gh.factory<_i20.HashMapper>(() => _i20.HashMapper());
  gh.factory<_i21.HexMapper>(() => _i21.HexMapper());
  gh.factory<_i22.IdFilterMapper>(() => _i22.IdFilterMapper());
  gh.factory<_i23.Iden3CoreLib>(() => _i23.Iden3CoreLib());
  gh.factory<_i24.Iden3MessageTypeMapper>(() => _i24.Iden3MessageTypeMapper());
  gh.factory<_i25.IdentityDTOMapper>(() => _i25.IdentityDTOMapper());
  gh.factory<_i26.JWZIsolatesWrapper>(() => _i26.JWZIsolatesWrapper());
  gh.factory<_i27.LibBabyJubJubDataSource>(
      () => _i27.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i28.LibIdentityDataSource>(
      () => _i28.LibIdentityDataSource(get<_i23.Iden3CoreLib>()));
  gh.factory<_i29.LocalContractFilesDataSource>(
      () => _i29.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i30.LocalIdentityDataSource>(
      () => _i30.LocalIdentityDataSource());
  gh.factory<_i31.LocalProofFilesDataSource>(
      () => _i31.LocalProofFilesDataSource());
  gh.factory<Map<String, _i11.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i32.NodeTypeDTOMapper>(() => _i32.NodeTypeDTOMapper());
  gh.factory<_i33.NodeTypeEntityMapper>(() => _i33.NodeTypeEntityMapper());
  gh.factory<_i34.NodeTypeMapper>(() => _i34.NodeTypeMapper());
  gh.lazySingletonAsync<_i35.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i36.PackageInfoDataSource>(() async =>
      _i36.PackageInfoDataSource(await get.getAsync<_i35.PackageInfo>()));
  gh.factoryAsync<_i37.PackageInfoRepositoryImpl>(() async =>
      _i37.PackageInfoRepositoryImpl(
          await get.getAsync<_i36.PackageInfoDataSource>()));
  gh.factory<_i38.PolygonIdCore>(() => _i38.PolygonIdCore());
  gh.factory<_i39.PolygonIdCoreCredential>(
      () => _i39.PolygonIdCoreCredential());
  gh.factory<_i40.PolygonIdCoreIden3comm>(() => _i40.PolygonIdCoreIden3comm());
  gh.factory<_i41.PolygonIdCoreIdentity>(() => _i41.PolygonIdCoreIdentity());
  gh.factory<_i42.PolygonIdCoreProof>(() => _i42.PolygonIdCoreProof());
  gh.factory<_i43.PrivateKeyMapper>(() => _i43.PrivateKeyMapper());
  gh.factory<_i44.ProofCircuitDataSource>(() => _i44.ProofCircuitDataSource());
  gh.factory<_i45.ProofMapper>(() => _i45.ProofMapper(get<_i20.HashMapper>()));
  gh.factory<_i46.ProofMapper>(() => _i46.ProofMapper());
  gh.factory<_i47.ProofRequestFiltersMapper>(
      () => _i47.ProofRequestFiltersMapper());
  gh.factory<_i48.ProverLib>(() => _i48.ProverLib());
  gh.factory<_i49.ProverLibWrapper>(() => _i49.ProverLibWrapper());
  gh.factory<_i50.RemoteClaimDataSource>(
      () => _i50.RemoteClaimDataSource(get<_i10.Client>()));
  gh.factory<_i51.RemoteIden3commDataSource>(
      () => _i51.RemoteIden3commDataSource(get<_i10.Client>()));
  gh.factory<_i52.RemoteIdentityDataSource>(
      () => _i52.RemoteIdentityDataSource());
  gh.factory<_i53.RevocationStatusMapper>(() => _i53.RevocationStatusMapper());
  gh.factory<_i54.RhsNodeTypeMapper>(() => _i54.RhsNodeTypeMapper());
  gh.lazySingleton<_i55.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i56.StateIdentifierMapper>(() => _i56.StateIdentifierMapper());
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i57.WalletLibWrapper>(() => _i57.WalletLibWrapper());
  gh.factory<_i58.Web3Client>(
      () => networkModule.web3Client(get<_i55.SdkEnv>()));
  gh.factory<_i59.WitnessAuthLib>(() => _i59.WitnessAuthLib());
  gh.factory<_i60.WitnessIsolatesWrapper>(() => _i60.WitnessIsolatesWrapper());
  gh.factory<_i61.WitnessMtpLib>(() => _i61.WitnessMtpLib());
  gh.factory<_i62.WitnessSigLib>(() => _i62.WitnessSigLib());
  gh.factory<_i63.AtomicQueryInputsWrapper>(
      () => _i63.AtomicQueryInputsWrapper(get<_i23.Iden3CoreLib>()));
  gh.factory<_i64.ClaimMapper>(() => _i64.ClaimMapper(
        get<_i9.ClaimStateMapper>(),
        get<_i8.ClaimInfoMapper>(),
      ));
  gh.factory<_i65.ClaimStoreRefWrapper>(() => _i65.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i66.EnvDataSource>(() => _i66.EnvDataSource(get<_i55.SdkEnv>()));
  gh.factory<_i67.IdentitySMTStoreRefWrapper>(() =>
      _i67.IdentitySMTStoreRefWrapper(
          get<Map<String, _i11.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i68.IdentityStoreRefWrapper>(() => _i68.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i69.LibPolygonIdCoreCredentialDataSource>(() =>
      _i69.LibPolygonIdCoreCredentialDataSource(
          get<_i39.PolygonIdCoreCredential>()));
  gh.factory<_i70.LibPolygonIdCoreIden3commDataSource>(() =>
      _i70.LibPolygonIdCoreIden3commDataSource(
          get<_i40.PolygonIdCoreIden3comm>()));
  gh.factory<_i71.LibPolygonIdCoreIdentityDataSource>(() =>
      _i71.LibPolygonIdCoreIdentityDataSource(
          get<_i41.PolygonIdCoreIdentity>()));
  gh.factory<_i72.NodeMapper>(() => _i72.NodeMapper(
        get<_i34.NodeTypeMapper>(),
        get<_i33.NodeTypeEntityMapper>(),
        get<_i32.NodeTypeDTOMapper>(),
        get<_i20.HashMapper>(),
      ));
  gh.factoryAsync<_i73.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i37.PackageInfoRepositoryImpl>()));
  gh.factory<_i49.ProverLibDataSource>(
      () => _i49.ProverLibDataSource(get<_i49.ProverLibWrapper>()));
  gh.factory<_i74.RPCDataSource>(
      () => _i74.RPCDataSource(get<_i58.Web3Client>()));
  gh.factory<_i75.RhsNodeMapper>(
      () => _i75.RhsNodeMapper(get<_i54.RhsNodeTypeMapper>()));
  gh.factory<_i65.StorageClaimDataSource>(
      () => _i65.StorageClaimDataSource(get<_i65.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i68.StorageIdentityDataSource>(
      () async => _i68.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i68.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i67.StorageSMTDataSource>(
      () => _i67.StorageSMTDataSource(get<_i67.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i57.WalletDataSource>(
      () => _i57.WalletDataSource(get<_i57.WalletLibWrapper>()));
  gh.factory<_i60.WitnessDataSource>(
      () => _i60.WitnessDataSource(get<_i60.WitnessIsolatesWrapper>()));
  gh.factory<_i63.AtomicQueryInputsDataSource>(() =>
      _i63.AtomicQueryInputsDataSource(get<_i63.AtomicQueryInputsWrapper>()));
  gh.factory<_i76.ConfigRepositoryImpl>(
      () => _i76.ConfigRepositoryImpl(get<_i66.EnvDataSource>()));
  gh.factory<_i77.CredentialRepositoryImpl>(() => _i77.CredentialRepositoryImpl(
        get<_i50.RemoteClaimDataSource>(),
        get<_i65.StorageClaimDataSource>(),
        get<_i69.LibPolygonIdCoreCredentialDataSource>(),
        get<_i27.LibBabyJubJubDataSource>(),
        get<dynamic>(),
        get<_i28.LibIdentityDataSource>(),
        get<_i64.ClaimMapper>(),
        get<_i14.FiltersMapper>(),
        get<_i22.IdFilterMapper>(),
        get<_i72.NodeMapper>(),
        get<_i53.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i78.GetPackageNameUseCase>(() async =>
      _i78.GetPackageNameUseCase(
          await get.getAsync<_i73.PackageInfoRepository>()));
  gh.factory<_i26.JWZDataSource>(() => _i26.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i57.WalletDataSource>(),
        get<_i26.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i79.ProofRepositoryImpl>(() => _i79.ProofRepositoryImpl(
        get<_i60.WitnessDataSource>(),
        get<_i49.ProverLibDataSource>(),
        get<_i63.AtomicQueryInputsDataSource>(),
        get<_i31.LocalProofFilesDataSource>(),
        get<_i44.ProofCircuitDataSource>(),
        get<_i52.RemoteIdentityDataSource>(),
        get<_i7.CircuitTypeMapper>(),
        get<_i47.ProofRequestFiltersMapper>(),
        get<_i46.ProofMapper>(),
        get<_i64.ClaimMapper>(),
        get<_i53.RevocationStatusMapper>(),
      ));
  gh.factory<_i80.SMTDataSource>(() => _i80.SMTDataSource(
        get<_i21.HexMapper>(),
        get<_i27.LibBabyJubJubDataSource>(),
        get<_i67.StorageSMTDataSource>(),
      ));
  gh.factory<_i81.SMTRepositoryImpl>(() => _i81.SMTRepositoryImpl(
        get<_i80.SMTDataSource>(),
        get<_i67.StorageSMTDataSource>(),
        get<_i27.LibBabyJubJubDataSource>(),
        get<_i72.NodeMapper>(),
        get<_i20.HashMapper>(),
        get<_i45.ProofMapper>(),
      ));
  gh.factory<_i82.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i76.ConfigRepositoryImpl>()));
  gh.factory<_i83.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i77.CredentialRepositoryImpl>()));
  gh.factory<_i84.GetClaimsUseCase>(
      () => _i84.GetClaimsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i85.GetEnvConfigUseCase>(
      () => _i85.GetEnvConfigUseCase(get<_i82.ConfigRepository>()));
  gh.factory<_i86.GetVocabsUseCase>(
      () => _i86.GetVocabsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i87.Iden3commRepositoryImpl>(() => _i87.Iden3commRepositoryImpl(
        get<_i51.RemoteIden3commDataSource>(),
        get<_i26.JWZDataSource>(),
        get<_i21.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i88.IdentityRepositoryImpl>(
      () async => _i88.IdentityRepositoryImpl(
            get<_i57.WalletDataSource>(),
            get<_i28.LibIdentityDataSource>(),
            get<_i27.LibBabyJubJubDataSource>(),
            get<_i71.LibPolygonIdCoreIdentityDataSource>(),
            get<_i69.LibPolygonIdCoreCredentialDataSource>(),
            get<_i70.LibPolygonIdCoreIden3commDataSource>(),
            get<_i80.SMTDataSource>(),
            get<_i52.RemoteIdentityDataSource>(),
            await get.getAsync<_i68.StorageIdentityDataSource>(),
            get<_i74.RPCDataSource>(),
            get<_i29.LocalContractFilesDataSource>(),
            get<_i21.HexMapper>(),
            get<_i43.PrivateKeyMapper>(),
            get<_i25.IdentityDTOMapper>(),
            get<_i75.RhsNodeMapper>(),
            get<_i56.StateIdentifierMapper>(),
            get<_i12.DidMapper>(),
          ));
  gh.factory<_i89.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i79.ProofRepositoryImpl>()));
  gh.factory<_i90.RemoveClaimsUseCase>(
      () => _i90.RemoveClaimsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i91.UpdateClaimUseCase>(
      () => _i91.UpdateClaimUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i92.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i87.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i93.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i88.IdentityRepositoryImpl>()));
  gh.factory<_i94.IsProofCircuitSupportedUseCase>(
      () => _i94.IsProofCircuitSupportedUseCase(get<_i89.ProofRepository>()));
  gh.factoryAsync<_i95.RemoveIdentityUseCase>(() async =>
      _i95.RemoveIdentityUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i96.SignMessageUseCase>(() async =>
      _i96.SignMessageUseCase(await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i97.CreateAndSaveIdentityUseCase>(
      () async => _i97.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i98.FetchIdentityStateUseCase>(
      () async => _i98.FetchIdentityStateUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i99.FetchStateRootsUseCase>(() async =>
      _i99.FetchStateRootsUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i100.GenerateNonRevProofUseCase>(
      () async => _i100.GenerateNonRevProofUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i83.CredentialRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
            await get.getAsync<_i98.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i101.GetAuthTokenUseCase>(
      () async => _i101.GetAuthTokenUseCase(
            get<_i92.Iden3commRepository>(),
            get<_i89.ProofRepository>(),
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i93.IdentityRepository>(),
          ));
  gh.factoryAsync<_i102.GetClaimRevocationStatusUseCase>(
      () async => _i102.GetClaimRevocationStatusUseCase(
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i93.IdentityRepository>(),
            await get.getAsync<_i100.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i103.GetDidIdentifierUseCase>(() async =>
      _i103.GetDidIdentifierUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i104.GetGistProofUseCase>(
      () async => _i104.GetGistProofUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i105.GetIdentifierUseCase>(() async =>
      _i105.GetIdentifierUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i106.GetIdentityUseCase>(() async =>
      _i106.GetIdentityUseCase(await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i107.Identity>(() async => _i107.Identity(
        await get.getAsync<_i97.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i106.GetIdentityUseCase>(),
        await get.getAsync<_i95.RemoveIdentityUseCase>(),
        await get.getAsync<_i105.GetIdentifierUseCase>(),
        await get.getAsync<_i96.SignMessageUseCase>(),
        await get.getAsync<_i98.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i108.FetchAndSaveClaimsUseCase>(
      () async => _i108.FetchAndSaveClaimsUseCase(
            get<_i15.GetFetchRequestsUseCase>(),
            await get.getAsync<_i101.GetAuthTokenUseCase>(),
            get<_i83.CredentialRepository>(),
          ));
  gh.factoryAsync<_i109.GenerateProofUseCase>(
      () async => _i109.GenerateProofUseCase(
            get<_i89.ProofRepository>(),
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i102.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i110.GetProofsUseCase>(() async => _i110.GetProofsUseCase(
        get<_i89.ProofRepository>(),
        await get.getAsync<_i93.IdentityRepository>(),
        get<_i84.GetClaimsUseCase>(),
        await get.getAsync<_i109.GenerateProofUseCase>(),
        get<_i94.IsProofCircuitSupportedUseCase>(),
        get<_i19.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i111.Proof>(() async =>
      _i111.Proof(await get.getAsync<_i109.GenerateProofUseCase>()));
  gh.factoryAsync<_i112.AuthenticateUseCase>(
      () async => _i112.AuthenticateUseCase(
            get<_i92.Iden3commRepository>(),
            await get.getAsync<_i110.GetProofsUseCase>(),
            await get.getAsync<_i101.GetAuthTokenUseCase>(),
            get<_i85.GetEnvConfigUseCase>(),
            await get.getAsync<_i78.GetPackageNameUseCase>(),
            await get.getAsync<_i103.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i113.Credential>(() async => _i113.Credential(
        await get.getAsync<_i108.FetchAndSaveClaimsUseCase>(),
        get<_i84.GetClaimsUseCase>(),
        get<_i90.RemoveClaimsUseCase>(),
        get<_i91.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i114.Iden3comm>(() async => _i114.Iden3comm(
        get<_i86.GetVocabsUseCase>(),
        await get.getAsync<_i112.AuthenticateUseCase>(),
        await get.getAsync<_i110.GetProofsUseCase>(),
        get<_i17.GetIden3MessageUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i115.PlatformModule {}

class _$NetworkModule extends _i115.NetworkModule {}

class _$DatabaseModule extends _i115.DatabaseModule {}

class _$Sdk extends _i115.Sdk {}

class _$RepositoriesModule extends _i115.RepositoriesModule {}
