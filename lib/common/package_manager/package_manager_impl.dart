import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/package_manager/package_manager.dart';
import 'package:polygonid_flutter_sdk/common/package_manager/packer.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/// Basic package manager for iden3 communication protocol
class PackageManager implements IPackageManager {
  @override
  final Map<MediaType, IPacker> packers;

  /// Creates an instance of PackageManager.
  PackageManager() : packers = {};

  @override
  List<String> getSupportedProfiles() {
    final acceptProfiles = <String>[];
    final mediaTypes = getSupportedMediaTypes();

    for (final mediaType in mediaTypes) {
      final p = packers[mediaType];
      if (p != null) {
        acceptProfiles.addAll(p.getSupportedProfiles());
      }
    }

    return acceptProfiles.toSet().toList();
  }

  @override
  bool isProfileSupported(MediaType mediaType, String profile) {
    final p = packers[mediaType];
    if (p == null) {
      return false;
    }

    return p.isProfileSupported(profile);
  }

  @override
  List<MediaType> getSupportedMediaTypes() {
    return packers.keys.toList();
  }

  @override
  void registerPackers(List<IPacker> packers) {
    for (final p in packers) {
      this.packers[p.mediaType()] = p;
    }
  }

  @override
  Future<Uint8List> pack(
    MediaType mediaType,
    Uint8List payload,
    PackerParams params,
  ) async {
    final p = packers[mediaType];
    if (p == null) {
      throw Exception('packer for media type $mediaType not found');
    }

    return await p.pack(payload, params);
  }

  @override
  Future<Uint8List> packMessage(
    MediaType mediaType,
    Iden3Message protocolMessage,
    PackerParams params,
  ) {
    final p = packers[mediaType];
    if (p == null) {
      throw Exception('packer for media type $mediaType not found');
    }

    return p.packMessage(protocolMessage, params);
  }

  @override
  Future<UnpackResult> unpack(Uint8List envelope) async {
    final decodedStr = utf8.decode(envelope);
    final safeEnvelope = decodedStr.trim();
    final mediaType = getMediaType(safeEnvelope);

    return UnpackResult(
      unpackedMessage: await _unpackWithSafeEnvelope(
        mediaType,
        Uint8List.fromList(utf8.encode(safeEnvelope)),
      ),
      unpackedMediaType: mediaType,
    );
  }

  @override
  Future<Iden3Message> unpackWithType(
    MediaType mediaType,
    Uint8List envelope,
  ) async {
    final decodedStr = utf8.decode(envelope);
    final safeEnvelope = decodedStr.trim();
    return await _unpackWithSafeEnvelope(
      mediaType,
      Uint8List.fromList(utf8.encode(safeEnvelope)),
    );
  }

  Future<Iden3Message> _unpackWithSafeEnvelope(
    MediaType mediaType,
    Uint8List envelope,
  ) async {
    final p = packers[mediaType];
    if (p == null) {
      throw Exception('packer for media type $mediaType not found');
    }
    final msg = await p.unpack(envelope);
    return msg;
  }

  @override
  MediaType getMediaType(String envelope) {
    final error = Exception("missing header 'typ' in the envelope");
    final supportedMediaTypes = MediaType.values;

    if (envelope.isNotEmpty && envelope[0] == '{') {
      final envelopeStub = jsonDecode(envelope) as Map<String, dynamic>;

      final typ = envelopeStub['typ'] as String?;
      if (typ != null) {
        final mediaType = _parseMediaType(typ);
        if (mediaType != null && supportedMediaTypes.contains(mediaType)) {
          return mediaType;
        }
      }

      final protectedValue = envelopeStub['protected'];
      if (protectedValue != null) {
        final String? protectedTyp;

        if (protectedValue is String) {
          final decoded =
              jsonDecode(
                    utf8.decode(base64Decode(_normalizeBase64(protectedValue))),
                  )
                  as Map<String, dynamic>;
          protectedTyp = decoded['typ'] as String?;
        } else if (protectedValue is Map<String, dynamic>) {
          protectedTyp = protectedValue['typ'] as String?;
        } else {
          protectedTyp = null;
        }

        if (protectedTyp != null) {
          final mediaType = _parseMediaType(protectedTyp);
          if (mediaType != null && supportedMediaTypes.contains(mediaType)) {
            return mediaType;
          }
        }
      }

      throw error;
    }

    final headerBase64 = envelope.split('.')[0];
    final header =
        jsonDecode(utf8.decode(base64Decode(_normalizeBase64(headerBase64))))
            as Map<String, dynamic>;

    final typ = header['typ'] as String?;
    if (typ == null) {
      throw error;
    }

    final mediaType = _parseMediaType(typ);
    if (mediaType == null || !supportedMediaTypes.contains(mediaType)) {
      throw error;
    }

    return mediaType;
  }

  /// Normalizes base64 string for decoding (handles URL-safe base64 and padding)
  String _normalizeBase64(String input) {
    // Replace URL-safe characters with standard base64
    var normalized = input.replaceAll('-', '+').replaceAll('_', '/');

    // Add padding if necessary
    final remainder = normalized.length % 4;
    if (remainder != 0) {
      normalized += '=' * (4 - remainder);
    }

    return normalized;
  }

  /// Parses a string to MediaType enum value
  MediaType? _parseMediaType(String value) {
    for (final mediaType in MediaType.values) {
      if (mediaType.value == value) {
        return mediaType;
      }
    }
    return null;
  }
}
