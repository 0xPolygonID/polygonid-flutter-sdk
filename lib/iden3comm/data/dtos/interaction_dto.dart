import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interaction_dto.g.dart';

enum InteractionTypeDTO {
  auth,
  offer,
}

enum InteractionStateDTO {
  unread,
  read,
}

/// Represents an interaction DTO.
@JsonSerializable()
class InteractionDTO extends Equatable {
  final String from;
  final String to;
  final String timestamp;
  final InteractionTypeDTO type;
  final InteractionStateDTO state;
  final Map<String, dynamic> data;

  const InteractionDTO({
    required this.from,
    required this.to,
    required this.timestamp,
    required this.type,
    required this.state,
    required this.data,
  });

  factory InteractionDTO.fromJson(Map<String, dynamic> json) =>
      _$InteractionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionDTOToJson(this);

  @override
  List<Object?> get props => [from, to, timestamp, type, state, data];
}
