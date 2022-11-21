import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';

class DidMapperParam {
  final String identifier;
  final String networkName;
  final String networkEnv;

  DidMapperParam(this.identifier, this.networkName, this.networkEnv);
}

class DidMapper extends ToMapper<String, DidMapperParam> {
  @override
  String mapTo(DidMapperParam to) {
    String env = "main";

    switch (to.networkEnv) {
      case "mumbai":
        env = to.networkEnv;
        break;
      case "mainnet":
      default:
        env = "main";
    }

    return "did:iden3:${to.networkName}:$env:${to.identifier}";
  }
}
