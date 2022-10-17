class CustomStrings {
  CustomStrings._();

  // APP
  static const String appTitle = "PolygonID Example App";

  // HOME
  static const String homeDescription =
      "Generate a new identity or if saved retrieved via PolygonID SDK";
  static const String homeIdentifierSectionPrefix = "Identifier:";
  static const String homeIdentifierSectionPlaceHolder = "Not yet created";
  static const String homeButtonCTA = "Create identity";

  // AUTH
  static const String authButtonCTA = "Connect";
  static const String authDescription =
      "Authenticate through verifier provider by scanning QR Code.\nIf you are already authenticated, you can skip this step";
  static const String authSuccess = "Authenticated successfully";

  // CLAIMS
  static const String claimsTitle = "Claims";
  static const String claimsDescription =
      "Connect with a service to add claims about your identity";
  static const String claimsListNoResult = "empty claims list";
  static const String claimNameCountryOfResidence = "Country of residence";
  static const String claimNameDateOfBirth = "Date of birth";
  static const String claimNamePolygonDaoMember = "Polygon DAO membership";
  static const String claimNamePolygonDaoTeamMember =
      "Polygon DAO team membership";
  static const String claimNameUniquePerson = "Unique identity";
  static const String claimNameProofOfPersonhood = "Proof of personhood";
  static const String claimRemovingError =
      "Error while removing selected claim, please try again";
  static const String deleteClaimButtonCTA = "Remove claim";
  static const String deleteAllClaimsButtonCTA = "Remove all claims";
  static const String claimCardIssuerLabel = "Issuer:";

  // ERROR
  static const String genericError = "A generic error occurred, try again";
  static const String iden3messageGenericError = "Error in the readed message";
}
