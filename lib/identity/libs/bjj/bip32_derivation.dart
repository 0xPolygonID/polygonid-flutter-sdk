import 'dart:typed_data';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Minimal BIP32 subset just to derive path m/44'/60'/0'/0 from a seed.
class Bip32Node {
  final Uint8List privateKey; // 32 bytes
  final Uint8List chainCode; // 32 bytes

  Bip32Node(this.privateKey, this.chainCode);
}

Uint8List _hmacSha512(Uint8List key, List<int> data) {
  final hmac = Hmac(sha512, key); // HMAC-SHA512
  final digest = hmac.convert(data).bytes;
  return Uint8List.fromList(digest);
}

Bip32Node masterFromSeed(Uint8List seed) {
  final I = _hmacSha512(Uint8List.fromList(utf8.encode('Bitcoin seed')), seed);
  return Bip32Node(I.sublist(0, 32), I.sublist(32));
}

// Hardened index if index >= 0x80000000
const int hardenedOffset = 0x80000000;

Bip32Node ckdPriv(Bip32Node parent, int index) {
  // Data: 0x00 + ser256(kpar) + ser32(index) for private derivation
  final data = <int>[0];
  data.addAll(parent.privateKey);
  data.addAll(_ser32(index));
  final I = _hmacSha512(parent.chainCode, data);
  final IL = I.sublist(0, 32);
  final IR = I.sublist(32);
  // We ignore key validity edge cases for simplicity (rare). Normally need to check IL in [1, n-1]
  // Add IL to parent key modulo curve order; here we just replace for deterministic babyjub derivation usage scope.
  // For babyjub key we only need entropy, so we use IL directly.
  return Bip32Node(IL, IR);
}

Uint8List _ser32(int i) {
  return Uint8List(4)
    ..[0] = (i >> 24) & 0xff
    ..[1] = (i >> 16) & 0xff
    ..[2] = (i >> 8) & 0xff
    ..[3] = i & 0xff;
}

// Derive a path like m/44'/60'/0'/0
Bip32Node derivePath(Bip32Node master, String path) {
  if (path == 'm' || path == 'M' || path == 'm/' || path == 'M/') {
    return master;
  }
  var current = master;
  final segments = path.split('/').where((p) => p.isNotEmpty).toList();
  if (segments.first.toLowerCase() == 'm') {
    segments.removeAt(0);
  }
  for (final seg in segments) {
    bool hardened = seg.endsWith("'");
    final indexStr = hardened ? seg.substring(0, seg.length - 1) : seg;
    final index = int.parse(indexStr);
    final idx = hardened ? (index + hardenedOffset) : index;
    current = ckdPriv(current, idx);
  }
  return current;
}

