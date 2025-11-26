import 'package:polygonid_flutter_sdk/jose/jwk.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_request_filters_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

class Iden3commCredentialRepositoryImpl extends Iden3commCredentialRepository {
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final ProofRequestFiltersMapper _proofRequestFiltersMapper;
  final CredentialMapper _claimMapper;
  final StacktraceManager _stacktraceManager;

  Iden3commCredentialRepositoryImpl(
    this._remoteIden3commDataSource,
    this._proofRequestFiltersMapper,
    this._claimMapper,
    this._stacktraceManager,
  );

  @override
  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request}) {
    return Future.value(_proofRequestFiltersMapper.mapFrom(request));
  }

  @override
  Future<CredentialEntity> fetchClaim({
    required String url,
    required String did,
    required String authToken,
    required List<JsonWebKey> keys,
  }) async {
    try {
      CredentialDTO claimDTO = await _remoteIden3commDataSource.fetchClaim(
        authToken: authToken,
        url: url,
        did: did,
        keys: keys,
      );
      claimDTO = await _fetchSchemaAndDisplayType(claimDTO);
      final CredentialEntity claimEntity = _claimMapper.mapFrom(claimDTO);
      return claimEntity;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError("Error fetching claim: $e");
      throw FetchClaimException(errorMessage: "Error fetching claim", error: e);
    }
  }

  /// fetch schema and displayType, if available add to the claimDTO otherwise
  /// return the claimDTO
  /// possible errors are not blocking
  Future<CredentialDTO> _fetchSchemaAndDisplayType(CredentialDTO dto) async {
    try {
      final displayMethod = dto.info.displayMethod;
      final Map<String, dynamic> schema = await _remoteIden3commDataSource
          .fetchSchema(url: dto.info.credentialSchema.id);
      dto.schema = schema;

      if (displayMethod != null) {
        final Map<String, dynamic> displayType =
            await _remoteIden3commDataSource.fetchDisplayType(
              url: displayMethod.id,
            );
        displayType['type'] = displayMethod.type;
        dto.displayType = displayType;
      }
    } catch (_) {
      return dto;
    }
    return dto;
  }

  @override
  Future<Map<String, dynamic>> fetchSchema({required String url}) async {
    try {
      final Map<String, dynamic> schema = await _remoteIden3commDataSource
          .fetchSchema(url: url);
      return schema;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError("Error fetching schema: $e");
      throw FetchSchemaException(
        errorMessage: "Error fetching schema",
        error: e,
      );
    }
  }

  @override
  Future<CredentialEntity> refreshCredential({
    required String url,
    required String authToken,
    required String profileDid,
    required List<JsonWebKey> keys,
  }) async {
    try {
      final claimDTO = await _remoteIden3commDataSource.refreshCredential(
        url: url,
        authToken: authToken,
        profileDid: profileDid,
        keys: keys,
      );
      Map<String, dynamic> schema = await _remoteIden3commDataSource
          .fetchSchema(url: claimDTO.info.credentialSchema.id);
      claimDTO.schema = schema;
      final CredentialEntity claimEntity = _claimMapper.mapFrom(claimDTO);
      return claimEntity;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError("Error refreshing credential: $e");
      throw RefreshCredentialException(
        errorMessage: "Error refreshing credential",
        error: e,
      );
    }
  }
}
