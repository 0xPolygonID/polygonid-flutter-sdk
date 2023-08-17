import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';

class Iden3commCredentialRepositoryImpl extends Iden3commCredentialRepository {
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final ProofRequestFiltersMapper _proofRequestFiltersMapper;
  final ClaimMapper _claimMapper;

  Iden3commCredentialRepositoryImpl(
    this._remoteIden3commDataSource,
    this._proofRequestFiltersMapper,
    this._claimMapper,
  );

  @override
  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request}) {
    return Future.value(_proofRequestFiltersMapper.mapFrom(request));
  }

  @override
  Future<ClaimEntity> fetchClaim({
    required String url,
    required String did,
    required String authToken,
  }) {
    return _remoteIden3commDataSource
        .fetchClaim(authToken: authToken, url: url, did: did)
        .then((dto) {
      /// Error in fetching schema is not blocking
      return _remoteIden3commDataSource
          .fetchSchema(url: dto.info.credentialSchema.id)
          .then((schema) {
            dto.schema = schema;
            return dto;
          })
          .catchError((_) => dto)
          .then((value) => _claimMapper.mapFrom(dto));
    }).catchError((error) => throw FetchClaimException(error));
  }

  @override
  Future<Map<String, dynamic>> fetchSchema({required String url}) {
    return _remoteIden3commDataSource
        .fetchSchema(url: url)
        .catchError((error) => throw FetchSchemaException(error));
  }
}
