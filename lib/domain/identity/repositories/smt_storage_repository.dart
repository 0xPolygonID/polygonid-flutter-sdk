import '../../../data/identity/smt/hash.dart';
import '../../../data/identity/smt/node.dart';

abstract class SMTStorageRepository {
  Node get(Hash k);
  void put(Hash k, Node n);
  Hash getRoot();
  void setRoot(Hash r);
}
