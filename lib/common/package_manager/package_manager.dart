import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/package_manager/packer.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/// Result of unpacking an envelope
class UnpackResult {
  final Iden3Message unpackedMessage;
  final MediaType unpackedMediaType;

  const UnpackResult({
    required this.unpackedMessage,
    required this.unpackedMediaType,
  });
}

/// Interface for defining the registry of packers
abstract interface class IPackageManager {
  /// Map of packers - key is media type, value is packer implementation
  Map<MediaType, IPacker> get packers;

  /// Registers new packers in the manager
  ///
  /// [packers] - list of packers to register
  void registerPackers(List<IPacker> packers);

  /// Packs payload with a packer that is assigned to media type.
  /// Forwards packer params to implementation.
  ///
  /// [mediaType] - the media type to use for packing
  /// [payload] - the payload bytes to pack
  /// [params] - packer parameters
  /// Returns packed bytes
  Future<Uint8List> pack(
    MediaType mediaType,
    Uint8List payload,
    PackerParams params,
  );

  /// Packs a protocol message with a packer that is assigned to media type.
  /// Forwards packer params to implementation.
  ///
  /// [mediaType] - the media type to use for packing
  /// [protocolMessage] - the message to pack
  /// [params] - packer parameters
  /// Returns packed bytes
  Future<Uint8List> packMessage(
    MediaType mediaType,
    Iden3Message protocolMessage,
    PackerParams params,
  );

  /// Unpacks packed envelope to basic protocol message and returns media type of the envelope
  ///
  /// [envelope] - bytes envelope
  /// Returns [UnpackResult] containing the unpacked message and media type
  Future<UnpackResult> unpack(Uint8List envelope);

  /// Unpacks an envelope with a known media type
  ///
  /// [mediaType] - the media type of the envelope
  /// [envelope] - the envelope bytes
  /// Returns the unpacked [BasicMessage]
  Future<Iden3Message> unpackWithType(MediaType mediaType, Uint8List envelope);

  /// Gets media type from an envelope
  ///
  /// [envelope] - the envelope string
  /// Returns the [MediaType]
  MediaType getMediaType(String envelope);

  /// Gets supported media types by packer manager
  ///
  /// Returns list of supported [MediaType]s
  List<MediaType> getSupportedMediaTypes();

  /// Gets supported accept profiles by packer manager
  ///
  /// Returns list of supported profile strings
  List<String> getSupportedProfiles();

  /// Returns true if media type and algorithms supported by packer manager
  ///
  /// [mediaType] - the media type to check
  /// [profile] - the profile to check
  /// Returns whether the profile is supported
  bool isProfileSupported(MediaType mediaType, String profile);
}
