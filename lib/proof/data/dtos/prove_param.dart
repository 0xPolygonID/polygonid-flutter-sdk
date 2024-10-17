import 'dart:typed_data';
import 'dart:ui';

class ProveParam {
  final String zKeyPath;
  final Uint8List wtns;
  final RootIsolateToken rootToken;

  ProveParam(
    this.zKeyPath,
    this.wtns,
    this.rootToken,
  );
}
