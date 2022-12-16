import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/constants.dart';

class DestinationPathDataSource {
  /// Returns the destination path of the db
  Future<String> getDestinationPath({required String identifier}) async {
    String path = await _createPath();
    final destinationPath = join(
      path,
      claimDatabasePrefix + identifier + '.db',
    );
    return destinationPath;
  }

  /// Returns the path to the directory where the database will be stored
  Future<String> _createPath() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return dir.path;
  }
}
