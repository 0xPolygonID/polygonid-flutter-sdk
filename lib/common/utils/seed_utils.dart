import 'dart:math';
import 'dart:typed_data';

Uint8List generateSeedBytes(Random random, {int seedLength = 32}) {
  final seedBytes = Uint8List(seedLength);
  for (var i = 0; i < seedBytes.length; i++) {
    seedBytes[i] = random.nextInt(256);
  }
  return seedBytes;
}
