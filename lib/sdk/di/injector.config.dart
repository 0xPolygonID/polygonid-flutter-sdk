// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i7;

import '../../credential/data/credential_repository_impl.dart' as _i34;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i20;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i28;
import '../../credential/data/mappers/claim_mapper.dart' as _i27;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i4;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i6;
import '../../credential/data/mappers/filter_mapper.dart' as _i8;
import '../../credential/data/mappers/filters_mapper.dart' as _i9;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i11;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i35;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i49;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i36;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i38;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i39;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i14;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i15;
import '../../identity/data/data_sources/local_files_data_source.dart' as _i16;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i21;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i29;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i30;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i22;
import '../../identity/data/data_sources/witness_auth_data_source.dart' as _i31;
import '../../identity/data/data_sources/witness_data_source.dart' as _i24;
import '../../identity/data/data_sources/witness_mtp_data_source.dart' as _i32;
import '../../identity/data/data_sources/witness_sig_data_source.dart' as _i33;
import '../../identity/data/mappers/hex_mapper.dart' as _i10;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i13;
import '../../identity/data/mappers/private_key_mapper.dart' as _i18;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i37;
import '../../identity/domain/repositories/identity_repository.dart' as _i40;
import '../../identity/domain/use_cases/authenticate_use_case.dart' as _i43;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i44;
import '../../identity/domain/use_cases/get_auth_token_use_case.dart' as _i45;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i46;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i47;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i41;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i42;
import '../../identity/libs/bjj/bjj.dart' as _i3;
import '../../identity/libs/iden3core/iden3core.dart' as _i12;
import '../../proof_generation/libs/prover/prover.dart' as _i19;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i23;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i25;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i26;
import '../credential_wallet.dart' as _i50;
import '../identity_wallet.dart' as _i48;
import 'injector.dart' as _i51; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i16.LocalFilesDataSource>(() => _i16.LocalFilesDataSource());
  gh.factory<_i17.LocalIdentityDataSource>(
      () => _i17.LocalIdentityDataSource());
  gh.factory<_i18.PrivateKeyMapper>(() => _i18.PrivateKeyMapper());
  gh.factory<_i19.ProverLib>(() => _i19.ProverLib());
  gh.factory<_i20.RemoteClaimDataSource>(
      () => _i20.RemoteClaimDataSource(get<_i5.Client>()));
  gh.factory<_i21.RemoteIdentityDataSource>(
      () => _i21.RemoteIdentityDataSource());
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i7.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i22.WalletLibWrapper>(() => _i22.WalletLibWrapper());
  gh.factory<_i23.WitnessAuthLib>(() => _i23.WitnessAuthLib());
  gh.factory<_i24.WitnessIsolatesWrapper>(() => _i24.WitnessIsolatesWrapper());
  gh.factory<_i25.WitnessMtpLib>(() => _i25.WitnessMtpLib());
  gh.factory<_i26.WitnessSigLib>(() => _i26.WitnessSigLib());
  gh.factory<_i27.ClaimMapper>(
      () => _i27.ClaimMapper(get<_i4.ClaimStateMapper>()));
  gh.factory<_i28.ClaimStoreRefWrapper>(() => _i28.ClaimStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i29.IdentityStoreRefWrapper>(() => _i29.IdentityStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i30.KeyValueStoreRefWrapper>(() => _i30.KeyValueStoreRefWrapper(
      get<_i7.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i28.StorageClaimDataSource>(() async =>
      _i28.StorageClaimDataSource(await get.getAsync<_i7.Database>(),
          get<_i28.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i30.StorageKeyValueDataSource>(() async =>
      _i30.StorageKeyValueDataSource(await get.getAsync<_i7.Database>(),
          get<_i30.KeyValueStoreRefWrapper>()));
  gh.factory<_i22.WalletDataSource>(
      () => _i22.WalletDataSource(get<_i22.WalletLibWrapper>()));
  gh.factory<_i31.WitnessAuthDataSource>(
      () => _i31.WitnessAuthDataSource(get<_i23.WitnessAuthLib>()));
  gh.factory<_i32.WitnessMtpDataSource>(
      () => _i32.WitnessMtpDataSource(get<_i25.WitnessMtpLib>()));
  gh.factory<_i33.WitnessSigDataSource>(
      () => _i33.WitnessSigDataSource(get<_i26.WitnessSigLib>()));
  gh.factoryAsync<_i34.CredentialRepositoryImpl>(() async =>
      _i34.CredentialRepositoryImpl(
          get<_i20.RemoteClaimDataSource>(),
          await get.getAsync<_i28.StorageClaimDataSource>(),
          get<_i6.CredentialRequestMapper>(),
          get<_i27.ClaimMapper>(),
          get<_i9.FiltersMapper>(),
          get<_i11.IdFilterMapper>()));
  gh.factory<_i14.JWZDataSource>(() => _i14.JWZDataSource(
      get<_i3.BabyjubjubLib>(),
      get<_i22.WalletDataSource>(),
      get<_i14.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i29.StorageIdentityDataSource>(() async =>
      _i29.StorageIdentityDataSource(
          await get.getAsync<_i7.Database>(),
          get<_i29.IdentityStoreRefWrapper>(),
          await get.getAsync<_i30.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i35.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i34.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i36.GetClaimsUseCase>(() async =>
      _i36.GetClaimsUseCase(await get.getAsync<_i35.CredentialRepository>()));
  gh.factoryAsync<_i37.IdentityRepositoryImpl>(() async =>
      _i37.IdentityRepositoryImpl(
          get<_i22.WalletDataSource>(),
          get<_i15.LibIdentityDataSource>(),
          await get.getAsync<_i29.StorageIdentityDataSource>(),
          await get.getAsync<_i30.StorageKeyValueDataSource>(),
          get<_i14.JWZDataSource>(),
          get<_i10.HexMapper>(),
          get<_i18.PrivateKeyMapper>(),
          get<_i13.IdentityDTOMapper>(),
          get<_i17.LocalIdentityDataSource>(),
          get<_i16.LocalFilesDataSource>(),
          get<_i21.RemoteIdentityDataSource>()));
  gh.factoryAsync<_i38.RemoveClaimsUseCase>(() async =>
      _i38.RemoveClaimsUseCase(
          await get.getAsync<_i35.CredentialRepository>()));
  gh.factoryAsync<_i39.UpdateClaimUseCase>(() async =>
      _i39.UpdateClaimUseCase(await get.getAsync<_i35.CredentialRepository>()));
  gh.factoryAsync<_i40.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i37.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i41.RemoveCurrentIdentityUseCase>(() async =>
      _i41.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i42.SignMessageUseCase>(() async =>
      _i42.SignMessageUseCase(await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i43.AuthenticateUseCase>(() async =>
      _i43.AuthenticateUseCase(await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i44.CreateIdentityUseCase>(() async =>
      _i44.CreateIdentityUseCase(
          await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i45.GetAuthTokenUseCase>(() async =>
      _i45.GetAuthTokenUseCase(await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i46.GetCurrentIdentifierUseCase>(() async =>
      _i46.GetCurrentIdentifierUseCase(
          await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i47.GetIdentityUseCase>(() async =>
      _i47.GetIdentityUseCase(await get.getAsync<_i40.IdentityRepository>()));
  gh.factoryAsync<_i48.IdentityWallet>(() async => _i48.IdentityWallet(
      await get.getAsync<_i44.CreateIdentityUseCase>(),
      await get.getAsync<_i47.GetIdentityUseCase>(),
      await get.getAsync<_i42.SignMessageUseCase>(),
      await get.getAsync<_i45.GetAuthTokenUseCase>(),
      await get.getAsync<_i46.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i41.RemoveCurrentIdentityUseCase>(),
      await get.getAsync<_i43.AuthenticateUseCase>()));
  gh.factoryAsync<_i49.FetchAndSaveClaimsUseCase>(() async =>
      _i49.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i45.GetAuthTokenUseCase>(),
          await get.getAsync<_i35.CredentialRepository>()));
  gh.factoryAsync<_i50.CredentialWallet>(() async => _i50.CredentialWallet(
      await get.getAsync<_i49.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i36.GetClaimsUseCase>(),
      await get.getAsync<_i38.RemoveClaimsUseCase>(),
      await get.getAsync<_i39.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i51.NetworkModule {}

class _$DatabaseModule extends _i51.DatabaseModule {}

class _$RepositoriesModule extends _i51.RepositoriesModule {}
