import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';

typedef CStringFree = void Function(Pointer<Utf8>);
typedef CStringFreeFFI = Void Function(Pointer<Utf8>);

@injectable
class BabyjubjubLib {
  final DynamicLibrary _nativeBabyjubjubLib = Platform.isAndroid
      ? DynamicLibrary.open("libbabyjubjub.so")
      : DynamicLibrary.process();

  late CStringFree cstringFree;

  BabyjubjubLib() {
    _packSignature = _nativeBabyjubjubLib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "pack_signature")
        .asFunction();

    _unpackSignature = _nativeBabyjubjubLib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "unpack_signature")
        .asFunction();

    _packPoint = _nativeBabyjubjubLib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(
                    Pointer<Utf8>, Pointer<Utf8>)>>("pack_point")
        .asFunction();

    _unpackPoint = _nativeBabyjubjubLib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "unpack_point")
        .asFunction();

    _prv2Pub = _nativeBabyjubjubLib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            "prv2pub")
        .asFunction();

    _signPoseidon = _nativeBabyjubjubLib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(
                    Pointer<Utf8>, Pointer<Utf8>)>>("sign_poseidon")
        .asFunction();

    _verifyPoseidon = _nativeBabyjubjubLib
        .lookup<
            NativeFunction<
                Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>,
                    Pointer<Utf8>)>>("verify_poseidon")
        .asFunction();

    cstringFree = _nativeBabyjubjubLib
        .lookup<NativeFunction<CStringFreeFFI>>("cstring_free")
        .asFunction();
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
      String privateKey, String compressedSignature, String msg) {
    final privateKeyPtr = privateKey.toNativeUtf8();
    final sigPtr = compressedSignature.toNativeUtf8();
    final msgPtr = msg.toNativeUtf8();
    final resultPtr = _verifyPoseidon(privateKeyPtr, sigPtr, msgPtr);
    final String resultString = resultPtr.toDartString();
    //print("- Response string:  $resultString");
    // Free the string pointer, as we already have
    // an owned String to return
    //print("- Freeing the native char*");
    cstringFree(resultPtr);
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
