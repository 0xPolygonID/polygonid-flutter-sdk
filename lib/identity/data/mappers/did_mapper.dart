import '../../../common/mappers/mapper.dart';

class DidMapperParam {
  final String identifier;
  final String blockchain;
  final String network;

  DidMapperParam(
      {required this.identifier,
      required this.blockchain,
      required this.network});
}

class DidMapper extends Mapper<String, DidMapperParam> {
  @override
  String mapTo(DidMapperParam to) {
    String env = "main";

    switch (to.network) {
      case "mumbai":
        env = to.network;
        break;
      case "mainnet":
      default:
        env = "main";
    }

    return "did:iden3:${to.blockchain}:$env:${to.identifier}";
  }

  @override
  DidMapperParam mapFrom(String from) {
    List<String> splits = from.split(":");
    if (splits.length == 5 && splits[0] == "did" && splits[1] == "iden3") {
      return DidMapperParam(
          blockchain: splits[2], network: splits[3], identifier: splits[4]);
    } else {
      throw FormatException;
    }
  }
}
