import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/basic_display_type.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/unknown_display_type.dart';

abstract class DisplayType {
  const DisplayType();

  String get typeName;

  factory DisplayType.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case Iden3BasicDisplayType.name:
        return Iden3BasicDisplayType.fromJson(json);
      default:
        return UnknownDisplayType.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}
