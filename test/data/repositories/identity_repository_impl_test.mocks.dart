// Mocks generated by Mockito 5.3.0 from annotations
// in polygonid_flutter_sdk/test/data/repositories/identity_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/common/http.dart' as _i5;
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart'
    as _i10;
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart'
    as _i19;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/auth_data_source.dart'
    as _i18;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/jwz_data_source.dart'
    as _i14;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart'
    as _i9;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart'
    as _i21;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart'
    as _i11;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_key_value_data_source.dart'
    as _i13;
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart'
    as _i6;
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart'
    as _i3;
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart'
    as _i15;
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart'
    as _i17;
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart'
    as _i16;
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart'
    as _i2;
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart'
    as _i20;
import 'package:sembast/sembast.dart' as _i12;

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
  _FakePrivadoIdWallet_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeIdentityDTO_1 extends _i1.SmartFake implements _i3.IdentityDTO {
  _FakeIdentityDTO_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeIdentityEntity_2 extends _i1.SmartFake
    implements _i4.IdentityEntity {
  _FakeIdentityEntity_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [WalletDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWalletDataSource extends _i1.Mock implements _i6.WalletDataSource {
  MockWalletDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.PrivadoIdWallet> createWallet({_i8.Uint8List? privateKey}) =>
      (super.noSuchMethod(
              Invocation.method(#createWallet, [], {#privateKey: privateKey}),
              returnValue: _i7.Future<_i2.PrivadoIdWallet>.value(
                  _FakePrivadoIdWallet_0(
                      this,
                      Invocation.method(
                          #createWallet, [], {#privateKey: privateKey}))))
          as _i7.Future<_i2.PrivadoIdWallet>);
  @override
  _i7.Future<String> signMessage(
          {_i8.Uint8List? privateKey, String? message}) =>
      (super.noSuchMethod(
          Invocation.method(
              #signMessage, [], {#privateKey: privateKey, #message: message}),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
}

/// A class which mocks [LibIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLibIdentityDataSource extends _i1.Mock
    implements _i9.LibIdentityDataSource {
  MockLibIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> getIdentifier({String? pubX, String? pubY}) =>
      (super.noSuchMethod(
          Invocation.method(#getIdentifier, [], {#pubX: pubX, #pubY: pubY}),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> getAuthClaim({String? pubX, String? pubY}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthClaim, [], {#pubX: pubX, #pubY: pubY}),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String?> prepareAtomicQueryInputs(
          String? challenge,
          String? privateKey,
          _i10.CredentialData? credential,
          String? circuitId,
          String? claimType,
          String? key,
          List<int>? values,
          int? operator,
          String? revStatusUrl) =>
      (super.noSuchMethod(
          Invocation.method(#prepareAtomicQueryInputs, [
            challenge,
            privateKey,
            credential,
            circuitId,
            claimType,
            key,
            values,
            operator,
            revStatusUrl
          ]),
          returnValue: _i7.Future<String?>.value()) as _i7.Future<String?>);
}

/// A class which mocks [StorageIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageIdentityDataSource extends _i1.Mock
    implements _i11.StorageIdentityDataSource {
  MockStorageIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i3.IdentityDTO> getIdentity({String? identifier}) =>
      (super.noSuchMethod(
              Invocation.method(#getIdentity, [], {#identifier: identifier}),
              returnValue: _i7.Future<_i3.IdentityDTO>.value(_FakeIdentityDTO_1(
                  this,
                  Invocation.method(
                      #getIdentity, [], {#identifier: identifier}))))
          as _i7.Future<_i3.IdentityDTO>);
  @override
  _i7.Future<void> storeIdentity(
          {String? identifier, _i3.IdentityDTO? identity}) =>
      (super.noSuchMethod(
              Invocation.method(#storeIdentity, [],
                  {#identifier: identifier, #identity: identity}),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<void> storeIdentityTransact(
          {_i12.DatabaseClient? transaction,
          String? identifier,
          _i3.IdentityDTO? identity}) =>
      (super.noSuchMethod(
              Invocation.method(#storeIdentityTransact, [], {
                #transaction: transaction,
                #identifier: identifier,
                #identity: identity
              }),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<void> removeIdentity({String? identifier}) => (super.noSuchMethod(
      Invocation.method(#removeIdentity, [], {#identifier: identifier}),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> removeIdentityTransact(
          {_i12.DatabaseClient? transaction, String? identifier}) =>
      (super.noSuchMethod(
              Invocation.method(#removeIdentityTransact, [],
                  {#transaction: transaction, #identifier: identifier}),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
}

/// A class which mocks [StorageKeyValueDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageKeyValueDataSource extends _i1.Mock
    implements _i13.StorageKeyValueDataSource {
  MockStorageKeyValueDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<dynamic> get({String? key, _i12.DatabaseClient? database}) =>
      (super.noSuchMethod(
          Invocation.method(#get, [], {#key: key, #database: database}),
          returnValue: _i7.Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<void> store(
          {String? key, dynamic value, _i12.DatabaseClient? database}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #store, [], {#key: key, #value: value, #database: database}),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<String?> remove({String? key, _i12.DatabaseClient? database}) =>
      (super.noSuchMethod(
          Invocation.method(#remove, [], {#key: key, #database: database}),
          returnValue: _i7.Future<String?>.value()) as _i7.Future<String?>);
}

/// A class which mocks [JWZDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJWZDataSource extends _i1.Mock implements _i14.JWZDataSource {
  MockJWZDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> getAuthToken(
          {_i8.Uint8List? privateKey,
          String? authClaim,
          String? message,
          String? circuitId,
          _i8.Uint8List? datFile,
          _i8.Uint8List? zKeyFile}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthToken, [], {
            #privateKey: privateKey,
            #authClaim: authClaim,
            #message: message,
            #circuitId: circuitId,
            #datFile: datFile,
            #zKeyFile: zKeyFile
          }),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
}

/// A class which mocks [HexMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockHexMapper extends _i1.Mock implements _i15.HexMapper {
  MockHexMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String mapFrom(_i8.Uint8List? from) =>
      (super.noSuchMethod(Invocation.method(#mapFrom, [from]), returnValue: '')
          as String);
  @override
  _i8.Uint8List mapTo(String? to) =>
      (super.noSuchMethod(Invocation.method(#mapTo, [to]),
          returnValue: _i8.Uint8List(0)) as _i8.Uint8List);
}

/// A class which mocks [PrivateKeyMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrivateKeyMapper extends _i1.Mock implements _i16.PrivateKeyMapper {
  MockPrivateKeyMapper() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [IdentityDTOMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdentityDTOMapper extends _i1.Mock implements _i17.IdentityDTOMapper {
  MockIdentityDTOMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.IdentityEntity mapFrom(_i3.IdentityDTO? from) => (super.noSuchMethod(
          Invocation.method(#mapFrom, [from]),
          returnValue:
              _FakeIdentityEntity_2(this, Invocation.method(#mapFrom, [from])))
      as _i4.IdentityEntity);
}

/// A class which mocks [AuthDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthDataSource extends _i1.Mock implements _i18.AuthDataSource {
  MockAuthDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> getAuthResponse(
          {String? identifier,
          String? privateKey,
          _i19.AuthRequest? authRequest,
          _i20.CircuitDataEntity? circuitDataEntity}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthResponse, [], {
            #identifier: identifier,
            #privateKey: privateKey,
            #authRequest: authRequest,
            #circuitDataEntity: circuitDataEntity
          }),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
}

/// A class which mocks [RemoteIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteIdentityDataSource extends _i1.Mock
    implements _i21.RemoteIdentityDataSource {
  MockRemoteIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> authWithToken(
          String? token, _i19.AuthRequest? request) =>
      (super.noSuchMethod(Invocation.method(#authWithToken, [token, request]),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this, Invocation.method(#authWithToken, [token, request]))))
          as _i7.Future<_i5.Response>);
}
