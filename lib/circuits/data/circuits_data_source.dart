import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:md5_file_checksum/md5_file_checksum.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';
import 'package:polygonid_flutter_sdk/circuits/data/download_response_dto.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:path/path.dart' as pathLib;

import 'circuits_to_download_param.dart';

@injectable
class CircuitsDataSource {
  final Directory directory;
  final Dio _client;
  late CancelToken _cancelToken;

  CircuitsDataSource(this.directory, this._client);

  StreamController<DownloadResponseDTO> _controller =
      StreamController<DownloadResponseDTO>.broadcast();

  Stream<DownloadResponseDTO> get downloadStream => _controller.stream;

  int _downloadSize = 0;

  /// downloadSize
  int get downloadSize => _downloadSize;

  /// we check if the circuit file exists and if the checksum is valid
  /// parameters:
  /// - [circuitFileName]: the name of the circuit file including the extension
  /// - [checksum]: the md5 checksum of the file
  Future<bool> circuitExistsAndValidChecksum({
    required String circuitFileName,
    required String checksum,
  }) async {
    try {
      String path = directory.path;
      var file = File('$path/$circuitFileName');
      final bool fileExists = await file.exists();
      if (!fileExists) {
        return false;
      }

      // we check the md5 checksum of the file
      final checksumFromFileBase64 =
          await _getChecksumWithoutBlockingUI(file.path);
      final String checksumFromFile = _base64ToHex(checksumFromFileBase64);

      // we compare the checksum of the file with the checksum provided
      if (checksumFromFile != checksum) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _getChecksumWithoutBlockingUI(String filePath) async {
    final rootToken = RootIsolateToken.instance!;
    final String checksum =
        await compute(_calculateChecksum, ChecksumParam(filePath, rootToken));
    return checksum;
  }

  Future<String> _calculateChecksum(ChecksumParam param) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(param.rootToken);
    String checksum =
        await Md5FileChecksum.getFileChecksum(filePath: param.filePath);
    return checksum;
  }

  // get the path to the temporary zip file, after the download is complete
  // the temporary file will be deleted
  Future<String> getPathForTemporaryZipFileDownload({
    required String zipFileName,
  }) async {
    String path = directory.path;
    String fileName = '${zipFileName.trim()}_temp.zip';

    return '$path/$fileName';
  }

  // delete the file at the given path
  Future<void> deleteFile(String pathToFile) async {
    try {
      var file = File(pathToFile);
      await file.delete();
    } catch (_) {
      // file not found? no problem, we don't need it
    }
  }

  ///
  Future<void> initStreamedResponseFromServer({
    required List<CircuitsToDownloadParam> circuitsToDownload,
  }) async {
    final fileDownloader = FileDownloader();
    _cancelToken = CancelToken();
    _cancelToken.whenCancel.then((_) {
      fileDownloader.cancelTasksWithIds(
          circuitsToDownload.map((i) => i.zipFileName).toList());
    });

    // first we get the file size
    try {
      int totalContentLength = 0;
      for (CircuitsToDownloadParam param in circuitsToDownload) {
        Response headResponse = await _client.head(param.bucketUrl);
        int contentLength =
            int.parse(headResponse.headers.value('content-length') ?? "0");
        totalContentLength += contentLength;
      }
      _downloadSize = totalContentLength;
    } catch (e) {
      _cancelToken.cancel();
      _controller.add(DownloadResponseDTO(
        progress: 0,
        total: 0,
        errorOccurred: true,
        errorMessage: e.toString(),
      ));
      return;
    }

    try {
      final progressList = List.filled(circuitsToDownload.length, 0.0);

      final downloadFutures = <Future>[];
      for (var i = 0; i < circuitsToDownload.length; i++) {
        final param = circuitsToDownload[i];
        final fileZip = File(param.temporaryZipDownloadPath!);

        final name = fileZip.uri.pathSegments.last;
        final path =
            fileZip.path.substring(0, fileZip.path.length - name.length);

        final task = DownloadTask(
          taskId: param.zipFileName,
          url: param.bucketUrl,
          baseDirectory: BaseDirectory.root,
          directory: path,
          filename: name,
        );

        final downloadFuture = fileDownloader.download(
          task,
          onProgress: (progress) {
            // Set individual file download progress
            progressList[i] = progress;

            // Calculate shared progress across all files
            final sharedProgress = progressList.fold(0.0, (a, b) => a + b) /
                circuitsToDownload.length;

            _controller.add(
              DownloadResponseDTO(
                progress: (_downloadSize * sharedProgress).toInt(),
                total: _downloadSize,
              ),
            );
          },
        );

        downloadFutures.add(downloadFuture);
      }

      await Future.wait(downloadFutures);
    } catch (e) {
      _cancelToken.cancel();
      _controller.add(DownloadResponseDTO(
        progress: 0,
        total: 0,
        errorOccurred: true,
        errorMessage: e.toString(),
      ));
      return;
    }
    _controller.add(DownloadResponseDTO(
      progress: 100,
      total: 100,
      done: true,
    ));
  }

  ///
  void cancelDownload() {
    _cancelToken.cancel();
    _controller.add(DownloadResponseDTO(
      progress: 0,
      total: 0,
      errorOccurred: true,
      errorMessage: 'Download cancelled by user',
    ));
  }

  int zipFileSize({required String pathToFile}) {
    var file = File(pathToFile);
    return file.lengthSync();
  }

  Future<String> getPathToCircuitZipFile({required String zipFileName}) async {
    String path = directory.path;
    String fileName = '${zipFileName.trim()}.zip';

    return '$path/$fileName';
  }

  Future<String> getPath() async {
    return Future.value(directory.path);
  }

  Future<bool> checkAllCircuitsChecksumFromZipDownloaded({
    required String pathForZipFile,
    required List<CircuitModel> circuitsToCheck,
  }) async {
    // the path where the circuits are stored
    final circuitsPath = await getPath();

    // read the zip file
    var zipFile = File(pathForZipFile);
    Uint8List zipBytes = await zipFile.readAsBytes();
    final zipDecoder = getItSdk.get<ZipDecoder>();
    var archive = zipDecoder.decodeBytes(zipBytes);

    bool allChecksumsAreValid = true;

    // iterate over the files in the zip
    for (final archiveFile in archive) {
      final fileName =
          pathLib.join(circuitsPath, pathLib.basename(archiveFile.name));
      if (archiveFile.isFile) {
        // write the file to local storage
        var outFile = File(fileName);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(archiveFile.content);

        // we get the checksum from list
        final String circuitToCheckChecksum = circuitsToCheck
            .firstWhere(
              (element) => element.fileName == outFile.path.split('/').last,
              orElse: () => CircuitModel(fileName: '', checksum: ''),
            )
            .checksum;

        if (circuitToCheckChecksum.isEmpty) {
          // if the checksum is empty we don't need to check it
          continue;
        }

        final circuitFromZipChecksumBase64 =
            await Md5FileChecksum.getFileChecksum(filePath: outFile.path);
        final String circuitFromZipChecksum =
            _base64ToHex(circuitFromZipChecksumBase64);

        // we compare the checksum of the file with the checksum provided in the list
        if (circuitFromZipChecksum != circuitToCheckChecksum) {
          // if the checksums are not the same we set the flag to false
          // and break the loop
          allChecksumsAreValid = false;
          break;
        }
      }
    }

    return allChecksumsAreValid;
  }

  Future<bool> removeCircuitFile({required String circuitFileName}) async {
    try {
      String path = directory.path;
      var file = File('$path/$circuitFileName');

      bool fileExists = await file.exists();
      if (!fileExists) {
        return true; // file does not exist so we return true
      }

      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  String _base64ToHex(String base64Str) {
    final bytes = base64.decode(base64Str);
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
  }
}

class ChecksumParam {
  final String filePath;
  final RootIsolateToken rootToken;

  ChecksumParam(
    this.filePath,
    this.rootToken,
  );
}
