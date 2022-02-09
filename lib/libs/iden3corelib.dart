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

  /*int getFieldSlotIndex() {
    NativeLibrary nativeLib = NativeLibrary(lib);

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
    schema =
        "{\"@context\": [{\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"KYCAgeCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCAgeCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"birthday\": {\"@id\": \"kyc-vocab:birthday\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}, \"KYCCountryOfResidenceCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc.json-ld#KYCCountryOfResidenceCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"kyc-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/kyc.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"countryCode\": {\"@id\": \"kyc-vocab:countryCode\", \"@type\": \"serialization:IndexDataSlotA\"}, \"documentType\": {\"@id\": \"kyc-vocab:documentType\", \"@type\": \"serialization:IndexDataSlotB\"}}}}]}";
    claimType = "KYCAgeCredential";
    // var key = "birthday";
    key = "documentType";
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
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDGetFieldSlotIndex(slotI, keyP, claimTypeP, schemaP);
    print("slotIndex:");
    print(slotI.value);
    print("status:");
    print(status.ref.status);
    return slotI.value;
  }

  IDENClaim? parseClaim(String jsonLDDocument, String schema) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<ffi.Int8> jsonLDDocumentP =
        jsonLDDocument.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();

    ffi.Pointer<ffi.Pointer<IDENClaim>> claimI =
        malloc<ffi.Pointer<IDENClaim>>();

    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDParseClaim(claimI, jsonLDDocumentP, schemaP);
    print("idenClaim status: ${claimI.value.ref.status}");
    if (status.ref.status == 0 && claimI.value.ref.status == 0) {
      return claimI.value.ref;
    } else {
      return null;
    }
  }

  int claimTreeEntryHash() {
    return 0;
  }

  String prepareAuthInputs(String challenge, String pubX, String pubY) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    ffi.Pointer<IDENAuthInputs> in1 = malloc<IDENAuthInputs>();
    in1.ref.challenge = 1; // TODO: put challenge
    ffi.Pointer<IDENCircuitClaim> authClaim = malloc<IDENCircuitClaim>();
    authClaim.ref.current_timestamp = 1642074362;
    in1.ref.auth_claim = authClaim.ref;

    int revNonce = 0; //13260572831089785859;
    //BigInt.parse("15930428023331155902"); // 13260572831089785859
    // TODO: put pubX and pubY
    String pubX =
        "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    String pubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    ffi.Pointer<IDENClaim> coreClaim =
        makeAuthClaim(pubY, pubX, revNonce.toInt());
    in1.ref.auth_claim.core_claim = coreClaim;

    ffi.Pointer<IDENmerkleTree> claimsTree = createCorrectMT()!;
    if (claimsTree == ffi.nullptr ||
        claimsTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (claimsTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = claimsTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${claimsTree.ref.status}");
    }
    //ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    ffi.Pointer<IDENTreeEntry> claimTreeEntry =
        nativeLib.IDENClaimTreeEntry(in1.ref.auth_claim.core_claim);
    if (claimTreeEntry == ffi.nullptr ||
        claimTreeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (claimTreeEntry.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = claimTreeEntry.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${claimTreeEntry.ref.status}");
    }

    ffi.Pointer<IDENstatus> status1 =
        nativeLib.IDENmerkleTreeAddClaim(claimsTree, claimTreeEntry);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, in1.ref.auth_claim.core_claim);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, claimsTree, userAuthClaimIndexHash.ref);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    in1.ref.auth_claim.proof = proof[0];

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENTreeRoot(claimsTreeRoot, claimsTree);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, claimsTreeRoot.ref);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    in1.ref.id = idP.ref;

    ffi.Pointer<IDENmerkleTree> revTree = createCorrectMT()!;
    if (revTree == ffi.nullptr ||
        revTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (revTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = revTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${revTree.ref.status}");
    }

    ffi.Pointer<IDENmerkleTree> rorTree = createCorrectMT()!;
    if (rorTree == ffi.nullptr ||
        rorTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (rorTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = rorTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${rorTree.ref.status}");
    }

    in1.ref.auth_claim.tree_state = makeTreeState(claimsTree, revTree, rorTree);

    in1.ref.state = in1.ref.auth_claim.tree_state;

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    nativeLib.IDENHashFromUInt64(revNonceHash, revNonce.toInt());

    ffi.Pointer<ffi.Pointer<IDENProof>> proofP =
        malloc<ffi.Pointer<IDENProof>>();
    nativeLib.IDENMerkleTreeGenerateProof(proofP, claimsTree, revNonceHash.ref);
    in1.ref.auth_claim.proof = proofP[0];

    // TODO: signature is done in privadoid_sdk with the wallet
    List<int> r = hexToBytes(
        "9d6a88b9a2eb1ce525065301a65f95a21b387cbf1d94fd4aa0be2e7b51532d0cc79b70d659246c05326b46e915a31163869ed11c44d47eb639bc0af381dba004");
    for (var i = 0; i < r.length; i++) {
      in1.ref.signature.data[i] = r[i];
    }

    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAuthInputs(in1);
    ffi.Pointer<ffi.Int8> json = response.ref.json_string;
    ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
    String result = jsonString.toDartString();
    return result;
  }

  String prepareAtomicQueryInputs(String challenge, String pubX, String pubY) {
    NativeLibrary nativeLib = NativeLibrary(lib);

    ffi.Pointer<IDENAtomicQueryInputs> request =
        malloc<IDENAtomicQueryInputs>();
    request.ref.challenge = 1; // TODO: put challenge
    ffi.Pointer<IDENCircuitClaim> authClaim = malloc<IDENCircuitClaim>();
    authClaim.ref.current_timestamp = 1642074362;
    request.ref.auth_claim = authClaim.ref;
    ffi.Pointer<IDENQuery> query = malloc<IDENQuery>();
    query.ref.slot_index = 2;
    query.ref.value = ffi.nullptr;
    query.ref.operator1 = 0;
    request.ref.query = query.ref;

    ffi.Pointer<IDENmerkleTree> userAuthClaimsTree = createCorrectMT()!;
    if (userAuthClaimsTree == ffi.nullptr ||
        userAuthClaimsTree.ref.status !=
            IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (userAuthClaimsTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = userAuthClaimsTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${userAuthClaimsTree.ref.status}");
    }

    //int revNonce = 0; //13260572831089785859;
    //BigInt.parse("15930428023331155902"); // 13260572831089785859
    // TODO: put pubX and pubY
    pubX =
        "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    pubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    ffi.Pointer<IDENClaim> coreClaim = makeAuthClaim(pubX, pubY, 0);
    request.ref.auth_claim.core_claim = coreClaim;

    //Add_Claim_to_Tree
    //ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    ffi.Pointer<IDENTreeEntry> claimTreeEntry =
        nativeLib.IDENClaimTreeEntry(request.ref.auth_claim.core_claim);
    if (claimTreeEntry == ffi.nullptr ||
        claimTreeEntry.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (claimTreeEntry.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = claimTreeEntry.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print(
          "ERROR : ${claimTreeEntry.ref.status}"); // IDENTREEENTRY_EXTRACT_CLAIM_ERROR
    }

    ffi.Pointer<IDENstatus> status1 =
        nativeLib.IDENmerkleTreeAddClaim(userAuthClaimsTree, claimTreeEntry);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    //END: Add_Claim_to_Tree

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 =
        nativeLib.IDENTreeRoot(userAuthClaimsTreeRoot, userAuthClaimsTree);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, userAuthClaimsTreeRoot.ref);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    request.ref.id = idP.ref;

    ffi.Pointer<IDENmerkleTree> emptyTree = createCorrectMT()!;
    if (emptyTree == ffi.nullptr ||
        emptyTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (emptyTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = emptyTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${emptyTree.ref.status}");
    }

    request.ref.auth_claim.tree_state =
        makeTreeState(userAuthClaimsTree, emptyTree, emptyTree);
    request.ref.current_tree_state = request.ref.auth_claim.tree_state;

    // TODO: signature is done in privadoid_sdk with the wallet
    List<int> r = hexToBytes(
        "9d6a88b9a2eb1ce525065301a65f95a21b387cbf1d94fd4aa0be2e7b51532d0cc79b70d659246c05326b46e915a31163869ed11c44d47eb639bc0af381dba004");
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, userAuthClaimsTree, userAuthClaimIndexHash.ref);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    request.ref.auth_claim.proof = proof[0];

    ffi.Pointer<IDENmerkleTree> issuerClaimsTree = createCorrectMT()!;
    if (issuerClaimsTree == ffi.nullptr ||
        issuerClaimsTree.ref.status !=
            IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (issuerClaimsTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = issuerClaimsTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${issuerClaimsTree.ref.status}");
    }

    ffi.Pointer<IDENmerkleTree> issuerRevTree = createCorrectMT()!;
    if (issuerRevTree == ffi.nullptr ||
        issuerRevTree.ref.status != IDENmerkleTreeStatus.IDENTMERKLETREE_OK) {
      if (issuerRevTree.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = issuerRevTree.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${issuerRevTree.ref.status}");
    }

    int issuerRevNonce = 0; //11203087622270641253llu;
    //BigInt.parse("15930428023331155902"); // 13260572831089785859

    // TODO: issuer pubX and pubY??
    String issuerPubX =
        "9582165609074695838007712438814613121302719752874385708394134542816240804696";
    String issuerPubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    ffi.Pointer<IDENClaim> issuerAuthClaim =
        makeAuthClaim(issuerPubX, issuerPubY, issuerRevNonce.toInt());

    //Add_Claim_to_Tree
    //ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    ffi.Pointer<IDENTreeEntry> issuerAuthClaimTreeEntry =
        nativeLib.IDENClaimTreeEntry(issuerAuthClaim);
    if (issuerAuthClaimTreeEntry == ffi.nullptr ||
        issuerAuthClaimTreeEntry.ref.status !=
            IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (issuerAuthClaimTreeEntry.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = issuerAuthClaimTreeEntry.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print(
          "ERROR : ${issuerAuthClaimTreeEntry.ref.status}"); // IDENTREEENTRY_EXTRACT_CLAIM_ERROR
    }

    status1 = nativeLib.IDENmerkleTreeAddClaim(
        issuerClaimsTree, issuerAuthClaimTreeEntry);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }
    //END: Add_Claim_to_Tree

    int revNonce = 1;
    request.ref.claim.core_claim = makeUserClaim(
        "0000dd107bd74ed9a1006b0455e0b36af814b07c0bb42f390868eb02220ba6",
        revNonce);

    status1 =
        nativeLib.IDENmerkleTreeAddClaim(issuerClaimsTree, claimTreeEntry);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    request.ref.claim.tree_state =
        makeTreeState(issuerClaimsTree, issuerRevTree, emptyTree);
    request.ref.revocation_status.tree_state =
        request.ref.auth_claim.tree_state;

    // Generate revocation status proof
    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    nativeLib.IDENHashFromUInt64(revNonceHash, revNonce.toInt());

    ffi.Pointer<ffi.Pointer<IDENProof>> proofP =
        malloc<ffi.Pointer<IDENProof>>();
    nativeLib.IDENMerkleTreeGenerateProof(
        proofP, issuerRevTree, revNonceHash.ref);
    request.ref.revocation_status.proof = proofP[0];

    ffi.Pointer<IDENMerkleTreeHash> userClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userClaimIndexHash, ffi.nullptr, request.ref.claim.core_claim);
    if (status1.ref.status != 0) {
      if (status1.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = status1.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${status1.ref.status}");
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> proofP1 =
        malloc<ffi.Pointer<IDENProof>>();
    nativeLib.IDENMerkleTreeGenerateProof(
        proofP1, issuerClaimsTree, userClaimIndexHash.ref);
    request.ref.claim.proof = proofP1[0];

    ffi.Pointer<ffi.Int8> unsafePointerQueryValue =
        "10".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> queryValue =
        nativeLib.IDENBigIntFromString(unsafePointerQueryValue);
    request.ref.query.value = queryValue;

    String result = "";
    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAtomicQueryInputs(request);
    if (response.ref.status != 0) {
      if (response.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = response.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        print("error message: " + msg);
      }
      print("ERROR : ${response.ref.status}");
    } else {
      ffi.Pointer<ffi.Int8> json = response.ref.json_string;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    nativeLib.IDENFreeBigInt(request.ref.query.value);
    nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    nativeLib.IDENFreeClaim(issuerAuthClaim);
    nativeLib.IDENFreeMerkleTree(userAuthClaimsTree);
    nativeLib.IDENFreeMerkleTree(issuerClaimsTree);
    nativeLib.IDENFreeMerkleTree(issuerRevTree);
    nativeLib.IDENFreeMerkleTree(emptyTree);
    nativeLib.IDENFreeProof(request.ref.claim.proof);
    nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    nativeLib.IDENFreeProof(request.ref.revocation_status.proof);

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
      }
      result.add(resultString);
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

  IDENTreeState makeTreeState(
      ffi.Pointer<IDENmerkleTree> claimsTree,
      ffi.Pointer<IDENmerkleTree> revTree,
      ffi.Pointer<IDENmerkleTree> rorTree) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();

    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    nativeLib.IDENTreeRoot(claimsRoot, claimsTree);
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    nativeLib.IDENTreeRoot(revocationRoot, revTree);
    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    nativeLib.IDENTreeRoot(rootOfRoots, rorTree);
    treeState.ref.root_of_roots = rootOfRoots.ref;

    ffi.Pointer<ffi.Pointer<IDENMerkleTreeHash>> hashes =
        malloc<ffi.Pointer<IDENMerkleTreeHash>>(3);
    hashes[0] = claimsRoot;
    hashes[1] = revocationRoot;
    hashes[2] = rootOfRoots;

    ffi.Pointer<IDENMerkleTreeHash> dst = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENstatus> status = nativeLib.IDENHashOfHashes(dst, hashes, 3);
    if (status.ref.status != 0) {
      print("error");
    }
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

    nativeLib.IDENClaimSetRevocationNonce(claim2, revNonce);

    if (claim2.ref.status != IDENClaimStatus.IDENCLAIMSTATUS_OK) {
      //return IDENstatusCode.IDENSTATUSCODE_CLAIM_ERROR;
    } else {
      return claim2;
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
