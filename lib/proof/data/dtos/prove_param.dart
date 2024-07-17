import 'dart:typed_data';

import 'package:flutter/services.dart';

class ProveParam {
  final Uint8List zkey;
  final Uint8List wtns;
  final RootIsolateToken token;

  ProveParam(
    this.zkey,
    this.wtns,
    this.token,
  );
}
