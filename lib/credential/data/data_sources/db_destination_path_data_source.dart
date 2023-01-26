import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/constants.dart';

/// Wrapper for [getDatabasesPath] to allow mocking
@injectable
class CreatePathWrapper {
  Future<String> createPath() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return dir.path;
  }
}

class DestinationPathDataSource {
  final CreatePathWrapper _createPathWrapper;

  DestinationPathDataSource(this._createPathWrapper);

  /// Returns the destination path of the db
  Future<String> getDestinationPath({required String did}) async {
    String path = await _createPath();
    final destinationPath = join(
      path,
      claimDatabasePrefix + did + '.db',
    );
    return destinationPath;
  }

  /// Returns the path to the directory where the database will be stored
  Future<String> _createPath() async {
    return _createPathWrapper.createPath();
  }
}
