import 'package:country_code/country_code.dart';
import 'package:country_list/country_list.dart';
import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_type_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/proof_model_type_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_detail_model.dart';

import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_type.dart';

import 'claim_model_state_mapper.dart';

class ClaimModelMapper implements FromMapper<ClaimEntity, ClaimModel> {
  ClaimModelStateMapper stateMapper;
  ClaimModelTypeMapper typeMapper;
  ProofModelTypeMapper proofTypeMapper;

  ClaimModelMapper(this.stateMapper, this.typeMapper, this.proofTypeMapper);

  @override
  ClaimModel mapFrom(ClaimEntity from) {
    ClaimModelType type = typeMapper.mapFrom(from.type);
    Map<String, dynamic> subject = from.credential['credentialSubject'];

    // Name
    String name = '';
    switch (type) {
      case ClaimModelType.countryOfResidence:
        name = 'Country of residence';
        break;
      case ClaimModelType.dateOfBirth:
        name = 'Date of birth';
        break;
      case ClaimModelType.polygonDaoMember:
        name = 'Polygon DAO membership';
        break;
      case ClaimModelType.polygonDaoTeamMember:
        name = 'Polygon DAO team membership';
        break;
      case ClaimModelType.uniquePerson:
        name = 'Unique identity';
        break;
      case ClaimModelType.proofOfPersonhood:
        name = 'Proof of personhood';
        break;
      default:
        name = '';
        break;
    }

    // Issuer
    String issuer = from.issuer;
    if (issuer == "1126ZbqjDTumLRJ5A9aExczKg8V33LiVZH4vWuc36W") {
      // Polygon Verify Prod
      issuer = "Polygon Verify";
    }

    // Expiration
    String expiration = from.expiration != null
        ? DateFormat("d MMM yyyy").format(DateTime.parse(from.expiration!))
        : '';

    // Creation date and proof name
    String creationDate = "None";
    String proofType = 'BJJ Signature';
    if (from.credential['proof'].isNotEmpty) {
      for (var proof in from.credential['proof']) {
        if (proof['@type'] == "Iden3SparseMerkleProof") {
          creationDate = DateFormat("d MMM yyyy").format(
              DateTime.fromMillisecondsSinceEpoch(
                  (proof['issuer_data']['state']['block_timestamp']) * 1000));
          proofType = 'SMT Signature';
          break;
        }
      }
    }

    String value = '';
    // Details
    List<ClaimDetailModel> details = [];

    subject.forEach((key, value) {
      if (key != "id" && key != "type") {
        String claimValue = value.toString();
        if (key.toLowerCase().contains("date") ||
            key.toLowerCase().contains("day") ||
            key.toLowerCase().contains("birth")) {
          try {
            claimValue = DateFormat("d MMM yyyy")
                .format(DateTime.parse(value.toString()));
            value = claimValue;
          } catch (e, s) {
            logger().d(s);
          }
        }

        if (key.toLowerCase().contains("country")) {
          try {
            CountryCode code = CountryCode.ofNumeric(value as int);
            Country country = Country.isoCode(code.alpha2);
            claimValue = country.name;
            value = claimValue;
          } catch (e, s) {
            logger().d(s);
          }
        }

        details.add(
          ClaimDetailModel(
            name: key,
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
        type: typeMapper.mapFrom(from.type),
        value: value,
        details: details);
  }
}
