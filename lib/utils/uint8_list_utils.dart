import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

class Uint8ArrayUtils {
  static Uint8List fromPointer(Pointer<Uint8> ptr, int length) {
    final view = ptr.asTypedList(length);
    final builder = BytesBuilder(copy: false);
    builder.add(view);
    return builder.takeBytes();
  }

  static Pointer<Uint8> toPointer(Uint8List bytes) {
    final ptr = calloc<Uint8>(bytes.length);
    final byteList = ptr.asTypedList(bytes.length);
    byteList.setAll(0, bytes);
    return ptr.cast();
  }

  static Uint8List uint8ListfromString(String text) {
    List<int> list = text.codeUnits;
    return Uint8List.fromList(list);
  }

  static String uint8ListToString(Uint8List bytes) {
    return String.fromCharCodes(bytes);
  }

  static BigInt leBuff2int(Uint8List buf) {
    BigInt res = BigInt.zero;
    for (int i = 0; i < buf.length; i++) {
      final n = BigInt.from(buf[i]);
      res = res + (n << i * 8);
    }
    return res;
  }

  static BigInt beBuff2int(Uint8List buff) {
    BigInt res = BigInt.zero;
    for (int i = 0; i < buff.length; i++) {
      final n = BigInt.from(buff[buff.length - i - 1]);
      res = res + (n << i * 8);
    }
    return res;
  }

  static Uint8List beInt2Buff(BigInt n, int len) {
    BigInt r = n;
    int o = len - 1;
    final buff = Uint8List(len);
    while ((r > BigInt.zero) && (o >= 0)) {
      final c = (r & BigInt.from(255)).toInt();
      buff[o] = c;
      o--;
      r = r >> 8;
    }
    if (r != BigInt.zero) {
      throw new ArgumentError("Number does not fit in this length");
    }
    return buff;
  }

  static Uint8List leInt2Buff(BigInt n, int len) {
    BigInt r = n;
    int o = 0;

    final buff = Uint8List(len);
    while ((r > BigInt.zero) && (o < buff.length)) {
      final c = (r & BigInt.from(255)).toInt();
      buff[o] = c;
      o++;
      r = r >> 8;
    }
    if (r == BigInt.zero) {
      throw new ArgumentError("Number does not fit in this length");
    }
    return buff;
  }

  static BigInt bytesToBigInt(Uint8List bytes) {
    BigInt read(int start, int end) {
      if (end - start <= 4) {
        int result = 0;
        for (int i = end - 1; i >= start; i--) {
          result = result * 256 + bytes[i];
        }
        return new BigInt.from(result);
      }
      int mid = start + ((end - start) >> 1);
      var result = read(start, mid) +
          read(mid, end) * (BigInt.one << ((mid - start) * 8));
      return result;
    }

    return read(0, bytes.length);
  }

  /// LITTLE ENDIAN!!
  static Uint8List bigIntToBytes(BigInt number) {
    // Not handling negative numbers. Decide how you want to do that.
    int bytes = (number.bitLength + 7) >> 3;
    var b256 = new BigInt.from(256);
    var result = new Uint8List(bytes);
    for (int i = 0; i < bytes; i++) {
      result[i] = number.remainder(b256).toInt();
      number = number >> 8;
    }
    return result;
  }

  static Uint8List hexZeroPad(Uint8List data, int size) {
    //assert(data.length <= size);
    if (data.length >= size) return data;
    return Uint8List(size)..setRange(size - data.length, size, data);
  }
}
