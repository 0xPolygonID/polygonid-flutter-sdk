import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_type_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/smt_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/proof_mapper.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'smt_repository_impl_test.mocks.dart';

// Data

// Dependencies
MockSMTDataSource smtDataSource = MockSMTDataSource();
MockStorageSMTDataSource storageSMTDataSource = MockStorageSMTDataSource();
MockLibBabyJubJubDataSource libBabyJubJubDataSource =
    MockLibBabyJubJubDataSource();
MockNodeMapper nodeMapper = MockNodeMapper();
MockHashMapper hashMapper = MockHashMapper();
MockProofMapper proofMapper = MockProofMapper();
MockTreeTypeMapper treeTypeMapper = MockTreeTypeMapper();
MockTreeStateMapper treeStateMapper = MockTreeStateMapper();

// Tested instance
SMTRepository repository = SMTRepositoryImpl(
  smtDataSource,
  storageSMTDataSource,
  libBabyJubJubDataSource,
  nodeMapper,
  hashMapper,
  proofMapper,
  treeTypeMapper,
  treeStateMapper,
);

@GenerateMocks([
  SMTDataSource,
  StorageSMTDataSource,
  LibBabyJubJubDataSource,
  NodeMapper,
  HashMapper,
  ProofMapper,
  TreeTypeMapper,
  TreeStateMapper,
])
void main() {
  group("Hash state", () {
    test(
        "Given params, when I call hashState, then I expect a String to be returned",
        () async {
      // Given
      when(libBabyJubJubDataSource.hashPoseidon3(any, any, any))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.hash));

      // When
      expect(
          await repository.hashState(
              claims: CommonMocks.message,
              revocation: CommonMocks.message,
              roots: CommonMocks.message),
          CommonMocks.hash);

      // Then
      var captureHash = verify(libBabyJubJubDataSource.hashPoseidon3(
              captureAny, captureAny, captureAny))
          .captured;
      expect(captureHash[0], CommonMocks.message);
      expect(captureHash[1], CommonMocks.message);
      expect(captureHash[2], CommonMocks.message);
    });

    test(
        "Given params, when I call hashState and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(libBabyJubJubDataSource.hashPoseidon3(any, any, any))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          repository.hashState(
              claims: CommonMocks.message,
              revocation: CommonMocks.message,
              roots: CommonMocks.message),
          throwsA(CommonMocks.exception));

      // Then
      var captureHash = verify(libBabyJubJubDataSource.hashPoseidon3(
              captureAny, captureAny, captureAny))
          .captured;
      expect(captureHash[0], CommonMocks.message);
      expect(captureHash[1], CommonMocks.message);
      expect(captureHash[2], CommonMocks.message);
    });
  });

  group("Convert state", () {
    test(
        "Given a TreeStateEntity, when I call convertState, then I expect a Map to be returned",
        () async {
      // Given
      when(treeStateMapper.mapTo(any)).thenReturn(IdentityMocks.treeStateDTO);

      // When
      expect(await repository.convertState(state: IdentityMocks.treeState),
          IdentityMocks.treeStateDTO.toJson());

      // Then
      expect(verify(treeStateMapper.mapTo(captureAny)).captured.first,
          IdentityMocks.treeState);
    });

    test(
        "Given a TreeStateEntity, when I call convertState and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(treeStateMapper.mapTo(any)).thenThrow(CommonMocks.exception);

      // When
      try {
        repository.convertState(state: IdentityMocks.treeState);
      } catch (error) {
        expect(error, CommonMocks.exception);
      }

      // Then
      expect(verify(treeStateMapper.mapTo(captureAny)).captured.first,
          IdentityMocks.treeState);
    });
  });
}
