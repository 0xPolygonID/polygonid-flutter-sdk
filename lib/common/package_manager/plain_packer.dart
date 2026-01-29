import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/accept_profile.dart';
import 'package:polygonid_flutter_sdk/common/common.dart';
import 'package:polygonid_flutter_sdk/common/package_manager/packer.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

/// Plain packer just serializes bytes to JSON and adds media type
class PlainPacker implements IPacker {
  final List<ProtocolVersion> _supportedProtocolVersions = [ProtocolVersion.v1];

  /// Packs a basic message using the specified parameters.
  ///
  /// [msg] - The basic message to pack.
  /// [param] - The packer parameters (not used).
  /// Returns a future that resolves to a Uint8List representing the packed message.
  @override
  Future<Uint8List> packMessage(Iden3Message msg, [PackerParams? param]) async {
    final msgMap = _messageToMap(msg);
    msgMap['typ'] = MediaType.plainMessage.value;
    return Uint8List.fromList(utf8.encode(jsonEncode(msgMap)));
  }

  /// Pack returns packed message to transport envelope
  ///
  /// [payload] - json message serialized
  /// [param] - not used here
  /// Returns packed message as Uint8List
  @override
  Future<Uint8List> pack(Uint8List payload, [PackerParams? param]) async {
    final msg = jsonDecode(utf8.decode(payload)) as Map<String, dynamic>;
    msg['typ'] = MediaType.plainMessage.value;
    return Uint8List.fromList(utf8.encode(jsonEncode(msg)));
  }

  /// Unpack returns unpacked message from transport envelope
  ///
  /// [envelope] - packed envelope (serialized json with media type)
  /// Returns unpacked Iden3Message
  @override
  Future<Iden3Message> unpack(Uint8List envelope) async {
    final map = jsonDecode(utf8.decode(envelope)) as Map<String, dynamic>;
    return _mapToMessage(map);
  }

  /// Returns media type for plain message
  @override
  MediaType mediaType() {
    return MediaType.plainMessage;
  }

  @override
  List<String> getSupportedProfiles() {
    return _supportedProtocolVersions
        .map((v) => '${v.value};env=${mediaType().value}')
        .toList();
  }

  @override
  bool isProfileSupported(String profile) {
    final parsed = parseAcceptProfile(profile);

    if (!_supportedProtocolVersions.contains(parsed.protocolVersion)) {
      return false;
    }
    if (parsed.env != mediaType()) {
      return false;
    }

    if (parsed.circuits != null) {
      throw Exception(
        'Circuits are not supported for ${parsed.env} media type',
      );
    }

    if (parsed.alg != null) {
      throw Exception(
        'Algorithms are not supported for ${parsed.env} media type',
      );
    }

    return true;
  }

  /// Converts a Iden3Message to a Map for JSON serialization
  Map<String, dynamic> _messageToMap(Iden3Message msg) {
    return {
      'id': msg.id,
      if (msg.typ != null) 'typ': msg.typ!,
      'type': msg.type,
      if (msg.thid != null) 'thid': msg.thid,
      if (msg.body != null) 'body': msg.body,
      if (msg.from != null) 'from': msg.from,
      if (msg.to != null) 'to': msg.to,
      if (msg.createdTime != null) 'created_time': msg.createdTime,
      if (msg.expiresTime != null) 'expires_time': msg.expiresTime,
      'attachments': msg.attachments,
    };
  }

  /// Converts a Map to a Iden3Message
  Future<Iden3Message> _mapToMessage(Map<String, dynamic> map) async {
    /*return Iden3Message(
      id: map['id'] as String,
      typ: map['typ'] != null ? _parseMediaType(map['typ'] as String) : null,
      type: map['type'] as String,
      thid: map['thid'] as String?,
      body: map['body'],
      from: map['from'] as String?,
      to: map['to'] as String?,
      createdTime: map['created_time'] as int?,
      expiresTime: map['expires_time'] as int?,
      attachments: (map['attachments'] as List<dynamic>?)
          ?.map((a) => a as Attachment)
          .toList(),
    );*/
    // TODO Rewrite this.
    return PolygonIdSdk.I.iden3comm.getIden3Message(message: jsonEncode(map));
  }

  MediaType? _parseMediaType(String value) {
    for (final mediaType in MediaType.values) {
      if (mediaType.value == value) {
        return mediaType;
      }
    }
    return null;
  }
}
