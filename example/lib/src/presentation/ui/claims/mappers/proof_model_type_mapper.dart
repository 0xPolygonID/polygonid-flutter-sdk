import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/proof_type.dart';

class ProofModelTypeMapper implements Mapper<String, ProofType> {
  @override
  ProofType mapFrom(String from) {
    switch (from) {
      case 'BJJSignature2021':
        return ProofType.signatureProof;
      case 'Iden3SparseMerkleProof':
      case 'Iden3SparseMerkleTreeProof':
        return ProofType.sparseMerkleTreeProof;
      default:
        return ProofType.unknown;
    }
  }

  @override
  String mapTo(ProofType to) {
    throw UnimplementedError();
  }
}
