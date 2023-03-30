import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connection_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ConnectionDTO extends Equatable {
  final String from;
  final String to;
  final List<dynamic> interactions;

  ConnectionDTO(
      {required this.from, required this.to, required this.interactions});

  factory ConnectionDTO.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionDTOToJson(this);

  @override
  List<Object?> get props => [from, to, interactions];
}
