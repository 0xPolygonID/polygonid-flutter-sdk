import '../../domain/exceptions/smt_exceptions.dart';
import '../../domain/repositories/smt_storage_repository.dart';
import '../../libs/smt/hash.dart';
import '../../libs/smt/node.dart';

class SMTMemoryStorageRepositoryImpl implements SMTStorageRepository {
  Hash? root;
  final Map<Hash, Node> data;

  SMTMemoryStorageRepositoryImpl(this.root, {data}) : data = <Hash, Node>{};

  @override
  Node get(Hash k) {
    final n = data[k];
    // print("get $k => $n");
    if (n == null) {
      throw SMTNotFound();
    }
    return n;
  }

  @override
  put(Hash k, Node n) {
    // print("put $k $n");
    data[k] = n;
  }

  @override
  Hash getRoot() {
    if (root == null) {
      return Hash.zero();
    }
    return root!;
  }

  @override
  void setRoot(Hash r) {
    root = r;
  }

  factory SMTMemoryStorageRepositoryImpl.fromJson(Map<String, dynamic> json) {
    return SMTMemoryStorageRepositoryImpl(
      json['root'],
      data: json['data'],
    );
  }

  Map<String, String> toJson() => {
        'root': root.toString(),
        'data': data.toString(),
      };
}
