// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_display_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iden3BasicDisplayType _$Iden3BasicDisplayTypeFromJson(
        Map<String, dynamic> json) =>
    Iden3BasicDisplayType(
      json['title'] as String?,
      json['description'] as String?,
      json['issuerName'] as String?,
      json['titleTextColor'] as String?,
      json['descriptionTextColor'] as String?,
      json['issuerTextColor'] as String?,
      json['backgroundImageUrl'] as String?,
      json['backgroundColor'] as String?,
      _logoFromJson(json['logo'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$Iden3BasicDisplayTypeToJson(
        Iden3BasicDisplayType instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'issuerName': instance.issuerName,
      'titleTextColor': instance.titleTextColor,
      'descriptionTextColor': instance.descriptionTextColor,
      'issuerTextColor': instance.issuerTextColor,
      'backgroundImageUrl': instance.backgroundImageUrl,
      'backgroundColor': instance.backgroundColor,
      'logo': _logoToJson(instance.logo),
    };

Iden3BasicDisplayTypeLogo _$Iden3BasicDisplayTypeLogoFromJson(
        Map<String, dynamic> json) =>
    Iden3BasicDisplayTypeLogo(
      json['uri'] as String?,
      json['alt'] as String?,
    );

Map<String, dynamic> _$Iden3BasicDisplayTypeLogoToJson(
        Iden3BasicDisplayTypeLogo instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'alt': instance.alt,
    };
