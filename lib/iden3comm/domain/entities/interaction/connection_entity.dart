import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

class ConnectionEntity extends InteractionEntity {
  ConnectionEntity({
    super.id,
    required super.from,
    required super.genesisDid,
    required super.profileNonce,
  }) : super(type: InteractionType.connection);

  factory ConnectionEntity.fromJson(Map<String, dynamic> json) {
    return ConnectionEntity(
      id: json['id'],
      from: json['from'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
    );
  }

  @override
  String toString() => "[ConnectionEntity] {${super.toString()}}";
}
