// Mocks generated by Mockito 5.3.0 from annotations
// in polygonid_flutter_sdk/test/domain/use_cases/get_auth_token_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart'
    as _i2;
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart'
    as _i3;
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart'
    as _i5;

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

class _FakeIdentityEntity_0 extends _i1.SmartFake
    implements _i2.IdentityEntity {
  _FakeIdentityEntity_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [IdentityRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdentityRepository extends _i1.Mock
    implements _i3.IdentityRepository {
  MockIdentityRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> createIdentity({String? privateKey}) =>
      (super.noSuchMethod(
          Invocation.method(#createIdentity, [], {#privateKey: privateKey}),
          returnValue: _i4.Future<String>.value('')) as _i4.Future<String>);
  @override
  _i4.Future<_i2.IdentityEntity> getIdentityFromKey({String? privateKey}) =>
      (super.noSuchMethod(
          Invocation.method(#getIdentityFromKey, [], {#privateKey: privateKey}),
          returnValue: _i4.Future<_i2.IdentityEntity>.value(
              _FakeIdentityEntity_0(
                  this,
                  Invocation.method(#getIdentityFromKey, [], {
                    #privateKey: privateKey
                  })))) as _i4.Future<_i2.IdentityEntity>);
  @override
  _i4.Future<String> getIdentifier({String? privateKey}) => (super.noSuchMethod(
      Invocation.method(#getIdentifier, [], {#privateKey: privateKey}),
      returnValue: _i4.Future<String>.value('')) as _i4.Future<String>);
  @override
  _i4.Future<_i2.IdentityEntity> getIdentity({String? identifier}) =>
      (super.noSuchMethod(
              Invocation.method(#getIdentity, [], {#identifier: identifier}),
              returnValue: _i4.Future<_i2.IdentityEntity>.value(
                  _FakeIdentityEntity_0(
                      this,
                      Invocation.method(
                          #getIdentity, [], {#identifier: identifier}))))
          as _i4.Future<_i2.IdentityEntity>);
  @override
  _i4.Future<String> signMessage({String? identifier, String? message}) =>
      (super.noSuchMethod(
          Invocation.method(
              #signMessage, [], {#identifier: identifier, #message: message}),
          returnValue: _i4.Future<String>.value('')) as _i4.Future<String>);
  @override
  _i4.Future<void> removeIdentity({String? identifier}) => (super.noSuchMethod(
      Invocation.method(#removeIdentity, [], {#identifier: identifier}),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<String?> getCurrentIdentifier() =>
      (super.noSuchMethod(Invocation.method(#getCurrentIdentifier, []),
          returnValue: _i4.Future<String?>.value()) as _i4.Future<String?>);
  @override
  _i4.Future<String> getAuthToken(
          {String? identifier,
          _i5.CircuitDataEntity? circuitData,
          String? message}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthToken, [], {
            #identifier: identifier,
            #circuitData: circuitData,
            #message: message
          }),
          returnValue: _i4.Future<String>.value('')) as _i4.Future<String>);
  @override
  _i4.Future<bool> authenticate(
          {String? authQrCodeResult,
          _i5.CircuitDataEntity? circuitDataEntity}) =>
      (super.noSuchMethod(
          Invocation.method(#authenticate, [], {
            #authQrCodeResult: authQrCodeResult,
            #circuitDataEntity: circuitDataEntity
          }),
          returnValue: _i4.Future<bool>.value(false)) as _i4.Future<bool>);
}
