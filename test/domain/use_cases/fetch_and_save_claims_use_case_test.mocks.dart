// Mocks generated by Mockito 5.2.0 from annotations
// in polygonid_flutter_sdk/test/domain/use_cases/fetch_and_save_claims_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart'
    as _i7;
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart'
    as _i2;
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart'
    as _i6;
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_auth_token_use_case.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeClaimEntity_0 extends _i1.Fake implements _i2.ClaimEntity {}

/// A class which mocks [GetAuthTokenUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAuthTokenUseCase extends _i1.Mock
    implements _i3.GetAuthTokenUseCase {
  MockGetAuthTokenUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> execute({_i3.GetAuthTokenParam? param}) =>
      (super.noSuchMethod(Invocation.method(#execute, [], {#param: param}),
          returnValue: Future<String>.value('')) as _i4.Future<String>);
}

/// A class which mocks [CredentialRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCredentialRepository extends _i1.Mock
    implements _i5.CredentialRepository {
  MockCredentialRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ClaimEntity> fetchClaim(
          {String? identifier,
          String? token,
          _i6.CredentialRequestEntity? credentialRequest}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchClaim, [], {
                #identifier: identifier,
                #token: token,
                #credentialRequest: credentialRequest
              }),
              returnValue: Future<_i2.ClaimEntity>.value(_FakeClaimEntity_0()))
          as _i4.Future<_i2.ClaimEntity>);
  @override
  _i4.Future<String> getFetchMessage(
          {_i6.CredentialRequestEntity? credentialRequest}) =>
      (super.noSuchMethod(
          Invocation.method(
              #getFetchMessage, [], {#credentialRequest: credentialRequest}),
          returnValue: Future<String>.value('')) as _i4.Future<String>);
  @override
  _i4.Future<void> saveClaims({List<_i2.ClaimEntity>? claims}) =>
      (super.noSuchMethod(Invocation.method(#saveClaims, [], {#claims: claims}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<List<_i2.ClaimEntity>> getClaims(
          {List<_i7.FilterEntity>? filters}) =>
      (super.noSuchMethod(
              Invocation.method(#getClaims, [], {#filters: filters}),
              returnValue:
                  Future<List<_i2.ClaimEntity>>.value(<_i2.ClaimEntity>[]))
          as _i4.Future<List<_i2.ClaimEntity>>);
  @override
  _i4.Future<void> removeClaims({List<String>? ids}) =>
      (super.noSuchMethod(Invocation.method(#removeClaims, [], {#ids: ids}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.ClaimEntity> updateClaim(
          {String? id, Map<String, dynamic>? data}) =>
      (super.noSuchMethod(
              Invocation.method(#updateClaim, [], {#id: id, #data: data}),
              returnValue: Future<_i2.ClaimEntity>.value(_FakeClaimEntity_0()))
          as _i4.Future<_i2.ClaimEntity>);
}
