class CustomStrings {
  CustomStrings._();

  // APP
  static const String appTitle = "PolygonID Example App";

  // HOME
  static const String homeDescription =
      "Generate a new identity or if saved retrieved via PolygonID SDK";
  static const String homeIdentifierSectionPrefix =
      "identity.getDidIdentifier()\nIdentifier:";
  static const String homeIdentifierSectionPlaceHolder = "Not yet created";
  static const String homeButtonCTA =
      "Create identity\nidentity.createIdentity()";
  static const String homeButtonRemoveIdentityCTA =
      "Remove identity\nidentity.removeIdentity() ";

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

  // SIGN
  static const String signMessageResultPlaceHolder = "Message not yet signed";

  // ERROR
  static const String genericError = "A generic error occurred, try again";
  static const String iden3messageGenericError = "Error in the readed message";

  // SIGN MESSAGE FEATURE CARD
  static const String signMessageMethod = "identity.sign()";
  static const String signMessageTitle = "Sign a message";
  static const String signMessageDescription =
      "Sign a message (hex/int) with your private key";

  // AUTHENTICATE FEATURE CARD
  static const String authenticateMethod = "iden3comm.authenticate()";
  static const String authenticateTitle = "Authenticate";
  static const String authenticateDescription =
      "Authenticate through issuer/verifier service provider";

  // CHECK IDENTITY VALIDITY FEATURE CARD
  static const String checkIdentityValidityMethod =
      "identity.checkIdentityValidity()";
  static const String checkIdentityValidityTitle = "Check identity validity";
  static const String checkIdentityValidityDescription =
      "Check if the identity is valid";
  static const String chechIdentityValidityButtonCTA =
      "Check validity\nidentity.checkIdentityValidity()";
}
