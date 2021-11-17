import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef CStringFree = void Function(Pointer<Utf8>);
typedef CStringFreeFFI = Void Function(Pointer<Utf8>);

class CircomLib {
  final DynamicLibrary lib = Platform.isAndroid
      ? DynamicLibrary.open("libbabyjubjub.so")
      : DynamicLibrary.process();

  late CStringFree cstringFree;

  CircomLib() {
    _packSignature = lib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "pack_signature")
        .asFunction();

    _unpackSignature = lib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "unpack_signature")
        .asFunction();

    _packPoint = lib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(
                    Pointer<Utf8>, Pointer<Utf8>)>>("pack_point")
        .asFunction();

    _unpackPoint = lib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "unpack_point")
        .asFunction();

    _prv2Pub = lib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "prv2pub")
        .asFunction();

    _hashPoseidon = lib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(
                    Pointer<Utf8>,
                    Pointer<Utf8>,
                    Pointer<Utf8>,
                    Pointer<Utf8>,
                    Pointer<Utf8>,
                    Pointer<Utf8>)>>("hash_poseidon")
        .asFunction();

    _signPoseidon = lib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(
                    Pointer<Utf8>, Pointer<Utf8>)>>("sign_poseidon")
        .asFunction();

    _verifyPoseidon = lib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Utf8>)>>("verify_poseidon")
        .asFunction();

    cstringFree =
        lib.lookup<NativeFunction<CStringFreeFFI>>("cstring_free").asFunction();
  }

  late Pointer<Utf8> Function(Pointer<Utf8>) _packSignature;
  String packSignature(String signature) {
    //if (lib == null) return "ERROR: The library is not initialized";

    final sig = signature.toNativeUtf8();
    //print("- Calling packSignature with argument: $sig");
    // The actual native call
    final resultPtr = _packSignature(sig);
    //print("- Result pointer:  $resultPtr");

    final result = resultPtr.toDartString();
    //print("- Response string:  $result");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return result;
  }

  late Pointer<Utf8> Function(Pointer<Utf8>) _unpackSignature;
  String unpackSignature(String compressedSignature) {
    //if (lib == null) return "ERROR: The library is not initialized";

    final sigPtr = compressedSignature.toNativeUtf8();
    final resultPtr = _unpackSignature(sigPtr);
    final result = resultPtr.toDartString();
    //print("- Response string:  $result");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return result;
  }

  late Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>) _packPoint;
  String packPoint(String pointX, String pointY) {
    //if (lib == null) return "ERROR: The library is not initialized";

    final ptrX = pointX.toNativeUtf8();
    final ptrY = pointY.toNativeUtf8();
    final resultPtr = _packPoint(ptrX, ptrY);
    final result = resultPtr.toDartString();
    //debugPrint("- Response string:  $result");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return result;
  }

  late Pointer<Utf8> Function(Pointer<Utf8>) _unpackPoint;
  List<String>? unpackPoint(String compressedPoint) {
    final pointPtr = compressedPoint.toNativeUtf8();
    final resultPtr = _unpackPoint(pointPtr);
    final result = resultPtr.toDartString();
    //print("- Response string:  $result");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return result.split(",");
  }

  // circomlib.poseidon -> hashPoseidon
  late Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>,
      Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>) _hashPoseidon;
  String hashPoseidon(
      String txCompressedData,
      String toEthAddr,
      String? toBjjAy,
      String? rqTxCompressedDatav2,
      String? rqToEthAddr,
      String? rqToBjjAy) {
    //if (lib == null) return "ERROR: The library is not initialized";
    final ptr1 = txCompressedData.toNativeUtf8();
    final ptr2 = toEthAddr.toNativeUtf8();
    final ptr3 = toBjjAy!.toNativeUtf8();
    final ptr4 = rqTxCompressedDatav2!.toNativeUtf8();
    final ptr5 = rqToEthAddr!.toNativeUtf8();
    final ptr6 = rqToBjjAy!.toNativeUtf8();
    try {
      final resultPtr = _hashPoseidon(ptr1, ptr2, ptr3, ptr4, ptr5, ptr6);
      String resultString = resultPtr.toDartString();
      resultString = resultString.replaceAll("Fr(", "");
      resultString = resultString.replaceAll(")", "");
      //print("- Response string:  $resultString");
      // Free the string pointer, as we already have
      // an owned String to return
      //print("- Freeing the native char*");
      cstringFree(resultPtr);
      return resultString;
    } catch(e) {
      return "";
    }
  }

  // privKey.signPoseidon -> signPoseidon
  late Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>) _signPoseidon;
  String signPoseidon(String privateKey, String msg) {
    //if (lib == null) return "ERROR: The library is not initialized";
    final prvKeyPtr = privateKey.toNativeUtf8();
    final msgPtr = msg.toNativeUtf8();
    final resultPtr = _signPoseidon(prvKeyPtr, msgPtr);
    final String compressedSignature = resultPtr.toDartString();
    //print("- Response string:  $compressedSignature");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return compressedSignature;
  }

  // privKey.verifyPoseidon -> verifyPoseidon
  late Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)
      _verifyPoseidon;
  bool verifyPoseidon(
      String publicKey, String compressedSignature, String msg) {
    final pubKeyPtr = publicKey.toNativeUtf8();
    final sigPtr = compressedSignature.toNativeUtf8();
    final msgPtr = msg.toNativeUtf8();
    final resultPtr = _verifyPoseidon(pubKeyPtr, sigPtr, msgPtr);
    final String resultString = resultPtr.toDartString();
    final bool result = resultString.compareTo("1") == 0;
    return result;
  }

  late Pointer<Utf8> Function(Pointer<Utf8>) _prv2Pub;
  String prv2pub(String privateKey) {
    final prvKeyPtr = privateKey.toNativeUtf8();
    final resultPtr = _prv2Pub(prvKeyPtr);
    final String resultString = resultPtr.toDartString();
    //print("- Response string:  $resultString");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
    return resultString;
  }
}
