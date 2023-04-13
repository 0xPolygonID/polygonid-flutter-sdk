import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction//notification_entity.dart';

enum OfferNotificationState {
  pending,
  accepted,
  rejected,
}

class OfferNotificationEntity extends NotificationEntity {
  final OfferNotificationState state;

  OfferNotificationEntity({
    super.id,
    required super.from,
    required super.genesisDid,
    required super.profileNonce,
    super.isRead,
    required super.payload,
    this.state = OfferNotificationState.pending,
  }) : super(notificationType: NotificationType.offer);

  factory OfferNotificationEntity.fromJson(Map<String, dynamic> json) {
    return OfferNotificationEntity(
      id: json['id'],
      from: json['from'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      isRead: json['isRead'] as bool,
      payload: json['payload'],
      state: OfferNotificationState.values
          .firstWhere((type) => type.toString() == json['state']),
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'state': state.toString(),
    });

  @override
  String toString() =>
      "[OfferNotificationEntity] {${super.toString()}, state: $state";

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is OfferNotificationEntity &&
      state == other.state;

  @override
  int get hashCode => runtimeType.hashCode;
}
