import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';

abstract class Mapper<From, To>
    implements FromMapper<From, To>, ToMapper<From, To> {}
