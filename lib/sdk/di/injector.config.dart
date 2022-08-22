// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i7;

import '../../credential/data/credential_repository_impl.dart' as _i27;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i18;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i24;
import '../../credential/data/mappers/claim_mapper.dart' as _i23;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i4;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i6;
import '../../credential/data/mappers/filter_mapper.dart' as _i8;
import '../../credential/data/mappers/filters_mapper.dart' as _i9;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i11;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i28;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i41;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i29;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i31;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i32;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i14;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i15;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i25;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i26;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i19;
import '../../identity/data/mappers/hex_mapper.dart' as _i10;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i13;
import '../../identity/data/mappers/private_key_mapper.dart' as _i16;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i30;
import '../../identity/domain/repositories/identity_repository.dart' as _i33;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i36;
import '../../identity/domain/use_cases/get_auth_token_use_case.dart' as _i37;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i38;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i39;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i34;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i35;
import '../../identity/libs/bjj/bjj.dart' as _i3;
import '../../identity/libs/iden3core/iden3core.dart' as _i12;
import '../../proof_generation/libs/prover/prover.dart' as _i17;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i20;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i21;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i22;
import '../credential_wallet.dart' as _i42;
import '../identity_wallet.dart' as _i40;
import 'injector.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.BabyjubjubLib>(() => _i3.BabyjubjubLib());
  gh.factory<_i4.ClaimStateMapper>(() => _i4.ClaimStateMapper());
  gh.factory<_i5.Client>(() => networkModule.client);
  gh.factory<_i6.CredentialRequestMapper>(() => _i6.CredentialRequestMapper());
  gh.lazySingletonAsync<_i7.Database>(() => databaseModule.database());
  gh.factory<_i8.FilterMapper>(() => _i8.FilterMapper());
  gh.factory<_i9.FiltersMapper>(
      () => _i9.FiltersMapper(get<_i8.FilterMapper>()));
  gh.factory<_i10.HexMapper>(() => _i10.HexMapper());
  gh.factory<_i11.IdFilterMapper>(() => _i11.IdFilterMapper());
  gh.factory<_i12.Iden3CoreLib>(() => _i12.Iden3CoreLib());
  gh.factory<_i13.IdentityDTOMapper>(() => _i13.IdentityDTOMapper());
  gh.factory<_i14.JWZIsolatesWrapper>(() => _i14.JWZIsolatesWrapper());
  gh.factory<_i15.LibIdentityDataSource>(
      () => _i15.LibIdentityDataSource(get<_i12.Iden3CoreLib>()));
  gh.factory<_i16.PrivateKeyMapper>(() => _i16.PrivateKeyMapper());
  gh.factory<_i17.ProverLib>(() => _i17.ProverLib());
  gh.factory<_i18.RemoteClaimDataSource>(
      () => _i18.RemoteClaimDataSource(get<_i5.Client>()));
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i7.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i19.WalletLibWrapper>(() => _i19.WalletLibWrapper());
  gh.factory<_i20.WitnessAuthLib>(() => _i20.WitnessAuthLib());
  gh.factory<_i21.WitnessMtpLib>(() => _i21.WitnessMtpLib());
  gh.factory<_i22.WitnessSigLib>(() => _i22.WitnessSigLib());
  gh.factory<_i23.ClaimMapper>(
      () => _i23.ClaimMapper(get<_i4.ClaimStateMapper>()));
  gh.factory<_i24.ClaimStoreRefWrapper>(() => _i24.ClaimStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i25.IdentityStoreRefWrapper>(() => _i25.IdentityStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i26.KeyValueStoreRefWrapper>(() => _i26.KeyValueStoreRefWrapper(
      get<_i7.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i24.StorageClaimDataSource>(() async =>
      _i24.StorageClaimDataSource(await get.getAsync<_i7.Database>(),
          get<_i24.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i26.StorageKeyValueDataSource>(() async =>
      _i26.StorageKeyValueDataSource(await get.getAsync<_i7.Database>(),
          get<_i26.KeyValueStoreRefWrapper>()));
  gh.factory<_i19.WalletDataSource>(
      () => _i19.WalletDataSource(get<_i19.WalletLibWrapper>()));
  gh.factoryAsync<_i27.CredentialRepositoryImpl>(() async =>
      _i27.CredentialRepositoryImpl(
          get<_i18.RemoteClaimDataSource>(),
          await get.getAsync<_i24.StorageClaimDataSource>(),
          get<_i6.CredentialRequestMapper>(),
          get<_i23.ClaimMapper>(),
          get<_i9.FiltersMapper>(),
          get<_i11.IdFilterMapper>()));
  gh.factory<_i14.JWZDataSource>(() => _i14.JWZDataSource(
      get<_i3.BabyjubjubLib>(),
      get<_i19.WalletDataSource>(),
      get<_i14.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i25.StorageIdentityDataSource>(() async =>
      _i25.StorageIdentityDataSource(
          await get.getAsync<_i7.Database>(),
          get<_i25.IdentityStoreRefWrapper>(),
          await get.getAsync<_i26.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i28.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i27.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i29.GetClaimsUseCase>(() async =>
      _i29.GetClaimsUseCase(await get.getAsync<_i28.CredentialRepository>()));
  gh.factoryAsync<_i30.IdentityRepositoryImpl>(() async =>
      _i30.IdentityRepositoryImpl(
          get<_i19.WalletDataSource>(),
          get<_i15.LibIdentityDataSource>(),
          await get.getAsync<_i25.StorageIdentityDataSource>(),
          await get.getAsync<_i26.StorageKeyValueDataSource>(),
          get<_i14.JWZDataSource>(),
          get<_i10.HexMapper>(),
          get<_i16.PrivateKeyMapper>(),
          get<_i13.IdentityDTOMapper>()));
  gh.factoryAsync<_i31.RemoveClaimsUseCase>(() async =>
      _i31.RemoveClaimsUseCase(
          await get.getAsync<_i28.CredentialRepository>()));
  gh.factoryAsync<_i32.UpdateClaimUseCase>(() async =>
      _i32.UpdateClaimUseCase(await get.getAsync<_i28.CredentialRepository>()));
  gh.factoryAsync<_i33.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i30.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i34.RemoveCurrentIdentityUseCase>(() async =>
      _i34.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i35.SignMessageUseCase>(() async =>
      _i35.SignMessageUseCase(await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i36.CreateIdentityUseCase>(() async =>
      _i36.CreateIdentityUseCase(
          await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i37.GetAuthTokenUseCase>(() async =>
      _i37.GetAuthTokenUseCase(await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i38.GetCurrentIdentifierUseCase>(() async =>
      _i38.GetCurrentIdentifierUseCase(
          await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i39.GetIdentityUseCase>(() async =>
      _i39.GetIdentityUseCase(await get.getAsync<_i33.IdentityRepository>()));
  gh.factoryAsync<_i40.IdentityWallet>(() async => _i40.IdentityWallet(
      await get.getAsync<_i36.CreateIdentityUseCase>(),
      await get.getAsync<_i39.GetIdentityUseCase>(),
      await get.getAsync<_i35.SignMessageUseCase>(),
      await get.getAsync<_i37.GetAuthTokenUseCase>(),
      await get.getAsync<_i38.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i34.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i41.FetchAndSaveClaimsUseCase>(() async =>
      _i41.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i37.GetAuthTokenUseCase>(),
          await get.getAsync<_i28.CredentialRepository>()));
  gh.factoryAsync<_i42.CredentialWallet>(() async => _i42.CredentialWallet(
      await get.getAsync<_i41.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i29.GetClaimsUseCase>(),
      await get.getAsync<_i31.RemoveClaimsUseCase>(),
      await get.getAsync<_i32.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i43.NetworkModule {}

class _$DatabaseModule extends _i43.DatabaseModule {}

class _$RepositoriesModule extends _i43.RepositoriesModule {}
