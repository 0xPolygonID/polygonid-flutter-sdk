import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/basic_display_type.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';

class DisplayTypeMapper extends Mapper<Map<String, dynamic>?, DisplayType?> {
  @override
  DisplayType? mapFrom(Map<String, dynamic>? from) {
    return from == null ? null : DisplayType.fromJson(from);
  }

  @override
  Map<String, dynamic>? mapTo(DisplayType? to) {
    if (to == null) {
      return null;
    }
    final json = to.toJson();
    json['type'] = to.typeName;
    return json;
  }
}

class DisplayTypeMapperParam {
  final String type;
  final Map<String, dynamic> json;

  DisplayTypeMapperParam(this.type, this.json);
}
