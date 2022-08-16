import 'package:polygonid_flutter_sdk/domain/identity/repositories/smt_storage_repository.dart';

import '../../../data/identity/smt/hash.dart';
import '../../../data/identity/smt/node.dart';
import '../../../domain/identity/exceptions/smt_exceptions.dart';

class SMTMemoryStorageRepositoryImpl implements SMTStorageRepository {
  final Map<Hash, Node> _data = <Hash, Node>{};
  Hash? _root;

  @override
  Node get(Hash k) {
    final n = _data[k];
    // print("get $k => $n");
    if (n == null) {
      throw SMTNotFound();
    }
    return n;
  }

  @override
  put(Hash k, Node n) {
    // print("put $k $n");
    _data[k] = n;
  }

  @override
  Hash getRoot() {
    if (_root == null) {
      return Hash.zero();
    }
    return _root!;
  }

  @override
  void setRoot(Hash r) {
    _root = r;
  }
}
