import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

enum NotificationState {
  pending,
  accepted,
  declined,
}

class NotificationEntity extends InteractionEntity {
  final bool isRead;
  final NotificationState state;

  NotificationEntity({
    required super.id,
    this.isRead = false,
    this.state = NotificationState.pending,
    required super.from,
    required super.genesisDid,
    required super.profileNonce,
    required super.type,
    required super.timestamp,
    required super.message,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'],
      isRead: json['isRead'] as bool,
      state: NotificationState.values
          .firstWhere((type) => type.toString() == json['state']),
      message: json['message'],
      from: json['from'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      type: InteractionType.values
          .firstWhere((type) => type.toString() == json['type']),
      timestamp: json['timestamp'],
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'isRead': isRead,
      'state': state.toString(),
    });

  @override
  String toString() =>
      "[NotificationEntity] {${super.toString()}, isRead: $isRead, state: $state}";

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is NotificationEntity &&
      isRead == other.isRead &&
      state == other.state;

  @override
  int get hashCode => runtimeType.hashCode;
}
