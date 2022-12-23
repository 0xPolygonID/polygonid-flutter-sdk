// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i36;
import 'package:sembast/sembast.dart' as _i12;
import 'package:web3dart/web3dart.dart' as _i59;

import '../../common/data/data_sources/env_datasource.dart' as _i66;
import '../../common/data/data_sources/package_info_datasource.dart' as _i37;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i79;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i38;
import '../../common/domain/repositories/config_repository.dart' as _i85;
import '../../common/domain/repositories/package_info_repository.dart' as _i75;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i88;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i81;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i39;
import '../../credential/data/credential_repository_impl.dart' as _i80;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i69;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i73;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i51;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i65;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i64;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i23;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i54;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i86;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i116;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i105;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i87;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i16;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i89;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i92;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i93;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i40;
import '../../env/sdk_env.dart' as _i56;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i70;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i52;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i48;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i95;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i108;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i115;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i111;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i17;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i18;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i19;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i113;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i41;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i27;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i28;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i29;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i71;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i30;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i31;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i53;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i77;
import '../../identity/data/data_sources/smt_data_source.dart' as _i83;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i68;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i67;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i58;
import '../../identity/data/mappers/bigint_mapper.dart' as _i7;
import '../../identity/data/mappers/did_mapper.dart' as _i13;
import '../../identity/data/mappers/hash_mapper.dart' as _i21;
import '../../identity/data/mappers/hex_mapper.dart' as _i22;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i26;
import '../../identity/data/mappers/node_mapper.dart' as _i74;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i33;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i34;
import '../../identity/data/mappers/node_type_mapper.dart' as _i35;
import '../../identity/data/mappers/private_key_mapper.dart' as _i44;
import '../../identity/data/mappers/proof_mapper.dart' as _i47;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i78;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i55;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i57;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i90;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i84;
import '../../identity/domain/repositories/identity_repository.dart' as _i96;
import '../../identity/domain/repositories/smt_repository.dart' as _i112;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i100;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i101;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i102;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i103;
import '../../identity/domain/use_cases/get_auth_claim_use_case.dart' as _i104;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i106;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i107;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i98;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i99;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/iden3core/iden3core.dart' as _i24;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i42;
import '../../proof/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i4;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i72;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i32;
import '../../proof/data/data_sources/prepare_inputs_data_source.dart' as _i76;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i45;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i50;
import '../../proof/data/data_sources/witness_data_source.dart' as _i61;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i8;
import '../../proof/data/mappers/proof_mapper.dart' as _i46;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i82;
import '../../proof/domain/repositories/proof_repository.dart' as _i91;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i110;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i94;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i97;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i43;
import '../../proof/libs/prover/prover.dart' as _i49;
import '../../proof/libs/witnesscalc/auth/witness_auth.dart' as _i60;
import '../../proof/libs/witnesscalc/mtp/witness_mtp.dart' as _i62;
import '../../proof/libs/witnesscalc/sig/witness_sig.dart' as _i63;
import '../credential.dart' as _i118;
import '../iden3comm.dart' as _i117;
import '../identity.dart' as _i109;
import '../mappers/iden3_message_type_mapper.dart' as _i25;
import '../proof.dart' as _i114;
import 'injector.dart' as _i119; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.AtomicQueryInputsWrapper>(
      () => _i4.AtomicQueryInputsWrapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.BigIntMapper>(() => _i7.BigIntMapper());
  gh.factory<_i8.CircuitTypeMapper>(() => _i8.CircuitTypeMapper());
  gh.factory<_i9.ClaimInfoMapper>(() => _i9.ClaimInfoMapper());
  gh.factory<_i10.ClaimStateMapper>(() => _i10.ClaimStateMapper());
  gh.factory<_i11.Client>(() => networkModule.client);
  gh.factoryParamAsync<_i12.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i12.Database>(() => databaseModule.database());
  gh.factory<_i13.DidMapper>(() => _i13.DidMapper());
  gh.factory<_i14.FilterMapper>(() => _i14.FilterMapper());
  gh.factory<_i15.FiltersMapper>(
      () => _i15.FiltersMapper(get<_i14.FilterMapper>()));
  gh.factory<_i16.GetFetchRequestsUseCase>(
      () => _i16.GetFetchRequestsUseCase());
  gh.factory<_i17.GetIden3MessageTypeUseCase>(
      () => _i17.GetIden3MessageTypeUseCase());
  gh.factory<_i18.GetIden3MessageUseCase>(() =>
      _i18.GetIden3MessageUseCase(get<_i17.GetIden3MessageTypeUseCase>()));
  gh.factory<_i19.GetProofQueryUseCase>(() => _i19.GetProofQueryUseCase());
  gh.factory<_i20.GetProofRequestsUseCase>(
      () => _i20.GetProofRequestsUseCase(get<_i19.GetProofQueryUseCase>()));
  gh.factory<_i21.HashMapper>(() => _i21.HashMapper());
  gh.factory<_i22.HexMapper>(() => _i22.HexMapper());
  gh.factory<_i23.IdFilterMapper>(() => _i23.IdFilterMapper());
  gh.factory<_i24.Iden3CoreLib>(() => _i24.Iden3CoreLib());
  gh.factory<_i25.Iden3MessageTypeMapper>(() => _i25.Iden3MessageTypeMapper());
  gh.factory<_i26.IdentityDTOMapper>(() => _i26.IdentityDTOMapper());
  gh.factory<_i27.JWZIsolatesWrapper>(() => _i27.JWZIsolatesWrapper());
  gh.factory<_i28.LibBabyJubJubDataSource>(
      () => _i28.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i29.LibIdentityDataSource>(
      () => _i29.LibIdentityDataSource(get<_i24.Iden3CoreLib>()));
  gh.factory<_i30.LocalContractFilesDataSource>(
      () => _i30.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i31.LocalIdentityDataSource>(
      () => _i31.LocalIdentityDataSource());
  gh.factory<_i32.LocalProofFilesDataSource>(
      () => _i32.LocalProofFilesDataSource());
  gh.factory<Map<String, _i12.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i33.NodeTypeDTOMapper>(() => _i33.NodeTypeDTOMapper());
  gh.factory<_i34.NodeTypeEntityMapper>(() => _i34.NodeTypeEntityMapper());
  gh.factory<_i35.NodeTypeMapper>(() => _i35.NodeTypeMapper());
  gh.lazySingletonAsync<_i36.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i37.PackageInfoDataSource>(() async =>
      _i37.PackageInfoDataSource(await get.getAsync<_i36.PackageInfo>()));
  gh.factoryAsync<_i38.PackageInfoRepositoryImpl>(() async =>
      _i38.PackageInfoRepositoryImpl(
          await get.getAsync<_i37.PackageInfoDataSource>()));
  gh.factory<_i39.PolygonIdCore>(() => _i39.PolygonIdCore());
  gh.factory<_i40.PolygonIdCoreCredential>(
      () => _i40.PolygonIdCoreCredential());
  gh.factory<_i41.PolygonIdCoreIden3comm>(() => _i41.PolygonIdCoreIden3comm());
  gh.factory<_i42.PolygonIdCoreIdentity>(() => _i42.PolygonIdCoreIdentity());
  gh.factory<_i43.PolygonIdCoreProof>(() => _i43.PolygonIdCoreProof());
  gh.factory<_i44.PrivateKeyMapper>(() => _i44.PrivateKeyMapper());
  gh.factory<_i45.ProofCircuitDataSource>(() => _i45.ProofCircuitDataSource());
  gh.factory<_i46.ProofMapper>(() => _i46.ProofMapper());
  gh.factory<_i47.ProofMapper>(() => _i47.ProofMapper(get<_i21.HashMapper>()));
  gh.factory<_i48.ProofRequestFiltersMapper>(
      () => _i48.ProofRequestFiltersMapper());
  gh.factory<_i49.ProverLib>(() => _i49.ProverLib());
  gh.factory<_i50.ProverLibWrapper>(() => _i50.ProverLibWrapper());
  gh.factory<_i51.RemoteClaimDataSource>(
      () => _i51.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i52.RemoteIden3commDataSource>(
      () => _i52.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i53.RemoteIdentityDataSource>(
      () => _i53.RemoteIdentityDataSource());
  gh.factory<_i54.RevocationStatusMapper>(() => _i54.RevocationStatusMapper());
  gh.factory<_i55.RhsNodeTypeMapper>(() => _i55.RhsNodeTypeMapper());
  gh.lazySingleton<_i56.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i57.StateIdentifierMapper>(() => _i57.StateIdentifierMapper());
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i58.WalletLibWrapper>(() => _i58.WalletLibWrapper());
  gh.factory<_i59.Web3Client>(
      () => networkModule.web3Client(get<_i56.SdkEnv>()));
  gh.factory<_i60.WitnessAuthLib>(() => _i60.WitnessAuthLib());
  gh.factory<_i61.WitnessIsolatesWrapper>(() => _i61.WitnessIsolatesWrapper());
  gh.factory<_i62.WitnessMtpLib>(() => _i62.WitnessMtpLib());
  gh.factory<_i63.WitnessSigLib>(() => _i63.WitnessSigLib());
  gh.factory<_i64.ClaimMapper>(() => _i64.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i65.ClaimStoreRefWrapper>(() => _i65.ClaimStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i66.EnvDataSource>(() => _i66.EnvDataSource(get<_i56.SdkEnv>()));
  gh.factory<_i67.IdentitySMTStoreRefWrapper>(() =>
      _i67.IdentitySMTStoreRefWrapper(
          get<Map<String, _i12.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i68.IdentityStoreRefWrapper>(() => _i68.IdentityStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i69.LibPolygonIdCoreCredentialDataSource>(() =>
      _i69.LibPolygonIdCoreCredentialDataSource(
          get<_i40.PolygonIdCoreCredential>()));
  gh.factory<_i70.LibPolygonIdCoreIden3commDataSource>(() =>
      _i70.LibPolygonIdCoreIden3commDataSource(
          get<_i41.PolygonIdCoreIden3comm>()));
  gh.factory<_i71.LibPolygonIdCoreIdentityDataSource>(() =>
      _i71.LibPolygonIdCoreIdentityDataSource(
          get<_i42.PolygonIdCoreIdentity>()));
  gh.factory<_i72.LibPolygonIdCoreProofDataSource>(() =>
      _i72.LibPolygonIdCoreProofDataSource(get<_i43.PolygonIdCoreProof>()));
  gh.factory<_i73.LocalClaimDataSource>(() => _i73.LocalClaimDataSource(
      get<_i69.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i74.NodeMapper>(() => _i74.NodeMapper(
        get<_i35.NodeTypeMapper>(),
        get<_i34.NodeTypeEntityMapper>(),
        get<_i33.NodeTypeDTOMapper>(),
        get<_i21.HashMapper>(),
      ));
  gh.factoryAsync<_i75.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i38.PackageInfoRepositoryImpl>()));
  gh.factory<_i76.PrepareInputsWrapper>(() =>
      _i76.PrepareInputsWrapper(get<_i72.LibPolygonIdCoreProofDataSource>()));
  gh.factory<_i50.ProverLibDataSource>(
      () => _i50.ProverLibDataSource(get<_i50.ProverLibWrapper>()));
  gh.factory<_i77.RPCDataSource>(
      () => _i77.RPCDataSource(get<_i59.Web3Client>()));
  gh.factory<_i78.RhsNodeMapper>(
      () => _i78.RhsNodeMapper(get<_i55.RhsNodeTypeMapper>()));
  gh.factory<_i65.StorageClaimDataSource>(
      () => _i65.StorageClaimDataSource(get<_i65.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i68.StorageIdentityDataSource>(
      () async => _i68.StorageIdentityDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i68.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i67.StorageSMTDataSource>(
      () => _i67.StorageSMTDataSource(get<_i67.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i58.WalletDataSource>(
      () => _i58.WalletDataSource(get<_i58.WalletLibWrapper>()));
  gh.factory<_i61.WitnessDataSource>(
      () => _i61.WitnessDataSource(get<_i61.WitnessIsolatesWrapper>()));
  gh.factory<_i79.ConfigRepositoryImpl>(
      () => _i79.ConfigRepositoryImpl(get<_i66.EnvDataSource>()));
  gh.factory<_i80.CredentialRepositoryImpl>(() => _i80.CredentialRepositoryImpl(
        get<_i51.RemoteClaimDataSource>(),
        get<_i65.StorageClaimDataSource>(),
        get<_i69.LibPolygonIdCoreCredentialDataSource>(),
        get<_i28.LibBabyJubJubDataSource>(),
        get<_i29.LibIdentityDataSource>(),
        get<_i73.LocalClaimDataSource>(),
        get<_i64.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i23.IdFilterMapper>(),
        get<_i74.NodeMapper>(),
        get<_i54.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i81.GetPackageNameUseCase>(() async =>
      _i81.GetPackageNameUseCase(
          await get.getAsync<_i75.PackageInfoRepository>()));
  gh.factory<_i76.PrepareInputsDataSource>(
      () => _i76.PrepareInputsDataSource(get<_i76.PrepareInputsWrapper>()));
  gh.factory<_i82.ProofRepositoryImpl>(() => _i82.ProofRepositoryImpl(
        get<_i61.WitnessDataSource>(),
        get<_i50.ProverLibDataSource>(),
        get<_i32.LocalProofFilesDataSource>(),
        get<_i72.LibPolygonIdCoreProofDataSource>(),
        get<_i45.ProofCircuitDataSource>(),
        get<_i53.RemoteIdentityDataSource>(),
        get<_i8.CircuitTypeMapper>(),
        get<_i48.ProofRequestFiltersMapper>(),
        get<_i46.ProofMapper>(),
        get<_i64.ClaimMapper>(),
        get<_i77.RPCDataSource>(),
        get<_i30.LocalContractFilesDataSource>(),
        get<_i54.RevocationStatusMapper>(),
      ));
  gh.factory<_i83.SMTDataSource>(() => _i83.SMTDataSource(
        get<_i22.HexMapper>(),
        get<_i28.LibBabyJubJubDataSource>(),
        get<_i67.StorageSMTDataSource>(),
      ));
  gh.factory<_i84.SMTRepositoryImpl>(() => _i84.SMTRepositoryImpl(
        get<_i83.SMTDataSource>(),
        get<_i67.StorageSMTDataSource>(),
        get<_i28.LibBabyJubJubDataSource>(),
        get<_i74.NodeMapper>(),
        get<_i21.HashMapper>(),
        get<_i47.ProofMapper>(),
      ));
  gh.factory<_i85.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i79.ConfigRepositoryImpl>()));
  gh.factory<_i86.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i80.CredentialRepositoryImpl>()));
  gh.factory<_i87.GetClaimsUseCase>(
      () => _i87.GetClaimsUseCase(get<_i86.CredentialRepository>()));
  gh.factory<_i88.GetEnvConfigUseCase>(
      () => _i88.GetEnvConfigUseCase(get<_i85.ConfigRepository>()));
  gh.factory<_i89.GetVocabsUseCase>(
      () => _i89.GetVocabsUseCase(get<_i86.CredentialRepository>()));
  gh.factoryAsync<_i90.IdentityRepositoryImpl>(
      () async => _i90.IdentityRepositoryImpl(
            get<_i58.WalletDataSource>(),
            get<_i29.LibIdentityDataSource>(),
            get<_i28.LibBabyJubJubDataSource>(),
            get<_i71.LibPolygonIdCoreIdentityDataSource>(),
            get<_i69.LibPolygonIdCoreCredentialDataSource>(),
            get<_i70.LibPolygonIdCoreIden3commDataSource>(),
            get<_i72.LibPolygonIdCoreProofDataSource>(),
            get<_i83.SMTDataSource>(),
            get<_i53.RemoteIdentityDataSource>(),
            await get.getAsync<_i68.StorageIdentityDataSource>(),
            get<_i77.RPCDataSource>(),
            get<_i30.LocalContractFilesDataSource>(),
            get<_i73.LocalClaimDataSource>(),
            get<_i22.HexMapper>(),
            get<_i44.PrivateKeyMapper>(),
            get<_i26.IdentityDTOMapper>(),
            get<_i78.RhsNodeMapper>(),
            get<_i74.NodeMapper>(),
            get<_i57.StateIdentifierMapper>(),
            get<_i13.DidMapper>(),
          ));
  gh.factory<_i27.JWZDataSource>(() => _i27.JWZDataSource(
        get<_i6.BabyjubjubLib>(),
        get<_i58.WalletDataSource>(),
        get<_i76.PrepareInputsDataSource>(),
        get<_i27.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i91.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i82.ProofRepositoryImpl>()));
  gh.factory<_i92.RemoveClaimsUseCase>(
      () => _i92.RemoveClaimsUseCase(get<_i86.CredentialRepository>()));
  gh.factory<_i93.UpdateClaimUseCase>(
      () => _i93.UpdateClaimUseCase(get<_i86.CredentialRepository>()));
  gh.factory<_i94.GetGistProofUseCase>(() => _i94.GetGistProofUseCase(
        get<_i91.ProofRepository>(),
        get<_i88.GetEnvConfigUseCase>(),
      ));
  gh.factory<_i95.Iden3commRepositoryImpl>(() => _i95.Iden3commRepositoryImpl(
        get<_i52.RemoteIden3commDataSource>(),
        get<_i70.LibPolygonIdCoreIden3commDataSource>(),
        get<_i27.JWZDataSource>(),
        get<_i22.HexMapper>(),
        get<_i47.ProofMapper>(),
        get<_i5.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i96.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i90.IdentityRepositoryImpl>()));
  gh.factory<_i97.IsProofCircuitSupportedUseCase>(
      () => _i97.IsProofCircuitSupportedUseCase(get<_i91.ProofRepository>()));
  gh.factoryAsync<_i98.RemoveIdentityUseCase>(() async =>
      _i98.RemoveIdentityUseCase(
          await get.getAsync<_i96.IdentityRepository>()));
  gh.factoryAsync<_i99.SignMessageUseCase>(() async =>
      _i99.SignMessageUseCase(await get.getAsync<_i96.IdentityRepository>()));
  gh.factoryAsync<_i100.CreateAndSaveIdentityUseCase>(
      () async => _i100.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i96.IdentityRepository>(),
            get<_i86.CredentialRepository>(),
            get<_i88.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i101.FetchIdentityStateUseCase>(
      () async => _i101.FetchIdentityStateUseCase(
            await get.getAsync<_i96.IdentityRepository>(),
            get<_i88.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i102.FetchStateRootsUseCase>(() async =>
      _i102.FetchStateRootsUseCase(
          await get.getAsync<_i96.IdentityRepository>()));
  gh.factoryAsync<_i103.GenerateNonRevProofUseCase>(
      () async => _i103.GenerateNonRevProofUseCase(
            await get.getAsync<_i96.IdentityRepository>(),
            get<_i86.CredentialRepository>(),
            get<_i88.GetEnvConfigUseCase>(),
            await get.getAsync<_i101.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i104.GetAuthClaimUseCase>(() async =>
      _i104.GetAuthClaimUseCase(await get.getAsync<_i96.IdentityRepository>()));
  gh.factoryAsync<_i105.GetClaimRevocationStatusUseCase>(
      () async => _i105.GetClaimRevocationStatusUseCase(
            get<_i86.CredentialRepository>(),
            await get.getAsync<_i96.IdentityRepository>(),
            await get.getAsync<_i103.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i106.GetDidIdentifierUseCase>(() async =>
      _i106.GetDidIdentifierUseCase(
          await get.getAsync<_i96.IdentityRepository>()));
  gh.factoryAsync<_i107.GetIdentityUseCase>(() async =>
      _i107.GetIdentityUseCase(await get.getAsync<_i96.IdentityRepository>()));
  gh.factory<_i108.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i95.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i109.Identity>(() async => _i109.Identity(
        await get.getAsync<_i100.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i107.GetIdentityUseCase>(),
        await get.getAsync<_i98.RemoveIdentityUseCase>(),
        await get.getAsync<_i106.GetDidIdentifierUseCase>(),
        await get.getAsync<_i99.SignMessageUseCase>(),
        await get.getAsync<_i101.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i110.GenerateProofUseCase>(
      () async => _i110.GenerateProofUseCase(
            get<_i91.ProofRepository>(),
            get<_i86.CredentialRepository>(),
            await get.getAsync<_i105.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i111.GetAuthTokenUseCase>(
      () async => _i111.GetAuthTokenUseCase(
            get<_i108.Iden3commRepository>(),
            get<_i91.ProofRepository>(),
            get<_i86.CredentialRepository>(),
            await get.getAsync<_i96.IdentityRepository>(),
            get<_i112.SMTRepository>(),
            get<_i13.DidMapper>(),
          ));
  gh.factoryAsync<_i113.GetProofsUseCase>(() async => _i113.GetProofsUseCase(
        get<_i91.ProofRepository>(),
        await get.getAsync<_i96.IdentityRepository>(),
        get<_i87.GetClaimsUseCase>(),
        await get.getAsync<_i110.GenerateProofUseCase>(),
        get<_i97.IsProofCircuitSupportedUseCase>(),
        get<_i20.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i114.Proof>(() async =>
      _i114.Proof(await get.getAsync<_i110.GenerateProofUseCase>()));
  gh.factoryAsync<_i115.AuthenticateUseCase>(
      () async => _i115.AuthenticateUseCase(
            get<_i108.Iden3commRepository>(),
            await get.getAsync<_i113.GetProofsUseCase>(),
            await get.getAsync<_i111.GetAuthTokenUseCase>(),
            get<_i88.GetEnvConfigUseCase>(),
            await get.getAsync<_i81.GetPackageNameUseCase>(),
            await get.getAsync<_i106.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i116.FetchAndSaveClaimsUseCase>(
      () async => _i116.FetchAndSaveClaimsUseCase(
            get<_i16.GetFetchRequestsUseCase>(),
            await get.getAsync<_i111.GetAuthTokenUseCase>(),
            get<_i86.CredentialRepository>(),
          ));
  gh.factoryAsync<_i117.Iden3comm>(() async => _i117.Iden3comm(
        get<_i89.GetVocabsUseCase>(),
        await get.getAsync<_i115.AuthenticateUseCase>(),
        await get.getAsync<_i113.GetProofsUseCase>(),
        get<_i18.GetIden3MessageUseCase>(),
      ));
  gh.factoryAsync<_i118.Credential>(() async => _i118.Credential(
        await get.getAsync<_i116.FetchAndSaveClaimsUseCase>(),
        get<_i87.GetClaimsUseCase>(),
        get<_i92.RemoveClaimsUseCase>(),
        get<_i93.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i119.PlatformModule {}

class _$NetworkModule extends _i119.NetworkModule {}

class _$DatabaseModule extends _i119.DatabaseModule {}

class _$Sdk extends _i119.Sdk {}

class _$RepositoriesModule extends _i119.RepositoriesModule {}
