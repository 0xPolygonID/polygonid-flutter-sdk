import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

class InitializationVectorMapper extends FromMapper<int,IV>{
  @override
  IV mapFrom(int from) {
    return IV.fromLength(from);
  }
}