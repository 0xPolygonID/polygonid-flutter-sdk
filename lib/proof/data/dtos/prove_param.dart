import 'dart:typed_data';

class ProveParam {
  final String circuitId;
  final String zKeyPath;
  final Uint8List wtns;

  ProveParam(
    this.circuitId,
    this.zKeyPath,
    this.wtns,
  );
}
