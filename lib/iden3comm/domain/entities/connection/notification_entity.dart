import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/interaction_entity.dart';

enum NotificationType {
  generic,
  offer,
  revocation,
  update,
  auth,
}

class NotificationEntity extends InteractionEntity {
  final NotificationType notificationType;
  final bool isRead;
  final String payload;

  NotificationEntity({
    super.id,
    required this.notificationType,
    this.isRead = false,
    required this.payload,
    required super.from,
    required super.to,
  }) : super(type: InteractionType.notification);

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'],
      notificationType: NotificationType.values
          .firstWhere((type) => type.toString() == json['notificationType']),
      isRead: json['isRead'] as bool,
      payload: json['payload'],
      from: json['from'],
      to: json['to'],
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'notificationType': notificationType.toString(),
      'isRead': isRead,
      'payload': payload,
    });

  @override
  String toString() =>
      "[NotificationEntity] {${super.toString()} notificationType: $notificationType, isRead: $isRead, payload: $payload}";

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is NotificationEntity &&
      type == other.type &&
      isRead == other.isRead &&
      payload == other.payload;

  @override
  int get hashCode => runtimeType.hashCode;
}
