import '../../../credential/data/dtos/claim_info_dto.dart';
import '../../../iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'gist_proof_dto.dart';

class AtomicQueryInputsConfigParam {
  final String ethereumUrl;
  final String stateContractAddr;

  AtomicQueryInputsConfigParam({
    required this.ethereumUrl,
    required this.stateContractAddr,
  });

  Map<String, dynamic> toJson() => {
        "ethereumUrl": ethereumUrl,
        "stateContractAddr": stateContractAddr,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  factory AtomicQueryInputsConfigParam.fromJson(Map<String, dynamic> json) {
    return AtomicQueryInputsConfigParam(
      ethereumUrl: json['ethereumUrl'],
      stateContractAddr: json['stateContractAddr'],
    );
  }
}
