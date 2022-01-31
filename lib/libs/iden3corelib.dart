import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'generated_bindings.dart';

/*// func IDENauthClaimTreeEntry(schemaHash *C.uchar, keyX, keyY *C.IDENBigInt,
// 	revNonce C.ulonglong) *C.IDENTreeEntry
typedef IDENauthClaimTreeEntry = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

//  func IDENClaimTreeEntryHash(
// 	indexHash *C.IDENMerkleTreeHash, valueHash *C.IDENMerkleTreeHash,
// 	claim *C.IDENClaim) *C.IDENstatus
typedef IDENClaimTreeEntryHash = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENTreeEntryIndexHash(res *C.IDENTreeEntry) *C.IDENHash
typedef IDENTreeEntryIndexHash = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENnewMerkleTree(maxLevels C.int) *C.IDENmerkleTree
typedef IDENnewMerkleTree = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENmerkleTreeRoot(mt *C.IDENmerkleTree) *C.uchar
typedef IDENmerkleTreeRoot = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENMerkleTreeGenerateProof(
// proof **C.IDENProof,
// mt *C.IDENmerkleTree,
// indexHash C.IDENMerkleTreeHash) *C.IDENstatus
typedef IDENMerkleTreeGenerateProof = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENmerkleTreeAddClaim(mt *C.IDENmerkleTree,
// treeEntry *C.IDENTreeEntry) *C.IDENstatus
typedef IDENmerkleTreeAddClaim = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>);

// func IDENTreeRoot(hash *C.IDENMerkleTreeHash,
// mt *C.IDENmerkleTree) *C.IDENstatus
typedef IDENTreeRoot = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);

// func IDENidGenesisFromIdenState(mtHash *C.uchar) *C.uchar
typedef IDENidGenesisFromIdenState = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENBigIntFromString(i *C.char) *C.IDENBigInt
typedef IDENBigIntFromString = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENNewClaim(schemaHash *C.uchar) *C.IDENClaim
typedef IDENNewClaim = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENClaimSetValueDataInt(c *C.IDENClaim, slotA, slotB *C.IDENBigInt)
typedef IDENClaimSetValueDataInt = Void Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENClaimSetIndexDataInt(c *C.IDENClaim, slotA, slotB *C.IDENBigInt)
typedef IDENClaimSetIndexDataInt = Void Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENClaimSetIndexID(c *C.IDENClaim, id C.IDENId)
typedef IDENClaimSetIndexID = Void Function(Pointer<Utf8>, Pointer<Utf8>);

// func IDENClaimSetRevocationNonce(c *C.IDENClaim, revNonce C.ulonglong)
typedef IDENClaimSetRevocationNonce = Void Function(
    Pointer<Utf8>, Pointer<Utf8>);

// func IDENClaimSetExpirationDate(c *C.IDENClaim, t C.time_t)
typedef IDENClaimSetExpirationDate = Void Function(
    Pointer<Utf8>, Pointer<Utf8>);

//func IDENClaimTreeEntry(c *C.IDENClaim) *C.IDENTreeEntry
typedef IDENClaimTreeEntry = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENFreeHash(res *C.IDENHash)
typedef IDENFreeHash = Void Function(Pointer<Utf8>);

// func IDENFreeClaim(claim *C.IDENClaim)
typedef IDENFreeClaim = Void Function(Pointer<Utf8>);

// func IDENFreeProof(proof *C.IDENProof)
typedef IDENFreeProof = Void Function(Pointer<Utf8>);

// func IDENFreeStatus(status *C.IDENstatus)
typedef IDENFreeStatus = Void Function(Pointer<Utf8>);

// func IDENFreeBigInt(bi *C.IDENBigInt)
typedef IDENFreeBigInt = Void Function(Pointer<Utf8>);

// func IDENFreeTreeEntry(res *C.IDENTreeEntry)
typedef IDENFreeTreeEntry = Void Function(Pointer<Utf8>);

// func IDENFreeMerkleTree(mt *C.IDENmerkleTree)
typedef IDENFreeMerkleTree = Void Function(Pointer<Utf8>);

// func IDENPrepareAtomicQueryInputs(
// in *C.IDENAtomicQueryInputs) *C.IDENJsonResponse
typedef IDENPrepareAtomicQueryInputs = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENPrepareAuthInputs(in *C.IDENAuthInputs) *C.IDENJsonResponse
typedef IDENPrepareAuthInputs = Pointer<Utf8> Function(Pointer<Utf8>);

// func IDENFreeJsonResponse(jsonResponse *C.IDENJsonResponse)
typedef IDENFreeJsonResponse = Void Function(Pointer<Utf8>);

// func IDENCalculateGenesisID(id *C.IDENId,
// clr C.IDENMerkleTreeHash) *C.IDENstatus
typedef IDENCalculateGenesisID = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>);

// func IDENHashOfHashes(dst *C.IDENMerkleTreeHash, hashes **C.IDENMerkleTreeHash,
// n C.size_t) *C.IDENstatus
typedef IDENHashOfHashes = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENHashFromUInt64(dst *C.IDENMerkleTreeHash, i C.ulonglong)
typedef IDENHashFromUInt64 = Void Function(Pointer<Utf8>, Pointer<Utf8>);

// func IDENJsonLDParseClaim(claim **C.IDENClaim,
// credential *C.char, schema *C.char) *C.IDENstatus
typedef IDENJsonLDParseClaim = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);

// func IDENJsonLDGetFieldSlotIndex(slotIndex *C.int, field *C.char,
// claimType *C.char, schema *C.char) *C.IDENstatus
typedef IDENJsonLDGetFieldSlotIndex = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);*/

class Iden3CoreLib {
  final ffi.DynamicLibrary lib = Platform.isAndroid
      ? ffi.DynamicLibrary.open("libiden3core.so")
      : ffi.DynamicLibrary.process();

  //late CStringFree cstringFree;

  Iden3CoreLib() {
    /*_packSignature = lib
        .lookup<ffi.NativeFunction<ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>)>>(
            "pack_signature")
        .asFunction();*/

    /*_unpackSignature = lib
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
                Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>,
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
        lib.lookup<NativeFunction<CStringFreeFFI>>("cstring_free").asFunction();*/
  }

  //late Pointer<Utf8> Function(Pointer<Utf8>) _packSignature;

  String getMerkleTreeRoot(String pubX, String pubY) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    final schemaHash = [
      0x7C,
      0x08,
      0x44,
      0xA0,
      0x75,
      0xA9,
      0xDD,
      0xC7,
      0xFC,
      0xBD,
      0xFB,
      0x4F,
      0x88,
      0xAC,
      0xD9,
      0xBC
    ];

    final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        calloc.allocate<ffi.Uint8>(
            schemaHash.length); // Allocate a pointer large enough.
    final pointerList = unsafePointerSchemaHash.asTypedList(schemaHash
        .length); // Create a list that uses our pointer and copy in the image data.
    pointerList.setAll(0, schemaHash);

    ffi.Pointer<ffi.Int8> unsafePointerX;
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY;
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;
    ffi.Pointer<IDENTreeEntry> entryRes = nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == null) {
      print("unable to allocate tree entry\n");
      return "ERROR";
    }

    /*if (entryRes.pointee.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n")
      if (entryRes.pointee.error_msg != nil) {
        let msg = String.init(cString: (entryRes?.pointee.error_msg)!)
        print("error message: " + msg)
      }
      return "ERROR"
    }*/

    /*if (entryRes?.pointee.data_len != 8 * 32) {
      print("unexpected data length\n");
      return "ERROR";
    }*/

    /*for i in 0...7 {
    print("%i:", i)
    for j in 0...31 {
    print(String(format:"%02X", entryRes!.pointee.data[32*i+j]))
    }
    //print("\n")
    }*/

    nativeLib.IDENFreeBigInt(keyX);
    nativeLib.IDENFreeBigInt(keyY);

    return "";
  }

  ffi.Pointer<IDENmerkleTree>? createCorrectMT() {
    NativeLibrary nativeLib = NativeLibrary(lib);

    var mt = nativeLib.IDENnewMerkleTree(40);

    /*if (mt == null) {
      print("unable to allocate merkle tree\n");
      return null;
    }*/

    /*if (mt?.pointee.status != IDENTMERKLETREE_OK) {
  print("error creating merkle tree, code: " + (mt?.pointee.status.rawValue.description)!)
  if (mt?.pointee.error_msg != nil) {
  print("error message: " + (mt?.pointee.error_msg.debugDescription)!)
  }
  IDENFreeMerkleTree(mt)
  return nil
  }*/

    print("merkle tree successfuly created\n");
    return mt;
  }

  /*String packSignature(String signature) {
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
  }*/

  /*late Pointer<Utf8> Function(Pointer<Utf8>) _unpackSignature;
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
  late Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)
      _hashPoseidon;
  String hashPoseidon(
      String claimsTreeRoot, String revocationTree, String rootsTreeRoot) {
    //if (lib == null) return "ERROR: The library is not initialized";
    final ptr1 = claimsTreeRoot.toNativeUtf8();
    final ptr2 = revocationTree.toNativeUtf8();
    final ptr3 = rootsTreeRoot.toNativeUtf8();
    try {
      final resultPtr = _hashPoseidon(ptr1, ptr2, ptr3);
      String resultString = resultPtr.toDartString();
      resultString = resultString.replaceAll("Fr(", "");
      resultString = resultString.replaceAll(")", "");
      //print("- Response string:  $resultString");
      // Free the string pointer, as we already have
      // an owned String to return
      //print("- Freeing the native char*");
      cstringFree(resultPtr);
      return resultString;
    } catch (e) {
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
  }*/
}
