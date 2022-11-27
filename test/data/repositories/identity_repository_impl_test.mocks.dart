// Mocks generated by Mockito 5.3.2 from annotations
// in polygonid_flutter_sdk/test/data/repositories/identity_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:typed_data' as _i13;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i16;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart'
    as _i14;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_data_source.dart'
    as _i17;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart'
    as _i23;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart'
    as _i19;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart'
    as _i22;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart'
    as _i18;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart'
    as _i20;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart'
    as _i11;
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart' as _i3;
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart'
    as _i6;
import 'package:polygonid_flutter_sdk/identity/data/dtos/node_dto.dart' as _i15;
import 'package:polygonid_flutter_sdk/identity/data/dtos/proof_dto.dart' as _i4;
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/identity/data/mappers/did_mapper.dart'
    as _i29;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart'
    as _i24;
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart'
    as _i26;
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart'
    as _i25;
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart'
    as _i27;
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart'
    as _i28;
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart'
    as _i8;
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart'
    as _i9;
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart'
    as _i10;
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart'
    as _i2;
import 'package:sembast/sembast.dart' as _i21;
import 'package:web3dart/web3dart.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePrivadoIdWallet_0 extends _i1.SmartFake
    implements _i2.PrivadoIdWallet {
  _FakePrivadoIdWallet_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHashDTO_1 extends _i1.SmartFake implements _i3.HashDTO {
  _FakeHashDTO_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProofDTO_2 extends _i1.SmartFake implements _i4.ProofDTO {
  _FakeProofDTO_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRhsNodeDTO_3 extends _i1.SmartFake implements _i5.RhsNodeDTO {
  _FakeRhsNodeDTO_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIdentityDTO_4 extends _i1.SmartFake implements _i6.IdentityDTO {
  _FakeIdentityDTO_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeb3Client_5 extends _i1.SmartFake implements _i7.Web3Client {
  _FakeWeb3Client_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeployedContract_6 extends _i1.SmartFake
    implements _i7.DeployedContract {
  _FakeDeployedContract_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIdentityEntity_7 extends _i1.SmartFake
    implements _i8.IdentityEntity {
  _FakeIdentityEntity_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePrivateIdentityEntity_8 extends _i1.SmartFake
    implements _i9.PrivateIdentityEntity {
  _FakePrivateIdentityEntity_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRhsNodeEntity_9 extends _i1.SmartFake implements _i10.RhsNodeEntity {
  _FakeRhsNodeEntity_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WalletDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWalletDataSource extends _i1.Mock implements _i11.WalletDataSource {
  MockWalletDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i2.PrivadoIdWallet> createWallet({_i13.Uint8List? secret}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createWallet,
          [],
          {#secret: secret},
        ),
        returnValue:
            _i12.Future<_i2.PrivadoIdWallet>.value(_FakePrivadoIdWallet_0(
          this,
          Invocation.method(
            #createWallet,
            [],
            {#secret: secret},
          ),
        )),
      ) as _i12.Future<_i2.PrivadoIdWallet>);
  @override
  _i12.Future<_i2.PrivadoIdWallet> getWallet(
          {required _i13.Uint8List? privateKey}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWallet,
          [],
          {#privateKey: privateKey},
        ),
        returnValue:
            _i12.Future<_i2.PrivadoIdWallet>.value(_FakePrivadoIdWallet_0(
          this,
          Invocation.method(
            #getWallet,
            [],
            {#privateKey: privateKey},
          ),
        )),
      ) as _i12.Future<_i2.PrivadoIdWallet>);
  @override
  _i12.Future<String> signMessage({
    required _i13.Uint8List? privateKey,
    required String? message,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signMessage,
          [],
          {
            #privateKey: privateKey,
            #message: message,
          },
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
}

/// A class which mocks [LibIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLibIdentityDataSource extends _i1.Mock
    implements _i14.LibIdentityDataSource {
  MockLibIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<String> getId(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getId,
          [id],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<String> getClaimsTreeRoot({
    required String? pubX,
    required String? pubY,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getClaimsTreeRoot,
          [],
          {
            #pubX: pubX,
            #pubY: pubY,
          },
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<String> getAuthClaim({
    required String? pubX,
    required String? pubY,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuthClaim,
          [],
          {
            #pubX: pubX,
            #pubY: pubY,
          },
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i3.HashDTO getNodeHash(_i15.NodeDTO? node) => (super.noSuchMethod(
        Invocation.method(
          #getNodeHash,
          [node],
        ),
        returnValue: _FakeHashDTO_1(
          this,
          Invocation.method(
            #getNodeHash,
            [node],
          ),
        ),
      ) as _i3.HashDTO);
  @override
  _i3.HashDTO getNodeKey(List<_i3.HashDTO>? children) => (super.noSuchMethod(
        Invocation.method(
          #getNodeKey,
          [children],
        ),
        returnValue: _FakeHashDTO_1(
          this,
          Invocation.method(
            #getNodeKey,
            [children],
          ),
        ),
      ) as _i3.HashDTO);
}

/// A class which mocks [LibBabyJubJubDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLibBabyJubJubDataSource extends _i1.Mock
    implements _i16.LibBabyJubJubDataSource {
  MockLibBabyJubJubDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<String> hashPoseidon(String? input1) => (super.noSuchMethod(
        Invocation.method(
          #hashPoseidon,
          [input1],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<String> hashPoseidon2(
    String? input1,
    String? input2,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #hashPoseidon2,
          [
            input1,
            input2,
          ],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<String> hashPoseidon3(
    String? input1,
    String? input2,
    String? input3,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #hashPoseidon3,
          [
            input1,
            input2,
            input3,
          ],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<String> hashPoseidon4(
    String? input1,
    String? input2,
    String? input3,
    String? input4,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #hashPoseidon4,
          [
            input1,
            input2,
            input3,
            input4,
          ],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
}

/// A class which mocks [LibPolygonIdCoreDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLibPolygonIdCoreDataSource extends _i1.Mock
    implements _i17.LibPolygonIdCoreDataSource {
  MockLibPolygonIdCoreDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String calculateGenesisId(String? claimsTreeRoot) => (super.noSuchMethod(
        Invocation.method(
          #calculateGenesisId,
          [claimsTreeRoot],
        ),
        returnValue: '',
      ) as String);
  @override
  String getAuthInputs() => (super.noSuchMethod(
        Invocation.method(
          #getAuthInputs,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  String issueClaim({
    required String? schema,
    required String? nonce,
    required String? pubX,
    required String? pubY,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #issueClaim,
          [],
          {
            #schema: schema,
            #nonce: nonce,
            #pubX: pubX,
            #pubY: pubY,
          },
        ),
        returnValue: '',
      ) as String);
}

/// A class which mocks [SMTDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSMTDataSource extends _i1.Mock implements _i18.SMTDataSource {
  MockSMTDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<void> createSMT({
    required int? maxLevels,
    required String? storeName,
    required String? identifier,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSMT,
          [],
          {
            #maxLevels: maxLevels,
            #storeName: storeName,
            #identifier: identifier,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
  @override
  _i12.Future<_i3.HashDTO> addLeaf({
    required _i15.NodeDTO? newNodeLeaf,
    required String? storeName,
    required String? identifier,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addLeaf,
          [],
          {
            #newNodeLeaf: newNodeLeaf,
            #storeName: storeName,
            #identifier: identifier,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i12.Future<_i3.HashDTO>.value(_FakeHashDTO_1(
          this,
          Invocation.method(
            #addLeaf,
            [],
            {
              #newNodeLeaf: newNodeLeaf,
              #storeName: storeName,
              #identifier: identifier,
              #privateKey: privateKey,
            },
          ),
        )),
      ) as _i12.Future<_i3.HashDTO>);
  @override
  _i12.Future<_i4.ProofDTO> generateProof({
    required _i3.HashDTO? key,
    required String? storeName,
    required String? identifier,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateProof,
          [],
          {
            #key: key,
            #storeName: storeName,
            #identifier: identifier,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i12.Future<_i4.ProofDTO>.value(_FakeProofDTO_2(
          this,
          Invocation.method(
            #generateProof,
            [],
            {
              #key: key,
              #storeName: storeName,
              #identifier: identifier,
              #privateKey: privateKey,
            },
          ),
        )),
      ) as _i12.Future<_i4.ProofDTO>);
  @override
  _i12.Future<_i3.HashDTO> getProofTreeRoot({
    required _i4.ProofDTO? proof,
    required _i15.NodeDTO? node,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProofTreeRoot,
          [],
          {
            #proof: proof,
            #node: node,
          },
        ),
        returnValue: _i12.Future<_i3.HashDTO>.value(_FakeHashDTO_1(
          this,
          Invocation.method(
            #getProofTreeRoot,
            [],
            {
              #proof: proof,
              #node: node,
            },
          ),
        )),
      ) as _i12.Future<_i3.HashDTO>);
  @override
  _i12.Future<bool> verifyProof({
    required _i4.ProofDTO? proof,
    required _i15.NodeDTO? node,
    required _i3.HashDTO? treeRoot,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyProof,
          [],
          {
            #proof: proof,
            #node: node,
            #treeRoot: treeRoot,
          },
        ),
        returnValue: _i12.Future<bool>.value(false),
      ) as _i12.Future<bool>);
}

/// A class which mocks [RemoteIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteIdentityDataSource extends _i1.Mock
    implements _i19.RemoteIdentityDataSource {
  MockRemoteIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i5.RhsNodeDTO> fetchStateRoots({required String? url}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchStateRoots,
          [],
          {#url: url},
        ),
        returnValue: _i12.Future<_i5.RhsNodeDTO>.value(_FakeRhsNodeDTO_3(
          this,
          Invocation.method(
            #fetchStateRoots,
            [],
            {#url: url},
          ),
        )),
      ) as _i12.Future<_i5.RhsNodeDTO>);
  @override
  _i12.Future<Map<String, dynamic>> getNonRevocationProof(
    String? identityState,
    int? revNonce,
    String? rhsBaseUrl,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNonRevocationProof,
          [
            identityState,
            revNonce,
            rhsBaseUrl,
          ],
        ),
        returnValue:
            _i12.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i12.Future<Map<String, dynamic>>);
}

/// A class which mocks [StorageIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageIdentityDataSource extends _i1.Mock
    implements _i20.StorageIdentityDataSource {
  MockStorageIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i6.IdentityDTO> getIdentity({required String? identifier}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdentity,
          [],
          {#identifier: identifier},
        ),
        returnValue: _i12.Future<_i6.IdentityDTO>.value(_FakeIdentityDTO_4(
          this,
          Invocation.method(
            #getIdentity,
            [],
            {#identifier: identifier},
          ),
        )),
      ) as _i12.Future<_i6.IdentityDTO>);
  @override
  _i12.Future<void> storeIdentity({
    required String? identifier,
    required _i6.IdentityDTO? identity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeIdentity,
          [],
          {
            #identifier: identifier,
            #identity: identity,
          },
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
  @override
  _i12.Future<void> storeIdentityTransact({
    required _i21.DatabaseClient? transaction,
    required String? identifier,
    required _i6.IdentityDTO? identity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeIdentityTransact,
          [],
          {
            #transaction: transaction,
            #identifier: identifier,
            #identity: identity,
          },
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
  @override
  _i12.Future<void> removeIdentity({required String? identifier}) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeIdentity,
          [],
          {#identifier: identifier},
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
  @override
  _i12.Future<void> removeIdentityTransact({
    required _i21.DatabaseClient? transaction,
    required String? identifier,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeIdentityTransact,
          [],
          {
            #transaction: transaction,
            #identifier: identifier,
          },
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
}

/// A class which mocks [RPCDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRPCDataSource extends _i1.Mock implements _i22.RPCDataSource {
  MockRPCDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Web3Client get web3Client => (super.noSuchMethod(
        Invocation.getter(#web3Client),
        returnValue: _FakeWeb3Client_5(
          this,
          Invocation.getter(#web3Client),
        ),
      ) as _i7.Web3Client);
  @override
  _i12.Future<String> getState(
    String? id,
    _i7.DeployedContract? stateContract,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getState,
          [
            id,
            stateContract,
          ],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
}

/// A class which mocks [LocalContractFilesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalContractFilesDataSource extends _i1.Mock
    implements _i23.LocalContractFilesDataSource {
  MockLocalContractFilesDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i7.DeployedContract> loadStateContract(String? address) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadStateContract,
          [address],
        ),
        returnValue:
            _i12.Future<_i7.DeployedContract>.value(_FakeDeployedContract_6(
          this,
          Invocation.method(
            #loadStateContract,
            [address],
          ),
        )),
      ) as _i12.Future<_i7.DeployedContract>);
}

/// A class which mocks [HexMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockHexMapper extends _i1.Mock implements _i24.HexMapper {
  MockHexMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String mapFrom(_i13.Uint8List? from) => (super.noSuchMethod(
        Invocation.method(
          #mapFrom,
          [from],
        ),
        returnValue: '',
      ) as String);
  @override
  _i13.Uint8List mapTo(String? to) => (super.noSuchMethod(
        Invocation.method(
          #mapTo,
          [to],
        ),
        returnValue: _i13.Uint8List(0),
      ) as _i13.Uint8List);
}

/// A class which mocks [PrivateKeyMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrivateKeyMapper extends _i1.Mock implements _i25.PrivateKeyMapper {
  MockPrivateKeyMapper() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [IdentityDTOMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdentityDTOMapper extends _i1.Mock implements _i26.IdentityDTOMapper {
  MockIdentityDTOMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.IdentityEntity mapFrom(_i6.IdentityDTO? from) => (super.noSuchMethod(
        Invocation.method(
          #mapFrom,
          [from],
        ),
        returnValue: _FakeIdentityEntity_7(
          this,
          Invocation.method(
            #mapFrom,
            [from],
          ),
        ),
      ) as _i8.IdentityEntity);
  @override
  _i6.IdentityDTO mapTo(_i8.IdentityEntity? to) => (super.noSuchMethod(
        Invocation.method(
          #mapTo,
          [to],
        ),
        returnValue: _FakeIdentityDTO_4(
          this,
          Invocation.method(
            #mapTo,
            [to],
          ),
        ),
      ) as _i6.IdentityDTO);
  @override
  _i9.PrivateIdentityEntity mapPrivateFrom(
    _i6.IdentityDTO? from,
    String? privateKey,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #mapPrivateFrom,
          [
            from,
            privateKey,
          ],
        ),
        returnValue: _FakePrivateIdentityEntity_8(
          this,
          Invocation.method(
            #mapPrivateFrom,
            [
              from,
              privateKey,
            ],
          ),
        ),
      ) as _i9.PrivateIdentityEntity);
}

/// A class which mocks [RhsNodeMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockRhsNodeMapper extends _i1.Mock implements _i27.RhsNodeMapper {
  MockRhsNodeMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.RhsNodeEntity mapFrom(_i5.RhsNodeDTO? from) => (super.noSuchMethod(
        Invocation.method(
          #mapFrom,
          [from],
        ),
        returnValue: _FakeRhsNodeEntity_9(
          this,
          Invocation.method(
            #mapFrom,
            [from],
          ),
        ),
      ) as _i10.RhsNodeEntity);
  @override
  _i5.RhsNodeDTO mapTo(_i10.RhsNodeEntity? to) => (super.noSuchMethod(
        Invocation.method(
          #mapTo,
          [to],
        ),
        returnValue: _FakeRhsNodeDTO_3(
          this,
          Invocation.method(
            #mapTo,
            [to],
          ),
        ),
      ) as _i5.RhsNodeDTO);
}

/// A class which mocks [StateIdentifierMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockStateIdentifierMapper extends _i1.Mock
    implements _i28.StateIdentifierMapper {
  MockStateIdentifierMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String mapTo(String? to) => (super.noSuchMethod(
        Invocation.method(
          #mapTo,
          [to],
        ),
        returnValue: '',
      ) as String);
}

/// A class which mocks [DidMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDidMapper extends _i1.Mock implements _i29.DidMapper {
  MockDidMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String mapTo(_i29.DidMapperParam? to) => (super.noSuchMethod(
        Invocation.method(
          #mapTo,
          [to],
        ),
        returnValue: '',
      ) as String);
}
