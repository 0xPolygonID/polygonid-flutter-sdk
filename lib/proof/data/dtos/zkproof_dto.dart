import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'zkproof_dto.g.dart';

/// Represents a zk base proof DTO.
@JsonSerializable(explicitToJson: true)
class ZKProofBaseDTO extends Equatable {
  @JsonKey(name: 'pi_a')
  final List<String> piA;
  @JsonKey(name: 'pi_b')
  final List<List<String>> piB;
  @JsonKey(name: 'pi_c')
  final List<String> piC;
  final String protocol;
  final String curve;

  const ZKProofBaseDTO(
      {required this.piA,
      required this.piB,
      required this.piC,
      required this.protocol,
      required this.curve});

  factory ZKProofBaseDTO.fromJson(Map<String, dynamic> json) =>
      _$ZKProofBaseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ZKProofBaseDTOToJson(this);

  @override
  List<Object?> get props => [piA, piB, piC, protocol, curve];
}

/// Represents a zk proof DTO.
@JsonSerializable(explicitToJson: true)
class ZKProofDTO extends Equatable {
  final ZKProofBaseDTO proof;
  @JsonKey(name: 'pub_signals')
  final List<String> pubSignals;

  const ZKProofDTO({required this.proof, required this.pubSignals});

  factory ZKProofDTO.fromJson(Map<String, dynamic> json) =>
      _$ZKProofDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ZKProofDTOToJson(this);

  @override
  List<Object?> get props => [proof, pubSignals];
}
