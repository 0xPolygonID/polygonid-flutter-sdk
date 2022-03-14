import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:privadoid_sdk/model/credential_credential.dart';
import 'package:privadoid_sdk/model/revocation_status.dart';
import 'package:web3dart/crypto.dart';

import 'generated_bindings.dart';

class Iden3CoreLib {
  final lib = Platform.isAndroid
      ? ffi.DynamicLibrary.open("libiden3core.so")
      : ffi.DynamicLibrary.process();

  Iden3CoreLib();

  int getFieldSlotIndex(
      String schema, String claimType, String key, NativeLibrary nativeLib) {
    var slotIn = 0;
    ffi.Pointer<ffi.Int32> slotI =
        slotIn.toString().toNativeUtf8().cast<ffi.Int32>();
    ffi.Pointer<ffi.Int8> keyP = key.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> claimTypeP =
        claimType.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();
    int result = 0;
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDGetFieldSlotIndex(slotI, keyP, claimTypeP, schemaP);
    consumeStatus(status, "IDENJsonLDGetFieldSlotIndex error", nativeLib);
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

    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENJsonLDParseClaim(claimI, jsonLDDocumentP, schemaP);
    consumeStatus(status, "", nativeLib);
    nativeLib.free(jsonLDDocumentP.cast());
    nativeLib.free(schemaP.cast());
    print("idenClaim status: ${claimI.value.ref.status}");
    if (claimI.value.ref.status == 0) {
      ffi.Pointer<IDENClaim> claim = claimI[0];
      nativeLib.free(claimI.cast());
      return claim;
    } else {
      //nativeLib.free(claimI.cast());
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

    // NON REV PROOF - ALL GOOD
    request.ref.auth_claim_non_revocation_proof = ffi.nullptr;

    // CHALLENGE - ALL GOOD
    request.ref.challenge = int.parse(challenge);

    // AUTH CLAIM - ALL GOOD
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

    request.ref.auth_claim.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    int revNonce = 0;
    print("revNonce: " + revNonce.toString());
    request.ref.auth_claim.core_claim = makeAuthClaim(pubX, pubY, revNonce);

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
    consumeStatus(status1, "merkle tree add claim", nativeLib);
    nativeLib.IDENFreeTreeEntry(authClaimTreeEntry);

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    consumeStatus(status1, "claim tree entry hash", nativeLib);

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, authClaimsTree, userAuthClaimIndexHash.ref);
    consumeStatus(status1, "merkle tree generate proof", nativeLib);
    print("proof existence: " + proof[0].ref.existence.toString());
    request.ref.auth_claim.proof = proof[0];
    nativeLib.free(userAuthClaimIndexHash.cast());
    nativeLib.free(proof.cast());

    ffi.Pointer<IDENMerkleTreeHash> authClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENTreeRoot(authClaimsTreeRoot, authClaimsTree);
    consumeStatus(status1, "IdenTreeRoot", nativeLib);

    request.ref.auth_claim.tree_state =
        makeTreeState(authClaimsTree, emptyTree, emptyTree, nativeLib);
    request.ref.state = request.ref.auth_claim.tree_state;
    nativeLib.IDENFreeMerkleTree(authClaimsTree);

    // ID
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, authClaimsTreeRoot.ref);
    consumeStatus(status1, "calculate genesis ID", nativeLib);
    request.ref.id = idP.ref;
    nativeLib.free(authClaimsTreeRoot.cast());
    print("authClaimsTreeRoot freed");
    nativeLib.free(idP.cast());
    print("idP freed");

    // SIGNATURE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // RESULT
    String result = "";
    print("/// RESULT");
    ffi.Pointer<IDENJsonResponse> response =
        nativeLib.IDENPrepareAuthInputs(request);
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
      print("idenjsonresponse OK : ${response.ref.status}");
      ffi.Pointer<ffi.Int8> json = response.ref.json_string;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    nativeLib.IDENFreeMerkleTree(emptyTree);
    nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    nativeLib.IDENFreeProof(request.ref.auth_claim_non_revocation_proof);
    nativeLib.IDENFreeJsonResponse(response);
    nativeLib.free(request.cast());

    print(result.toString());
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
    request.ref.query.slot_index =
        getFieldSlotIndex(schema, claimType, key, nativeLib);
    ffi.Pointer<ffi.Int8> unsafePointerValue =
        value.toString().toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> valuePtr =
        nativeLib.IDENBigIntFromString(unsafePointerValue);
    request.ref.query.value = valuePtr;
    request.ref.query.operator1 = operator;
    print("query after free: " + request.ref.query.slot_index.toString());

    // AUTH CLAIM - ALL GOOD
    request.ref.auth_claim.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    int revNonce = 0;
    print("revNonce: " + revNonce.toString());
    request.ref.auth_claim.core_claim = makeAuthClaim(pubX, pubY, revNonce);

    ffi.Pointer<IDENRevocationStatus> revStatus1 =
        malloc<IDENRevocationStatus>();
    revStatus1.ref.tree_state =
        makeTreeState(emptyTree, emptyTree, emptyTree, nativeLib);
    revStatus1.ref.proof = ffi.nullptr;
    request.ref.auth_claim_rev_status = revStatus1.ref;

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
    consumeStatus(status1, "merkle tree add claim", nativeLib);
    nativeLib.IDENFreeTreeEntry(authClaimTreeEntry);

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    consumeStatus(status1, "claim tree entry hash", nativeLib);

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = nativeLib.IDENMerkleTreeGenerateProof(
        proof, authClaimsTree, userAuthClaimIndexHash.ref);
    consumeStatus(status1, "merkle tree generate proof", nativeLib);
    print("proof existence: " + proof[0].ref.existence.toString());
    request.ref.auth_claim.proof = proof[0];
    nativeLib.free(userAuthClaimIndexHash.cast());
    nativeLib.free(proof.cast());

    ffi.Pointer<IDENMerkleTreeHash> authClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = nativeLib.IDENTreeRoot(authClaimsTreeRoot, authClaimsTree);
    consumeStatus(status1, "IdenTreeRoot", nativeLib);

    request.ref.auth_claim.tree_state =
        makeTreeState(authClaimsTree, emptyTree, emptyTree, nativeLib);
    request.ref.current_tree_state = request.ref.auth_claim.tree_state;
    nativeLib.IDENFreeMerkleTree(authClaimsTree);

    // ID - ALL GOOD
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = nativeLib.IDENCalculateGenesisID(idP, authClaimsTreeRoot.ref);
    consumeStatus(status1, "calculate genesis id", nativeLib);
    request.ref.id = idP.ref;
    nativeLib.free(authClaimsTreeRoot.cast());
    print("authClaimsTreeRoot freed");
    nativeLib.free(idP.cast());
    print("idP freed");

    // CHALLENGE - ALL GOOD
    request.ref.challenge = int.parse(challenge);

    // SIGNATURE OF THE CHALLENGE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // REVOCATION STATUS - ALL GOOD
    print("START REVOCATION STATUS");
    int siblingsNum = revocationStatus.mtp!.siblings!.length;
    ffi.Pointer<IDENProof> revProof = malloc<IDENProof>();
    ffi.Pointer<IDENRevocationStatus> revStatus =
        malloc<IDENRevocationStatus>();
    request.ref.revocation_status = revStatus.ref;
    request.ref.revocation_status.proof = revProof;
    request.ref.revocation_status.proof.ref.siblings_num = siblingsNum;
    print("siblingsNum : " + siblingsNum.toString());
    if (siblingsNum > 0) {
      ffi.Pointer<ffi.Pointer<ffi.Uint8>> siblings =
          malloc<ffi.Pointer<ffi.Uint8>>(siblingsNum);
      for (int j = 0; j < siblingsNum; j++) {
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            revocationStatus.mtp!.siblings![j].toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            nativeLib.IDENBigIntFromString(unsafePointerSibling);
        request.ref.revocation_status.proof.ref.siblings[j] = sibling.ref.data;
        nativeLib.IDENFreeBigInt(sibling);
      }
    } else {
      request.ref.revocation_status.proof.ref.siblings = ffi.nullptr;
    }
    request.ref.revocation_status.proof.ref.existence =
        revocationStatus.mtp!.existence == false ? 0 : 1;
    request.ref.revocation_status.proof.ref.auxNodeKey = ffi.nullptr;
    request.ref.revocation_status.proof.ref.auxNodeValue = ffi.nullptr;
    request.ref.revocation_status.proof.ref.status = 0;
    request.ref.revocation_status.proof.ref.error_msg = ffi.nullptr;

    // Revocation Status State
    for (int x = 0; x < 32; x++) {
      request.ref.revocation_status.tree_state.state.data[x] = 0;
      request.ref.revocation_status.tree_state.claims_root.data[x] = 0;
      request.ref.revocation_status.tree_state.revocation_root.data[x] = 0;
      request.ref.revocation_status.tree_state.root_of_roots.data[x] = 0;
    }
    List<int> stateBytes = hexToBytes(revocationStatus.issuer!.state!);
    for (int i = 0; i < stateBytes.length; i++) {
      request.ref.revocation_status.tree_state.state.data[i] = stateBytes[i];
    }
    List<int> claimsRootBytes =
        hexToBytes(revocationStatus.issuer!.claimsTreeRoot!);
    for (int i = 0; i < claimsRootBytes.length; i++) {
      request.ref.revocation_status.tree_state.claims_root.data[i] =
          claimsRootBytes[i];
    }

    // CLAIM
    print("START CLAIM");
    request.ref.claim.current_timestamp =
        request.ref.auth_claim.current_timestamp;
    request.ref.claim.core_claim = parseClaim(jsonLDDocument, schema)!;

    int siblingsNum1 = credential.proof![1].mtp!.siblings!.length;
    print("siblingsNum1 claim : " + siblingsNum1.toString());
    ffi.Pointer<IDENProof> claimProof = malloc<IDENProof>();
    request.ref.claim.proof = claimProof;
    request.ref.claim.proof.ref.siblings_num = siblingsNum1;
    print("siblingsNum2 claim : " + siblingsNum1.toString());

    if (siblingsNum1 > 0) {
      ffi.Pointer<ffi.Pointer<ffi.Uint8>> siblings =
          malloc<ffi.Pointer<ffi.Uint8>>(siblingsNum1);
      request.ref.claim.proof.ref.siblings = siblings;
      for (int i = 0; i < siblingsNum1; i++) {
        String bigIntString = credential.proof![1].mtp!.siblings![i];
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            bigIntString.toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            nativeLib.IDENBigIntFromString(unsafePointerSibling);
        if (sibling.ref.status == 0) {
          ffi.Pointer<ffi.Uint8> sibui = malloc<ffi.Uint8>(32);
          for (int x = 0; x < 32; x++) {
            sibui[x] = 0;
          }
          for (int j = 0; j < sibling.ref.data_len; j++) {
            sibui[j] = sibling.ref.data[j];
          }
          siblings[i] = sibui;
        }
        nativeLib.IDENFreeBigInt(sibling);
        print("sibling freed");
        nativeLib.free(unsafePointerSibling.cast());
      }
      request.ref.claim.proof.ref.siblings = siblings;
    } else {
      request.ref.claim.proof.ref.siblings = ffi.nullptr;
    }
    request.ref.claim.proof.ref.existence =
        credential.proof![1].mtp!.existence == false ? 0 : 1;
    List<int> auxNodeKeyBytes = hexToBytes(credential.proof![1].h_index!);
    ffi.Pointer<ffi.Uint8> auxNodeKey =
        malloc<ffi.Uint8>(auxNodeKeyBytes.length);
    for (int i = 0; i < auxNodeKeyBytes.length; i++) {
      auxNodeKey[i] = auxNodeKeyBytes[i];
    }

    print("aux node key");

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

    for (int x = 0; x < 32; x++) {
      request.ref.claim.tree_state.state.data[x] = 0;
      request.ref.claim.tree_state.claims_root.data[x] = 0;
      request.ref.claim.tree_state.revocation_root.data[x] = 0;
      request.ref.claim.tree_state.root_of_roots.data[x] = 0;
    }
    List<int> stateBytes1 = hexToBytes(credential.proof![1].state!.value!);
    for (int i = 0; i < stateBytes1.length; i++) {
      request.ref.claim.tree_state.state.data[i] = stateBytes1[i];
    }

    List<int> claimsRootBytes1 =
        hexToBytes(credential.proof![1].state!.claims_tree_root!);
    for (int i = 0; i < claimsRootBytes1.length; i++) {
      request.ref.claim.tree_state.claims_root.data[i] = claimsRootBytes1[i];
    }

    // RESULT
    String result = "";
    print("/// RESULT");
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
      print("idenjsonresponse OK : ${response.ref.status}");
      ffi.Pointer<ffi.Int8> json = response.ref.json_string;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    nativeLib.IDENFreeBigInt(request.ref.query.value);
    nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    nativeLib.IDENFreeClaim(request.ref.claim.core_claim);
    nativeLib.IDENFreeMerkleTree(emptyTree);
    nativeLib.IDENFreeProof(request.ref.claim.proof);
    nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    nativeLib.IDENFreeProof(request.ref.revocation_status.proof);
    nativeLib.IDENFreeJsonResponse(response);
    nativeLib.free(request.cast());

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
      ffi.Pointer<IDENmerkleTree> rorTree,
      NativeLibrary nativeLib) {
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();

    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENstatus> status =
        nativeLib.IDENTreeRoot(claimsRoot, claimsTree);
    consumeStatus(status, "claims tree root", nativeLib);
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENTreeRoot(revocationRoot, revTree);
    consumeStatus(status, "revocation root", nativeLib);
    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENTreeRoot(rootOfRoots, rorTree);
    consumeStatus(status, "root of roots", nativeLib);
    treeState.ref.root_of_roots = rootOfRoots.ref;

    ffi.Pointer<ffi.Pointer<IDENMerkleTreeHash>> hashes =
        malloc<ffi.Pointer<IDENMerkleTreeHash>>(3);
    hashes[0] = claimsRoot;
    hashes[1] = revocationRoot;
    hashes[2] = rootOfRoots;

    ffi.Pointer<IDENMerkleTreeHash> dst = malloc<IDENMerkleTreeHash>();
    status = nativeLib.IDENHashOfHashes(dst, hashes, 3);
    consumeStatus(status, "hash of Hashes", nativeLib);

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

  bool consumeStatus(
      ffi.Pointer<IDENstatus> status, String msg, NativeLibrary nativeLib) {
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
    consumeStatus(status1, "unable to add claim to tree", nativeLib);
    nativeLib.IDENFreeTreeEntry(treeEntry);
  }

  bool addClaimToMT(
      ffi.Pointer<IDENmerkleTree> mt, ffi.Pointer<IDENTreeEntry> entryRes) {
    NativeLibrary nativeLib = NativeLibrary(lib);
    ffi.Pointer<IDENstatus> addStatus =
        nativeLib.IDENmerkleTreeAddClaim(mt, entryRes);
    return consumeStatus(addStatus, "add claim", nativeLib);
  }
}
