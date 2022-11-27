import '../../libs/bjj/bjj.dart';

class LibBabyJubJubDataSource {
  final BabyjubjubLib _babyjubjubLib;

  LibBabyJubJubDataSource(this._babyjubjubLib);

  Future<String> hashPoseidon(String input1) {
    try {
      String hash = _babyjubjubLib.poseidonHash(input1);
      return Future.value(hash);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> hashPoseidon2(String input1, String input2) {
    try {
      String hash = _babyjubjubLib.poseidonHash2(input1, input2);
      return Future.value(hash);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> hashPoseidon3(String input1, String input2, String input3) {
    try {
      String hash = _babyjubjubLib.poseidonHash3(input1, input2, input3);
      return Future.value(hash);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> hashPoseidon4(
      String input1, String input2, String input3, String input4) {
    try {
      String hash =
          _babyjubjubLib.poseidonHash4(input1, input2, input3, input4);
      return Future.value(hash);
    } catch (e) {
      return Future.error(e);
    }
  }
}
