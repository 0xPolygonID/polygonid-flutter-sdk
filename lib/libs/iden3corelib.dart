import 'dart:convert';
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
  static NativeLibrary get _nativeLib {
    return Platform.isAndroid
        ? NativeLibrary(ffi.DynamicLibrary.open("libiden3core.so"))
        : NativeLibrary(ffi.DynamicLibrary.process());
  }

  /*static ProverLib get _proverLib {
    return Platform.isAndroid
        ? ProverLib(ffi.DynamicLibrary.open("libgmp.so"),
            ffi.DynamicLibrary.open("librapidsnark.so"))
        : ProverLib(ffi.DynamicLibrary.process(), ffi.DynamicLibrary.process());
  }*/

  Iden3CoreLib();

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
    if (kDebugMode) {
      print("idenState reversed: " + reversed);
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();

    ffi.Pointer<IDENMerkleTreeHash> state = malloc<IDENMerkleTreeHash>();
    for (var i = 0; i < pointerList.length; i++) {
      state.ref.data[i] = pointerList[i];
    }

    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();

    int res = _nativeLib.IDENidGenesisFromIdenState(idP, state.ref, status);
    if (res == 0) {
      if (kDebugMode) {
        print("unable to get genesis id from iden state\n");
      }
      return "ERROR";
    }

    // print("Genesis ID:\n");
    var result = "";
    for (int i = 0; i < 31; i++) {
      result = result + idP.ref.data[i].toRadixString(16).padLeft(2, '0');
      // print(result);
    }

    if (unsafePointerState != ffi.nullptr) {
      _nativeLib.free(unsafePointerState.cast());
      if (kDebugMode) {
        print("idenState successfully freed");
      }
    }

    if (idP != ffi.nullptr) {
      _nativeLib.free(idP.cast());
      if (kDebugMode) {
        print("id genesis successfully freed");
      }
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

    ffi.Pointer<ffi.Int8> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyXValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyX =
        malloc<ffi.Pointer<IDENBigInt>>();
    keyX.value = keyXValue;
    ffi.Pointer<IDENStatus> statusValue = malloc<IDENStatus>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    status.value = statusValue;
    int res = _nativeLib.IDENBigIntFromString(keyX, unsafePointerX, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<ffi.Int8> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> keyYValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyY =
        malloc<ffi.Pointer<IDENBigInt>>();
    keyY.value = keyYValue;
    res = _nativeLib.IDENBigIntFromString(keyY, unsafePointerY, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<ffi.Pointer<IDENClaim>> claim =
        malloc<ffi.Pointer<IDENClaim>>();
    res = _nativeLib.IDENNewClaim(claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    res = _nativeLib.IDENClaimSetValueDataInt(
        claim.value, keyX.value, keyY.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    String revNonce = "15930428023331155902";

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    res = _nativeLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    final mt = _createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    res = _nativeLib.IDENMerkleTreeAddClaim(mt, claim.value, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
      return "ERROR";
    }

    ffi.Pointer<IDENMerkleTreeHash> mtRoot = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENMerkleTreeRoot(mtRoot, mt, status);
    if (res == 0) {
      if (kDebugMode) {
        print("unable to get merkle tree root\n");
      }
      return "ERROR";
    }

    //print("Root:");
    var result = "";
    for (int i = 0; i < 32; i++) {
      result = result + mtRoot.ref.data[i].toRadixString(16).padLeft(2, "0");
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

    /*if (entryRes != ffi.nullptr) {
      _nativeLib.IDENFreeTreeEntry(entryRes);
      print("tree entry successfuly freed\n");
    }*/

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
      if (kDebugMode) {
        print("schema hash successfully freed\n");
      }
    }

    return result;
  }

  ffi.Pointer<IDENClaim>? parseClaim(String jsonLDDocument, String schema) {
    ffi.Pointer<ffi.Int8> jsonLDDocumentP =
        jsonLDDocument.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();

    ffi.Pointer<ffi.Pointer<IDENClaim>> claimI =
        malloc<ffi.Pointer<IDENClaim>>();

    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();

    int res = _nativeLib.IDENJsonLDParseClaim(
        claimI, jsonLDDocumentP, schemaP, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return null;
    }
    _nativeLib.free(jsonLDDocumentP.cast());
    _nativeLib.free(schemaP.cast());

    ffi.Pointer<IDENClaim> claim = claimI[0];
    _nativeLib.free(claimI.cast());
    return claim;
  }

  int claimTreeEntryHash() {
    return 0;
  }

  // TODO: fix implementation
  String getAuthClaim(String pubX, pubY) {
    ffi.Pointer<IDENCircuitClaim> authClaim = malloc<IDENCircuitClaim>();
    String result = "";
    String revNonce = "15930428023331155902";
    if (kDebugMode) {
      print("revNonce: " + revNonce.toString());
    }
    ffi.Pointer<ffi.Pointer<IDENClaim>> claim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    bool ok = _makeAuthClaim(claim, pubX, pubY, revNonce, status);
    if (!ok) {
      _consumeStatus(status, "can't create auth claim's core claim");
    }
    authClaim.ref.core_claim = claim.value;

    ffi.Pointer<IDENMerkleTree> claimsTree = _createCorrectMT()!;

    int res = _nativeLib.IDENMerkleTreeAddClaim(
        claimsTree, authClaim.ref.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, authClaim.ref.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claimf");
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        userAuthClaimProof, claimsTree, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
    }
    authClaim.ref.proof = userAuthClaimProof.value;

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENMerkleTreeRoot(claimsTreeRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "can't calc tree root");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    res = _nativeLib.IDENCalculateGenesisID(idP, claimsTreeRoot.ref, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate genesis ID");
    }
    authClaim.ref.issuer_id = idP.ref;

    ffi.Pointer<IDENMerkleTree> revTree = _createCorrectMT()!;
    ffi.Pointer<IDENMerkleTree> rorTree = _createCorrectMT()!;

    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();
    ok = _makeTreeState(treeState, claimsTree, revTree, rorTree, status);
    if (!ok) {
      _consumeStatus(status, "error calculating tree state");
    }
    authClaim.ref.tree_state = treeState.ref;

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        revNonceHash, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        userAuthClaimNonRevProof, revTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating revocation status proof");
    }
    authClaim.ref.non_rev_proof.proof = userAuthClaimNonRevProof.value;
    authClaim.ref.non_rev_proof.tree_state = malloc<IDENTreeState>().ref;

    authClaim.ref.signature_proof.issuer_id = malloc<IDENId>().ref;
    authClaim.ref.signature_proof.signature = malloc<IDENBJJSignature>().ref;
    authClaim.ref.signature_proof.issuer_tree_state =
        malloc<IDENTreeState>().ref;
    authClaim.ref.signature_proof.issuer_auth_claim = ffi.nullptr;
    authClaim.ref.signature_proof.issuer_auth_claim_mtp = ffi.nullptr;
    authClaim.ref.signature_proof.issuer_auth_non_rev_proof =
        malloc<IDENRevocationStatus>().ref;
    authClaim.ref.signature_proof.issuer_auth_non_rev_proof.tree_state =
        malloc<IDENTreeState>().ref;
    authClaim.ref.signature_proof.issuer_auth_non_rev_proof.proof = ffi.nullptr;

    result = json.encode(authClaim.ref.toJson());
    return result;
  }

  String prepareAuthInputs(
    String challenge,
    String authClaim,
    String pubX,
    String pubY,
    String signature,
  ) {
    ffi.Pointer<IDENAuthInputs> request = malloc<IDENAuthInputs>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    String revNonce = "15930428023331155902";

    // MOCKUP TO TEST
    /*challenge = "1";
    pubX =
        "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    pubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    signature =
        "9d6a88b9a2eb1ce525065301a65f95a21b387cbf1d94fd4aa0be2e7b51532d0cc79b70d659246c05326b46e915a31163869ed11c44d47eb639bc0af381dba004";*/

    // CHALLENGE - ALL GOOD
    ffi.Pointer<ffi.Int8> unsafePointerChallenge =
        challenge.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> challengeValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> challengePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    challengePointer.value = challengeValue;
    int res = _nativeLib.IDENBigIntFromString(
        challengePointer, unsafePointerChallenge, status);
    if (res == 0) {
      _consumeStatus(status, "can't convert BigInt from String");
    }
    request.ref.challenge = challengePointer.value;

    // AUTH CLAIM - ALL GOOD
    ffi.Pointer<IDENClaim> authClaimValue = malloc<IDENClaim>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> authClaimPointer =
        malloc<ffi.Pointer<IDENClaim>>();
    authClaimPointer.value = authClaimValue;
    bool ok = _makeAuthClaim(authClaimPointer, pubX, pubY, revNonce, status);
    if (!ok) {
      _consumeStatus(status, "can't create auth claim");
    }
    request.ref.auth_claim.core_claim = authClaimPointer.value;

    ffi.Pointer<IDENMerkleTree> claimsTree = _createCorrectMT()!;

    res = _nativeLib.IDENMerkleTreeAddClaim(
        claimsTree, request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash, ffi.nullptr,
        request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claimf");
    }

    ffi.Pointer<IDENProof> userAuthClaimProofValue = malloc<IDENProof>();
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    userAuthClaimProof.value = userAuthClaimProofValue;
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        userAuthClaimProof, claimsTree, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
    }
    request.ref.auth_claim.proof = userAuthClaimProof.value;

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENMerkleTreeRoot(claimsTreeRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "can't calc tree root");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    res = _nativeLib.IDENCalculateGenesisID(idP, claimsTreeRoot.ref, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate genesis ID");
    }
    request.ref.id = idP.ref;

    ffi.Pointer<IDENMerkleTree> revTree = _createCorrectMT()!;
    ffi.Pointer<IDENMerkleTree> rorTree = _createCorrectMT()!;

    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();
    ok = _makeTreeState(treeState, claimsTree, revTree, rorTree, status);
    if (!ok) {
      _consumeStatus(status, "error calculating tree state");
    }
    request.ref.auth_claim.tree_state = treeState.ref;

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<IDENBigInt> revNonceValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    revNonceBigInt.value = revNonceValue;
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "revNonce: can't convert BigInt from String");
    }

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        revNonceHash, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "revNonce: can't convert Hash from BigInt");
    }

    ffi.Pointer<IDENProof> userAuthClaimNonRevProofValue = malloc<IDENProof>();
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    userAuthClaimNonRevProof.value = userAuthClaimNonRevProofValue;
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        userAuthClaimNonRevProof, revTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating revocation status proof");
    }
    request.ref.auth_claim.non_rev_proof.proof = userAuthClaimNonRevProof.value;

    request.ref.auth_claim.issuer_id = malloc<IDENId>().ref;
    request.ref.auth_claim.non_rev_proof.tree_state =
        malloc<IDENTreeState>().ref;
    request.ref.auth_claim.signature_proof =
        malloc<IDENBCircuitsBJJSignatureProof>().ref;
    request.ref.auth_claim.signature_proof.issuer_id = malloc<IDENId>().ref;
    for (var i = 0; i < 64; i++) {
      request.ref.auth_claim.signature_proof.signature.data[i] = 0;
    }
    request.ref.auth_claim.signature_proof.issuer_tree_state =
        malloc<IDENTreeState>().ref;
    request.ref.auth_claim.signature_proof.issuer_auth_claim = ffi.nullptr;
    request.ref.auth_claim.signature_proof.issuer_auth_claim_mtp = ffi.nullptr;
    request.ref.auth_claim.signature_proof.issuer_auth_non_rev_proof =
        malloc<IDENRevocationStatus>().ref;
    request.ref.auth_claim.signature_proof.issuer_auth_non_rev_proof
        .tree_state = malloc<IDENTreeState>().ref;
    request.ref.auth_claim.signature_proof.issuer_auth_non_rev_proof.proof =
        ffi.nullptr;

    //Map<String, dynamic> circuitClaim = json.decode(authClaim);
    //IDENCircuitClaim claim = IDENCircuitClaim.fromJson(circuitClaim);
    //request.ref.auth_claim = claim;

    // SIGNATURE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    // RESULT
    String result = "";
    if (kDebugMode) {
      print("/// RESULT");
    }
    ffi.Pointer<ffi.Int8> responseValue = malloc<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<ffi.Int8>> response =
        malloc<ffi.Pointer<ffi.Int8>>();
    response.value = responseValue;
    res = _nativeLib.IDENPrepareAuthInputs(response, request, status);
    if (res == 0) {
      _consumeStatus(status, "can't prepare auth inputs");
    }

    ffi.Pointer<ffi.Int8> json = response.value;
    ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    _nativeLib.IDENFreeMerkleTree(claimsTree);
    _nativeLib.IDENFreeMerkleTree(revTree);
    _nativeLib.IDENFreeMerkleTree(rorTree);
    _nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeLib.IDENFreeBigInt(request.ref.challenge);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.non_rev_proof.proof);
    _nativeLib.free(response.cast());

    if (kDebugMode) {
      print(result.toString());
    }
    return result;
  }

  String prepareAtomicQueryMTPInputs(
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
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    ffi.Pointer<IDENAtomicQueryMTPInputs> request =
        malloc<IDENAtomicQueryMTPInputs>();
    request.ref.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // QUERY - ALL GOOD
    request.ref.query.slot_index = _getFieldSlotIndex(schema, claimType, key);

    ffi.Pointer<ffi.Int8> unsafePointerValue =
        value.toString().toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
        malloc<ffi.Pointer<IDENBigInt>>();
    int res =
        _nativeLib.IDENBigIntFromString(valuePtr, unsafePointerValue, status);
    request.ref.query.values = valuePtr;
    request.ref.query.values_num = 1;
    request.ref.query.operator1 = operator;
    if (kDebugMode) {
      print("query after free: " + request.ref.query.slot_index.toString());
    }

    // CHALLENGE - ALL GOOD
    ffi.Pointer<ffi.Int8> unsafePointerChallenge =
        challenge.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> challengePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        challengePointer, unsafePointerChallenge, status);
    request.ref.challenge = challengePointer.value;

    // ID - ALL GOOD
    // TODO REMOVE
    //pubX =
    //    "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    //pubY =
    //    "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    String userRevNonce = "15930428023331155902";

    String issuerPubX =
        "9582165609074695838007712438814613121302719752874385708394134542816240804696";
    String issuerPubY =
        "18271435592817415588213874506882839610978320325722319742324814767882756910515";
    String issuerRevNonce = "11203087622270641253";

    ffi.Pointer<IDENId> id = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> authClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> userAuthClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    res = _generateIdentity(
        id, authClaim, userAuthClaimsTree, pubX, pubY, userRevNonce);
    assert(res == 0);

    request.ref.id = id.ref;
    request.ref.auth_claim.core_claim = authClaim.value;

    ffi.Pointer<IDENMerkleTree> emptyTree = _createCorrectMT()!;
    ffi.Pointer<IDENTreeState> userAuthTreeState = malloc<IDENTreeState>();
    bool ok = _makeTreeState(userAuthTreeState, userAuthClaimsTree.value,
        emptyTree, emptyTree, status);
    if (!ok) {
      _consumeStatus(status, "cannot calculate user auth tree state");
      //retVal = 1;
      return "";
    }
    request.ref.auth_claim.tree_state = userAuthTreeState.ref;
    request.ref.auth_claim.non_rev_proof.tree_state = userAuthTreeState.ref;

    ffi.Pointer<ffi.Int8> unsafePointerUserRevNonce =
        userRevNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> userRevNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        userRevNonceBigInt, unsafePointerUserRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> userRevNonceHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        userRevNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> nonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        nonRevProof, emptyTree, userRevNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(
          status, "error generating user auth claim's non-revocation proof");
      //retVal = 1;
      return "";
    }
    request.ref.auth_claim.non_rev_proof.proof = nonRevProof.value;

    // SIGNATURE OF THE CHALLENGE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash, ffi.nullptr,
        request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claim");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        proof, userAuthClaimsTree.value, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: " + proof[0].ref.existence.toString());
    }
    request.ref.auth_claim.proof = proof[0];

    ffi.Pointer<IDENId> issuerId = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> issuerAuthClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> issuerAuthClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    res = _generateIdentity(issuerId, issuerAuthClaim, issuerAuthClaimsTree,
        issuerPubX, issuerPubY, issuerRevNonce);
    assert(res == 0);

    request.ref.claim.issuer_id = issuerId.ref;

    ffi.Pointer<IDENMerkleTree> issuerRevTree = _createCorrectMT()!;

    ffi.Pointer<IDENMerkleTreeHash> issuerClaimsTreeRoot =
        malloc<IDENMerkleTreeHash>();

    res = _nativeLib.IDENMerkleTreeRoot(
        issuerClaimsTreeRoot, issuerRevTree, status);
    if (res == 0) {
      _consumeStatus(status, "can't calculate issuer's claims tree root");
      return "";
    }

    request.ref.claim.core_claim = _makeUserClaim(
        request.ref.id, userRevNonce, "ce6bb12c96bfd1544c02c289c6b4b987");

    res = _nativeLib.IDENMerkleTreeAddClaim(
        issuerAuthClaimsTree.value, request.ref.claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "can't add claim to issuer's claims tree");
      return "";
    }
    ffi.Pointer<IDENTreeState> issuerStateAfterClaimAdd =
        malloc<IDENTreeState>();
    ok = _makeTreeState(issuerStateAfterClaimAdd, issuerAuthClaimsTree.value,
        issuerRevTree, emptyTree, status);
    if (!ok) {
      _consumeStatus(status, "can't calculate issuer's state after claim add");
      return "";
    }

    request.ref.claim.tree_state = issuerStateAfterClaimAdd.ref;
    request.ref.claim.non_rev_proof.tree_state = issuerStateAfterClaimAdd.ref;

    // Generate revocation status proof
    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        revNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> claimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        claimNonRevProof, issuerRevTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating revocation status proof");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: " + claimNonRevProof[0].ref.existence.toString());
    }
    request.ref.claim.non_rev_proof.proof = claimNonRevProof[0];

    ffi.Pointer<IDENMerkleTreeHash> userClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(
        userClaimIndexHash, ffi.nullptr, request.ref.claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "error calculating index hash of user's claim");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> claimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        claimProof, issuerAuthClaimsTree.value, userClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status,
          "error generating proof that user's claim is in the issuers claims tree");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: " + claimProof[0].ref.existence.toString());
    }
    request.ref.claim.proof = claimProof[0];

    ffi.Pointer<ffi.Int8> unsafePointerQuery =
        "10".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> queryValuePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        queryValuePointer, unsafePointerQuery, status);
    request.ref.query.values = queryValuePointer;

    // RESULT
    String result = "";
    if (kDebugMode) {
      print("/// RESULT");
    }
    ffi.Pointer<ffi.Pointer<ffi.Int8>> response =
        malloc<ffi.Pointer<ffi.Int8>>();
    res = _nativeLib.IDENPrepareAtomicQueryMTPInputs(response, request, status);
    if (status.value.ref.status != 0) {
      if (kDebugMode) {
        if (status.value.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = status.value.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("idenjsonresponse Error : ${status.value.ref.status}");
      }
    } else {
      if (kDebugMode) {
        print("idenjsonresponse OK : ${status.value.ref.status}");
      }
      ffi.Pointer<ffi.Int8> json = response.value;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    _nativeLib.IDENFreeBigInt(request.ref.challenge);
    _nativeLib.IDENFreeBigInt(request.ref.query.values[0]);
    _nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeLib.IDENFreeClaim(issuerAuthClaim.value);
    _nativeLib.IDENFreeMerkleTree(userAuthClaimsTree.value);
    _nativeLib.IDENFreeMerkleTree(issuerAuthClaimsTree.value);
    _nativeLib.IDENFreeMerkleTree(issuerRevTree);
    _nativeLib.IDENFreeMerkleTree(emptyTree);
    _nativeLib.IDENFreeProof(request.ref.claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeLib.IDENFreeProof(request.ref.claim.non_rev_proof.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.non_rev_proof.proof);
    _nativeLib.free(response.cast());

    if (kDebugMode) {
      print(result.toString());
    }
    return result;
  }

  String prepareAtomicQuerySigInputs(
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
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    ffi.Pointer<IDENAtomicQuerySigInputs> request =
        malloc<IDENAtomicQuerySigInputs>();
    request.ref.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // MOCKUP_DATA
    // TODO REMOVE
    challenge = "1";
    signature =
        "9d6a88b9a2eb1ce525065301a65f95a21b387cbf1d94fd4aa0be2e7b51532d0cc79b70d659246c05326b46e915a31163869ed11c44d47eb639bc0af381dba004";
    pubX =
        "17640206035128972995519606214765283372613874593503528180869261482403155458945";
    pubY =
        "20634138280259599560273310290025659992320584624461316485434108770067472477956";
    value = 10;
    String userRevNonce = "15930428023331155902";

    String issuerPubX =
        "9582165609074695838007712438814613121302719752874385708394134542816240804696";
    String issuerPubY =
        "18271435592817415588213874506882839610978320325722319742324814767882756910515";
    String issuerRevNonce = "11203087622270641253";
    String claimSignature =
        "4fe8744c71cb0f59a0be115fdb1506958f011a2c0e91b8eebb510381c32d25a02be403385b266f3fe681c97746daf86c6e28e33367abf393afb8ff701677b501";

    // ID - ALL GOOD
    ffi.Pointer<IDENId> id = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> authClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> userClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    int res = _generateIdentity(
        id, authClaim, userClaimsTree, pubX, pubY, userRevNonce);
    if (res == 0) {
      return "";
    }

    request.ref.id = id.ref;
    request.ref.auth_claim.core_claim = authClaim.value;

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash, ffi.nullptr,
        request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claim");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> authClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(authClaimProof,
        userClaimsTree.value, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
      //retVal = 1;
      return "";
    }
    request.ref.auth_claim.proof = authClaimProof.value;

    ffi.Pointer<IDENMerkleTree> emptyTree = _createCorrectMT()!;
    ffi.Pointer<IDENTreeState> userTreeState = malloc<IDENTreeState>();
    bool ok = _makeTreeState(
        userTreeState, userClaimsTree.value, emptyTree, emptyTree, status);
    if (!ok) {
      _consumeStatus(status, "can't make tree state for user's claims tree");
      //retVal = 1;
      return "";
    }
    request.ref.auth_claim.tree_state = userTreeState.ref;
    request.ref.auth_claim.non_rev_proof.tree_state = userTreeState.ref;

    ffi.Pointer<ffi.Int8> unsafePointerUserRevNonce =
        userRevNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> userRevNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        userRevNonceBigInt, unsafePointerUserRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimRevNonceHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        userAuthClaimRevNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> nonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        nonRevProof, emptyTree, userAuthClaimRevNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(
          status, "error generating user auth claim's non-revocation proof");
      //retVal = 1;
      return "";
    }
    request.ref.auth_claim.non_rev_proof.proof = nonRevProof.value;

    // SIGNATURE OF THE CHALLENGE - ALL GOOD
    List<int> r = hexToBytes(signature);
    for (var i = 0; i < r.length; i++) {
      request.ref.signature.data[i] = r[i];
    }

    request.ref.claim.tree_state = userTreeState.ref;

    String revNonce = "1";
    request.ref.claim.core_claim = _makeUserClaim(
        request.ref.id, revNonce, "ce6bb12c96bfd1544c02c289c6b4b987");

    ffi.Pointer<IDENId> issuerId = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> issuerAuthClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> issuerClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    res = _generateIdentity(issuerId, issuerAuthClaim, issuerClaimsTree,
        issuerPubX, issuerPubY, issuerRevNonce);
    if (res == 0) {
      return "";
    }
    request.ref.claim.issuer_id = issuerId.ref;

    ffi.Pointer<IDENMerkleTree> issuerRevTree = _createCorrectMT()!;

    ffi.Pointer<IDENTreeState> issuerGenesisState = malloc<IDENTreeState>();
    ok = _makeTreeState(issuerGenesisState, issuerClaimsTree.value,
        issuerRevTree, emptyTree, status);
    if (!ok) {
      _consumeStatus(status, "can't make tree state for issuer's claims tree");
      //retVal = 1;
      return "";
    }
    request.ref.claim.signature_proof.issuer_auth_claim = issuerAuthClaim.value;

    ffi.Pointer<IDENMerkleTreeHash> issuerAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(
        issuerAuthClaimIndexHash, ffi.nullptr, issuerAuthClaim.value, status);
    if (res == 0) {
      _consumeStatus(status,
          "error calculating index and value hashes of issuer's auth claim");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> issuerAuthClaimMTPProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(issuerAuthClaimMTPProof,
        issuerClaimsTree.value, issuerAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status,
          "error generating proof that issuer's auth claim is in the issuers claims tree");
      //retVal = 1;
      return "";
    }
    request.ref.claim.signature_proof.issuer_auth_claim_mtp =
        issuerAuthClaimMTPProof.value;

    request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state =
        issuerGenesisState.ref;

    // Generate revocation status proof

    ffi.Pointer<ffi.Int8> unsafePointerIssuerRevNonce =
        issuerRevNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> issuerRevNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        issuerRevNonceBigInt, unsafePointerIssuerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> issuerAuthClaimRevNonceHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        issuerAuthClaimRevNonceHash, issuerRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> claimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(claimNonRevProof,
        issuerRevTree, issuerAuthClaimRevNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status,
          "error generating proof that issuer's auth claim is not in revocation tree");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: " + claimNonRevProof[0].ref.existence.toString());
    }
    request.ref.claim.non_rev_proof.proof = claimNonRevProof.value;

    res = _nativeLib.IDENMerkleTreeAddClaim(
        issuerClaimsTree.value, request.ref.claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "can't add claim to issuer's claims tree");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> userClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENClaimTreeEntryHash(
        userClaimIndexHash, ffi.nullptr, request.ref.claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index and value hashes of user's claimf");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> claimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        claimProof, issuerClaimsTree.value, userClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status,
          "error generating proof that user's claim is in the issuers claims tree");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: " + claimProof[0].ref.existence.toString());
    }
    request.ref.claim.proof = claimProof.value;

    ffi.Pointer<IDENTreeState> issuerStateAfterClaimAdd =
        malloc<IDENTreeState>();
    ok = _makeTreeState(issuerStateAfterClaimAdd, issuerClaimsTree.value,
        issuerRevTree, emptyTree, status);
    if (!ok) {
      _consumeStatus(status,
          "can't make tree state for issuer's claims tree after claim add");
      return "";
    }

    request.ref.claim.tree_state = issuerStateAfterClaimAdd.ref;
    request.ref.claim.non_rev_proof.tree_state = issuerStateAfterClaimAdd.ref;

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashFromBigInt(
        revNonceHash, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }
    ffi.Pointer<ffi.Pointer<IDENProof>> userClaimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeLib.IDENMerkleTreeGenerateProof(
        userClaimNonRevProof, issuerRevTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status,
          "Error generating proof that user's claim is in the issuers claims tree");
      return "";
    }
    request.ref.claim.non_rev_proof.proof = userClaimNonRevProof.value;

    request.ref.claim.signature_proof.issuer_id = request.ref.claim.issuer_id;
    request.ref.claim.signature_proof.issuer_tree_state =
        issuerGenesisState.ref;

    // SIGNATURE OF THE CLAIM - ALL GOOD
    List<int> r2 = hexToBytes(claimSignature);
    for (var i = 0; i < r2.length; i++) {
      request.ref.claim.signature_proof.signature.data[i] = r2[i];
    }

    // QUERY - ALL GOOD
    request.ref.query.slot_index = _getFieldSlotIndex(schema, claimType, key);

    ffi.Pointer<ffi.Int8> unsafePointerValue =
        value.toString().toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(valuePtr, unsafePointerValue, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    request.ref.query.values = valuePtr;
    request.ref.query.values_num = 1;
    request.ref.query.operator1 = operator;
    if (kDebugMode) {
      print("query after free: " + request.ref.query.slot_index.toString());
    }

    // RESULT
    String result = "";
    if (kDebugMode) {
      print("/// RESULT");
    }
    ffi.Pointer<ffi.Pointer<ffi.Int8>> response =
        malloc<ffi.Pointer<ffi.Int8>>();
    res = _nativeLib.IDENPrepareAtomicQuerySigInputs(response, request, status);
    if (status.value.ref.status != 0) {
      if (kDebugMode) {
        if (status.value.ref.error_msg != ffi.nullptr) {
          ffi.Pointer<ffi.Int8> json = status.value.ref.error_msg;
          ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
          String msg = jsonString.toDartString();
          print("error message: " + msg);
        }
        print("idenjsonresponse Error : ${status.value.ref.status}");
      }
    } else {
      if (kDebugMode) {
        print("idenjsonresponse OK : ${status.value.ref.status}");
      }
      ffi.Pointer<ffi.Int8> json = response.value;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      if (jsonString != ffi.nullptr) {
        result = jsonString.toDartString();
      }
    }

    _nativeLib.IDENFreeBigInt(request.ref.challenge);
    _nativeLib.IDENFreeBigInt(request.ref.query.values[0]);
    _nativeLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeLib.IDENFreeClaim(request.ref.claim.core_claim);
    _nativeLib.IDENFreeClaim(issuerAuthClaim.value);
    _nativeLib.IDENFreeMerkleTree(userClaimsTree.value);
    _nativeLib.IDENFreeMerkleTree(issuerClaimsTree.value);
    _nativeLib.IDENFreeMerkleTree(issuerRevTree);
    _nativeLib.IDENFreeMerkleTree(emptyTree);
    _nativeLib.IDENFreeProof(request.ref.claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeLib.IDENFreeProof(request.ref.auth_claim.non_rev_proof.proof);
    _nativeLib.IDENFreeProof(request.ref.claim.non_rev_proof.proof);
    _nativeLib.IDENFreeProof(
        request.ref.claim.signature_proof.issuer_auth_claim_mtp);
    _nativeLib.IDENFreeProof(
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.proof);
    _nativeLib.free(response.cast());

    if (kDebugMode) {
      print(result.toString());
    }
    return result;
  }

  bool _consumeStatus(ffi.Pointer<ffi.Pointer<IDENStatus>> status, String msg) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate status\n");
      }
      return false;
    }
    bool result = true;

    if (status.value.ref.status >= 0) {
      result = false;
      if (msg.isEmpty) {
        msg = "status is not OK";
      }
      if (kDebugMode) {
        print("Status: ${status.value.ref.status.toString()}");
      }
      if (status.value.ref.error_msg == ffi.nullptr) {
        if (kDebugMode) {
          print("$msg: ${status.value.ref.status.toString()}");
        }
      } else {
        ffi.Pointer<ffi.Int8> json = status.value.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        try {
          String errormsg = jsonString.toDartString();
          if (kDebugMode) {
            print(
                "$msg: ${status.value.ref.status.toString()}. Error: $errormsg");
          }
        } catch (e) {
          if (kDebugMode) {
            print("$msg: ${status.value.ref.status.toString()}");
          }
        }
      }
    }
    _nativeLib.IDENFreeStatus(status.value);
    return result;
  }

  bool _makeTreeState(
      ffi.Pointer<IDENTreeState> treeState,
      ffi.Pointer<IDENMerkleTree> claimsTree,
      ffi.Pointer<IDENMerkleTree> revTree,
      ffi.Pointer<IDENMerkleTree> rorTree,
      ffi.Pointer<ffi.Pointer<IDENStatus>> status) {
    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    int res = _nativeLib.IDENMerkleTreeRoot(claimsRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "claims tree root");
      return false;
    }
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENMerkleTreeRoot(revocationRoot, revTree, status);
    if (res == 0) {
      _consumeStatus(status, "revocation root");
      return false;
    }

    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENMerkleTreeRoot(rootOfRoots, rorTree, status);
    if (res == 0) {
      _consumeStatus(status, "root of roots");
      return false;
    }

    treeState.ref.root_of_roots = rootOfRoots.ref;

    ffi.Pointer<ffi.Pointer<IDENMerkleTreeHash>> hashes =
        malloc<ffi.Pointer<IDENMerkleTreeHash>>(3);
    hashes[0] = claimsRoot;
    hashes[1] = revocationRoot;
    hashes[2] = rootOfRoots;

    ffi.Pointer<IDENMerkleTreeHash> dst = malloc<IDENMerkleTreeHash>();
    res = _nativeLib.IDENHashOfHashes(dst, hashes, 3, status);
    if (res == 0) {
      _consumeStatus(status, "hash of Hashes");
      return false;
    }

    treeState.ref.state = dst.ref;

    return true;
  }

  bool _makeAuthClaim(
      ffi.Pointer<ffi.Pointer<IDENClaim>> claim,
      String privKeyXHex,
      String privKeyYHex,
      String revNonce,
      ffi.Pointer<ffi.Pointer<IDENStatus>> status) {
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
        malloc<ffi.Uint8>(schemaHash.length);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length);
    pointerList.setAll(0, schemaHash);

    int res = _nativeLib.IDENNewClaim(claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Int8> unsafePointerX =
        privKeyXHex.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyX =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(keyX, unsafePointerX, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Int8> unsafePointerY =
        privKeyYHex.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyY =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(keyY, unsafePointerY, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    res = _nativeLib.IDENClaimSetIndexDataInt(
        claim.value, keyX.value, keyY.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    res = _nativeLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    _nativeLib.free(unsafePointerSchemaHash.cast());
    _nativeLib.IDENFreeBigInt(keyX.value);
    _nativeLib.IDENFreeBigInt(keyY.value);
    _nativeLib.IDENFreeBigInt(revNonceBigInt.value);
    return true;
  }

  ffi.Pointer<IDENClaim> _makeUserClaim(
      IDENId id, String revNonce, String schemaHex) {
    /*final schemaHash = [
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
    ];*/

    List<int> schemaHash = hexToBytes(schemaHex);
    final ffi.Pointer<ffi.Uint8> unsafePointerSchemaHash =
        malloc<ffi.Uint8>(schemaHash.length);
    final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length);
    pointerList.setAll(0, schemaHash);

    ffi.Pointer<ffi.Pointer<IDENClaim>> claim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    int res = _nativeLib.IDENNewClaim(claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "error creating new claim");
    }

    res = _nativeLib.IDENClaimSetIndexID(claim.value, id, status);
    if (res == 0) {
      _consumeStatus(status, "error setting index id to claim");
    }

    ffi.Pointer<ffi.Int8> unsafePointerSlotA =
        "10".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> slotA =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(slotA, unsafePointerSlotA, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    ffi.Pointer<ffi.Int8> unsafePointerSlotB =
        "0".toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> slotB =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(slotB, unsafePointerSlotB, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    ffi.Pointer<ffi.Int8> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    res = _nativeLib.IDENClaimSetIndexDataInt(
        claim.value, slotA.value, slotB.value, status);
    if (res == 0) {
      _consumeStatus(status, "error setting index data int to claim");
    }

    _nativeLib.IDENFreeBigInt(slotA.value);
    _nativeLib.IDENFreeBigInt(slotB.value);

    res = _nativeLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "error setting revocation nonce to claim");
    }

    res =
        _nativeLib.IDENClaimSetExpirationDate(claim.value, 1669884010, status);
    if (res == 0) {
      _consumeStatus(status, "error setting expiration date to claim");
    }

    return claim.value;
  }

  /// Allocate new IDENClaim & IDENMerkleTree. Caller must free those object.
  ///
  /// Return 0 on success.
  int _generateIdentity(
      ffi.Pointer<IDENId> id,
      ffi.Pointer<ffi.Pointer<IDENClaim>> claim,
      ffi.Pointer<ffi.Pointer<IDENMerkleTree>> claimsTree,
      String authClaimKeyX,
      String authClaimKeyY,
      String authClaimRevNonce) {
    int result = 0;
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    int res = _nativeLib.IDENNewMerkleTree(claimsTree, 40, status);
    if (res == 0) {
      _consumeStatus(status, "can't create merkle tree");
      result = 1;
      return result;
    }

    bool ok = _makeAuthClaim(
        claim, authClaimKeyX, authClaimKeyY, authClaimRevNonce, status);
    if (!ok) {
      _consumeStatus(status, "can't create auth claim");
      result = 1;
      return result;
    }

    res = _nativeLib.IDENMerkleTreeAddClaim(
        claimsTree.value, claim.value, status);
    if (res == 0) {
      _consumeStatus(status, "can't add claim to merkle tree");
      result = 1;
      return result;
    }

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res =
        _nativeLib.IDENMerkleTreeRoot(claimsTreeRoot, claimsTree.value, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate claim's tree root");
      result = 1;
      return result;
    }

    res = _nativeLib.IDENCalculateGenesisID(id, claimsTreeRoot.ref, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate genesis ID");
      result = 1;
      return result;
    }

    return result;
  }

  ffi.Pointer<IDENMerkleTree>? _createCorrectMT() {
    ffi.Pointer<IDENMerkleTree> mtValue = malloc<IDENMerkleTree>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> mt =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    mt.value = mtValue;
    ffi.Pointer<IDENStatus> statusValue = malloc<IDENStatus>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    status.value = statusValue;
    int res = _nativeLib.IDENNewMerkleTree(mt, 40, status);
    if (res == 0 || mt == ffi.nullptr) {
      bool error = _consumeStatus(status, "error new merkle tree");
      if (error) {
        _nativeLib.IDENFreeMerkleTree(mt.value);
      }
      if (kDebugMode) {
        print("unable to allocate merkle tree\n");
      }
      return null;
    }

    if (kDebugMode) {
      print("merkle tree successfully created\n");
    }
    return mt.value;
  }

  int _getFieldSlotIndex(String schema, String claimType, String key) {
    var slotIn = 0;
    ffi.Pointer<ffi.Int32> slotI =
        slotIn.toString().toNativeUtf8().cast<ffi.Int32>();
    ffi.Pointer<ffi.Int8> keyP = key.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> claimTypeP =
        claimType.toNativeUtf8().cast<ffi.Int8>();
    ffi.Pointer<ffi.Int8> schemaP = schema.toNativeUtf8().cast<ffi.Int8>();
    int result = 0;
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    int res = _nativeLib.IDENJsonLDGetFieldSlotIndex(
        slotI, keyP, claimTypeP, schemaP, status);
    if (res == 0) {
      _consumeStatus(status, "IDENJsonLDGetFieldSlotIndex error");
      return result;
    }
    if (kDebugMode) {
      print("slotIndex: ${slotI.value}");
    }
    result = slotI.value;
    _nativeLib.free(slotI.cast());
    _nativeLib.free(keyP.cast());
    _nativeLib.free(claimTypeP.cast());
    _nativeLib.free(schemaP.cast());
    return result;
  }

  /*Future<bool> prover() async {
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
  }*/
}
