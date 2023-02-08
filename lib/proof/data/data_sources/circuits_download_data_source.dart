import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';

class CircuitsDownloadDataSource {
  ///
  Future<bool> circuitsFilesExist() async {
    String fileName = 'circuits.zip';
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    var file = File('$path/$fileName');
    return await file.exists();
  }
}
