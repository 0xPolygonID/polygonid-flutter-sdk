import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class BabyjubjubLib extends PolygonIdCore {
  BabyjubjubLib();

  String compressPoint(String pointX, String pointY) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "public_key_x_int": pointX,
        "public_key_y_int": pointY,
      }),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNBabyJubJubPublicCompress,
      methodName: 'PLGNBabyJubJubPublicCompress',
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json["public_key"] as String;
      },
    );
  }

  List<String> uncompressPoint(String compressedPoint) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "public_key": compressedPoint,
      }),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNBabyJubJubPublicUncompress,
      methodName: 'PLGNBabyJubJubPublicUncompress',
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return [
          json["public_key_x_int"] as String,
          json["public_key_y_int"] as String,
        ];
      },
    );
  }

  String signPoseidon(String privateKey, String msg) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "private_key": privateKey,
        "msg_int": msg,
      }),
      function: PolygonIdCore.nativePolygonIdCoreLib.PLGNBabyJubJubSignPoseidon,
      methodName: 'PLGNBabyJubJubSignPoseidon',
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json["signature"];
      },
    );
  }

  bool verifyPoseidon(
    String publicKey,
    String compressedSignature,
    String msg,
  ) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "public_key": publicKey,
        "signature": compressedSignature,
        "msg_int": msg,
      }),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNBabyJubJubVerifyPoseidon,
      methodName: 'PLGNBabyJubJubVerifyPoseidon',
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json["valid"] as bool;
      },
    );
  }

  String prv2pub(String privateKey) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "private_key": privateKey,
      }),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNBabyJubJubPrivate2Public,
      methodName: 'PLGNBabyJubJubPrivate2Public',
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json["public_key"] as String;
      },
    );
  }
}
