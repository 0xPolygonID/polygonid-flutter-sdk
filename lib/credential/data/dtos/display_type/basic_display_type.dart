import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';

part 'basic_display_type.g.dart';

@JsonSerializable()
class Iden3BasicDisplayType extends DisplayType {
  static const name = "Iden3BasicDisplayMethodV1";

  final String? title;
  final String? description;
  final String? issuerName;
  final String? titleTextColor;
  final String? descriptionTextColor;
  final String? issuerTextColor;
  final String? backgroundImageUrl;
  final String? backgroundColor;
  @JsonKey(toJson: _logoToJson, fromJson: _logoFromJson)
  final Iden3BasicDisplayTypeLogo? logo;

  Iden3BasicDisplayType(
    this.title,
    this.description,
    this.issuerName,
    this.titleTextColor,
    this.descriptionTextColor,
    this.issuerTextColor,
    this.backgroundImageUrl,
    this.backgroundColor,
    this.logo,
  );

  factory Iden3BasicDisplayType.fromJson(Map<String, dynamic> json) =>
      _$Iden3BasicDisplayTypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$Iden3BasicDisplayTypeToJson(this);

  @override
  String get typeName => name;

  @override
  List<Object?> get props => [
        title,
        description,
        issuerName,
        titleTextColor,
        descriptionTextColor,
        issuerTextColor,
        backgroundImageUrl,
        backgroundColor,
        logo,
      ];

  @override
  toString() {
    return 'Iden3BasicDisplayType: {title: $title, description: $description, issuerName: $issuerName, titleTextColor: $titleTextColor, descriptionTextColor: $descriptionTextColor, issuerTextColor: $issuerTextColor, backgroundImageUrl: $backgroundImageUrl, backgroundColor: $backgroundColor, logo: $logo}';
  }
}

@JsonSerializable()
class Iden3BasicDisplayTypeLogo {
  final String? uri;
  final String? alt;

  Iden3BasicDisplayTypeLogo(this.uri, this.alt);

  factory Iden3BasicDisplayTypeLogo.fromJson(Map<String, dynamic> json) =>
      _$Iden3BasicDisplayTypeLogoFromJson(json);

  Map<String, dynamic> toJson() => _$Iden3BasicDisplayTypeLogoToJson(this);

  @override
  List<Object?> get props => [uri, alt];
}

Map<String, dynamic>? _logoToJson(Iden3BasicDisplayTypeLogo? logo) {
  return logo?.toJson();
}

Iden3BasicDisplayTypeLogo? _logoFromJson(Map<String, dynamic>? json) {
  return json == null ? null : Iden3BasicDisplayTypeLogo.fromJson(json);
}
