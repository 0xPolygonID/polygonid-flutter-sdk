// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i9;

import '../../credential/data/credential_repository_impl.dart' as _i44;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i28;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i40;
import '../../credential/data/mappers/claim_mapper.dart' as _i39;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i6;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i10;
import '../../credential/data/mappers/filters_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i13;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i46;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i70;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i47;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i48;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i53;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i54;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i25;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i29;
import '../../iden3comm/data/mappers/iden3_message_mapper.dart' as _i41;
import '../../iden3comm/data/mappers/iden3_message_type_mapper.dart' as _i15;
import '../../iden3comm/data/mappers/proof_response_mapper.dart' as _i24;
import '../../iden3comm/data/mappers/schema_info_mapper.dart' as _i32;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i49;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i58;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i69;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i64;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i67;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i17;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i18;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i42;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i43;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i33;
import '../../identity/data/mappers/auth_request_mapper.dart' as _i3;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i4;
import '../../identity/data/mappers/hex_mapper.dart' as _i12;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i16;
import '../../identity/data/mappers/private_key_mapper.dart' as _i23;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i50;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i30;
import '../../identity/domain/repositories/identity_repository.dart' as _i59;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i21;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i63;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i65;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i66;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i61;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i62;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i14;
import '../../identity/libs/smt/hash.dart' as _i31;
import '../../identity/libs/smt/merkletree.dart' as _i20;
import '../../identity/libs/smt/node.dart' as _i22;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i38;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i19;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i35;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i45;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i51;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i55;
import '../../proof_generation/domain/use_cases/get_atomic_query_inputs_use_case.dart'
    as _i56;
import '../../proof_generation/domain/use_cases/get_witness_use_case.dart'
    as _i57;
import '../../proof_generation/domain/use_cases/prove_use_case.dart' as _i52;
import '../../proof_generation/libs/prover/prover.dart' as _i26;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i34;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i36;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i37;
import '../credential_wallet.dart' as _i72;
import '../iden3comm.dart' as _i71;
import '../identity_wallet.dart' as _i68;
import '../proof_generation.dart' as _i60;
import 'injector.dart' as _i73; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i15.Iden3MessageTypeMapper>(() => _i15.Iden3MessageTypeMapper());
  gh.factory<_i16.IdentityDTOMapper>(() => _i16.IdentityDTOMapper());
  gh.factory<_i17.JWZIsolatesWrapper>(() => _i17.JWZIsolatesWrapper());
  gh.factory<_i18.LibIdentityDataSource>(
      () => _i18.LibIdentityDataSource(get<_i14.Iden3CoreLib>()));
  gh.factory<_i19.LocalFilesDataSource>(() => _i19.LocalFilesDataSource());
  gh.factory<_i20.MerkleTree>(() => _i20.MerkleTree(
      get<_i14.Iden3CoreLib>(), get<_i21.SMTStorageRepository>(), get<int>()));
  gh.factory<_i22.Node>(
      () => _i22.Node(get<_i22.NodeType>(), get<_i14.Iden3CoreLib>()));
  gh.factory<_i23.PrivateKeyMapper>(() => _i23.PrivateKeyMapper());
  gh.factory<_i24.ProofResponseMapper>(() => _i24.ProofResponseMapper());
  gh.factory<_i25.ProofScopeDataSource>(() => _i25.ProofScopeDataSource());
  gh.factory<_i26.ProverLib>(() => _i26.ProverLib());
  gh.factory<_i27.ProverLibWrapper>(() => _i27.ProverLibWrapper());
  gh.factory<_i28.RemoteClaimDataSource>(
      () => _i28.RemoteClaimDataSource(get<_i7.Client>()));
  gh.factory<_i29.RemoteIden3commDataSource>(
      () => _i29.RemoteIden3commDataSource(get<_i7.Client>()));
  gh.factory<_i30.SMTMemoryStorageRepositoryImpl>(() =>
      _i30.SMTMemoryStorageRepositoryImpl(
          get<_i31.Hash>(), get<Map<_i31.Hash, _i22.Node>>()));
  gh.factory<_i32.SchemaInfoMapper>(() => _i32.SchemaInfoMapper());
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i9.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i33.WalletLibWrapper>(() => _i33.WalletLibWrapper());
  gh.factory<_i34.WitnessAuthLib>(() => _i34.WitnessAuthLib());
  gh.factory<_i35.WitnessIsolatesWrapper>(() => _i35.WitnessIsolatesWrapper());
  gh.factory<_i36.WitnessMtpLib>(() => _i36.WitnessMtpLib());
  gh.factory<_i37.WitnessSigLib>(() => _i37.WitnessSigLib());
  gh.factory<_i38.AtomicQueryInputsWrapper>(
      () => _i38.AtomicQueryInputsWrapper(get<_i14.Iden3CoreLib>()));
  gh.factory<_i39.ClaimMapper>(
      () => _i39.ClaimMapper(get<_i6.ClaimStateMapper>()));
  gh.factory<_i40.ClaimStoreRefWrapper>(() => _i40.ClaimStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i41.Iden3MessageMapper>(
      () => _i41.Iden3MessageMapper(get<_i15.Iden3MessageTypeMapper>()));
  gh.factory<_i42.IdentityStoreRefWrapper>(() => _i42.IdentityStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i43.KeyValueStoreRefWrapper>(() => _i43.KeyValueStoreRefWrapper(
      get<_i9.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i27.ProverLibDataSource>(
      () => _i27.ProverLibDataSource(get<_i27.ProverLibWrapper>()));
  gh.factoryAsync<_i40.StorageClaimDataSource>(() async =>
      _i40.StorageClaimDataSource(await get.getAsync<_i9.Database>(),
          get<_i40.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i43.StorageKeyValueDataSource>(() async =>
      _i43.StorageKeyValueDataSource(await get.getAsync<_i9.Database>(),
          get<_i43.KeyValueStoreRefWrapper>()));
  gh.factory<_i33.WalletDataSource>(
      () => _i33.WalletDataSource(get<_i33.WalletLibWrapper>()));
  gh.factory<_i35.WitnessDataSource>(
      () => _i35.WitnessDataSource(get<_i35.WitnessIsolatesWrapper>()));
  gh.factory<_i38.AtomicQueryInputsDataSource>(() =>
      _i38.AtomicQueryInputsDataSource(get<_i38.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i44.CredentialRepositoryImpl>(() async =>
      _i44.CredentialRepositoryImpl(
          get<_i28.RemoteClaimDataSource>(),
          await get.getAsync<_i40.StorageClaimDataSource>(),
          get<_i8.CredentialRequestMapper>(),
          get<_i39.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i13.IdFilterMapper>()));
  gh.factory<_i17.JWZDataSource>(() => _i17.JWZDataSource(
      get<_i5.BabyjubjubLib>(),
      get<_i33.WalletDataSource>(),
      get<_i17.JWZIsolatesWrapper>()));
  gh.factory<_i45.ProofRepositoryImpl>(() => _i45.ProofRepositoryImpl(
      get<_i35.WitnessDataSource>(),
      get<_i27.ProverLibDataSource>(),
      get<_i38.AtomicQueryInputsDataSource>(),
      get<_i19.LocalFilesDataSource>()));
  gh.factoryAsync<_i42.StorageIdentityDataSource>(() async =>
      _i42.StorageIdentityDataSource(
          await get.getAsync<_i9.Database>(),
          get<_i42.IdentityStoreRefWrapper>(),
          await get.getAsync<_i43.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i46.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i44.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i47.GetClaimsUseCase>(() async =>
      _i47.GetClaimsUseCase(await get.getAsync<_i46.CredentialRepository>()));
  gh.factoryAsync<_i48.GetVocabsUseCase>(() async =>
      _i48.GetVocabsUseCase(await get.getAsync<_i46.CredentialRepository>()));
  gh.factoryAsync<_i49.Iden3commRepositoryImpl>(() async =>
      _i49.Iden3commRepositoryImpl(
          get<_i33.WalletDataSource>(),
          get<_i29.RemoteIden3commDataSource>(),
          get<_i17.JWZDataSource>(),
          get<_i12.HexMapper>(),
          get<_i25.ProofScopeDataSource>(),
          await get.getAsync<_i40.StorageClaimDataSource>(),
          get<_i39.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i4.AuthResponseMapper>()));
  gh.factoryAsync<_i50.IdentityRepositoryImpl>(() async =>
      _i50.IdentityRepositoryImpl(
          get<_i33.WalletDataSource>(),
          get<_i18.LibIdentityDataSource>(),
          await get.getAsync<_i42.StorageIdentityDataSource>(),
          await get.getAsync<_i43.StorageKeyValueDataSource>(),
          get<_i12.HexMapper>(),
          get<_i23.PrivateKeyMapper>(),
          get<_i16.IdentityDTOMapper>()));
  gh.factory<_i51.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i45.ProofRepositoryImpl>()));
  gh.factory<_i52.ProveUseCase>(
      () => _i52.ProveUseCase(get<_i51.ProofRepository>()));
  gh.factoryAsync<_i53.RemoveClaimsUseCase>(() async =>
      _i53.RemoveClaimsUseCase(
          await get.getAsync<_i46.CredentialRepository>()));
  gh.factoryAsync<_i54.UpdateClaimUseCase>(() async =>
      _i54.UpdateClaimUseCase(await get.getAsync<_i46.CredentialRepository>()));
  gh.factory<_i55.GenerateProofUseCase>(
      () => _i55.GenerateProofUseCase(get<_i51.ProofRepository>()));
  gh.factory<_i56.GetAtomicQueryInputsUseCase>(
      () => _i56.GetAtomicQueryInputsUseCase(get<_i51.ProofRepository>()));
  gh.factory<_i57.GetWitnessUseCase>(
      () => _i57.GetWitnessUseCase(get<_i51.ProofRepository>()));
  gh.factoryAsync<_i58.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i49.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i59.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i50.IdentityRepositoryImpl>()));
  gh.factory<_i60.ProofGeneration>(() => _i60.ProofGeneration(
      get<_i56.GetAtomicQueryInputsUseCase>(),
      get<_i57.GetWitnessUseCase>(),
      get<_i52.ProveUseCase>()));
  gh.factoryAsync<_i61.RemoveCurrentIdentityUseCase>(() async =>
      _i61.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i62.SignMessageUseCase>(() async =>
      _i62.SignMessageUseCase(await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i63.CreateIdentityUseCase>(() async =>
      _i63.CreateIdentityUseCase(
          await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i64.GetAuthTokenUseCase>(() async =>
      _i64.GetAuthTokenUseCase(
          await get.getAsync<_i58.Iden3commRepository>(),
          get<_i51.ProofRepository>(),
          await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i65.GetCurrentIdentifierUseCase>(() async =>
      _i65.GetCurrentIdentifierUseCase(
          await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i66.GetIdentityUseCase>(() async =>
      _i66.GetIdentityUseCase(await get.getAsync<_i59.IdentityRepository>()));
  gh.factoryAsync<_i67.GetProofsUseCase>(() async => _i67.GetProofsUseCase(
      get<_i51.ProofRepository>(),
      await get.getAsync<_i59.IdentityRepository>(),
      await get.getAsync<_i46.CredentialRepository>(),
      get<_i25.ProofScopeDataSource>(),
      get<_i33.WalletDataSource>(),
      get<_i55.GenerateProofUseCase>()));
  gh.factoryAsync<_i68.IdentityWallet>(() async => _i68.IdentityWallet(
      await get.getAsync<_i63.CreateIdentityUseCase>(),
      await get.getAsync<_i66.GetIdentityUseCase>(),
      await get.getAsync<_i62.SignMessageUseCase>(),
      await get.getAsync<_i65.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i61.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i69.AuthenticateUseCase>(() async =>
      _i69.AuthenticateUseCase(
          await get.getAsync<_i58.Iden3commRepository>(),
          await get.getAsync<_i67.GetProofsUseCase>(),
          await get.getAsync<_i64.GetAuthTokenUseCase>()));
  gh.factoryAsync<_i70.FetchAndSaveClaimsUseCase>(() async =>
      _i70.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i64.GetAuthTokenUseCase>(),
          await get.getAsync<_i46.CredentialRepository>()));
  gh.factoryAsync<_i71.Iden3comm>(() async => _i71.Iden3comm(
      await get.getAsync<_i48.GetVocabsUseCase>(),
      await get.getAsync<_i69.AuthenticateUseCase>(),
      get<_i3.AuthRequestMapper>()));
  gh.factoryAsync<_i72.CredentialWallet>(() async => _i72.CredentialWallet(
      await get.getAsync<_i70.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i47.GetClaimsUseCase>(),
      await get.getAsync<_i53.RemoveClaimsUseCase>(),
      await get.getAsync<_i54.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i73.NetworkModule {}

class _$DatabaseModule extends _i73.DatabaseModule {}

class _$RepositoriesModule extends _i73.RepositoriesModule {}
