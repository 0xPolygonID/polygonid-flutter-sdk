import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:web3dart/web3dart.dart';

class PrivateKeyMapper {
  @override
  Uint8List? mapFrom(String? from) {
    if (from == null) {
      return null;
    }

    final privateKey = strip0x(from);

    if (privateKey.length == 32) {
      /// This is a workaround to support the old version of the SDK which
      /// used String.codeUnits to convert private key to bytes.
      /// IMPORTANT: This is not a correct way to convert a private key to bytes.
      /// It is recommended to remove it once possible.
      var private = from.codeUnits;
      final key = Uint8List(32);
      key.setAll(0, Uint8List.fromList(private));
      key.fillRange(private.length, 32, 0);
      return key;
    }

    if (privateKey.length != 64) {
      throw TooLongPrivateKeyException(
        errorMessage:
            "Private key length is too long, ${from.length} symbols instead of 64 symbols",
      );
    }

    final private = HEX.decode(from);

    return Uint8List.fromList(private);
  }
}
