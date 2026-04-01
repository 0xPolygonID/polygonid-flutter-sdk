import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

/// Message sent to respond to a [ResourcePermissionsListFetchMessage] or
/// [ResourcePermissionsRequestsListMessage] with the list of permissions
/// or permission requests sent or received.
class ResourcePermissionsListMessage
    extends Iden3Message<ResourcePermissionsListBody> {
  ResourcePermissionsListMessage({
    String? id,
    super.typ,
    String? thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         type: Iden3MessageType.permissionsList,
         id: id ?? const Uuid().v4(),
         thid: thid ?? const Uuid().v4(),
       );

  factory ResourcePermissionsListMessage.fromJson(Map<String, dynamic> json) {
    return ResourcePermissionsListMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ResourcePermissionsListBody.fromJson(json['body'] ?? {}),
      from: json['from'],
      to: json['to'],
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  String toString() => "[ResourcePermissionsListMessage] {${super.toString()}}";
}

class ResourcePermissionsListBody with EquatableMixin implements JsonEncodable {
  final List<Permission> granted;
  final List<Permission> pending;
  final List<Permission> rejected;
  final List<Permission>? revoked;
  final List<Permission>? deleted;

  ResourcePermissionsListBody({
    required this.granted,
    required this.pending,
    required this.rejected,
    this.revoked,
    this.deleted,
  });

  factory ResourcePermissionsListBody.fromJson(Map<String, dynamic> json) {
    return ResourcePermissionsListBody(
      granted:
          (json['granted'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e))
              .toList() ??
          [],
      pending:
          (json['pending'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e))
              .toList() ??
          [],
      rejected:
          (json['rejected'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e))
              .toList() ??
          [],
      revoked: (json['revoked'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e))
          .toList(),
      deleted: (json['deleted'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [granted, pending, rejected, revoked, deleted];

  @override
  Map<String, dynamic> toJson() {
    return {
      'granted': granted.map((e) => e.toJson()).toList(),
      'pending': pending.map((e) => e.toJson()).toList(),
      'rejected': rejected.map((e) => e.toJson()).toList(),
      if (revoked != null) 'revoked': revoked?.map((e) => e.toJson()).toList(),
      if (deleted != null) 'deleted': deleted?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

class Permission with EquatableMixin {
  final String did;

  // timestamp - Unix epoch time in seconds.
  final int? timestamp;

  Permission({required this.did, required this.timestamp});

  factory Permission.fromJson(dynamic json) {
    if (json is String) {
      return Permission(did: json, timestamp: null);
    }

    return Permission(did: json['did'], timestamp: json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    return {'did': did, 'timestamp': timestamp};
  }

  @override
  List<Object?> get props => [did, timestamp];
}
