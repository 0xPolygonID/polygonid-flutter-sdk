// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i9;

import '../../credential/data/credential_repository_impl.dart' as _i35;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i23;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i32;
import '../../credential/data/mappers/claim_mapper.dart' as _i31;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i6;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i10;
import '../../credential/data/mappers/filters_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i13;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i36;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i50;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i37;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i39;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i40;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i16;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i17;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i24;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i33;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i34;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i25;
import '../../identity/data/mappers/auth_request_mapper.dart' as _i3;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i4;
import '../../identity/data/mappers/hex_mapper.dart' as _i12;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i15;
import '../../identity/data/mappers/private_key_mapper.dart' as _i19;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i38;
import '../../identity/domain/repositories/identity_repository.dart' as _i41;
import '../../identity/domain/use_cases/authenticate_use_case.dart' as _i44;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i45;
import '../../identity/domain/use_cases/get_auth_token_use_case.dart' as _i46;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i47;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i48;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i42;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i43;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i14;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i30;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i18;
import '../../proof_generation/data/data_sources/proof_scope_data_source.dart'
    as _i20;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i22;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i27;
import '../../proof_generation/libs/prover/prover.dart' as _i21;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i26;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i28;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i29;
import '../credential_wallet.dart' as _i51;
import '../identity_wallet.dart' as _i49;
import 'injector.dart' as _i52; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.AuthRequestMapper>(() => _i3.AuthRequestMapper());
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.ClaimStateMapper>(() => _i6.ClaimStateMapper());
  gh.factory<_i7.Client>(() => networkModule.client);
  gh.factory<_i8.CredentialRequestMapper>(() => _i8.CredentialRequestMapper());
  gh.lazySingletonAsync<_i9.Database>(() => databaseModule.database());
  gh.factory<_i10.FilterMapper>(() => _i10.FilterMapper());
  gh.factory<_i11.FiltersMapper>(
      () => _i11.FiltersMapper(get<_i10.FilterMapper>()));
  gh.factory<_i12.HexMapper>(() => _i12.HexMapper());
  gh.factory<_i13.IdFilterMapper>(() => _i13.IdFilterMapper());
  gh.factory<_i14.Iden3CoreLib>(() => _i14.Iden3CoreLib());
  gh.factory<_i15.IdentityDTOMapper>(() => _i15.IdentityDTOMapper());
  gh.factory<_i16.JWZIsolatesWrapper>(() => _i16.JWZIsolatesWrapper());
  gh.factory<_i17.LibIdentityDataSource>(
      () => _i17.LibIdentityDataSource(get<_i14.Iden3CoreLib>()));
  gh.factory<_i18.LocalFilesDataSource>(() => _i18.LocalFilesDataSource());
  gh.factory<_i19.PrivateKeyMapper>(() => _i19.PrivateKeyMapper());
  gh.factory<_i20.ProofScopeDataSource>(() => _i20.ProofScopeDataSource());
  gh.factory<_i21.ProverLib>(() => _i21.ProverLib());
  gh.factory<_i22.ProverLibWrapper>(() => _i22.ProverLibWrapper());
  gh.factory<_i23.RemoteClaimDataSource>(
      () => _i23.RemoteClaimDataSource(get<_i7.Client>()));
  gh.factory<_i24.RemoteIdentityDataSource>(
      () => _i24.RemoteIdentityDataSource(get<_i7.Client>()));
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i9.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i25.WalletLibWrapper>(() => _i25.WalletLibWrapper());
  gh.factory<_i26.WitnessAuthLib>(() => _i26.WitnessAuthLib());
  gh.factory<_i27.WitnessIsolatesWrapper>(() => _i27.WitnessIsolatesWrapper());
  gh.factory<_i28.WitnessMtpLib>(() => _i28.WitnessMtpLib());
  gh.factory<_i29.WitnessSigLib>(() => _i29.WitnessSigLib());
  gh.factory<_i30.AtomicQueryInputsWrapper>(
      () => _i30.AtomicQueryInputsWrapper(get<_i14.Iden3CoreLib>()));
  gh.factory<_i31.ClaimMapper>(
      () => _i31.ClaimMapper(get<_i6.ClaimStateMapper>()));
  gh.factory<_i32.ClaimStoreRefWrapper>(() => _i32.ClaimStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i33.IdentityStoreRefWrapper>(() => _i33.IdentityStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i34.KeyValueStoreRefWrapper>(() => _i34.KeyValueStoreRefWrapper(
      get<_i9.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i22.ProverLibDataSource>(
      () => _i22.ProverLibDataSource(get<_i22.ProverLibWrapper>()));
  gh.factoryAsync<_i32.StorageClaimDataSource>(() async =>
      _i32.StorageClaimDataSource(await get.getAsync<_i9.Database>(),
          get<_i32.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i34.StorageKeyValueDataSource>(() async =>
      _i34.StorageKeyValueDataSource(await get.getAsync<_i9.Database>(),
          get<_i34.KeyValueStoreRefWrapper>()));
  gh.factory<_i25.WalletDataSource>(
      () => _i25.WalletDataSource(get<_i25.WalletLibWrapper>()));
  gh.factory<_i27.WitnessDataSource>(
      () => _i27.WitnessDataSource(get<_i27.WitnessIsolatesWrapper>()));
  gh.factory<_i30.AtomicQueryInputsDataSource>(() =>
      _i30.AtomicQueryInputsDataSource(get<_i30.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i35.CredentialRepositoryImpl>(() async =>
      _i35.CredentialRepositoryImpl(
          get<_i23.RemoteClaimDataSource>(),
          await get.getAsync<_i32.StorageClaimDataSource>(),
          get<_i8.CredentialRequestMapper>(),
          get<_i31.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i13.IdFilterMapper>()));
  gh.factory<_i16.JWZDataSource>(() => _i16.JWZDataSource(
      get<_i5.BabyjubjubLib>(),
      get<_i25.WalletDataSource>(),
      get<_i16.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i33.StorageIdentityDataSource>(() async =>
      _i33.StorageIdentityDataSource(
          await get.getAsync<_i9.Database>(),
          get<_i33.IdentityStoreRefWrapper>(),
          await get.getAsync<_i34.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i36.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i35.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i37.GetClaimsUseCase>(() async =>
      _i37.GetClaimsUseCase(await get.getAsync<_i36.CredentialRepository>()));
  gh.factoryAsync<_i38.IdentityRepositoryImpl>(() async =>
      _i38.IdentityRepositoryImpl(
          get<_i25.WalletDataSource>(),
          get<_i17.LibIdentityDataSource>(),
          await get.getAsync<_i33.StorageIdentityDataSource>(),
          await get.getAsync<_i34.StorageKeyValueDataSource>(),
          get<_i16.JWZDataSource>(),
          get<_i12.HexMapper>(),
          get<_i19.PrivateKeyMapper>(),
          get<_i15.IdentityDTOMapper>(),
          get<_i24.RemoteIdentityDataSource>(),
          get<_i3.AuthRequestMapper>(),
          get<_i20.ProofScopeDataSource>(),
          await get.getAsync<_i32.StorageClaimDataSource>(),
          get<_i31.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i27.WitnessDataSource>(),
          get<_i22.ProverLibDataSource>(),
          get<_i4.AuthResponseMapper>(),
          get<_i30.AtomicQueryInputsDataSource>(),
          get<_i18.LocalFilesDataSource>()));
  gh.factoryAsync<_i39.RemoveClaimsUseCase>(() async =>
      _i39.RemoveClaimsUseCase(
          await get.getAsync<_i36.CredentialRepository>()));
  gh.factoryAsync<_i40.UpdateClaimUseCase>(() async =>
      _i40.UpdateClaimUseCase(await get.getAsync<_i36.CredentialRepository>()));
  gh.factoryAsync<_i41.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i38.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i42.RemoveCurrentIdentityUseCase>(() async =>
      _i42.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i43.SignMessageUseCase>(() async =>
      _i43.SignMessageUseCase(await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i44.AuthenticateUseCase>(() async =>
      _i44.AuthenticateUseCase(await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i45.CreateIdentityUseCase>(() async =>
      _i45.CreateIdentityUseCase(
          await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i46.GetAuthTokenUseCase>(() async =>
      _i46.GetAuthTokenUseCase(await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i47.GetCurrentIdentifierUseCase>(() async =>
      _i47.GetCurrentIdentifierUseCase(
          await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i48.GetIdentityUseCase>(() async =>
      _i48.GetIdentityUseCase(await get.getAsync<_i41.IdentityRepository>()));
  gh.factoryAsync<_i49.IdentityWallet>(() async => _i49.IdentityWallet(
      await get.getAsync<_i45.CreateIdentityUseCase>(),
      await get.getAsync<_i48.GetIdentityUseCase>(),
      await get.getAsync<_i43.SignMessageUseCase>(),
      await get.getAsync<_i46.GetAuthTokenUseCase>(),
      await get.getAsync<_i47.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i42.RemoveCurrentIdentityUseCase>(),
      await get.getAsync<_i44.AuthenticateUseCase>()));
  gh.factoryAsync<_i50.FetchAndSaveClaimsUseCase>(() async =>
      _i50.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i46.GetAuthTokenUseCase>(),
          await get.getAsync<_i36.CredentialRepository>()));
  gh.factoryAsync<_i51.CredentialWallet>(() async => _i51.CredentialWallet(
      await get.getAsync<_i50.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i37.GetClaimsUseCase>(),
      await get.getAsync<_i39.RemoveClaimsUseCase>(),
      await get.getAsync<_i40.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i52.NetworkModule {}

class _$DatabaseModule extends _i52.DatabaseModule {}

class _$RepositoriesModule extends _i52.RepositoriesModule {}
