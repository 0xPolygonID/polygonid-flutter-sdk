import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../../common/mappers/from_mapper.dart';

final _leafNodeValue = BigInt.parse(
  "0100000000000000000000000000000000000000000000000000000000000000",
  radix: 2,
);

class NodeTypeEntityMapper extends FromMapper<NodeEntity, NodeType> {
  @override
  NodeType mapFrom(NodeEntity from) {
    if (from.children.length == 3) {
      if (from.children[2].toBigInt() == _leafNodeValue) {
        return NodeType.leaf;
      } else {
        return NodeType.state;
      }
    } else if (from.children.length == 2) {
      return NodeType.middle;
    } else {
      return NodeType.unknown;
    }
  }
}
