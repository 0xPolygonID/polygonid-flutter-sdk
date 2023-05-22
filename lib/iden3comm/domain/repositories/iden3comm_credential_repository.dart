import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';

abstract class Iden3commCredentialRepository {
  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request});

  Future<ClaimEntity> fetchClaim({
    required String url,
    required String did,
    required String authToken,
  });

  Future<Map<String, dynamic>> fetchSchema({required String url});
}
