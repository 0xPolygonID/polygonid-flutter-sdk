import '../../data/dtos/hash_dto.dart';

class SMTUtils {
  static List<bool> getPath(int numLevel, HashDTO h) {
    final path = List<bool>.filled(numLevel, false);
    for (int i = 0; i < numLevel; i++) {
      path[i] = h.testBit(i);
    }
    return path;
  }
}
