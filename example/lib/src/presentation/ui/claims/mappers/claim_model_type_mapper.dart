import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/models/claim_model_type.dart';

class ClaimModelTypeMapper implements Mapper<String, ClaimModelType> {
  @override
  ClaimModelType mapFrom(String from) {
    switch (from) {
      case 'KYCCountryOfResidenceCredential':
      case "CountryOfResidenceCredential":
        return ClaimModelType.countryOfResidence;
      case 'KYCAgeCredential':
      case 'AgeCredential':
        return ClaimModelType.dateOfBirth;
      case "PolygonDAOMember":
        return ClaimModelType.polygonDaoMember;
      case "PolygonDAOTeamMember":
        return ClaimModelType.polygonDaoTeamMember;
      case "UniquePersonCredential":
        return ClaimModelType.uniquePerson;
      case "ProofOfPersonhood":
        return ClaimModelType.proofOfPersonhood;
      default:
        return ClaimModelType.unknown;
    }
  }

  @override
  String mapTo(ClaimModelType to) {
    throw UnimplementedError();
  }
}
