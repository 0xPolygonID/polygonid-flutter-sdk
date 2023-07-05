import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/proof_model_type_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_detail_model.dart';

import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/utils/claim_utils.dart';

import 'claim_model_state_mapper.dart';

class ClaimModelMapper implements FromMapper<ClaimEntity, ClaimModel> {
  ClaimModelStateMapper stateMapper;
  ProofModelTypeMapper proofTypeMapper;

  ClaimModelMapper(this.stateMapper, this.proofTypeMapper);

  @override
  ClaimModel mapFrom(ClaimEntity from) {
    String type = from.type;
    Map<String, dynamic> subject = from.info['credentialSubject'];

    // Name
    String name = ClaimUtils.separateByCamelCaseString(type);

    // Issuer
    String issuer = from.issuer;

    // Expiration
    String expiration = 'None';
    try {
      expiration = from.expiration != null
          ? DateFormat("d MMM yyyy").format(DateTime.parse(from.expiration!))
          : 'None';
    } catch (_) {}

    // Creation date and proof name
    String creationDate = "None";
    String proofType = '';
    if (from.info['proof'].isNotEmpty) {
      for (var proof in from.info['proof']) {
        if (proof['type'] == "Iden3SparseMerkleProof" ||
            proof['type'] == "Iden3SparseMerkleTreeProof") {
          creationDate = DateFormat("d MMM yyyy").format(
              DateTime.fromMillisecondsSinceEpoch(
                  (proof['issuerData']['state']['blockTimestamp']) * 1000));
        }
        proofType += '- ${proof['type']}\n';
      }
      proofType = proofType.substring(0, proofType.length - 1);
    }

    String value = '';
    // Details
    List<ClaimDetailModel> details = [];

    subject.forEach((key, value) {
      if (key != "id" && key != "type") {
        String claimTitle = key;
        String claimValue = value.toString();

        details.add(
          ClaimDetailModel(
            name: claimTitle,
            value: claimValue,
          ),
        );
      }
    });

    details.addAll([
      ClaimDetailModel(
        name: 'Issued on',
        value: creationDate,
      ),
      ClaimDetailModel(
        name: 'Issuer',
        value: issuer,
      ),
      ClaimDetailModel(
        name: 'Expiration date',
        value: expiration,
      ),
      ClaimDetailModel(
        name: 'Proof type',
        value: proofType,
      )
    ]);

    return ClaimModel(
        id: from.id,
        name: name,
        issuer: from.issuer,
        expiration: from.expiration,
        state: stateMapper.mapFrom(from.state),
        type: from.type,
        value: value,
        details: details);
  }
}
