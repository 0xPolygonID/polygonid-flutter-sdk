// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt/encrypt.dart' as _i16;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i42;
import 'package:sembast/sembast.dart' as _i14;
import 'package:web3dart/web3dart.dart' as _i65;

import '../../common/data/data_sources/env_datasource.dart' as _i73;
import '../../common/data/data_sources/package_info_datasource.dart' as _i43;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i88;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i44;
import '../../common/domain/repositories/config_repository.dart' as _i94;
import '../../common/domain/repositories/package_info_repository.dart' as _i84;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i99;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i90;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i45;
import '../../credential/data/credential_repository_impl.dart' as _i89;
import '../../credential/data/data_sources/db_destination_path_data_source.dart'
    as _i13;
import '../../credential/data/data_sources/encryption_db_data_source.dart'
    as _i17;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i78;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i82;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i57;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i72;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i10;
import '../../credential/data/mappers/claim_mapper.dart' as _i71;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i11;
import '../../credential/data/mappers/encryption_key_mapper.dart' as _i18;
import '../../credential/data/mappers/filter_mapper.dart' as _i19;
import '../../credential/data/mappers/filters_mapper.dart' as _i20;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i27;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i60;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i95;
import '../../credential/domain/use_cases/export_claims_use_case.dart' as _i96;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i132;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i97;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i122;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i98;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i21;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i100;
import '../../credential/domain/use_cases/import_claims_use_case.dart' as _i102;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i105;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i107;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i46;
import '../../env/sdk_env.dart' as _i62;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i79;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i58;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i6;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i53;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i110;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i125;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i131;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i128;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i24;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i25;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i129;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i47;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i30;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i33;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i80;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i34;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i35;
import '../../identity/data/data_sources/prepare_inputs_data_source.dart'
    as _i85;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i59;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i86;
import '../../identity/data/data_sources/smt_data_source.dart' as _i92;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i77;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i76;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i64;
import '../../identity/data/mappers/auth_inputs_mapper.dart' as _i5;
import '../../identity/data/mappers/bigint_mapper.dart' as _i8;
import '../../identity/data/mappers/did_mapper.dart' as _i15;
import '../../identity/data/mappers/hash_mapper.dart' as _i75;
import '../../identity/data/mappers/hex_mapper.dart' as _i26;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i29;
import '../../identity/data/mappers/node_hash_mapper.dart' as _i38;
import '../../identity/data/mappers/node_mapper.dart' as _i83;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i39;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i40;
import '../../identity/data/mappers/node_type_mapper.dart' as _i41;
import '../../identity/data/mappers/private_key_mapper.dart' as _i50;
import '../../identity/data/mappers/q_mapper.dart' as _i56;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i87;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i61;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i63;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i101;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i93;
import '../../identity/domain/repositories/identity_repository.dart' as _i111;
import '../../identity/domain/repositories/smt_repository.dart' as _i106;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i116;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i117;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i118;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i119;
import '../../identity/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i120;
import '../../identity/domain/use_cases/get_auth_claim_use_case.dart' as _i121;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i123;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i124;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i114;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i115;
import '../../identity/libs/bjj/bjj.dart' as _i7;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i48;
import '../../proof/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i4;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i81;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i36;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i51;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i55;
import '../../proof/data/data_sources/witness_data_source.dart' as _i68;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i9;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i74;
import '../../proof/data/mappers/jwz_mapper.dart' as _i31;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i32;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i37;
import '../../proof/data/mappers/proof_mapper.dart' as _i52;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i91;
import '../../proof/domain/repositories/proof_repository.dart' as _i103;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i127;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i108;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i109;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i112;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i113;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i104;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i49;
import '../../proof/libs/prover/prover.dart' as _i54;
import '../../proof/libs/witnesscalc/auth/witness_auth.dart' as _i66;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i67;
import '../../proof/libs/witnesscalc/mtp/witness_mtp.dart' as _i69;
import '../../proof/libs/witnesscalc/sig/witness_sig.dart' as _i70;
import '../credential.dart' as _i134;
import '../iden3comm.dart' as _i133;
import '../identity.dart' as _i126;
import '../mappers/iden3_message_type_mapper.dart' as _i28;
import '../proof.dart' as _i130;
import 'injector.dart' as _i135; // ignore_for_file: unnecessary_lambdas

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
  final encryptionModule = _$EncryptionModule();
  final sdk = _$Sdk();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AtomicQueryInputsWrapper>(
      () => _i4.AtomicQueryInputsWrapper());
  gh.factory<_i5.AuthInputsMapper>(() => _i5.AuthInputsMapper());
  gh.factory<_i6.AuthResponseMapper>(() => _i6.AuthResponseMapper());
  gh.factory<_i7.BabyjubjubLib>(() => _i7.BabyjubjubLib());
  gh.factory<_i8.BigIntMapper>(() => _i8.BigIntMapper());
  gh.factory<_i9.CircuitTypeMapper>(() => _i9.CircuitTypeMapper());
  gh.factory<_i10.ClaimInfoMapper>(() => _i10.ClaimInfoMapper());
  gh.factory<_i11.ClaimStateMapper>(() => _i11.ClaimStateMapper());
  gh.factory<_i12.Client>(() => networkModule.client);
  gh.factory<_i13.CreatePathWrapper>(() => _i13.CreatePathWrapper());
  gh.factoryParamAsync<_i14.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i14.Database>(() => databaseModule.database());
  gh.factory<_i13.DestinationPathDataSource>(
      () => _i13.DestinationPathDataSource(get<_i13.CreatePathWrapper>()));
  gh.factory<_i15.DidMapper>(() => _i15.DidMapper());
  gh.factoryParam<_i16.Encrypter, _i16.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i17.EncryptionDbDataSource>(() => _i17.EncryptionDbDataSource());
  gh.factory<_i18.EncryptionKeyMapper>(() => _i18.EncryptionKeyMapper());
  gh.factory<_i19.FilterMapper>(() => _i19.FilterMapper());
  gh.factory<_i20.FiltersMapper>(
      () => _i20.FiltersMapper(get<_i19.FilterMapper>()));
  gh.factory<_i21.GetFetchRequestsUseCase>(
      () => _i21.GetFetchRequestsUseCase());
  gh.factory<_i22.GetIden3MessageTypeUseCase>(
      () => _i22.GetIden3MessageTypeUseCase());
  gh.factory<_i23.GetIden3MessageUseCase>(() =>
      _i23.GetIden3MessageUseCase(get<_i22.GetIden3MessageTypeUseCase>()));
  gh.factory<_i24.GetProofQueryUseCase>(() => _i24.GetProofQueryUseCase());
  gh.factory<_i25.GetProofRequestsUseCase>(
      () => _i25.GetProofRequestsUseCase(get<_i24.GetProofQueryUseCase>()));
  gh.factory<_i26.HexMapper>(() => _i26.HexMapper());
  gh.factory<_i27.IdFilterMapper>(() => _i27.IdFilterMapper());
  gh.factory<_i28.Iden3MessageTypeMapper>(() => _i28.Iden3MessageTypeMapper());
  gh.factory<_i29.IdentityDTOMapper>(() => _i29.IdentityDTOMapper());
  gh.factory<_i30.JWZIsolatesWrapper>(() => _i30.JWZIsolatesWrapper());
  gh.factory<_i31.JWZMapper>(() => _i31.JWZMapper());
  gh.factory<_i32.JWZProofMapper>(() => _i32.JWZProofMapper());
  gh.factory<_i33.LibBabyJubJubDataSource>(
      () => _i33.LibBabyJubJubDataSource(get<_i7.BabyjubjubLib>()));
  gh.factory<_i34.LocalContractFilesDataSource>(
      () => _i34.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i35.LocalIdentityDataSource>(
      () => _i35.LocalIdentityDataSource());
  gh.factory<_i36.LocalProofFilesDataSource>(
      () => _i36.LocalProofFilesDataSource());
  gh.factory<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i37.NodeAuxMapper>(() => _i37.NodeAuxMapper());
  gh.factory<_i38.NodeHashMapper>(() => _i38.NodeHashMapper());
  gh.factory<_i39.NodeTypeDTOMapper>(() => _i39.NodeTypeDTOMapper());
  gh.factory<_i40.NodeTypeEntityMapper>(() => _i40.NodeTypeEntityMapper());
  gh.factory<_i41.NodeTypeMapper>(() => _i41.NodeTypeMapper());
  gh.lazySingletonAsync<_i42.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i43.PackageInfoDataSource>(() async =>
      _i43.PackageInfoDataSource(await get.getAsync<_i42.PackageInfo>()));
  gh.factoryAsync<_i44.PackageInfoRepositoryImpl>(() async =>
      _i44.PackageInfoRepositoryImpl(
          await get.getAsync<_i43.PackageInfoDataSource>()));
  gh.factory<_i45.PolygonIdCore>(() => _i45.PolygonIdCore());
  gh.factory<_i46.PolygonIdCoreCredential>(
      () => _i46.PolygonIdCoreCredential());
  gh.factory<_i47.PolygonIdCoreIden3comm>(() => _i47.PolygonIdCoreIden3comm());
  gh.factory<_i48.PolygonIdCoreIdentity>(() => _i48.PolygonIdCoreIdentity());
  gh.factory<_i49.PolygonIdCoreProof>(() => _i49.PolygonIdCoreProof());
  gh.factory<_i50.PrivateKeyMapper>(() => _i50.PrivateKeyMapper());
  gh.factory<_i51.ProofCircuitDataSource>(() => _i51.ProofCircuitDataSource());
  gh.factory<_i52.ProofMapper>(() => _i52.ProofMapper(
        get<_i38.NodeHashMapper>(),
        get<_i37.NodeAuxMapper>(),
      ));
  gh.factory<_i53.ProofRequestFiltersMapper>(
      () => _i53.ProofRequestFiltersMapper());
  gh.factory<_i54.ProverLib>(() => _i54.ProverLib());
  gh.factory<_i55.ProverLibWrapper>(() => _i55.ProverLibWrapper());
  gh.factory<_i56.QMapper>(() => _i56.QMapper());
  gh.factory<_i57.RemoteClaimDataSource>(
      () => _i57.RemoteClaimDataSource(get<_i12.Client>()));
  gh.factory<_i58.RemoteIden3commDataSource>(
      () => _i58.RemoteIden3commDataSource(get<_i12.Client>()));
  gh.factory<_i59.RemoteIdentityDataSource>(
      () => _i59.RemoteIdentityDataSource());
  gh.factory<_i60.RevocationStatusMapper>(() => _i60.RevocationStatusMapper());
  gh.factory<_i61.RhsNodeTypeMapper>(() => _i61.RhsNodeTypeMapper());
  gh.lazySingleton<_i62.SdkEnv>(() => sdk.sdkEnv);
  gh.factoryParam<_i14.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i63.StateIdentifierMapper>(() => _i63.StateIdentifierMapper());
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i64.WalletLibWrapper>(() => _i64.WalletLibWrapper());
  gh.factory<_i65.Web3Client>(
      () => networkModule.web3Client(get<_i62.SdkEnv>()));
  gh.factory<_i66.WitnessAuthLib>(() => _i66.WitnessAuthLib());
  gh.factory<_i67.WitnessAuthV2Lib>(() => _i67.WitnessAuthV2Lib());
  gh.factory<_i68.WitnessIsolatesWrapper>(() => _i68.WitnessIsolatesWrapper());
  gh.factory<_i69.WitnessMtpLib>(() => _i69.WitnessMtpLib());
  gh.factory<_i70.WitnessSigLib>(() => _i70.WitnessSigLib());
  gh.factory<_i71.ClaimMapper>(() => _i71.ClaimMapper(
        get<_i11.ClaimStateMapper>(),
        get<_i10.ClaimInfoMapper>(),
      ));
  gh.factory<_i72.ClaimStoreRefWrapper>(() => _i72.ClaimStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i73.EnvDataSource>(() => _i73.EnvDataSource(get<_i62.SdkEnv>()));
  gh.factory<_i74.GistProofMapper>(
      () => _i74.GistProofMapper(get<_i52.ProofMapper>()));
  gh.factory<_i75.HashMapper>(() => _i75.HashMapper(get<_i26.HexMapper>()));
  gh.factory<_i76.IdentitySMTStoreRefWrapper>(() =>
      _i76.IdentitySMTStoreRefWrapper(
          get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i77.IdentityStoreRefWrapper>(() => _i77.IdentityStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i78.LibPolygonIdCoreCredentialDataSource>(() =>
      _i78.LibPolygonIdCoreCredentialDataSource(
          get<_i46.PolygonIdCoreCredential>()));
  gh.factory<_i79.LibPolygonIdCoreIden3commDataSource>(() =>
      _i79.LibPolygonIdCoreIden3commDataSource(
          get<_i47.PolygonIdCoreIden3comm>()));
  gh.factory<_i80.LibPolygonIdCoreIdentityDataSource>(() =>
      _i80.LibPolygonIdCoreIdentityDataSource(
          get<_i48.PolygonIdCoreIdentity>()));
  gh.factory<_i81.LibPolygonIdCoreProofDataSource>(() =>
      _i81.LibPolygonIdCoreProofDataSource(get<_i49.PolygonIdCoreProof>()));
  gh.factory<_i82.LocalClaimDataSource>(() => _i82.LocalClaimDataSource(
      get<_i78.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i83.NodeMapper>(() => _i83.NodeMapper(
        get<_i41.NodeTypeMapper>(),
        get<_i40.NodeTypeEntityMapper>(),
        get<_i39.NodeTypeDTOMapper>(),
        get<_i38.NodeHashMapper>(),
      ));
  gh.factoryAsync<_i84.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i44.PackageInfoRepositoryImpl>()));
  gh.factory<_i85.PrepareInputsWrapper>(() => _i85.PrepareInputsWrapper(
      get<_i79.LibPolygonIdCoreIden3commDataSource>()));
  gh.factory<_i55.ProverLibDataSource>(
      () => _i55.ProverLibDataSource(get<_i55.ProverLibWrapper>()));
  gh.factory<_i86.RPCDataSource>(
      () => _i86.RPCDataSource(get<_i65.Web3Client>()));
  gh.factory<_i87.RhsNodeMapper>(
      () => _i87.RhsNodeMapper(get<_i61.RhsNodeTypeMapper>()));
  gh.factory<_i72.StorageClaimDataSource>(
      () => _i72.StorageClaimDataSource(get<_i72.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i77.StorageIdentityDataSource>(
      () async => _i77.StorageIdentityDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i77.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i76.StorageSMTDataSource>(
      () => _i76.StorageSMTDataSource(get<_i76.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i64.WalletDataSource>(
      () => _i64.WalletDataSource(get<_i64.WalletLibWrapper>()));
  gh.factory<_i68.WitnessDataSource>(
      () => _i68.WitnessDataSource(get<_i68.WitnessIsolatesWrapper>()));
  gh.factory<_i88.ConfigRepositoryImpl>(
      () => _i88.ConfigRepositoryImpl(get<_i73.EnvDataSource>()));
  gh.factory<_i89.CredentialRepositoryImpl>(() => _i89.CredentialRepositoryImpl(
        get<_i57.RemoteClaimDataSource>(),
        get<_i72.StorageClaimDataSource>(),
        get<_i78.LibPolygonIdCoreCredentialDataSource>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i82.LocalClaimDataSource>(),
        get<_i71.ClaimMapper>(),
        get<_i20.FiltersMapper>(),
        get<_i27.IdFilterMapper>(),
        get<_i17.EncryptionDbDataSource>(),
        get<_i13.DestinationPathDataSource>(),
        get<_i18.EncryptionKeyMapper>(),
        get<_i83.NodeMapper>(),
        get<_i60.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i90.GetPackageNameUseCase>(() async =>
      _i90.GetPackageNameUseCase(
          await get.getAsync<_i84.PackageInfoRepository>()));
  gh.factory<_i85.PrepareInputsDataSource>(
      () => _i85.PrepareInputsDataSource(get<_i85.PrepareInputsWrapper>()));
  gh.factory<_i91.ProofRepositoryImpl>(() => _i91.ProofRepositoryImpl(
        get<_i68.WitnessDataSource>(),
        get<_i55.ProverLibDataSource>(),
        get<_i36.LocalProofFilesDataSource>(),
        get<_i81.LibPolygonIdCoreProofDataSource>(),
        get<_i51.ProofCircuitDataSource>(),
        get<_i59.RemoteIdentityDataSource>(),
        get<_i9.CircuitTypeMapper>(),
        get<_i53.ProofRequestFiltersMapper>(),
        get<_i52.ProofMapper>(),
        get<_i74.GistProofMapper>(),
        get<_i32.JWZProofMapper>(),
        get<_i71.ClaimMapper>(),
        get<_i86.RPCDataSource>(),
        get<_i34.LocalContractFilesDataSource>(),
        get<_i60.RevocationStatusMapper>(),
        get<_i31.JWZMapper>(),
      ));
  gh.factory<_i92.SMTDataSource>(() => _i92.SMTDataSource(
        get<_i26.HexMapper>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i76.StorageSMTDataSource>(),
      ));
  gh.factory<_i93.SMTRepositoryImpl>(() => _i93.SMTRepositoryImpl(
        get<_i92.SMTDataSource>(),
        get<_i76.StorageSMTDataSource>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i83.NodeMapper>(),
        get<_i38.NodeHashMapper>(),
        get<_i52.ProofMapper>(),
      ));
  gh.factory<_i94.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i88.ConfigRepositoryImpl>()));
  gh.factory<_i95.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i89.CredentialRepositoryImpl>()));
  gh.factory<_i96.ExportClaimsUseCase>(
      () => _i96.ExportClaimsUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i97.GetAuthClaimUseCase>(
      () => _i97.GetAuthClaimUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i98.GetClaimsUseCase>(
      () => _i98.GetClaimsUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i99.GetEnvConfigUseCase>(
      () => _i99.GetEnvConfigUseCase(get<_i94.ConfigRepository>()));
  gh.factory<_i100.GetVocabsUseCase>(
      () => _i100.GetVocabsUseCase(get<_i95.CredentialRepository>()));
  gh.factoryAsync<_i101.IdentityRepositoryImpl>(
      () async => _i101.IdentityRepositoryImpl(
            get<_i64.WalletDataSource>(),
            get<_i33.LibBabyJubJubDataSource>(),
            get<_i80.LibPolygonIdCoreIdentityDataSource>(),
            get<_i78.LibPolygonIdCoreCredentialDataSource>(),
            get<_i79.LibPolygonIdCoreIden3commDataSource>(),
            get<_i81.LibPolygonIdCoreProofDataSource>(),
            get<_i92.SMTDataSource>(),
            get<_i59.RemoteIdentityDataSource>(),
            await get.getAsync<_i77.StorageIdentityDataSource>(),
            get<_i86.RPCDataSource>(),
            get<_i34.LocalContractFilesDataSource>(),
            get<_i82.LocalClaimDataSource>(),
            get<_i26.HexMapper>(),
            get<_i50.PrivateKeyMapper>(),
            get<_i29.IdentityDTOMapper>(),
            get<_i87.RhsNodeMapper>(),
            get<_i83.NodeMapper>(),
            get<_i63.StateIdentifierMapper>(),
            get<_i15.DidMapper>(),
            get<_i75.HashMapper>(),
            get<_i5.AuthInputsMapper>(),
            get<_i56.QMapper>(),
          ));
  gh.factory<_i102.ImportClaimsUseCase>(
      () => _i102.ImportClaimsUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i30.JWZDataSource>(() => _i30.JWZDataSource(
        get<_i7.BabyjubjubLib>(),
        get<_i64.WalletDataSource>(),
        get<_i85.PrepareInputsDataSource>(),
        get<_i30.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i103.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i91.ProofRepositoryImpl>()));
  gh.factory<_i104.ProveUseCase>(
      () => _i104.ProveUseCase(get<_i103.ProofRepository>()));
  gh.factory<_i105.RemoveClaimsUseCase>(
      () => _i105.RemoveClaimsUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i106.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i93.SMTRepositoryImpl>()));
  gh.factory<_i107.UpdateClaimUseCase>(
      () => _i107.UpdateClaimUseCase(get<_i95.CredentialRepository>()));
  gh.factory<_i108.GetGistProofUseCase>(() => _i108.GetGistProofUseCase(
        get<_i103.ProofRepository>(),
        get<_i99.GetEnvConfigUseCase>(),
      ));
  gh.factory<_i109.GetJWZUseCase>(
      () => _i109.GetJWZUseCase(get<_i103.ProofRepository>()));
  gh.factory<_i110.Iden3commRepositoryImpl>(() => _i110.Iden3commRepositoryImpl(
        get<_i58.RemoteIden3commDataSource>(),
        get<_i79.LibPolygonIdCoreIden3commDataSource>(),
        get<_i30.JWZDataSource>(),
        get<_i26.HexMapper>(),
        get<_i52.ProofMapper>(),
        get<_i74.GistProofMapper>(),
        get<_i6.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i111.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i101.IdentityRepositoryImpl>()));
  gh.factory<_i112.IsProofCircuitSupportedUseCase>(
      () => _i112.IsProofCircuitSupportedUseCase(get<_i103.ProofRepository>()));
  gh.factory<_i113.LoadCircuitUseCase>(
      () => _i113.LoadCircuitUseCase(get<_i103.ProofRepository>()));
  gh.factoryAsync<_i114.RemoveIdentityUseCase>(() async =>
      _i114.RemoveIdentityUseCase(
          await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i115.SignMessageUseCase>(() async =>
      _i115.SignMessageUseCase(await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i116.CreateAndSaveIdentityUseCase>(
      () async => _i116.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i111.IdentityRepository>(),
            get<_i95.CredentialRepository>(),
            get<_i99.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i117.FetchIdentityStateUseCase>(
      () async => _i117.FetchIdentityStateUseCase(
            await get.getAsync<_i111.IdentityRepository>(),
            get<_i99.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i118.FetchStateRootsUseCase>(() async =>
      _i118.FetchStateRootsUseCase(
          await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i119.GenerateNonRevProofUseCase>(
      () async => _i119.GenerateNonRevProofUseCase(
            await get.getAsync<_i111.IdentityRepository>(),
            get<_i95.CredentialRepository>(),
            get<_i99.GetEnvConfigUseCase>(),
            await get.getAsync<_i117.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i120.GetAuthChallengeUseCase>(() async =>
      _i120.GetAuthChallengeUseCase(
          await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i121.GetAuthClaimUseCase>(() async =>
      _i121.GetAuthClaimUseCase(
          await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i122.GetClaimRevocationStatusUseCase>(
      () async => _i122.GetClaimRevocationStatusUseCase(
            get<_i95.CredentialRepository>(),
            await get.getAsync<_i111.IdentityRepository>(),
            await get.getAsync<_i119.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i123.GetDidIdentifierUseCase>(() async =>
      _i123.GetDidIdentifierUseCase(
          await get.getAsync<_i111.IdentityRepository>()));
  gh.factoryAsync<_i124.GetIdentityUseCase>(() async =>
      _i124.GetIdentityUseCase(await get.getAsync<_i111.IdentityRepository>()));
  gh.factory<_i125.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i110.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i126.Identity>(() async => _i126.Identity(
        await get.getAsync<_i116.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i124.GetIdentityUseCase>(),
        await get.getAsync<_i114.RemoveIdentityUseCase>(),
        await get.getAsync<_i123.GetDidIdentifierUseCase>(),
        await get.getAsync<_i115.SignMessageUseCase>(),
        await get.getAsync<_i117.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i127.GenerateProofUseCase>(
      () async => _i127.GenerateProofUseCase(
            get<_i103.ProofRepository>(),
            await get.getAsync<_i122.GetClaimRevocationStatusUseCase>(),
            get<_i104.ProveUseCase>(),
          ));
  gh.factoryAsync<_i128.GetAuthTokenUseCase>(
      () async => _i128.GetAuthTokenUseCase(
            get<_i125.Iden3commRepository>(),
            get<_i103.ProofRepository>(),
            get<_i95.CredentialRepository>(),
            await get.getAsync<_i111.IdentityRepository>(),
            get<_i106.SMTRepository>(),
            get<_i15.DidMapper>(),
            get<_i108.GetGistProofUseCase>(),
          ));
  gh.factoryAsync<_i129.GetProofsUseCase>(() async => _i129.GetProofsUseCase(
        get<_i103.ProofRepository>(),
        await get.getAsync<_i111.IdentityRepository>(),
        get<_i98.GetClaimsUseCase>(),
        await get.getAsync<_i127.GenerateProofUseCase>(),
        get<_i112.IsProofCircuitSupportedUseCase>(),
        get<_i25.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i130.Proof>(() async =>
      _i130.Proof(await get.getAsync<_i127.GenerateProofUseCase>()));
  gh.factoryAsync<_i131.AuthenticateUseCase>(
      () async => _i131.AuthenticateUseCase(
            get<_i125.Iden3commRepository>(),
            await get.getAsync<_i129.GetProofsUseCase>(),
            await get.getAsync<_i128.GetAuthTokenUseCase>(),
            get<_i99.GetEnvConfigUseCase>(),
            await get.getAsync<_i90.GetPackageNameUseCase>(),
            await get.getAsync<_i123.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i132.FetchAndSaveClaimsUseCase>(
      () async => _i132.FetchAndSaveClaimsUseCase(
            get<_i21.GetFetchRequestsUseCase>(),
            await get.getAsync<_i128.GetAuthTokenUseCase>(),
            get<_i95.CredentialRepository>(),
          ));
  gh.factoryAsync<_i133.Iden3comm>(() async => _i133.Iden3comm(
        get<_i100.GetVocabsUseCase>(),
        await get.getAsync<_i131.AuthenticateUseCase>(),
        await get.getAsync<_i129.GetProofsUseCase>(),
        get<_i23.GetIden3MessageUseCase>(),
      ));
  gh.factoryAsync<_i134.Credential>(() async => _i134.Credential(
        await get.getAsync<_i132.FetchAndSaveClaimsUseCase>(),
        get<_i98.GetClaimsUseCase>(),
        get<_i105.RemoveClaimsUseCase>(),
        get<_i107.UpdateClaimUseCase>(),
        get<_i96.ExportClaimsUseCase>(),
        get<_i102.ImportClaimsUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i135.PlatformModule {}

class _$NetworkModule extends _i135.NetworkModule {}

class _$DatabaseModule extends _i135.DatabaseModule {}

class _$EncryptionModule extends _i135.EncryptionModule {}

class _$Sdk extends _i135.Sdk {}

class _$RepositoriesModule extends _i135.RepositoriesModule {}
