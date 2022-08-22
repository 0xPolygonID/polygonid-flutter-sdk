import '../../libs/smt/hash.dart';
import '../../libs/smt/node.dart';

abstract class SMTStorageRepository {
  Node get(Hash k);
  void put(Hash k, Node n);
  Hash getRoot();
  void setRoot(Hash r);
}
