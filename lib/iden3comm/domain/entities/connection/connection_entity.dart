import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/interaction_entity.dart';

class ConnectionEntity extends InteractionEntity {
  ConnectionEntity({
    super.id,
    required super.from,
    required super.to,
  }) : super(type: InteractionType.connection);

  factory ConnectionEntity.fromJson(Map<String, dynamic> json) {
    return ConnectionEntity(
      id: json['id'],
      from: json['from'],
      to: json['to'],
    );
  }

  @override
  String toString() => "[ConnectionEntity] {${super.toString()}}";
}
