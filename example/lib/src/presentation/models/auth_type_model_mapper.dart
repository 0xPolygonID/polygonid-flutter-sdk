import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/auth.dart';


class AuthTypeModelMapper extends Mapper<AuthType, String> {
  @override
  String mapFrom(AuthType from) {
    switch (from) {
      case AuthType.auth:
        return "https://iden3-communication.io/authorization/1.0/request";
      case AuthType.offer:
        return "https://iden3-communication.io/credentials/1.0/offer";
      case AuthType.issuance:
        return "https://iden3-communication.io/credentials/1.0/issuance-response";
      default:
        return "";
    }
  }

  @override
  AuthType mapTo(String to) {
    switch (to) {
      case "https://iden3-communication.io/authorization/1.0/request":
        return AuthType.auth;
      case "https://iden3-communication.io/credentials/1.0/offer":
        return AuthType.offer;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        return AuthType.issuance;
      default:
        return AuthType.unknown;
    }
  }
}