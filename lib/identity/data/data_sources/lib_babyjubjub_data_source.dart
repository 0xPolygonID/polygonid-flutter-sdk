import '../../libs/bjj/bjj.dart';

class LibBabyJubJubDataSource {
  final BabyjubjubLib _babyjubjubLib;

  LibBabyJubJubDataSource(this._babyjubjubLib);

  Future<String> hashPoseidon(List<String> children) {
    try {
      String hash = _babyjubjubLib.poseidonHashHashes(children);
      return Future.value(hash);
    } catch (e) {
      return Future.error(e);
    }
  }
}
