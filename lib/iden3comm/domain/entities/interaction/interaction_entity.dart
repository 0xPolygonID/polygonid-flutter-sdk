import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';

class InteractionEntity extends InteractionBaseEntity {
  final String genesisDid;
  final BigInt profileNonce;

  InteractionEntity({
    required super.id,
    required super.from,
    required this.genesisDid,
    required this.profileNonce,
    required super.type,
    required super.state,
    required super.timestamp,
    required super.message,
  });

  factory InteractionEntity.fromJson(Map<String, dynamic> json) {
    return InteractionEntity(
      id: json['id'],
      from: json['from'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      type: InteractionType.values
          .firstWhere((type) => type.name == json['type']),
      state: InteractionState.values
          .firstWhere((type) => type.name == json['state']),
      timestamp: json['timestamp'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'genesisDid': genesisDid,
      'profileNonce': profileNonce.toString(),
    });

  @override
  String toString() =>
      "[InteractionEntity] {${super.toString()}, genesisDid: $genesisDid, profileNonce: $profileNonce}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          genesisDid == other.genesisDid &&
          profileNonce == other.profileNonce &&
          type == other.type &&
          state == other.state &&
          timestamp == other.timestamp &&
          message == other.message;

  @override
  int get hashCode => runtimeType.hashCode;
}
