import 'dart:typed_data';

import 'package:archive/archive.dart';

/// Builds an in-memory zip archive from the given [entries].
///
/// Keys are archive entry names (e.g. `'myCircuit.wcd'`) and values are the
/// file contents as raw bytes.
Uint8List makeZipBytes(Map<String, List<int>> entries) {
  final archive = Archive();
  for (final entry in entries.entries) {
    archive.addFile(ArchiveFile.bytes(entry.key, entry.value));
  }
  return ZipEncoder().encodeBytes(archive);
}
