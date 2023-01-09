import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';

class JWZProofMapper extends FromMapper<Map<String, dynamic>, JWZProof> {
  @override
  JWZProof mapFrom(Map<String, dynamic> from) {
    return JWZProof.fromJson(from);
  }
}
