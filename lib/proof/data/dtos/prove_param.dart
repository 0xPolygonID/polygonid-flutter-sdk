import 'dart:typed_data';

class ProveParam {
  final String circuitId;
  final Uint8List zKey;
  final Uint8List wtns;

  ProveParam(this.circuitId, this.zKey, this.wtns);
}
