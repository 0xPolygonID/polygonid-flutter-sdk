import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';

class UnknownDisplayType extends DisplayType {
  final Map<String, dynamic> displayType;

  @override
  String get typeName => "UnknownDisplayType";

  UnknownDisplayType(this.displayType);

  factory UnknownDisplayType.fromJson(Map<String, dynamic> json) {
    return UnknownDisplayType(json);
  }

  @override
  Map<String, dynamic> toJson() => displayType;
}
