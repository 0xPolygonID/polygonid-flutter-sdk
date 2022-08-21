import 'hash.dart';

class SMTUtils {
  static List<bool> getPath(int numLevel, Hash h) {
    final path = List<bool>.filled(numLevel, false);
    for (int i = 0; i < numLevel; i++) {
      path[i] = h.testBit(i);
    }
    return path;
  }
}
