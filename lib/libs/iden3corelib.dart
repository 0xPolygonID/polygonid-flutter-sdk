import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:privadoid_sdk/libs/proverlib.dart';
import 'package:privadoid_sdk/model/credential_credential.dart';
import 'package:privadoid_sdk/model/revocation_status.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

import 'generated_bindings.dart';

class Iden3CoreLib {
  /*final lib = Platform.isAndroid
      ? ffi.DynamicLibrary.open("libiden3core.so")
      : ffi.DynamicLibrary.process();*/

  static NativeLibrary get _nativeLib {
    return Platform.isAndroid
        ? NativeLibrary(ffi.DynamicLibrary.open("libiden3core.so"))
        : NativeLibrary(ffi.DynamicLibrary.process());
  }

  static ProverLib get _proverLib {
    return Platform.isAndroid
        ? ProverLib(ffi.DynamicLibrary.open("libgmp.so"),
            ffi.DynamicLibrary.open("librapidsnark.so"))
        : ProverLib(ffi.DynamicLibrary.process(), ffi.DynamicLibrary.process());
  }

  Iden3CoreLib();

  int getFieldSlotIndex(String schema, String claimType, String key) {
    var slotIn = 0;
    ffi.Pointer<ffi.Int32> slotI =
        slotIn.toString().toNativeUtf8().cast<ffi.Int32>();
    ffi.Pointer<ffi.Int8> keyP = key.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> claimTypeP =
        claimType.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();
    int result = 0;
    ffi.Pointer<IDENstatus> status = _nativeLib.IDENJsonLDGetFieldSlotIndex(
        slotI, keyP, claimTypeP, schemaP);
    _consumeStatus(status, "IDENJsonLDGetFieldSlotIndex error");
    print("slotIndex:");
    print(slotI.value);
    result = slotI.value;
    _nativeLib.free(slotI.cast());
    _nativeLib.free(keyP.cast());
    _nativeLib.free(claimTypeP.cast());
    _nativeLib.free(schemaP.cast());
    return result;
  }

  ffi.Pointer<IDENClaim>? parseClaim(String jsonLDDocument, String schema) {
    ffi.Pointer<ffi.Int8> jsonLDDocumentP =
        jsonLDDocument.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();

    ffi.Pointer<ffi.Pointer<IDENClaim>> claimI =
        malloc<ffi.Pointer<IDENClaim>>();

    ffi.Pointer<IDENstatus> status =
        _nativeLib.IDENJsonLDParseClaim(claimI, jsonLDDocumentP, schemaP);
    _consumeStatus(status, "");
    _nativeLib.free(jsonLDDocumentP.cast());
    _nativeLib.free(schemaP.cast());
    if (kDebugMode) {
      print("idenClaim status: ${claimI.value.ref.status}");
    }
    if (claimI.value.ref.status == 0) {
      ffi.Pointer<IDENClaim> claim = claimI[0];
      _nativeLib.free(claimI.cast());
      return claim;
    } else {
      //nativeLib.free(claimI.cast());
      return null;
    }
  }

  int claimTreeEntryHash() {
    return 0;
  }

  String getAuthClaim(String pubX, pubY) {
    //final claim = ffi.Pointer<IDENCircuitClaim>.fromAddress(data as int);
    ffi.Pointer<IDENCircuitClaim> claim = malloc<IDENCircuitClaim>();

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

    claim.ref.current_timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    int revNonce = 0;
    if (kDebugMode) {
      print("revNonce: " + revNonce.toString());
    }
    claim.ref.core_claim = makeAuthClaim(pubX, pubY, revNonce);

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
        _nativeLib.IDENClaimTreeEntry(claim.ref.core_claim);
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
        _nativeLib.IDENmerkleTreeAddClaim(authClaimsTree, authClaimTreeEntry);
    _consumeStatus(status1, "merkle tree add claim");
    _nativeLib.IDENFreeTreeEntry(authClaimTreeEntry);

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = _nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, claim.ref.core_claim);
    _consumeStatus(status1, "claim tree entry hash");

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = _nativeLib.IDENMerkleTreeGenerateProof(
        proof, authClaimsTree, userAuthClaimIndexHash.ref);
    _consumeStatus(status1, "merkle tree generate proof");
    if (kDebugMode) {
      print("proof existence: " + proof[0].ref.existence.toString());
    }
    claim.ref.proof = proof[0];
    _nativeLib.free(userAuthClaimIndexHash.cast());
    _nativeLib.free(proof.cast());

    ffi.Pointer<IDENMerkleTreeHash> authClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = _nativeLib.IDENTreeRoot(authClaimsTreeRoot, authClaimsTree);
    _consumeStatus(status1, "IdenTreeRoot");

    claim.ref.tree_state = makeTreeState(authClaimsTree, emptyTree, emptyTree);
    _nativeLib.IDENFreeMerkleTree(authClaimsTree);

    // ID
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = _nativeLib.IDENCalculateGenesisID(idP, authClaimsTreeRoot.ref);
    _consumeStatus(status1, "calculate genesis ID");
    //request.ref.id = idP.ref;
    String msg1 = json.encode(idP.ref.toJson());
    _nativeLib.free(authClaimsTreeRoot.cast());
    if (kDebugMode) {
      print("authClaimsTreeRoot freed");
    }
    _nativeLib.free(idP.cast());
    if (kDebugMode) {
      print("idP freed");
    }

    //ffi.Pointer<Utf8> jsonString = claim.cast<Utf8>();

    String msg = json.encode(claim.ref.toJson());
    //jsonString.toDartString();
    return msg;
  }

  String prepareAuthInputs(
    String challenge,
    String authClaim,
    String pubX,
    String pubY,
    String signature,
  ) {
    ffi.Pointer<IDENAuthInputs> request = malloc<IDENAuthInputs>();

    // NON REV PROOF - ALL GOOD
    request.ref.auth_claim_non_revocation_proof = ffi.nullptr;

    // CHALLENGE - ALL GOOD
    request.ref.challenge = int.parse(challenge);

    // AUTH CLAIM - ALL GOOD
    Map<String, dynamic> circuitClaim = json.decode(authClaim);
    IDENCircuitClaim claim = IDENCircuitClaim.fromJson(circuitClaim);
    request.ref.auth_claim = claim;
    request.ref.auth_claim.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int revNonce = 0;
    if (kDebugMode) {
      print("revNonce: " + revNonce.toString());
    }
    request.ref.auth_claim.core_claim = makeAuthClaim(pubX, pubY, revNonce);

    request.ref.state = request.ref.auth_claim.tree_state;

    // ID
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    ffi.Pointer<IDENstatus> status1 = _nativeLib.IDENCalculateGenesisID(
        idP, request.ref.auth_claim.tree_state.claims_root);
    _consumeStatus(status1, "calculate genesis ID");
    request.ref.id = idP.ref;

    print("Genesis ID:\n");
    var result2 = "";
    for (int i = 0; i < 31; i++) {
      result2 = result2 + idP.ref.data[i].toRadixString(16).padLeft(2, '0');
    }
    print(result2);
    if (kDebugMode) {
      print("authClaimsTreeRoot freed");
    }
    _nativeLib.free(idP.cast());
    if (kDebugMode) {
      print("idP freed");
    }

    // SIGNATURE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // RESULT
    String result = "";
    print("/// RESULT");
    ffi.Pointer<IDENJsonResponse> response =
        _nativeLib.IDENPrepareAuthInputs(request);
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
      if (kDebugMode) {
        print("idenjsonresponse OK : ${response.ref.status}");
      }
      ffi.Pointer<ffi.Int8> json = response.ref.json_string;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    _nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim_non_revocation_proof);
    _nativeLib.IDENFreeJsonResponse(response);
    _nativeLib.free(request.cast());

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
    request.ref.query.slot_index = getFieldSlotIndex(schema, claimType, key);
    ffi.Pointer<ffi.Int8> unsafePointerValue =
        value.toString().toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> valuePtr =
        _nativeLib.IDENBigIntFromString(unsafePointerValue);
    request.ref.query.value = valuePtr;
    request.ref.query.operator1 = operator;
    print("query after free: " + request.ref.query.slot_index.toString());

    // AUTH CLAIM - ALL GOOD
    request.ref.auth_claim.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    int revNonce = 0;
    if (kDebugMode) {
      print("revNonce: " + revNonce.toString());
    }
    request.ref.auth_claim.core_claim = makeAuthClaim(pubX, pubY, revNonce);

    ffi.Pointer<IDENRevocationStatus> revStatus1 =
        malloc<IDENRevocationStatus>();
    revStatus1.ref.tree_state = makeTreeState(emptyTree, emptyTree, emptyTree);
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
        _nativeLib.IDENClaimTreeEntry(request.ref.auth_claim.core_claim);
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
        _nativeLib.IDENmerkleTreeAddClaim(authClaimsTree, authClaimTreeEntry);
    _consumeStatus(status1, "merkle tree add claim");
    _nativeLib.IDENFreeTreeEntry(authClaimTreeEntry);

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    status1 = _nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, request.ref.auth_claim.core_claim);
    _consumeStatus(status1, "claim tree entry hash");

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    status1 = _nativeLib.IDENMerkleTreeGenerateProof(
        proof, authClaimsTree, userAuthClaimIndexHash.ref);
    _consumeStatus(status1, "merkle tree generate proof");
    if (kDebugMode) {
      print("proof existence: " + proof[0].ref.existence.toString());
    }
    request.ref.auth_claim.proof = proof[0];
    _nativeLib.free(userAuthClaimIndexHash.cast());
    _nativeLib.free(proof.cast());

    ffi.Pointer<IDENMerkleTreeHash> authClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    status1 = _nativeLib.IDENTreeRoot(authClaimsTreeRoot, authClaimsTree);
    _consumeStatus(status1, "IdenTreeRoot");

    request.ref.auth_claim.tree_state =
        makeTreeState(authClaimsTree, emptyTree, emptyTree);
    request.ref.current_tree_state = request.ref.auth_claim.tree_state;
    _nativeLib.IDENFreeMerkleTree(authClaimsTree);

    // ID - ALL GOOD
    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    status1 = _nativeLib.IDENCalculateGenesisID(idP, authClaimsTreeRoot.ref);
    _consumeStatus(status1, "calculate genesis id");
    request.ref.id = idP.ref;
    _nativeLib.free(authClaimsTreeRoot.cast());
    if (kDebugMode) {
      print("authClaimsTreeRoot freed");
    }
    _nativeLib.free(idP.cast());
    if (kDebugMode) {
      print("idP freed");
    }

    // CHALLENGE - ALL GOOD
    request.ref.challenge = int.parse(challenge);

    // SIGNATURE OF THE CHALLENGE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // REVOCATION STATUS - ALL GOOD
    if (kDebugMode) {
      print("START REVOCATION STATUS");
    }
    int siblingsNum = revocationStatus.mtp!.siblings!.length;
    ffi.Pointer<IDENProof> revProof = malloc<IDENProof>();
    ffi.Pointer<IDENRevocationStatus> revStatus =
        malloc<IDENRevocationStatus>();
    request.ref.revocation_status = revStatus.ref;
    request.ref.revocation_status.proof = revProof;
    request.ref.revocation_status.proof.ref.siblings_num = siblingsNum;
    if (kDebugMode) {
      print("siblingsNum : " + siblingsNum.toString());
    }
    if (siblingsNum > 0) {
      for (int j = 0; j < siblingsNum; j++) {
        ffi.Pointer<ffi.Int8> unsafePointerSibling =
            revocationStatus.mtp!.siblings![j].toNativeUtf8().cast<ffi.Int8>();
        ffi.Pointer<IDENBigInt> sibling =
            _nativeLib.IDENBigIntFromString(unsafePointerSibling);
        request.ref.revocation_status.proof.ref.siblings[j] = sibling.ref.data;
        _nativeLib.IDENFreeBigInt(sibling);
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
    if (kDebugMode) {
      print("START CLAIM");
    }
    request.ref.claim.current_timestamp =
        request.ref.auth_claim.current_timestamp;
    request.ref.claim.core_claim = parseClaim(jsonLDDocument, schema)!;

    int siblingsNum1 = credential.proof![1].mtp!.siblings!.length;
    if (kDebugMode) {
      print("siblingsNum1 claim : " + siblingsNum1.toString());
    }
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
            _nativeLib.IDENBigIntFromString(unsafePointerSibling);
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
        _nativeLib.IDENFreeBigInt(sibling);
        if (kDebugMode) {
          print("sibling freed");
        }
        _nativeLib.free(unsafePointerSibling.cast());
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

    if (kDebugMode) {
      print("aux node key");
    }

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
    if (kDebugMode) {
      print("/// RESULT");
    }
    ffi.Pointer<IDENJsonResponse> response =
        _nativeLib.IDENPrepareAtomicQueryInputs(request);
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

    _nativeLib.IDENFreeBigInt(request.ref.query.value);
    _nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeLib.IDENFreeClaim(request.ref.claim.core_claim);
    _nativeLib.IDENFreeMerkleTree(emptyTree);
    _nativeLib.IDENFreeProof(request.ref.claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeLib.IDENFreeProof(request.ref.revocation_status.proof);
    _nativeLib.IDENFreeJsonResponse(response);
    _nativeLib.free(request.cast());

    if (kDebugMode) {
      print(result.toString());
    }
    return result;
  }

  String getGenesisId(String idenState) {
    if (kDebugMode) {
      print("idenState: " + idenState);
    }
    List<int> bytes = hexToBytes(idenState);
    List<int> reversedBytes = bytes.reversed.toList();
    final ffi.Pointer<ffi.Uint8> unsafePointerState =
        malloc<ffi.Uint8>(reversedBytes.length);
    final Uint8List pointerList =
        unsafePointerState.asTypedList(reversedBytes.length);
    pointerList.setAll(0, reversedBytes);

    String reversed = bytesToHex(reversedBytes, padToEvenLength: true);
    print("idenState reversed: " + reversed);

    final idGenesis = _nativeLib.IDENidGenesisFromIdenState(unsafePointerState);
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
      _nativeLib.free(unsafePointerState.cast());
      if (kDebugMode) {
        print("idenState successfully freed");
      }
    }

    if (idGenesis != ffi.nullptr) {
      _nativeLib.free(idGenesis.cast());
      if (kDebugMode) {
        print("id genesis successfully freed");
      }
    }

    return result;
  }

  List<String> getAuthClaimTreeEntry(String pubX, String pubY) {
    // TODO schemaHash hardcoded
    final schemaHash = [
      0xCA,
      0x93,
      0x88,
      0x57,
      0x24,
      0x1D,
      0xB9,
      0x45,
      0x1E,
      0xA3,
      0x29,
      0x25,
      0x6B,
      0x9C,
      0x06,
      0xE5
    ];

    final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        malloc<ffi.Uint8>(schemaHash.length + 1);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length + 1);
    pointerList.setAll(0, schemaHash);
    pointerList[schemaHash.length] = 0;

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        _nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        _nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;

    ffi.Pointer<IDENTreeEntry> entryRes = _nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate tree entry\n");
      }
      return ["ERROR"];
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        print("error creating tree entry\n");
      }
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        if (kDebugMode) {
          print("error message: " + msg);
        }
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
      _nativeLib.IDENFreeTreeEntry(entryRes);
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
      _nativeLib.free(unsafePointerSchemaHash.cast());
      print("schemaHash successfully freed\n");
    }

    return result;
  }

  String getMerkleTreeRoot(String pubX, String pubY) {
    // TODO schemaHash hardcoded
    final schemaHash = [
      0xCA,
      0x93,
      0x88,
      0x57,
      0x24,
      0x1D,
      0xB9,
      0x45,
      0x1E,
      0xA3,
      0x29,
      0x25,
      0x6B,
      0x9C,
      0x06,
      0xE5
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
        _nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        _nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0;
    ffi.Pointer<IDENTreeEntry> entryRes = _nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate tree entry\n");
      }
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        print("error creating tree entry\n");
      }
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String msg = jsonString.toDartString();
        if (kDebugMode) {
          print("error message: " + msg);
        }
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      if (kDebugMode) {
        print("unexpected data length\n");
      }
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

    final mtRoot = _nativeLib.IDENmerkleTreeRoot(mt);
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
      _nativeLib.free(mtRoot.cast());
      print("tree root successfuly freed\n");
    }

    if (mt != ffi.nullptr) {
      _nativeLib.IDENFreeMerkleTree(mt);
      print("merkle tree successfuly freed\n");
    }

    if (entryRes != ffi.nullptr) {
      _nativeLib.IDENFreeTreeEntry(entryRes);
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
      _nativeLib.free(unsafePointerSchemaHash.cast());
      print("schema hash successfully freed\n");
    }

    return result;
  }

  String createNewIdentity(String pubX, String pubY) {
    // TODO schemaHash hardcoded
    final schemaHash = [
      0xCA,
      0x93,
      0x88,
      0x57,
      0x24,
      0x1D,
      0xB9,
      0x45,
      0x1E,
      0xA3,
      0x29,
      0x25,
      0x6B,
      0x9C,
      0x06,
      0xE5
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
        _nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        _nativeLib.IDENBigIntFromString(unsafePointerY);

    int revNonce = 0; // 13260572831089785859
    ffi.Pointer<IDENTreeEntry> entryRes = _nativeLib.IDENauthClaimTreeEntry(
        unsafePointerSchemaHash, keyX, keyY, revNonce);
    if (entryRes == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate tree entry\n");
      }
      return "ERROR";
    }

    if (entryRes.ref.status != IDENtreeEntryStatus.IDENTREEENTRY_OK) {
      if (kDebugMode) {
        print("error creating tree entry\n");
      }
      if (entryRes.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = entryRes.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        print("error message: " + errormsg);
      }
      return "ERROR";
    }

    if (entryRes.ref.data_len != 8 * 32) {
      if (kDebugMode) {
        print("unexpected data length\n");
      }
      return "ERROR";
    }
    /*for (int i = 0; i < 8; i++) {
      print("$i");
      for (int j = 0; j < 32; j++) {
        print(entryRes.ref.data[32 * i + j].toRadixString(16));
      }
      print("\n");
    }*/

    if (kDebugMode) {
      print("generated Tree Entry IS CORRECT");
    }

    final mt = createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    final res = addClaimToMT(mt, entryRes);
    if (res == false) {
      return "ERROR";
    }

    final mtRoot = _nativeLib.IDENmerkleTreeRoot(mt);
    if (mtRoot == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to get merkle tree root\n");
      }
      return "ERROR";
    }

    //print("Root:");
    /*for (int i = 0; i < 32; i++) {
      //print(mtRoot[i].toRadixString(16));
    }*/
    //print("\n");

    final idGenesis = _nativeLib.IDENidGenesisFromIdenState(mtRoot);
    if (idGenesis == ffi.nullptr) {
      print("unable to get genesis id from iden state\n");
      return "ERROR";
    }

    /*print("Genesis ID:");
    for (int i = 0; i < 31; i++) {
      print(idGenesis[i].toRadixString(16));
    }
    print("\n");*/

    final indexHash = _nativeLib.IDENTreeEntryIndexHash(entryRes);
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

    final proof = _nativeLib.IDENmerkleTreeGenerateProof(mt, indexHash);
    if (proof == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate proof\n");
      }
      return "ERROR";
    }

    if (proof.ref.status != IDENProofStatus.IDENPROOFSTATUS_OK) {
      if (kDebugMode) {
        print("error generate proof: " + (proof.ref.status.toString()));
      }
      if (proof.ref.error_msg != ffi.nullptr) {
        ffi.Pointer<ffi.Int8> json = proof.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        String errormsg = jsonString.toDartString();
        if (kDebugMode) {
          print("error message: " + errormsg);
        }
      }
      return "ERROR";
    }

    if (kDebugMode) {
      print("proof existence: ${proof.ref.existence}");
    }
    if (proof.ref.existence == 0) {
      return "ERROR";
    }

    if (proof != ffi.nullptr) {
      _nativeLib.IDENFreeProof(proof);
      if (kDebugMode) {
        print("proof successfully freed\n");
      }
    }

    if (indexHash != ffi.nullptr) {
      _nativeLib.IDENFreeHash(indexHash);
      if (kDebugMode) {
        print("index hash successfully freed\n");
      }
    }

    if (idGenesis != ffi.nullptr) {
      _nativeLib.free(idGenesis.cast());
      if (kDebugMode) {
        print("id genesis successfully freed\n");
      }
    }

    if (mtRoot != ffi.nullptr) {
      _nativeLib.free(mtRoot.cast());
      if (kDebugMode) {
        print("tree root successfully freed\n");
      }
    }

    if (mt != ffi.nullptr) {
      _nativeLib.IDENFreeMerkleTree(mt);
      if (kDebugMode) {
        print("merkle tree successfully freed\n");
      }
    }

    if (entryRes != ffi.nullptr) {
      _nativeLib.IDENFreeTreeEntry(entryRes);
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
      _nativeLib.free(unsafePointerSchemaHash.cast());
      print("schema hash successfully freed\n");
    }

    return "ALL GOOD";
  }

  IDENTreeState makeTreeState(
      ffi.Pointer<IDENmerkleTree> claimsTree,
      ffi.Pointer<IDENmerkleTree> revTree,
      ffi.Pointer<IDENmerkleTree> rorTree) {
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();

    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    ffi.Pointer<IDENstatus> status =
        _nativeLib.IDENTreeRoot(claimsRoot, claimsTree);
    _consumeStatus(status, "claims tree root");
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    status = _nativeLib.IDENTreeRoot(revocationRoot, revTree);
    _consumeStatus(status, "revocation root");
    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    status = _nativeLib.IDENTreeRoot(rootOfRoots, rorTree);
    _consumeStatus(status, "root of roots");
    treeState.ref.root_of_roots = rootOfRoots.ref;

    ffi.Pointer<ffi.Pointer<IDENMerkleTreeHash>> hashes =
        malloc<ffi.Pointer<IDENMerkleTreeHash>>(3);
    hashes[0] = claimsRoot;
    hashes[1] = revocationRoot;
    hashes[2] = rootOfRoots;

    ffi.Pointer<IDENMerkleTreeHash> dst = malloc<IDENMerkleTreeHash>();
    status = _nativeLib.IDENHashOfHashes(dst, hashes, 3);
    _consumeStatus(status, "hash of Hashes");

    treeState.ref.state = dst.ref;

    return treeState.ref;
  }

  ffi.Pointer<IDENClaim> makeAuthClaim(String pubX, String pubY, int revNonce) {
    revNonce = 0;

    //ffi.Pointer<IDENstatus> status = malloc<IDENstatus>();

    final schemaHash = [
      0xCA,
      0x93,
      0x88,
      0x57,
      0x24,
      0x1D,
      0xB9,
      0x45,
      0x1E,
      0xA3,
      0x29,
      0x25,
      0x6B,
      0x9C,
      0x06,
      0xE5
    ];

    final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        malloc<ffi.Uint8>(schemaHash.length /*+ 1*/);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length /*+ 1*/);
    pointerList.setAll(0, schemaHash);
    //pointerList[schemaHash.length] = 0;

    ffi.Pointer<IDENClaim> claim2 =
        _nativeLib.IDENNewClaim(unsafePointerSchemaHash);

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyX =
        _nativeLib.IDENBigIntFromString(unsafePointerX);

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyY =
        _nativeLib.IDENBigIntFromString(unsafePointerY);

    _nativeLib.IDENClaimSetIndexDataInt(claim2, keyX, keyY);

    _nativeLib.IDENClaimSetRevocationNonce(claim2, revNonce);

    if (claim2.ref.status != IDENClaimStatus.IDENCLAIMSTATUS_OK) {
      if (kDebugMode) {
        print("claim error");
      }
      //return IDENstatusCode.IDENSTATUSCODE_CLAIM_ERROR;
    } else {
      if (kDebugMode) {
        print("claim all good");
      }
      //return IDENstatusCode.IDENSTATUSCODE_OK;
    }
    return claim2;
  }

  ffi.Pointer<IDENClaim> makeUserClaim(String idHex, int revNonce) {
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
        _nativeLib.IDENNewClaim(unsafePointerSchemaHash);

    List<int> r = hexToBytes(idHex);
    ffi.Pointer<IDENId> id = malloc<IDENId>();
    for (var i = 0; i < r.length; i++) {
      id.ref.data[i] = r[i];
    }
    _nativeLib.IDENClaimSetIndexID(claim, id.ref);

    ffi.Pointer<ffi.Int8> unsafePointerSlotA =
        "10".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> slotA =
        _nativeLib.IDENBigIntFromString(unsafePointerSlotA);

    ffi.Pointer<ffi.Int8> unsafePointerslotB =
        "0".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> slotB =
        _nativeLib.IDENBigIntFromString(unsafePointerslotB);

    _nativeLib.IDENClaimSetIndexDataInt(claim, slotA, slotB);

    _nativeLib.IDENFreeBigInt(slotA);
    _nativeLib.IDENFreeBigInt(slotB);

    _nativeLib.IDENClaimSetRevocationNonce(claim, revNonce);

    _nativeLib.IDENClaimSetExpirationDate(claim, 1669884010);

    return claim;
  }

  ffi.Pointer<IDENmerkleTree>? createCorrectMT() {
    var mt = _nativeLib.IDENnewMerkleTree(40);

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
      _nativeLib.IDENFreeMerkleTree(mt);
      return null;
    }

    print("merkle tree successfully created\n");
    return mt;
  }

  bool _consumeStatus(ffi.Pointer<IDENstatus> status, String msg) {
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
    _nativeLib.IDENFreeStatus(status);
    return result;
  }

  void addClaimToTree(
      ffi.Pointer<IDENmerkleTree> tree, ffi.Pointer<IDENClaim> claim) {
    ffi.Pointer<IDENTreeEntry> treeEntry = _nativeLib.IDENClaimTreeEntry(claim);
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
        _nativeLib.IDENmerkleTreeAddClaim(tree, treeEntry);
    _consumeStatus(status1, "unable to add claim to tree");
    _nativeLib.IDENFreeTreeEntry(treeEntry);
  }

  bool addClaimToMT(
      ffi.Pointer<IDENmerkleTree> mt, ffi.Pointer<IDENTreeEntry> entryRes) {
    ffi.Pointer<IDENstatus> addStatus =
        _nativeLib.IDENmerkleTreeAddClaim(mt, entryRes);
    return _consumeStatus(addStatus, "add claim");
  }

  Future<bool> prover() async {
    ByteData zkeyBytes = await rootBundle.load('assets/circuit_final.zkey');
    ByteData wtnsBytes = await rootBundle.load('assets/witness.wtns');
    int zkeySize = zkeyBytes.lengthInBytes; // 15613350
    ffi.Pointer<ffi.Void> zkeyBuffer =
        Uint8ArrayUtils.toPointer(zkeyBytes.buffer.asUint8List()).cast();
    int wtnsSize = wtnsBytes.lengthInBytes; // 890924
    ffi.Pointer<ffi.Void> wtnsBuffer =
        Uint8ArrayUtils.toPointer(wtnsBytes.buffer.asUint8List()).cast();
    int proofSize = 16384;
    ffi.Pointer<ffi.Int8> proofBuffer = malloc<ffi.Int8>(proofSize);
    int publicSize = 16384;
    ffi.Pointer<ffi.Int8> publicBuffer = malloc<ffi.Int8>(publicSize);
    int errorMaxSize = 256;
    ffi.Pointer<ffi.Int8> errorMsg = malloc<ffi.Int8>(errorMaxSize);

    DateTime start = DateTime.now();

    int result = _proverLib.groth16_prover(
        zkeyBuffer,
        zkeySize,
        wtnsBuffer,
        wtnsSize,
        proofBuffer,
        proofSize,
        publicBuffer,
        publicSize,
        errorMsg,
        errorMaxSize);

    DateTime end = DateTime.now();

    int time = end.difference(start).inMicroseconds;

    if (result == PRPOVER_OK) {
      ffi.Pointer<ffi.Int8> json = proofBuffer;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      String proofmsg = jsonString.toDartString();

      ffi.Pointer<ffi.Int8> json2 = publicBuffer;
      ffi.Pointer<Utf8> jsonString2 = json2.cast<Utf8>();
      String publicmsg = jsonString2.toDartString();

      print("$result: ${result.toString()}");
      print("Proof: $proofmsg");
      print("Public: $publicmsg.");
      print("Time: $time");
    } else {
      ffi.Pointer<ffi.Int8> json = errorMsg;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      String errormsg = jsonString.toDartString();
      print("$result: ${result.toString()}. Error: $errormsg");
    }

    return result == PRPOVER_OK;
  }
}
