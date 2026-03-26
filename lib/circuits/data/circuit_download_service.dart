import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as pathLib;
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

/// Handles downloading zip archives from remote URLs and extracting them to
/// the local filesystem.
///
/// This is intentionally decoupled from [CircuitRegistry] and
/// [CircuitsFilesDataSource] so that each class has a single responsibility:
/// - [CircuitRegistry]          — pure registration/lookup of circuit sources
/// - [CircuitDownloadService]   — network download + zip extraction
/// - [CircuitsFilesDataSource]  — file resolution (local, asset, registry)
@injectable
class CircuitDownloadService {
  final Directory _directory;
  final ZipDecoder _zipDecoder;
  final Dio _client;

  /// Candidate file names for graph (.wcd) files inside a circuit folder.
  /// `%s` is replaced with the circuitId.
  static const _graphFallbacks = ['%s.wcd', 'graph.wcd'];

  /// Candidate file names for zkey files inside a circuit folder.
  static const _zkeyFallbacks = ['%s.zkey', 'circuit_final.zkey'];

  CircuitDownloadService(this._directory, this._zipDecoder, this._client);

  /// Extracts entries from [zipFilePath] into [outputDirectory], placing each
  /// file directly in [outputDirectory] (using only the basename of the
  /// archive entry). Directory entries are skipped.
  Future<void> extractZipToDirectory({
    required String zipFilePath,
    required String outputDirectory,
  }) async {
    final archive = _zipDecoder.decodeStream(InputFileStream(zipFilePath));

    for (final archiveFile in archive) {
      if (!archiveFile.isFile) continue;
      final outPath = pathLib.join(
        outputDirectory,
        pathLib.basename(archiveFile.name),
      );
      await File(outPath).create(recursive: true);
      archiveFile.writeContent(OutputFileStream(outPath));
    }
  }

  /// Downloads a zip archive from [zipUrl], extracts it into a subdirectory
  /// named [circuitId] under the base directory, and deletes the zip.
  ///
  /// Extraction is performed into a temporary directory that is atomically
  /// renamed to the final location once all files have been written. This
  /// prevents a partially-extracted directory from being mistaken for a valid
  /// extraction on subsequent calls.
  ///
  /// When [forceDownload] is `false` (the default) the download is skipped if
  /// the circuit files are already present on disk. Pass `true` to always
  /// re-download and re-extract.
  ///
  /// [cancelToken] can be used to cancel the in-flight Dio download.
  Future<void> downloadAndExtractZip(
    String circuitId,
    String zipUrl, {
    bool forceDownload = false,
    CancelToken? cancelToken,
  }) async {
    final circuitDir = Directory(pathLib.join(_directory.path, circuitId));

    // Skip only when the expected circuit files are already present.
    if (!forceDownload && _circuitFilesValid(circuitId, circuitDir)) return;

    // If the directory exists but is incomplete, remove it so we start fresh.
    if (circuitDir.existsSync()) {
      circuitDir.deleteSync(recursive: true);
    }

    final zipPath = pathLib.join(_directory.path, '$circuitId.zip');
    final tempDir = Directory(
      pathLib.join(
        _directory.path,
        '${circuitId}_tmp_${DateTime.now().millisecondsSinceEpoch}',
      ),
    );

    try {
      await _client.download(zipUrl, zipPath, cancelToken: cancelToken);

      await tempDir.create(recursive: true);
      await extractZipToDirectory(
        zipFilePath: zipPath,
        outputDirectory: tempDir.path,
      );

      // Validate that the extraction produced the expected files.
      if (!_circuitFilesValid(circuitId, tempDir)) {
        throw CircuitNotDownloadedException(
          circuit: circuitId,
          errorMessage:
              'Extraction of $circuitId produced an incomplete set of files',
        );
      }

      // Atomic rename – safe on the same filesystem.
      await tempDir.rename(circuitDir.path);
    } catch (_) {
      // Clean up partial artefacts so a retry can succeed.
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      if (circuitDir.existsSync()) {
        circuitDir.deleteSync(recursive: true);
      }
      deleteFile(zipPath);
      rethrow;
    }

    // Clean up the zip.
    deleteFile(zipPath);
  }

  void deleteFile(String pathToFile) {
    try {
      File(pathToFile).deleteSync();
    } catch (_) {} // file not found — nothing to clean up
  }

  /// Returns `true` when [dir] contains at least one expected circuit file
  /// (.wcd or .zkey) for the given [circuitId].
  bool _circuitFilesValid(String circuitId, Directory dir) {
    if (!dir.existsSync()) return false;

    for (final pattern in [..._graphFallbacks, ..._zkeyFallbacks]) {
      final file = File(
        pathLib.join(dir.path, pattern.replaceAll('%s', circuitId)),
      );
      if (file.existsSync()) return true;
    }
    return false;
  }
}
