import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_type_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/smt_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'smt_repository_impl_test.mocks.dart';

// Data

// Dependencies
MockSMTDataSource smtDataSource = MockSMTDataSource();
MockStorageSMTDataSource storageSMTDataSource = MockStorageSMTDataSource();
MockTreeTypeMapper treeTypeMapper = MockTreeTypeMapper();
MockTreeStateMapper treeStateMapper = MockTreeStateMapper();

// Tested instance
SMTRepository repository = SMTRepositoryImpl(
  smtDataSource,
  storageSMTDataSource,
  treeTypeMapper,
  treeStateMapper,
);

@GenerateMocks([
  SMTDataSource,
  StorageSMTDataSource,
  TreeTypeMapper,
  TreeStateMapper,
])
void main() {
  group("Convert state", () {
    test(
        "Given a TreeStateEntity, when I call convertState, then I expect a Map to be returned",
        () async {
      // Given
      when(treeStateMapper.mapTo(any)).thenReturn(CommonMocks.aMap);

      // When
      expect(await repository.convertState(state: IdentityMocks.treeState),
          CommonMocks.aMap);

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
