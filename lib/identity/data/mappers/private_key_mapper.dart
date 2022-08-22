import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';

import '../../domain/exceptions/identity_exceptions.dart';

class PrivateKeyMapper extends FromMapper<String?, Uint8List?> {
  @override
  Uint8List? mapFrom(String? from) {
    Uint8List? key;

    if (from != null) {
      var private = from.codeUnits;

      if (private.length > 32) {
        throw TooLongPrivateKeyException();
      }

      key = Uint8List(32);
      key.setAll(0, Uint8List.fromList(private));
      key.fillRange(private.length, 32, 0);
    }

    return key;
  }
}
