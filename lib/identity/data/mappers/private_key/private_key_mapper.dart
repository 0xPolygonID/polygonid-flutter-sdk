import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';

abstract class PrivateKeyMapper extends FromMapper<String?, Uint8List?> {}
