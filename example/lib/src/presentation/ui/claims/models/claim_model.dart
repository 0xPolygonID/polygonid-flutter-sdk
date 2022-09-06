import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_credential_proof.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_detail_model.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_state.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_type.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:country_code/country_code.dart';
import 'package:country_list/country_list.dart';
import 'package:intl/intl.dart';

class ClaimModel {
  final String? expiration;
  final String id;
  CredentialData credentialData;

  String? issuer = '';

  ClaimModelState state = ClaimModelState.pending;
  String? url = '';
  String? thid = '';
  String type = '';

  ClaimModel({
    required this.credentialData,
    required this.id,
    required this.expiration,
    required this.issuer,
    required this.state,
    required this.type,
    this.url,
    this.thid,
  });

  ///
  String get name {
    return type;
    /*switch (type) {
      case ClaimModelType.countryOfResidence:
        return CustomStrings.claimNameCountryOfResidence;
      case ClaimModelType.dateOfBirth:
        return CustomStrings.claimNameDateOfBirth;
      case ClaimModelType.polygonDaoMember:
        return CustomStrings.claimNamePolygonDaoMember;
      case ClaimModelType.polygonDaoTeamMember:
        return CustomStrings.claimNamePolygonDaoTeamMember;
      case ClaimModelType.uniquePerson:
        return CustomStrings.claimNameUniquePerson;
      case ClaimModelType.proofOfPersonhood:
        return CustomStrings.claimNameProofOfPersonhood;
      default:
        return "";
    }*/
  }

  ///
  String get value {
    var subject = credentialData.credential!.credentialSubject;

    return subject.toString();
    /*switch (type) {
      case ClaimModelType.countryOfResidence:
        CountryCode code = CountryCode.ofNumeric(subject!.countryCode!);
        Country country = Country.isoCode(code.alpha2);
        return country.name;
      case ClaimModelType.dateOfBirth:
        if (subject!.birthday != null) {
          String date = DateFormat("d MMM yyyy").format(DateTime.parse(subject.birthday!.toString()));
          return date;
        } else {
          return '';
        }
      case ClaimModelType.uniquePerson:
      case ClaimModelType.proofOfPersonhood:
        if (subject!.birthday != null) {
          String date = DateFormat("d MMM yyyy").format(DateTime.parse(subject.birthday!.toString()));
          return date;
        } else {
          return '';
        }
      default:
        return '';
    }*/
  }

  ///
  int? get version {
    var subject = credentialData.credential!.credentialSubject;
    return subject?.version;
  }

  ///
  String get birthDate {
    var subject = credentialData.credential!.credentialSubject;
    if (subject!.birthday != null) {
      String date = DateFormat("d MMM yyyy").format(DateTime.parse(subject.birthday!.toString()));
      return date;
    } else if (subject.birthDay != null) {
      String date = DateFormat("d MMM yyyy").format(DateTime.parse(subject.birthDay!.toString()));
      return date;
    } else {
      return '';
    }
  }

  ///
  String? get countryName {
    var subject = credentialData.credential!.credentialSubject;
    if (subject!.countryCode != null) {
      CountryCode code = CountryCode.ofNumeric(subject.countryCode!);
      Country country = Country.isoCode(code.alpha2);
      return country.name;
    } else {
      return null;
    }
  }

  ///
  String get expirationDate {
    String expirationDate = DateFormat("d MMM yyyy").format(DateTime.parse(expiration!));
    return expirationDate;
  }

  ///
  String get creationDate {
    String creationDate = "None";
    if (credentialData.credential != null && credentialData.credential!.proof != null && credentialData.credential!.proof!.isNotEmpty) {
      for (var proof in credentialData.credential!.proof!) {
        if (proof.type == CredentialCredentialProofType.Iden3SparseMerkleProof.name) {
          creationDate = DateFormat("d MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(proof.issuer_data!.state!.block_timestamp! * 1000));
        }
      }
    }

    return creationDate;
  }

  ///
  String get issuerName {
    String issuerName = issuer!;
    if (issuerName == "1126ZbqjDTumLRJ5A9aExczKg8V33LiVZH4vWuc36W") {
      // Polygon Verify Prod
      issuerName = "Polygon Verify";
    }
    return issuerName;
  }

  ///
  String get proofTypeName {
    String proofTypeString = 'BJJ Signature';
    if (credentialData.credential != null && credentialData.credential!.proof != null && credentialData.credential!.proof!.isNotEmpty) {
      for (var proof in credentialData.credential!.proof!) {
        if (proof.type == CredentialCredentialProofType.Iden3SparseMerkleProof.name) {
          proofTypeString = 'SMT Signature';
        }
      }
    }
    return proofTypeString;
  }

  ///
  List<ClaimDetailModel> get detail {
    List<ClaimDetailModel> result = [];

    /*switch (type) {
      case ClaimModelType.dateOfBirth:
        result.addAll([
          ClaimDetailModel(
            name: 'Date of Birth',
            value: birthDate,
          ),
        ]);
        break;
      case ClaimModelType.countryOfResidence:
        result.addAll([
          ClaimDetailModel(
            name: 'Country of residence',
            value: countryName ?? '',
          ),
        ]);
        break;
      case ClaimModelType.polygonDaoMember:
        result.addAll([
          ClaimDetailModel(
            name: 'Role',
            value: 'Member',
          ),
          ClaimDetailModel(
            name: 'Version',
            value: version.toString(),
          )
        ]);
        break;
      case ClaimModelType.polygonDaoTeamMember:
        result.addAll([
          ClaimDetailModel(
            name: 'Version',
            value: version.toString(),
          )
        ]);
        break;
      default:
        break;
    }*/

    result.addAll([
      ClaimDetailModel(
        name: 'Issued on',
        value: creationDate,
      ),
      ClaimDetailModel(
        name: 'Issuer',
        value: issuerName,
      ),
      ClaimDetailModel(
        name: 'Expiration date',
        value: expirationDate,
      ),
      ClaimDetailModel(
        name: 'Proof type',
        value: proofTypeName,
      )
    ]);

    return result;
  }
}
