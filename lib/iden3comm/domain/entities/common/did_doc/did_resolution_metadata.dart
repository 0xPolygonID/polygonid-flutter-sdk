import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'did_resolution_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class DIDResolutionMetadata with EquatableMixin {
  final String? contentType;
  final String? error;

  DIDResolutionMetadata({this.contentType, this.error});

  factory DIDResolutionMetadata.fromJson(Map<String, dynamic> json) =>
      _$DIDResolutionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$DIDResolutionMetadataToJson(this);

  @override
  List<Object?> get props => [contentType, error];
}
