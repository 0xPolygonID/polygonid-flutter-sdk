// Mocks generated by Mockito 5.3.2 from annotations
// in polygonid_flutter_sdk/test/domain/use_cases/get_proof_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart'
    as _i12;
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart'
    as _i10;
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart'
    as _i14;
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart'
    as _i18;
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart'
    as _i11;
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i17;
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart'
    as _i6;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart'
    as _i13;
import 'package:polygonid_flutter_sdk/identity/libs/jwz/jwz_proof.dart' as _i3;
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart'
    as _i2;
import 'package:polygonid_flutter_sdk/proof_generation/domain/repositories/proof_repository.dart'
    as _i7;
import 'package:polygonid_flutter_sdk/proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i15;
import 'package:polygonid_flutter_sdk/proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i16;

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

class _FakeCircuitDataEntity_0 extends _i1.SmartFake
    implements _i2.CircuitDataEntity {
  _FakeCircuitDataEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeJWZProof_1 extends _i1.SmartFake implements _i3.JWZProof {
  _FakeJWZProof_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePrivateIdentityEntity_2 extends _i1.SmartFake
    implements _i4.PrivateIdentityEntity {
  _FakePrivateIdentityEntity_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIdentityEntity_3 extends _i1.SmartFake
    implements _i5.IdentityEntity {
  _FakeIdentityEntity_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRhsNodeEntity_4 extends _i1.SmartFake implements _i6.RhsNodeEntity {
  _FakeRhsNodeEntity_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProofRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProofRepository extends _i1.Mock implements _i7.ProofRepository {
  MockProofRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> isCircuitSupported({required String? circuitId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #isCircuitSupported,
          [],
          {#circuitId: circuitId},
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
  @override
  _i8.Future<_i2.CircuitDataEntity> loadCircuitFiles(String? circuitId) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadCircuitFiles,
          [circuitId],
        ),
        returnValue:
            _i8.Future<_i2.CircuitDataEntity>.value(_FakeCircuitDataEntity_0(
          this,
          Invocation.method(
            #loadCircuitFiles,
            [circuitId],
          ),
        )),
      ) as _i8.Future<_i2.CircuitDataEntity>);
  @override
  _i8.Future<_i9.Uint8List> calculateAtomicQueryInputs(
    String? challenge,
    _i10.ClaimEntity? authClaim,
    String? circuitId,
    _i11.ProofQueryParamEntity? queryParam,
    String? pubX,
    String? pubY,
    String? signature,
    Map<String, dynamic>? revocationStatus,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #calculateAtomicQueryInputs,
          [
            challenge,
            authClaim,
            circuitId,
            queryParam,
            pubX,
            pubY,
            signature,
            revocationStatus,
          ],
        ),
        returnValue: _i8.Future<_i9.Uint8List>.value(_i9.Uint8List(0)),
      ) as _i8.Future<_i9.Uint8List>);
  @override
  _i8.Future<_i9.Uint8List> calculateWitness(
    _i2.CircuitDataEntity? circuitData,
    _i9.Uint8List? atomicQueryInputs,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #calculateWitness,
          [
            circuitData,
            atomicQueryInputs,
          ],
        ),
        returnValue: _i8.Future<_i9.Uint8List>.value(_i9.Uint8List(0)),
      ) as _i8.Future<_i9.Uint8List>);
  @override
  _i8.Future<_i3.JWZProof> prove(
    _i2.CircuitDataEntity? circuitData,
    _i9.Uint8List? wtnsBytes,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #prove,
          [
            circuitData,
            wtnsBytes,
          ],
        ),
        returnValue: _i8.Future<_i3.JWZProof>.value(_FakeJWZProof_1(
          this,
          Invocation.method(
            #prove,
            [
              circuitData,
              wtnsBytes,
            ],
          ),
        )),
      ) as _i8.Future<_i3.JWZProof>);
  @override
  _i8.Future<List<_i12.FilterEntity>> getFilters(
          {required _i11.ProofRequestEntity? request}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFilters,
          [],
          {#request: request},
        ),
        returnValue:
            _i8.Future<List<_i12.FilterEntity>>.value(<_i12.FilterEntity>[]),
      ) as _i8.Future<List<_i12.FilterEntity>>);
}

/// A class which mocks [IdentityRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdentityRepository extends _i1.Mock
    implements _i13.IdentityRepository {
  MockIdentityRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i4.PrivateIdentityEntity> createIdentity({
    required dynamic blockchain,
    required dynamic network,
    String? secret,
    required String? accessMessage,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createIdentity,
          [],
          {
            #blockchain: blockchain,
            #network: network,
            #secret: secret,
            #accessMessage: accessMessage,
          },
        ),
        returnValue: _i8.Future<_i4.PrivateIdentityEntity>.value(
            _FakePrivateIdentityEntity_2(
          this,
          Invocation.method(
            #createIdentity,
            [],
            {
              #blockchain: blockchain,
              #network: network,
              #secret: secret,
              #accessMessage: accessMessage,
            },
          ),
        )),
      ) as _i8.Future<_i4.PrivateIdentityEntity>);
  @override
  _i8.Future<void> storeIdentity({
    required _i5.IdentityEntity? identity,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeIdentity,
          [],
          {
            #identity: identity,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> removeIdentity({
    required String? identifier,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeIdentity,
          [],
          {
            #identifier: identifier,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<_i5.IdentityEntity> getIdentity({required String? did}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdentity,
          [],
          {#did: did},
        ),
        returnValue: _i8.Future<_i5.IdentityEntity>.value(_FakeIdentityEntity_3(
          this,
          Invocation.method(
            #getIdentity,
            [],
            {#did: did},
          ),
        )),
      ) as _i8.Future<_i5.IdentityEntity>);
  @override
  _i8.Future<_i4.PrivateIdentityEntity> getPrivateIdentity({
    required String? did,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPrivateIdentity,
          [],
          {
            #did: did,
            #privateKey: privateKey,
          },
        ),
        returnValue: _i8.Future<_i4.PrivateIdentityEntity>.value(
            _FakePrivateIdentityEntity_2(
          this,
          Invocation.method(
            #getPrivateIdentity,
            [],
            {
              #did: did,
              #privateKey: privateKey,
            },
          ),
        )),
      ) as _i8.Future<_i4.PrivateIdentityEntity>);
  @override
  _i8.Future<List<_i5.IdentityEntity>> getIdentities() => (super.noSuchMethod(
        Invocation.method(
          #getIdentities,
          [],
        ),
        returnValue:
            _i8.Future<List<_i5.IdentityEntity>>.value(<_i5.IdentityEntity>[]),
      ) as _i8.Future<List<_i5.IdentityEntity>>);
  @override
  _i8.Future<String> signMessage({
    required String? privateKey,
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
        returnValue: _i8.Future<String>.value(''),
      ) as _i8.Future<String>);
  @override
  _i8.Future<String> getDidIdentifier({
    required String? privateKey,
    required String? blockchain,
    required String? network,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDidIdentifier,
          [],
          {
            #privateKey: privateKey,
            #blockchain: blockchain,
            #network: network,
          },
        ),
        returnValue: _i8.Future<String>.value(''),
      ) as _i8.Future<String>);
  @override
  _i8.Future<Map<String, dynamic>> getNonRevProof({
    required String? identityState,
    required int? nonce,
    required String? baseUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNonRevProof,
          [],
          {
            #identityState: identityState,
            #nonce: nonce,
            #baseUrl: baseUrl,
          },
        ),
        returnValue:
            _i8.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i8.Future<Map<String, dynamic>>);
  @override
  _i8.Future<String> getState({
    required String? identifier,
    required String? contractAddress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getState,
          [],
          {
            #identifier: identifier,
            #contractAddress: contractAddress,
          },
        ),
        returnValue: _i8.Future<String>.value(''),
      ) as _i8.Future<String>);
  @override
  _i8.Future<String> getGistProof({
    required String? identifier,
    required String? contractAddress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getGistProof,
          [],
          {
            #identifier: identifier,
            #contractAddress: contractAddress,
          },
        ),
        returnValue: _i8.Future<String>.value(''),
      ) as _i8.Future<String>);
  @override
  _i8.Future<_i6.RhsNodeEntity> getStateRoots({required String? url}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStateRoots,
          [],
          {#url: url},
        ),
        returnValue: _i8.Future<_i6.RhsNodeEntity>.value(_FakeRhsNodeEntity_4(
          this,
          Invocation.method(
            #getStateRoots,
            [],
            {#url: url},
          ),
        )),
      ) as _i8.Future<_i6.RhsNodeEntity>);
}

/// A class which mocks [GetClaimsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetClaimsUseCase extends _i1.Mock implements _i14.GetClaimsUseCase {
  MockGetClaimsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i10.ClaimEntity>> execute(
          {required _i14.GetClaimsParam? param}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#param: param},
        ),
        returnValue:
            _i8.Future<List<_i10.ClaimEntity>>.value(<_i10.ClaimEntity>[]),
      ) as _i8.Future<List<_i10.ClaimEntity>>);
}

/// A class which mocks [GenerateProofUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGenerateProofUseCase extends _i1.Mock
    implements _i15.GenerateProofUseCase {
  MockGenerateProofUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i3.JWZProof> execute({required _i15.GenerateProofParam? param}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#param: param},
        ),
        returnValue: _i8.Future<_i3.JWZProof>.value(_FakeJWZProof_1(
          this,
          Invocation.method(
            #execute,
            [],
            {#param: param},
          ),
        )),
      ) as _i8.Future<_i3.JWZProof>);
}

/// A class which mocks [IsProofCircuitSupportedUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockIsProofCircuitSupportedUseCase extends _i1.Mock
    implements _i16.IsProofCircuitSupportedUseCase {
  MockIsProofCircuitSupportedUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> execute({required String? param}) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#param: param},
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}

/// A class which mocks [GetProofRequestsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProofRequestsUseCase extends _i1.Mock
    implements _i17.GetProofRequestsUseCase {
  MockGetProofRequestsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i11.ProofRequestEntity>> execute(
          {required _i18.Iden3MessageEntity? param}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#param: param},
        ),
        returnValue: _i8.Future<List<_i11.ProofRequestEntity>>.value(
            <_i11.ProofRequestEntity>[]),
      ) as _i8.Future<List<_i11.ProofRequestEntity>>);
}
