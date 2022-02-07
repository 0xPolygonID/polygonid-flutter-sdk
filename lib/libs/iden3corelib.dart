import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:web3dart/crypto.dart';

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

  Iden3CoreLib();

// String jsonLDDocument, String schema

// .auth_claim = { .current_timestamp = 1642074362 },
// 	.challenge = 1,
// 	.claim = { .current_timestamp = 1642074362 },
// 	.query = { .slot_index = 2, .value = NULL, .operator = 0 }
  void test() {
    /*NativeLibrary nativeLib = NativeLibrary(lib);
    final createStructFn =
    lib.lookupFunction<CreateStruct, CreateStruct>('CreateStruct');

    IDENAtomicQueryInputs result = createStructFn();
    result.challenge = 1;
    result.auth_claim.current_timestamp = 1642074362;
    result.claim.current_timestamp = 1642074362;
    result.query.slot_index = 2;
    result.query.operator1 = 0;
    ffi.Pointer<IDENJsonResponse> response = nativeLib.IDENPrepareAtomicQueryInputs(result as ffi.Pointer<IDENAtomicQueryInputs>);
    print(response);*/
  }

  int getFieldSlotIndex() {
    NativeLibrary nativeLib = NativeLibrary(lib);

    // var key = "birthday";
    var key = "documentType";
    List<int> keyBytes = utf8.encode(key);
    final ffi.Pointer<ffi.Int8> keyP = malloc<ffi.Int8>(keyBytes.length);
    final Int8List keyPointerList = keyP.asTypedList(keyBytes.length);
    keyPointerList.setAll(0, keyBytes);

    var claimType = "KYCAgeCredential";
    List<int> claimTypeBytes = utf8.encode(claimType);
    final ffi.Pointer<ffi.Int8> claimTypeP =
        malloc<ffi.Int8>(claimTypeBytes.length);
    final Int8List claimTypePointerList =
        claimTypeP.asTypedList(claimTypeBytes.length);
    claimTypePointerList.setAll(0, claimTypeBytes);

    var schema =
        "{\"@context\": [{\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"KYCAgeCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCAgeCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"birthday\": {\"@id\": \"kyc-vocab:birthday\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}, \"KYCCountryOfResidenceCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCCountryOfResidenceCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"countryCode\": {\"@id\": \"kyc-vocab:countryCode\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}}]}";
    List<int> schemaBytes = utf8.encode(schema);
    final ffi.Pointer<ffi.Int8> schemaP = malloc<ffi.Int8>(schemaBytes.length);
    final Int8List schemaPointerList = schemaP.asTypedList(schemaBytes.length);
    schemaPointerList.setAll(0, schemaBytes);

    List<int> slotInBytes = [0];
    final ffi.Pointer<ffi.Int32> slotInP =
        malloc<ffi.Int32>(slotInBytes.length);
    final Int32List slotInPointerList = slotInP.asTypedList(slotInBytes.length);
    slotInPointerList.setAll(0, slotInBytes);

    // var status = nativeLib.IDENJsonLDGetFieldSlotIndex(&slotIndex, key, claimType, schema);
    ffi.Pointer<IDENstatus> status = nativeLib.IDENJsonLDGetFieldSlotIndex(
        slotInP, keyP, claimTypeP, schemaP);

    //print("slotIndex:");
    //print(slotInP.value);
    return status.ref.status;
  }

  String getGenesisId(String idenState) {
    print("idenState: " + idenState);
    NativeLibrary nativeLib = NativeLibrary(lib);
    List<int> bytes = hexToBytes(idenState);
    List<int> reversedBytes = bytes.reversed.toList();
    final ffi.Pointer<ffi.Uint8> unsafePointerState =
        malloc<ffi.Uint8>(reversedBytes.length);
    final Uint8List pointerList =
        unsafePointerState.asTypedList(reversedBytes.length);
    pointerList.setAll(0, reversedBytes);

    String reversed = bytesToHex(reversedBytes, padToEvenLength: true);
    print("idenState reversed: " + reversed);

    final idGenesis = nativeLib.IDENidGenesisFromIdenState(unsafePointerState);
    if (idGenesis == null) {
      print("unable to get genesis id from iden state\n");
      return "ERROR";
    }

    print("Genesis ID:\n");
    var result = "";
    for (int i = 0; i < 31; i++) {
      result = result + idGenesis[i].toRadixString(16).padLeft(2, '0');
      print(result);
    }

    if (idGenesis != null) {
      nativeLib.free(idGenesis.cast());
      print("id genesis successfully freed");
    }

    return result;
  }

  List<String> getAuthClaimTreeEntry(String pubX, String pubY) {
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
        malloc<ffi.Uint8>(schemaHash.length + 1);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length + 1);
    pointerList.setAll(0, schemaHash);
    pointerList[schemaHash.length] = 0;

    /*final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        calloc.allocate<ffi.Uint8>(
            schemaHash.length); // Allocate a pointer large enough.
    final pointerList = unsafePointerSchemaHash.asTypedList(schemaHash
        .length); // Create a list that uses our pointer and copy in the image data.
    pointerList.setAll(0, schemaHash);*/

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;

    ffi.Pointer<IDENTreeEntry> entryRes = nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == null) {
      print("unable to allocate tree entry\n");
      return ["ERROR"];
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != null) {
        final msg = entryRes.ref.error_msg.toString();
        print("error message: " + msg);
      }
      return ["ERROR"];
    }

    if (entryRes.ref.data_len != 8 * 32) {
      print("unexpected data length\n");
      return ["ERROR"];
    }

    List<String> result = [];
    for (int i = 0; i < 8; i++) {
      print("$i");
      var resultString = "";
      for (int j = 0; j < 32; j++) {
        resultString = resultString +
            entryRes.ref.data[32 * i + j].toRadixString(16).padLeft(2, "0");
        //print(entryRes.ref.data[32 * i + j].toRadixString(16));
      }
      result.add(resultString);
      //print("\n");
    }

    print("generated Tree Entry IS CORRECT");

    if (entryRes != null) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }

    if (keyX != null) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfuly freed\n");
    }

    if (keyY != null) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfuly freed\n");
    }

    return result;
  }

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
        malloc<ffi.Uint8>(schemaHash.length + 1);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length + 1);
    pointerList.setAll(0, schemaHash);
    pointerList[schemaHash.length] = 0;

    /*final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        calloc.allocate<ffi.Uint8>(
            schemaHash.length); // Allocate a pointer large enough.
    final pointerList = unsafePointerSchemaHash.asTypedList(schemaHash
        .length); // Create a list that uses our pointer and copy in the image data.
    pointerList.setAll(0, schemaHash);*/

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;
    ffi.Pointer<IDENTreeEntry> entryRes = nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == null) {
      print("unable to allocate tree entry\n");
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != null) {
        final msg = entryRes.ref.error_msg.toString();
        print("error message: " + msg);
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      print("unexpected data length\n");
      return "ERROR";
    }
    for (int i = 0; i < 8; i++) {
      print("$i");
      for (int j = 0; j < 32; j++) {
        print(entryRes.ref.data[32 * i + j].toRadixString(16).padLeft(2, "0"));
      }
      print("\n");
    }

    final mt = createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    final res = addClaimToMT(mt, entryRes);
    if (res != 0) {
      return "ERROR";
    }

    final mtRoot = nativeLib.IDENmerkleTreeRoot(mt);
    if (mtRoot == null) {
      print("unable to get merkle tree root\n");
      return "ERROR";
    }

    print("Root:");
    var result = "";
    for (int i = 0; i < 32; i++) {
      result = result + mtRoot[i].toRadixString(16).padLeft(2, "0");
    }

    if (mtRoot != null) {
      nativeLib.free(mtRoot.cast());
      print("tree root successfuly freed\n");
    }

    if (mt != null) {
      nativeLib.IDENFreeMerkleTree(mt);
      print("merkle tree successfuly freed\n");
    }

    if (entryRes != null) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }

    if (keyX != null) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfuly freed\n");
    }

    if (keyY != null) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfuly freed\n");
    }

    return result;
  }

  String createNewIdentity(String pubX, String pubY) {
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
        malloc<ffi.Uint8>(schemaHash.length + 1);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length + 1);
    pointerList.setAll(0, schemaHash);
    pointerList[schemaHash.length] = 0;

    /*final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        calloc.allocate<ffi.Uint8>(
            schemaHash.length); // Allocate a pointer large enough.
    final pointerList = unsafePointerSchemaHash.asTypedList(schemaHash
        .length); // Create a list that uses our pointer and copy in the image data.
    pointerList.setAll(0, schemaHash);*/

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0; // 13260572831089785859
    ffi.Pointer<IDENTreeEntry> entryRes = nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == null) {
      print("unable to allocate tree entry\n");
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != null) {
        final msg = entryRes.ref.error_msg.toString();
        print("error message: " + msg);
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      print("unexpected data length\n");
      return "ERROR";
    }
    for (int i = 0; i < 8; i++) {
      print("$i");
      for (int j = 0; j < 32; j++) {
        print(entryRes.ref.data[32 * i + j].toRadixString(16));
      }
      print("\n");
    }

    print("generated Tree Entry IS CORRECT");

    final mt = createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    final res = addClaimToMT(mt, entryRes);
    if (res != 0) {
      return "ERROR";
    }

    final mtRoot = nativeLib.IDENmerkleTreeRoot(mt);
    if (mtRoot == null) {
      print("unable to get merkle tree root\n");
      return "ERROR";
    }

    print("Root:");
    for (int i = 0; i < 32; i++) {
      print(mtRoot[i].toRadixString(16));
    }
    print("\n");

    final idGenesis = nativeLib.IDENidGenesisFromIdenState(mtRoot);
    if (idGenesis == null) {
      print("unable to get genesis id from iden state\n");
      return "ERROR";
    }

    print("Genesis ID:");
    for (int i = 0; i < 31; i++) {
      print(idGenesis[i].toRadixString(16));
    }
    print("\n");

    final indexHash = nativeLib.IDENTreeEntryIndexHash(entryRes);
    if (indexHash == null) {
      print("unable to allocate index hash\n");
      return "ERROR";
    }

    if (indexHash.ref.status != IDENHashStatus.IDENHASHSTATUS_OK) {
      print("cant calc index hash: ${indexHash.ref.status.toString()}");
      if (indexHash.ref.error_msg != null) {
        final msg = indexHash.ref.error_msg.toString();
        print("error message: " + msg);
      }
      return "ERROR";
    }

    final proof = nativeLib.IDENmerkleTreeGenerateProof(mt, indexHash);
    if (proof == null) {
      print("unable to allocate proof\n");
      return "ERROR";
    }

    if (proof.ref.status != IDENProofStatus.IDENPROOFSTATUS_OK) {
      print("error generate proof: " + (proof.ref.status.toString()));
      if (proof.ref.error_msg != null) {
        print("error message: " + (proof.ref.error_msg.toString()));
      }
      return "ERROR";
    }

    print("proof existence: ${proof.ref.existence}");
    if (proof.ref.existence == 0) {
      return "ERROR";
    }

    if (proof != null) {
      nativeLib.IDENFreeProof(proof);
      print("proof successfully freed\n");
    }

    if (indexHash != null) {
      nativeLib.IDENFreeHash(indexHash);
      print("index hash successfully freed\n");
    }

    if (idGenesis != null) {
      nativeLib.free(idGenesis.cast());
      print("id genesis successfully freed\n");
    }

    if (mtRoot != null) {
      nativeLib.free(mtRoot.cast());
      print("tree root successfuly freed\n");
    }

    if (mt != null) {
      nativeLib.IDENFreeMerkleTree(mt);
      print("merkle tree successfuly freed\n");
    }

    if (entryRes != null) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }

    if (keyX != null) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfuly freed\n");
    }

    if (keyY != null) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfuly freed\n");
    }

    return "ALL GOOD";
  }

  ffi.Pointer<IDENmerkleTree>? createCorrectMT() {
    NativeLibrary nativeLib = NativeLibrary(lib);

    var mt = nativeLib.IDENnewMerkleTree(40);

    if (mt == null) {
      print("unable to allocate merkle tree\n");
      return null;
    }

    if (mt.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      print("error creating merkle tree, code: ${mt.ref.status.toString()}");
      if (mt.ref.error_msg != null) {
        print("error message: ${mt.ref.error_msg.toString()}");
      }
      nativeLib.IDENFreeMerkleTree(mt);
      return null;
    }

    print("merkle tree successfuly created\n");
    return mt;
  }

  ffi.Pointer<IDENJsonResponse>? authPrepareInputs(String pubX, String pubY) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    final claimsTree = createCorrectMT();
    return null;
    /*if (claimsTree == null) {
      return "ERROR";
    }*/

    /*ffi.Pointer<IDENTreeEntry> claimTreeEntry = nativeLib.IDENClaimTreeEntry(c);

    final res = addClaimToMT(claimsTree, claimTreeEntry);
    if (res != 0) {
      return "ERROR";
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash;
    ffi.Pointer<IDENstatus> status = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, null, request.auth_claim.core_claim);

    status = nativeLib.IDENMerkleTreeGenerateProof(&request.auth_claim.proof,
    claimsTree, userAuthClaimIndexHash);

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot;
    status = nativeLib.IDENTreeRoot(claimsTreeRoot, claimsTree);

    status = nativeLib.IDENCalculateGenesisID(&(request.id), claimsTreeRoot.ref);

    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAuthInputs(request);

    return response;*/
  }

  int addClaimToMT(
      ffi.Pointer<IDENmerkleTree> mt, ffi.Pointer<IDENTreeEntry> entryRes) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENstatus> addStatus =
        nativeLib.IDENmerkleTreeAddClaim(mt, entryRes);

    if (addStatus == null) {
      print("unable to allocate result to add entry to merkle tree");
      return 1;
    }

    if (addStatus.ref.status != IDENstatusCode.IDENSTATUSCODE_OK) {
      print("error add entry to merkle tree, code ${addStatus.ref.status}");
      if (addStatus.ref.error_msg != null) {
        print(", error message: ${addStatus.ref.error_msg}");
      }
      ;
      print("\n");
      nativeLib.IDENFreeStatus(addStatus);
      return 1;
    }

    nativeLib.IDENFreeStatus(addStatus);
    return 0;
  }
}
