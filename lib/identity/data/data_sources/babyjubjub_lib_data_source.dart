import 'package:polygonid_flutter_sdk/identity/libs/bjj/bjj.dart';

class BabyjubjubLibDataSource {
  final BabyjubjubLib _babyjubjubLib;

  BabyjubjubLibDataSource(this._babyjubjubLib);

  Future<String> getPoseidonHash(String input) {
    return Future.value(_babyjubjubLib.poseidonHash(input));
  }
}
