import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:privadoid_sdk/model/credential_credential.dart';
import 'package:privadoid_sdk/model/revocation_status.dart';
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
  final lib = Platform.isAndroid
      ? ffi.DynamicLibrary.open("libiden3core.so")
      : ffi.DynamicLibrary.process();

  Iden3CoreLib();

  /*int getFieldSlotIndex() {
    //var key = "birthday";
    //var key = "documentType";
    var key = "countryCode";
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

    print("slotIndex:");
    print(slotInP.value);
    print("Error message: ${status.ref.error_msg.toString()}");
    return status.ref.status;
  }*/

  int getFieldSlotIndex(String schema, String claimType, String key) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    //schema =
    //    "{\"@context\": [{\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"KYCAgeCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCAgeCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"birthday\": {\"@id\": \"kyc-vocab:birthday\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}, \"KYCCountryOfResidenceCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCCountryOfResidenceCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"countryCode\": {\"@id\": \"kyc-vocab:countryCode\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}}]}";
    //claimType = "KYCAgeCredential";
    // var key = "birthday";
    //key = "documentType";
    var slotIn = 0;
    ffi.Pointer<ffi.Int32> slotI =
        slotIn.toString().toNativeUtf8().cast<ffi.Int32>();
    ffi.Pointer<ffi.Int8> keyP = key.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> claimTypeP =
        claimType.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();
    // let schemaP : UnsafeMutablePointer<CChar>  = UnsafeMutablePointer<CChar>(mutating: schema);
    // let claimTypeP : UnsafeMutablePointer<CChar>  = UnsafeMutablePointer<CChar>(mutating: claimType);
    // let keyP : UnsafeMutablePointer<CChar>  = UnsafeMutablePointer<CChar>(mutating: key);

    // var status = nativeLib.IDENJsonLDGetFieldSlotIndex(&slotIndex, key, claimType, schema);
    int result = 0;
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDGetFieldSlotIndex(slotI, keyP, claimTypeP, schemaP);
    consumeStatus(status, "IDENJsonLDGetFieldSlotIndex error");
    print("slotIndex:");
    print(slotI.value);
    result = slotI.value;
    nativeLib.free(slotI.cast());
    nativeLib.free(keyP.cast());
    nativeLib.free(claimTypeP.cast());
    nativeLib.free(schemaP.cast());
    return result;
  }

  ffi.Pointer<IDENClaim>? parseClaim(String jsonLDDocument, String schema) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<ffi.Int8> jsonLDDocumentP =
        jsonLDDocument.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();

    ffi.Pointer<ffi.Pointer<IDENClaim>> claimI =
        malloc<ffi.Pointer<IDENClaim>>();

    //BigInt.parse('9401485880430551000');

    //BigInt.from(2034832188220019200);
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDParseClaim(claimI, jsonLDDocumentP, schemaP);
    consumeStatus(status, "");
    print("idenClaim status: ${claimI.value.ref.status}");
    if (claimI.value.ref.status == 0) {
      return claimI[0];
    } else {
      return null;
    }
  }

  int claimTreeEntryHash() {
    return 0;
  }

  String prepareAuthInputs(
    String challenge,
    String pubX,
    String pubY,
    String signature,
  ) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENAuthInputs> request = malloc<IDENAuthInputs>();
    request.ref.challenge = int.parse(challenge); //1;
    ffi.Pointer<IDENCircuitClaim> authClaim = malloc<IDENCircuitClaim>();
    authClaim.ref.current_timestamp = 1642074362;
    request.ref.auth_claim = authClaim.ref;

    int revNonce = 0; //13260572831089785859.0;
    //BigInt.parse("15930428023331155902"); // 13260572831089785859
    /*String pubX =
        "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    String pubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";*/
    ffi.Pointer<IDENClaim> coreClaim = makeAuthClaim(pubY, pubX, revNonce);
    request.ref.auth_claim.core_claim = coreClaim;
    //nativeLib.IDENFreeClaim(coreClaim);

    ffi.Pointer<IDENmerkleTree> claimsTree = createCorrectMT()!;
    if (claimsTree == ffi.nullptr ||
        claimsTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (claimsTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = claimsTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("Claims Tree Error : ${claimsTree.ref.status}");
      }
    }
    //ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    ffi.Pointer<IDENTreeEntry> claimTreeEntry =
        nativeLib.IDENClaimTreeEntry(request.ref.auth_claim.core_claim);
    if (claimTreeEntry == ffi.nullptr ||
        claimTreeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        if (claimTreeEntry.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = claimTreeEntry.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${claimTreeEntry.ref.status}");
      }
    }
    ffi.Pointer<IDENstatus> status1 =
        nativeLib.IDENmerkleTreeAddClaim(claimsTree, claimTreeEntry);
    consumeStatus(status1, "merkle tree add claim");

    //nativeLib.IDENFreeTreeEntry(claimTreeEntry);

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    consumeStatus(status1, "claim tree entry hash");

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, claimsTree, userAuthClaimIndexHash.ref);
    consumeStatus(status1, "merkle tree generate proof");
    request.ref.auth_claim.proof = proof[0];

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENTreeRoot(claimsTreeRoot, claimsTree);
    consumeStatus(status1, "IdenTreeRoot");

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, claimsTreeRoot.ref);
    consumeStatus(status1, "calculate genesis ID");
    request.ref.id = idP.ref;

    ffi.Pointer<IDENmerkleTree> revTree = createCorrectMT()!;
    if (revTree == ffi.nullptr ||
        revTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (revTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = revTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${revTree.ref.status}");
      }
    }

    ffi.Pointer<IDENmerkleTree> rorTree = createCorrectMT()!;
    if (rorTree == ffi.nullptr ||
        rorTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (rorTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = rorTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${rorTree.ref.status}");
      }
    }

    request.ref.auth_claim.tree_state =
        makeTreeState(claimsTree, revTree, rorTree);

    /*nativeLib.IDENFreeMerkleTree(claimsTree);
    nativeLib.IDENFreeMerkleTree(revTree);
    nativeLib.IDENFreeMerkleTree(rorTree);*/

    request.ref.state = request.ref.auth_claim.tree_state;

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    nativeLib.IDENHashFromUInt64(revNonceHash, revNonce.toInt());

    ffi.Pointer<ffi.Pointer<IDENProof>> proofP =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proofP, claimsTree, revNonceHash.ref);
    consumeStatus(status1, "generate proof");
    request.ref.auth_claim.proof = proofP[0];

    //nativeLib.IDENFreeProof(proofP[0]);
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAuthInputs(request);
    ffi.Pointer<ffi.Int8> json = response.ref.json_string;
    ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
    String result = jsonString.toDartString();

    nativeLib.IDENFreeJsonResponse(response);
    return result;
  }

  String prepareAtomicQueryInputs(
      String challenge,
      String pubX,
      String pubY,
      String signature,
      CredentialCredential credential,
      String jsonLDDocument,
      String schema,
      String claimType,
      String key,
      int value,
      int operator,
      RevocationStatus revocationStatus) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENAtomicQueryInputs> request =
        malloc<IDENAtomicQueryInputs>();

    ffi.Pointer<IDENmerkleTree> emptyTree = createCorrectMT()!;
    if (emptyTree == ffi.nullptr ||
        emptyTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (emptyTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = emptyTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${emptyTree.ref.status}");
      }
    }

    // QUERY - ALL GOOD
    ffi.Pointer<IDENQuery> query = malloc<IDENQuery>();
    query.ref.slot_index = getFieldSlotIndex(schema, claimType, key);
    ffi.Pointer<ffi.Int8> unsafePointerValue =
        value.toString().toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> valuePtr =
        nativeLib.IDENBigIntFromString(unsafePointerValue);
    query.ref.value = valuePtr;
    query.ref.operator1 = operator;
    request.ref.query = query.ref;

    // AUTH CLAIM - ALL GOOD
    ffi.Pointer<IDENCircuitClaim> authClaim = malloc<IDENCircuitClaim>();
    authClaim.ref.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000; //1642074362;
    request.ref.auth_claim = authClaim.ref;

    ffi.Pointer<IDENmerkleTree> userAuthClaimsTree = createCorrectMT()!;
    if (userAuthClaimsTree == ffi.nullptr ||
        userAuthClaimsTree.ref.status !=
            IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (userAuthClaimsTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = userAuthClaimsTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${userAuthClaimsTree.ref.status}");
      }
    }

    // max int = "9223372036854775807"
    int revNonce = 0; //BigInt.parse("15930428023331155902").toInt();
    print("revNonce: " + revNonce.toString());
    ffi.Pointer<IDENClaim> coreClaim = makeAuthClaim(pubX, pubY, revNonce);
    request.ref.auth_claim.core_claim = coreClaim;

    ///
    ffi.Pointer<IDENmerkleTree> authClaimsTree = createCorrectMT()!;
    if (authClaimsTree == ffi.nullptr ||
        authClaimsTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (authClaimsTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = authClaimsTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("Claims Tree Error : ${authClaimsTree.ref.status}");
      }
    }
    ffi.Pointer<IDENTreeEntry> authClaimTreeEntry =
        nativeLib.IDENClaimTreeEntry(request.ref.auth_claim.core_claim);
    if (authClaimTreeEntry == ffi.nullptr ||
        authClaimTreeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        if (authClaimTreeEntry.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = authClaimTreeEntry.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${authClaimTreeEntry.ref.status}");
      }
    }
    ffi.Pointer<IDENstatus> status1 =
        nativeLib.IDENmerkleTreeAddClaim(authClaimsTree, authClaimTreeEntry);
    consumeStatus(status1, "merkle tree add claim");

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    consumeStatus(status1, "claim tree entry hash");

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, authClaimsTree, userAuthClaimIndexHash.ref);
    consumeStatus(status1, "merkle tree generate proof");
    print("proof existence: " + proof[0].ref.existence.toString());
    request.ref.auth_claim.proof = proof[0];

    ffi.Pointer<IDENMerkleTreeHash> authClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENTreeRoot(authClaimsTreeRoot, authClaimsTree);
    consumeStatus(status1, "IdenTreeRoot");

    request.ref.auth_claim.tree_state =
        makeTreeState(authClaimsTree, emptyTree, emptyTree);
    request.ref.current_tree_state = request.ref.auth_claim.tree_state;
    //request.ref.auth_claim = authClaim.ref;

    // ID - ALL GOOD
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, authClaimsTreeRoot.ref);
    consumeStatus(status1, "calculate genesis id");
    request.ref.id = idP.ref;

    // CHALLENGE - ALL GOOD
    request.ref.challenge = int.parse(challenge);

    // SIGNATURE OF THE CHALLENGE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // REVOCATION STATUS - ALL GOOD?
    ///

    ///
    int siblingsNum = revocationStatus.mtp!.siblings!.length;
    ffi.Pointer<IDENProof> revProof = malloc<IDENProof>();
    revProof.ref.siblings_num = siblingsNum;
    if (siblingsNum > 0) {
      ffi.Pointer<ffi.Pointer<ffi.Uint8>> siblings =
          malloc<ffi.Pointer<ffi.Uint8>>(siblingsNum);
      for (int j = 0; j < siblingsNum; j++) {
        ffi.Pointer<ffi.Uint8> sib = malloc<ffi.Uint8>();
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            revocationStatus.mtp!.siblings![j].toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            nativeLib.IDENBigIntFromString(unsafePointerSibling);
        sib = sibling.ref.data;
        siblings[j] = sib;
      }
      revProof.ref.siblings = siblings;
    } else {
      revProof.ref.siblings = ffi.nullptr;
    }
    revProof.ref.existence = revocationStatus.mtp!.existence == false ? 0 : 1;
    revProof.ref.auxNodeKey = ffi.nullptr;
    revProof.ref.auxNodeValue = ffi.nullptr;
    revProof.ref.status = 0;
    revProof.ref.error_msg = ffi.nullptr;
    request.ref.revocation_status.proof = revProof;

    // Revocation Status State
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();
    request.ref.revocation_status.tree_state = treeState.ref;
    ffi.Pointer<IDENMerkleTreeHash> state = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENMerkleTreeHash> revocationTreeRoot =
    malloc<IDENMerkleTreeHash>();
    for (int x = 0; x < 32; x++) {
      state.ref.data[x] = 0;
      claimsRoot.ref.data[x] = 0;
      revocationTreeRoot.ref.data[x] = 0;
    }
    List<int> stateBytes = hexToBytes(revocationStatus.issuer!.state!);
    for (int i = 0; i < stateBytes.length; i++) {
      state.ref.data[i] = stateBytes[i];
    }
    List<int> claimsRootBytes =
        hexToBytes(revocationStatus.issuer!.claimsTreeRoot!);
    for (int i = 0; i < claimsRootBytes.length; i++) {
      claimsRoot.ref.data[i] =
          claimsRootBytes[i];
    }
    List<int> revocationTreeRootBytes =
        hexToBytes(revocationStatus.issuer!.revocationTreeRoot!);
    for (int i = 0; i < revocationTreeRootBytes.length; i++) {
      revocationTreeRoot.ref.data[i] =
          revocationTreeRootBytes[i];
    }
    request.ref.revocation_status.tree_state.state = state.ref;
    request.ref.revocation_status.tree_state.claims_root = claimsRoot.ref;
    request.ref.revocation_status.tree_state.revocation_root = revocationTreeRoot.ref;
    ///

    // CLAIM
    ffi.Pointer<IDENCircuitClaim> claim = malloc<IDENCircuitClaim>();
    claim.ref.current_timestamp =
        request.ref.auth_claim.current_timestamp; //1642074362;
    // TODO: NEEDED??
    ffi.Pointer<IDENClaim> coreClaimPtr = parseClaim(jsonLDDocument, schema)!;
    claim.ref.core_claim = coreClaimPtr;
    //claim.ref.core_claim = ffi.nullptr;
    request.ref.claim = claim.ref;
    /*request.ref.claim.current_timestamp =
        request.ref.auth_claim.current_timestamp;*/

    ///
    /*ffi.Pointer<IDENmerkleTree> issuerClaimsTree = createCorrectMT()!;
    if (issuerClaimsTree == ffi.nullptr ||
        issuerClaimsTree.ref.status !=
            IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (kDebugMode) {
        if (issuerClaimsTree.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = issuerClaimsTree.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("Claims Tree Error : ${issuerClaimsTree.ref.status}");
      }
    }
    //ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    ffi.Pointer<IDENTreeEntry> claimTreeEntry =
        nativeLib.IDENClaimTreeEntry(request.ref.claim.core_claim);
    if (claimTreeEntry == ffi.nullptr ||
        claimTreeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        if (claimTreeEntry.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = claimTreeEntry.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("ERROR : ${claimTreeEntry.ref.status}");
      }
    }
    status1 =
        nativeLib.IDENmerkleTreeAddClaim(issuerClaimsTree, claimTreeEntry);
    consumeStatus(status1, "merkle tree add claim");

    ffi.Pointer<IDENMerkleTreeHash> claimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        claimIndexHash, ffi.nullptr, request.ref.claim.core_claim);
    consumeStatus(status1, "claim tree entry hash");

    ffi.Pointer<ffi.Pointer<IDENProof>> claimProof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        claimProof, issuerClaimsTree, claimIndexHash.ref);
    consumeStatus(status1, "merkle tree generate proof");
    request.ref.claim.proof = claimProof[0];
    request.ref.claim.tree_state =
        makeTreeState(issuerClaimsTree, emptyTree, emptyTree);*/

    ///

    /*List<String> sibl = [
      "247514503935869953996590827671745463146848755216265640561733781908595034333",
      "1489949987702564259617776673941859146614009426491938726018377085464907876268",
      "10988994750042665433834271042690149752335415440803206519477668889946262010711",
      "0",
      "4348256684169072579301860566689083471336299110250228311946170849945238939674",
    ];*/
    //int siblingsNum1 = credential.proof![0].issuer_mtp!.mtp!.siblings!.length;
    int siblingsNum1 = credential.proof![1].mtp!.siblings!.length;
    ffi.Pointer<IDENProof> claimProof = malloc<IDENProof>();
    request.ref.claim.proof = claimProof;
    request.ref.claim.proof.ref.siblings_num = siblingsNum1;

    if (siblingsNum1 > 0) {
      ffi.Pointer<ffi.Pointer<ffi.Uint8>> siblings =
          malloc<ffi.Pointer<ffi.Uint8>>(siblingsNum1);
      request.ref.claim.proof.ref.siblings = siblings;
      for (int i = 0; i < siblingsNum1; i++) {
        //String bigIntString =
        //    credential.proof![0].issuer_mtp!.mtp!.siblings![i];
        String bigIntString = credential.proof![1].mtp!.siblings![i];
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            bigIntString.toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            nativeLib.IDENBigIntFromString(unsafePointerSibling);
        if (sibling.ref.status == 0) {
          ffi.Pointer<ffi.Uint8> sibui = malloc<ffi.Uint8>(32);
          int dataLen =
              32; //sibling.ref.data_len != 0 ? sibling.ref.data_len : 32;
          for (int x = 0; x < 32; x++) {
            sibui[x] = 0;
          }
          int dataLen2 = sibling.ref.data_len;
          for (int j = 0; j < sibling.ref.data_len; j++) {
            sibui[j] = sibling.ref.data[j];
          }
          request.ref.claim.proof.ref.siblings[i] = sibui;
        }
        nativeLib.IDENFreeBigInt(sibling);
      }

      /*String bigIntString1 = sibl[1];
      ffi.Pointer<ffi.Int8> unsafePointerSibling1 =
          bigIntString1.toNativeUtf8().cast<ffi.Int8>();
      ffi.Pointer<IDENBigInt> sibling1 =
          nativeLib.IDENBigIntFromString(unsafePointerSibling1);
      if (sibling1.ref.status == 0) {
        siblings[1] = sibling1.ref.data;
      }

      String bigIntString2 = sibl[2];
      ffi.Pointer<ffi.Int8> unsafePointerSibling2 =
          bigIntString2.toNativeUtf8().cast<ffi.Int8>();
      ffi.Pointer<IDENBigInt> sibling2 =
          nativeLib.IDENBigIntFromString(unsafePointerSibling2);
      if (sibling2.ref.status == 0) {
        siblings[2] = sibling2.ref.data;
      }

      String bigIntString3 = sibl[3];
      ffi.Pointer<ffi.Int8> unsafePointerSibling3 =
          bigIntString3.toNativeUtf8().cast<ffi.Int8>();
      ffi.Pointer<IDENBigInt> sibling3 =
          nativeLib.IDENBigIntFromString(unsafePointerSibling3);
      if (sibling3.ref.status == 0) {
        siblings[3] = sibling3.ref.data;
      }

      // nativeLib.IDENFreeBigInt(sibling3);

      String bigIntString4 = sibl[4];
      ffi.Pointer<ffi.Int8> unsafePointerSibling4 =
          bigIntString4.toNativeUtf8().cast<ffi.Int8>();
      ffi.Pointer<IDENBigInt> sibling4 =
          nativeLib.IDENBigIntFromString(unsafePointerSibling4);
      if (sibling4.ref.status == 0) {
        siblings[4] = sibling4.ref.data;
      }*/
      /*for (int j = 0; j < siblingsNum1; j++) {
        String bigIntString = sibl[j];
        //"1489949987702564259617776673941859146614009426491938726018377085464907876268"; //credential.proof![1].mtp!.siblings![j].padLeft(76, '0');
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            bigIntString.toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            nativeLib.IDENBigIntFromString(unsafePointerSibling);
        if (sibling.ref.status == 0) {
          List<int> siblingList =
              sibling.ref.data.asTypedList(sibling.ref.data_len);
          ffi.Pointer<ffi.Uint8> sib = malloc<ffi.Uint8>(32);
          for (int x = 0; x < 32; x++) {
            if (x < siblingList.length) {
              sib[x] = siblingList[x];
            } else {
              sib[x] = 0;
            }
          }
          /*for (int i = 0; i < siblingList.length; i++) {
            sib[i] = siblingList[i];
          }*/
          //sib = sibling.ref.data;
          siblings[j] = sib;
        } else {
          print("sibling parse bigint error");
        }
      }*/
      request.ref.claim.proof.ref.siblings = siblings;
    } else {
      request.ref.claim.proof.ref.siblings = ffi.nullptr;
    }
    //request.ref.claim.proof.ref.existence =
    //    credential.proof![0].issuer_mtp!.mtp!.existence == false ? 0 : 1;
    request.ref.claim.proof.ref.existence =
        credential.proof![1].mtp!.existence == false ? 0 : 1;
    //List<int> auxNodeKeyBytes =
    //    hexToBytes(credential.proof![0].issuer_mtp!.h_index!);
    List<int> auxNodeKeyBytes = hexToBytes(credential.proof![1].h_index!);
    ffi.Pointer<ffi.Uint8> auxNodeKey =
        malloc<ffi.Uint8>(auxNodeKeyBytes.length);
    for (int i = 0; i < auxNodeKeyBytes.length; i++) {
      auxNodeKey[i] = auxNodeKeyBytes[i];
    }

    //List<int> auxNodeValueBytes =
    //    hexToBytes(credential.proof![0].issuer_mtp!.h_value!);
    List<int> auxNodeValueBytes = hexToBytes(credential.proof![1].h_value!);
    ffi.Pointer<ffi.Uint8> auxNodeValue =
        malloc<ffi.Uint8>(auxNodeValueBytes.length);
    for (int i = 0; i < auxNodeValueBytes.length; i++) {
      auxNodeValue[i] = auxNodeValueBytes[i];
    }
    request.ref.claim.proof.ref.auxNodeKey = auxNodeKey;
    request.ref.claim.proof.ref.auxNodeValue = auxNodeValue;
    request.ref.claim.proof.ref.status = 0;
    request.ref.claim.proof.ref.error_msg = ffi.nullptr;

    ffi.Pointer<IDENTreeState> treeState1 = malloc<IDENTreeState>();
    request.ref.claim.tree_state = treeState1.ref;
    ffi.Pointer<IDENMerkleTreeHash> state1 = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENMerkleTreeHash> claimsRoot1 = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENMerkleTreeHash> revocationTreeRoot1 =
        malloc<IDENMerkleTreeHash>();
    for (int x = 0; x < 32; x++) {
      state1.ref.data[x] = 0;
      claimsRoot1.ref.data[x] = 0;
      revocationTreeRoot1.ref.data[x] = 0;
    }
    //Uint8List stateBytes1 =
    //    hexToBytes(credential.proof![0].issuer_mtp!.state!.value!);
    List<int> stateBytes1 = hexToBytes(credential.proof![1].state!.value!);
    for (int i = 0; i < stateBytes1.length; i++) {
      state1.ref.data[i] = stateBytes1[i];
    }

    //Uint8List claimsRootBytes1 =
    //    hexToBytes(credential.proof![0].issuer_mtp!.state!.claims_tree_root!);
    List<int> claimsRootBytes1 =
        hexToBytes(credential.proof![1].state!.claims_tree_root!);
    for (int i = 0; i < claimsRootBytes1.length; i++) {
      claimsRoot1.ref.data[i] = claimsRootBytes1[i];
    }

    List<int> revocationTreeRootBytes1 =
        hexToBytes(credential.proof![1].state!.revocation_tree_root!);
    for (int i = 0; i < revocationTreeRootBytes1.length; i++) {
      revocationTreeRoot1.ref.data[i] = revocationTreeRootBytes1[i];
    }
    request.ref.claim.tree_state.state = state1.ref;
    request.ref.claim.tree_state.claims_root = claimsRoot1.ref;
    //request.ref.claim.tree_state.revocation_root = revocationTreeRoot1.ref;
    //request.ref.claim.tree_state = treeState1.ref;
    //request.ref.claim.tree_state = request.ref.revocation_status.tree_state;*/

    ///

    // RESULT
    String result = "";
    //    "{\"authClaim\":[\"164867201768971999401702181843803888060\",\"0\",\"10716384162326860677584018346415352487946899665553664605395309902620028412489\",\"14611722070321938719565676041787170977854863598214403049524080129726879411123\",\"0\",\"0\",\"0\",\"0\"],\"authClaimMtp\":[\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\"],\"authClaimNonRevMtp\":[\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\"],\"authClaimNonRevMtpAuxHi\":\"0\",\"authClaimNonRevMtpAuxHv\":\"0\",\"authClaimNonRevMtpNoAux\":\"1\",\"challenge\":\"500308\",\"challengeSignatureR8x\":\"20674031000307120176080131714192048228903021326929579905695600068761421314873\",\"challengeSignatureR8y\":\"5474589209221372589638295040190819244278606156460770309658313598288914373533\",\"challengeSignatureS\":\"532299105944809528299186760183669078210016066019987231910096495141782590568\",\"claim\":[\"3677203805624134172815825715044445108615\",\"383496730998907275823696120576523203355766120163503954455394413078566666240\",\"19870910\",\"1\",\"227737578870278824342995087008\",\"0\",\"0\",\"0\"],\"claimIssuanceClaimsTreeRoot\":\"3869973920328231708198314297686760086660937736232911712461326417880844769736\",\"claimIssuanceIdenState\":\"20025477422449691321451459286928491899946277716633246854571180803520339724462\",\"claimIssuanceMtp\":[\"247514503935869953996590827671745463146848755216265640561733781908595034333\",\"1489949987702564259617776673941859146614009426491938726018377085464907876268\",\"10988994750042665433834271042690149752335415440803206519477668889946262010711\",\"0\",\"4348256684169072579301860566689083471336299110250228311946170849945238939674\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\"],\"claimIssuanceRevTreeRoot\":\"0\",\"claimIssuanceRootsTreeRoot\":\"0\",\"claimNonRevIssuerClaimsTreeRoot\":\"3869973920328231708198314297686760086660937736232911712461326417880844769736\",\"claimNonRevIssuerRevTreeRoot\":\"0\",\"claimNonRevIssuerRootsTreeRoot\":\"0\",\"claimNonRevIssuerState\":\"20025477422449691321451459286928491899946277716633246854571180803520339724462\",\"claimNonRevMtp\":[\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\",\"0\"],\"claimNonRevMtpAuxHi\":\"0\",\"claimNonRevMtpAuxHv\":\"0\",\"claimNonRevMtpNoAux\":\"1\",\"claimSchema\":\"274380136414749538182079640726762994055\",\"hoClaimsTreeRoot\":\"5805884353888396157011520376551853687017326947948362371494696184595479414250\",\"hoIdenState\":\"20052791088731755005951266630711844666345518743219899853778012645317160568957\",\"hoRevTreeRoot\":\"0\",\"hoRootsTreeRoot\":\"0\",\"id\":\"383496730998907275823696120576523203355766120163503954455394413078566666240\",\"operator\":1,\"slotIndex\":2,\"timestamp\":\"1645886935\",\"value\":\"20000101\"}";
    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAtomicQueryInputs(request);
    if (response.ref.status != 0) {
      if (kDebugMode) {
        if (response.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = response.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("idenjsonresponse Error : ${response.ref.status}");
      }
    } else {
      ffi.Pointer<ffi.Int8> json = response.ref.json_string;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }

      //nativeLib.free(jsonString);
    }

    nativeLib.IDENFreeBigInt(request.ref.query.value);
    nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    nativeLib.IDENFreeClaim(request.ref.claim.core_claim);
    nativeLib.IDENFreeMerkleTree(userAuthClaimsTree);
    nativeLib.IDENFreeMerkleTree(authClaimsTree);
    nativeLib.IDENFreeMerkleTree(emptyTree);
    //nativeLib.IDENFreeHash(state1);
    nativeLib.IDENFreeProof(request.ref.claim.proof);
    nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    nativeLib.IDENFreeProof(request.ref.revocation_status.proof);

    /*if (emptyTree != ffi.nullptr) {
      nativeLib.IDENFreeMerkleTree(emptyTree);
    }
    if (authClaim != ffi.nullptr) {
      nativeLib.free(authClaim.cast());
    }
    if (query != ffi.nullptr) {
      nativeLib.free(query.cast());
    }
    if (unsafePointerValue != ffi.nullptr) {
      nativeLib.free(unsafePointerValue.cast());
    }
    if (valuePtr != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(valuePtr);
    }
    if (response != ffi.nullptr) {
      nativeLib.IDENFreeJsonResponse(response);
      response = ffi.nullptr;
      nativeLib.free(response.cast());
    }

    /*if (coreClaimPtr != ffi.nullptr) {
      nativeLib.IDENFreeClaim(coreClaimPtr);
    }*/
    if (coreClaim != ffi.nullptr) {
      nativeLib.IDENFreeClaim(coreClaim);
    }
    /*if (claimsRoot != ffi.nullptr) {
      nativeLib.free(claimsRoot.cast());
    }
    if (treeState != ffi.nullptr) {
      nativeLib.free(treeState.cast());
    }*/
    /*if (revProof != ffi.nullptr) {
      nativeLib.IDENFreeProof(revProof);
    }*/
    /*if (sib != ffi.nullptr) {
      nativeLib.free(sib.cast());
    }*/
    /*if (siblings != ffi.nullptr) {
      nativeLib.free(siblings.cast());
    }*/

    /*if (request.ref.query.value != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(request.ref.query.value);
    }
    nativeLib.IDENFreeClaim(auth_claim);
    nativeLib.IDENFreeClaim(request.ref.claim.core_claim);*/
    //nativeLib.IDENFreeClaim(issuerAuthClaim);
    //nativeLib.IDENFreeMerkleTree(userAuthClaimsTree);
    //nativeLib.IDENFreeMerkleTree(issuerClaimsTree);
    //nativeLib.IDENFreeMerkleTree(issuerRevTree);
    //nativeLib.IDENFreeMerkleTree(emptyTree);
    nativeLib.IDENFreeProof(request.ref.claim.proof);
    nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    nativeLib.IDENFreeProof(request.ref.revocation_status.proof);
    /*if (revProof != ffi.nullptr) {
      nativeLib.IDENFreeProof(revProof);
    }*/

    /*if (userAuthClaimsTree != ffi.nullptr) {
      nativeLib.IDENFreeMerkleTree(userAuthClaimsTree);
      userAuthClaimsTree = ffi.nullptr;
    }*/*/
    print(result.toString());
    return result;
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
    if (idGenesis == ffi.nullptr) {
      print("unable to get genesis id from iden state\n");
      return "ERROR";
    }

    // print("Genesis ID:\n");
    var result = "";
    for (int i = 0; i < 31; i++) {
      result = result + idGenesis[i].toRadixString(16).padLeft(2, '0');
      // print(result);
    }

    if (unsafePointerState != ffi.nullptr) {
      nativeLib.free(unsafePointerState.cast());
      if (kDebugMode) {
        print("idenState successfully freed");
      }
    }

    if (idGenesis != ffi.nullptr) {
      nativeLib.free(idGenesis.cast());
      if (kDebugMode) {
        print("id genesis successfully freed");
      }
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

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;

    ffi.Pointer<IDENTreeEntry> entryRes = nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == ffi.nullptr) {
      print("unable to allocate tree entry\n");
      return ["ERROR"];
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
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
      //print("$i");
      var resultString = "";
      for (int j = 0; j < 32; j++) {
        resultString = resultString +
            entryRes.ref.data[32 * i + j].toRadixString(16).padLeft(2, "0");
      }
      result.add(resultString);
    }

    print("generated Tree Entry IS CORRECT");

    if (entryRes != ffi.nullptr) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }

    /*if (keyX != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfully freed\n");
    }

    if (keyY != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfully freed\n");
    }*/

    if (unsafePointerSchemaHash != ffi.nullptr) {
      nativeLib.free(unsafePointerSchemaHash.cast());
      print("schemaHash successfully freed\n");
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
    if (entryRes == ffi.nullptr) {
      print("unable to allocate tree entry\n");
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      print("unexpected data length\n");
      return "ERROR";
    }
    /*for (int i = 0; i < 8; i++) {
      print("$i");
      for (int j = 0; j < 32; j++) {
        print(entryRes.ref.data[32 * i + j].toRadixString(16).padLeft(2, "0"));
      }
      print("\n");
    }*/

    final mt = createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    final res = addClaimToMT(mt, entryRes);
    if (res == false) {
      return "ERROR";
    }

    final mtRoot = nativeLib.IDENmerkleTreeRoot(mt);
    if (mtRoot == ffi.nullptr) {
      print("unable to get merkle tree root\n");
      return "ERROR";
    }

    //print("Root:");
    var result = "";
    for (int i = 0; i < 32; i++) {
      result = result + mtRoot[i].toRadixString(16).padLeft(2, "0");
    }

    if (mtRoot != ffi.nullptr) {
      nativeLib.free(mtRoot.cast());
      print("tree root successfuly freed\n");
    }

    if (mt != ffi.nullptr) {
      nativeLib.IDENFreeMerkleTree(mt);
      print("merkle tree successfuly freed\n");
    }

    if (entryRes != ffi.nullptr) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }

    /*if (keyX != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfuly freed\n");
    }

    if (keyY != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfuly freed\n");
    }*/

    if (unsafePointerSchemaHash != ffi.nullptr) {
      nativeLib.free(unsafePointerSchemaHash.cast());
      print("schema hash successfully freed\n");
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
    if (entryRes == ffi.nullptr) {
      print("unable to allocate tree entry\n");
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      print("error creating tree entry\n");
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        print("error message: " + errormsg);
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      print("unexpected data length\n");
      return "ERROR";
    }
    /*for (int i = 0; i < 8; i++) {
      print("$i");
      for (int j = 0; j < 32; j++) {
        print(entryRes.ref.data[32 * i + j].toRadixString(16));
      }
      print("\n");
    }*/

    print("generated Tree Entry IS CORRECT");

    final mt = createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    final res = addClaimToMT(mt, entryRes);
    if (res == false) {
      return "ERROR";
    }

    final mtRoot = nativeLib.IDENmerkleTreeRoot(mt);
    if (mtRoot == ffi.nullptr) {
      print("unable to get merkle tree root\n");
      return "ERROR";
    }

    //print("Root:");
    /*for (int i = 0; i < 32; i++) {
      //print(mtRoot[i].toRadixString(16));
    }*/
    //print("\n");

    final idGenesis = nativeLib.IDENidGenesisFromIdenState(mtRoot);
    if (idGenesis == ffi.nullptr) {
      print("unable to get genesis id from iden state\n");
      return "ERROR";
    }

    /*print("Genesis ID:");
    for (int i = 0; i < 31; i++) {
      print(idGenesis[i].toRadixString(16));
    }
    print("\n");*/

    final indexHash = nativeLib.IDENTreeEntryIndexHash(entryRes);
    if (indexHash == ffi.nullptr) {
      print("unable to allocate index hash\n");
      return "ERROR";
    }

    if (indexHash.ref.status != IDENHashStatus.IDENHASHSTATUS_OK) {
      print("cant calc index hash: ${indexHash.ref.status.toString()}");
      if (indexHash.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = indexHash.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        print("error message: " + errormsg);
      }
      return "ERROR";
    }

    final proof = nativeLib.IDENmerkleTreeGenerateProof(mt, indexHash);
    if (proof == ffi.nullptr) {
      print("unable to allocate proof\n");
      return "ERROR";
    }

    if (proof.ref.status != IDENProofStatus.IDENPROOFSTATUS_OK) {
      print("error generate proof: " + (proof.ref.status.toString()));
      if (proof.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = proof.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        print("error message: " + errormsg);
      }
      return "ERROR";
    }

    print("proof existence: ${proof.ref.existence}");
    if (proof.ref.existence == 0) {
      return "ERROR";
    }

    if (proof != ffi.nullptr) {
      nativeLib.IDENFreeProof(proof);
      print("proof successfully freed\n");
    }

    if (indexHash != ffi.nullptr) {
      nativeLib.IDENFreeHash(indexHash);
      print("index hash successfully freed\n");
    }

    if (idGenesis != ffi.nullptr) {
      nativeLib.free(idGenesis.cast());
      print("id genesis successfully freed\n");
    }

    if (mtRoot != ffi.nullptr) {
      nativeLib.free(mtRoot.cast());
      print("tree root successfully freed\n");
    }

    if (mt != ffi.nullptr) {
      nativeLib.IDENFreeMerkleTree(mt);
      print("merkle tree successfully freed\n");
    }

    if (entryRes != ffi.nullptr) {
      nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfully freed\n");
    }

    /*if (keyX != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyX);
      print("keyX successfully freed\n");
    }

    if (keyY != ffi.nullptr) {
      nativeLib.IDENFreeBigInt(keyY);
      print("keyY successfully freed\n");
    }*/

    if (unsafePointerSchemaHash != ffi.nullptr) {
      nativeLib.free(unsafePointerSchemaHash.cast());
      print("schema hash successfully freed\n");
    }

    return "ALL GOOD";
  }

  IDENTreeState makeTreeState(
      ffi.Pointer<IDENmerkleTree> claimsTree,
      ffi.Pointer<IDENmerkleTree> revTree,
      ffi.Pointer<IDENmerkleTree> rorTree) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();

    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENTreeRoot(claimsRoot, claimsTree);
    consumeStatus(status, "claims tree root");
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENTreeRoot(revocationRoot, revTree);
    consumeStatus(status, "revocation root");
    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENTreeRoot(rootOfRoots, rorTree);
    consumeStatus(status, "root of roots");
    treeState.ref.root_of_roots = rootOfRoots.ref;

    ffi.Pointer<ffi.Pointer<IDENMerkleTreeHash>> hashes =
        malloc<ffi.Pointer<IDENMerkleTreeHash>>(3);
    hashes[0] = claimsRoot;
    hashes[1] = revocationRoot;
    hashes[2] = rootOfRoots;

    ffi.Pointer<IDENMerkleTreeHash> dst = malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENHashOfHashes(dst, hashes, 3);
    consumeStatus(status, "hash of Hashes");

    treeState.ref.state = dst.ref;

    return treeState.ref;
  }

  ffi.Pointer<IDENClaim> makeAuthClaim(String pubX, String pubY, int revNonce) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    revNonce = 0;

    //ffi.Pointer<IDENstatus> status = malloc<IDENstatus>();

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
        malloc<ffi.Uint8>(schemaHash.length /*+ 1*/);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length /*+ 1*/);
    pointerList.setAll(0, schemaHash);
    //pointerList[schemaHash.length] = 0;

    ffi.Pointer<IDENClaim> claim2 =
        nativeLib.IDENNewClaim(unsafePointerSchemaHash);

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        nativeLib.IDENBigIntFromString(unsafePointerY);

    nativeLib.IDENClaimSetIndexDataInt(claim2, keyX, keyY);

    //double revNonce2 = 15930428023331155902.0;
    nativeLib.IDENClaimSetRevocationNonce(claim2, revNonce);

    if (claim2.ref.status != IDENClaimStatus.IDENCLAIMSTATUS_OK) {
      print("claim error");
      //return IDENstatusCode.IDENSTATUSCODE_CLAIM_ERROR;
    } else {
      print("claim all good");
      //return IDENstatusCode.IDENSTATUSCODE_OK;
    }
    return claim2;
  }

  ffi.Pointer<IDENClaim> makeUserClaim(String idHex, int revNonce) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    final schemaHash = [
      0xce,
      0x6b,
      0xb1,
      0x2c,
      0x96,
      0xbf,
      0xd1,
      0x54,
      0x4c,
      0x02,
      0xc2,
      0x89,
      0xc6,
      0xb4,
      0xb9,
      0x87
    ];

    final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        malloc<ffi.Uint8>(schemaHash.length /*+ 1*/);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length /*+ 1*/);
    pointerList.setAll(0, schemaHash);
    //pointerList[schemaHash.length] = 0;

    ffi.Pointer<IDENClaim> claim =
        nativeLib.IDENNewClaim(unsafePointerSchemaHash);

    List<int> r = hexToBytes(idHex);
    ffi.Pointer<IDENId> id = malloc<IDENId>();
    for (var i = 0; i < r.length; i++) {
      id.ref.data[i] = r[i];
    }
    nativeLib.IDENClaimSetIndexID(claim, id.ref);

    ffi.Pointer<ffi.Int8> unsafePointerSlotA =
        "10".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> slotA =
        nativeLib.IDENBigIntFromString(unsafePointerSlotA);

    ffi.Pointer<ffi.Int8> unsafePointerslotB =
        "0".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> slotB =
        nativeLib.IDENBigIntFromString(unsafePointerslotB);

    nativeLib.IDENClaimSetIndexDataInt(claim, slotA, slotB);

    nativeLib.IDENFreeBigInt(slotA);
    nativeLib.IDENFreeBigInt(slotB);

    nativeLib.IDENClaimSetRevocationNonce(claim, revNonce);

    nativeLib.IDENClaimSetExpirationDate(claim, 1669884010);

    return claim;
  }

  ffi.Pointer<IDENmerkleTree>? createCorrectMT() {
    NativeLibrary nativeLib = NativeLibrary(lib);

    var mt = nativeLib.IDENnewMerkleTree(40);

    if (mt == ffi.nullptr) {
      print("unable to allocate merkle tree\n");
      return null;
    }

    if (mt.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (mt.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = mt.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("error creating merkle tree, code: ${mt.ref.status.toString()}");
      nativeLib.IDENFreeMerkleTree(mt);
      return null;
    }

    print("merkle tree successfully created\n");
    return mt;
  }

  /*ffi.Pointer<IDENJsonResponse>? authPrepareInputs(String pubX, String pubY) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    //final claimsTree = createCorrectMT();
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
  }*/

  bool consumeStatus(ffi.Pointer<IDENstatus> status, String msg) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    if (status == ffi.nullptr) {
      print("unable to allocate status\n");
      return false;
    }
    bool result = true;

    if (status.ref.status != IDENstatusCode.IDENSTATUSCODE_OK) {
      result = false;
      if (msg.isEmpty) {
        msg = "status is not OK";
      }
      if (status.ref.error_msg == ffi.nullptr) {
        print("$msg: ${status.ref.status.toString()}");
      } else {
        ffi.Pointer<ffi.Int8> json = status.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        print("$msg: ${status.ref.status.toString()}. Error: $errormsg");
      }
    }
    nativeLib.IDENFreeStatus(status);
    return result;
  }

  void addClaimToTree(
      ffi.Pointer<IDENmerkleTree> tree, ffi.Pointer<IDENClaim> claim) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENTreeEntry> treeEntry = nativeLib.IDENClaimTreeEntry(claim);
    if (treeEntry == ffi.nullptr ||
        treeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (treeEntry.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = treeEntry.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${treeEntry.ref.status}");
    }

    ffi.Pointer<IDENstatus> status1 =
        nativeLib.IDENmerkleTreeAddClaim(tree, treeEntry);
    consumeStatus(status1, "unable to add claim to tree");
    nativeLib.IDENFreeTreeEntry(treeEntry);
  }

  bool addClaimToMT(
      ffi.Pointer<IDENmerkleTree> mt, ffi.Pointer<IDENTreeEntry> entryRes) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENstatus> addStatus =
        nativeLib.IDENmerkleTreeAddClaim(mt, entryRes);
    return consumeStatus(addStatus, "add claim");
  }
}
