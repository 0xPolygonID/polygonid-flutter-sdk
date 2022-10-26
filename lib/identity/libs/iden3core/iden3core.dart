import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/revocation_status.dart';
import 'package:web3dart/crypto.dart';

import '../../../credential/data/dtos/credential_dto.dart';
import '../../../credential/data/dtos/credential_proofs/credential_proof_bjj_dto.dart';
import '../../../credential/data/dtos/credential_proofs/credential_proof_dto.dart';
import '../../../credential/data/dtos/credential_proofs/credential_proof_sm_dto.dart';
import '../smt/hash.dart';
import 'native_iden3core.dart';
import 'native_iden3core_extension.dart';

@injectable
class Iden3CoreLib {
  static NativeIden3CoreLib get _nativeIden3CoreLib {
    return Platform.isAndroid
        ? NativeIden3CoreLib(ffi.DynamicLibrary.open("libiden3core.so"))
        : NativeIden3CoreLib(ffi.DynamicLibrary.process());
  }

  Iden3CoreLib();

  String getGenesisId(String idenState) {
    if (kDebugMode) {
      print("idenState: $idenState");
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
      print("idenState reversed: $reversed");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();

    ffi.Pointer<IDENMerkleTreeHash> state = malloc<IDENMerkleTreeHash>();
    for (var i = 0; i < pointerList.length; i++) {
      state.ref.data[i] = pointerList[i];
    }

    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();

    int res =
        _nativeIden3CoreLib.IDENidGenesisFromIdenState(idP, state.ref, status);
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
      _nativeIden3CoreLib.free(unsafePointerState.cast());
      if (kDebugMode) {
        print("idenState successfully freed");
      }
    }

    if (idP != ffi.nullptr) {
      _nativeIden3CoreLib.free(idP.cast());
      if (kDebugMode) {
        print("id genesis successfully freed");
      }
    }

    return result;
  }

  Map<String, String> generateIdentity(String pubX, String pubY) {
    // ID - ALL GOOD
    String userRevNonce = "15930428023331155902";

    ffi.Pointer<IDENId> id = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> authClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> userAuthClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    int res = _generateIdentity(
        id, authClaim, userAuthClaimsTree, pubX, pubY, userRevNonce);
    assert(res == 0);

    var result = "";
    for (int i = 0; i < 31; i++) {
      result = result + id.ref.data[i].toRadixString(16).padLeft(2, '0');
    }
    if (kDebugMode) {
      print(result);
    }
    _nativeIden3CoreLib.IDENFreeMerkleTree(userAuthClaimsTree.value);
    _nativeIden3CoreLib.IDENFreeClaim(authClaim.value);

    Map<String, String> map = {};
    map['id'] = result.toString();
    map['authClaim'] = authClaim.value.ref.toJson().toString();

    return map;
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

    final ffi.Pointer<ffi.UnsignedChar> unsafePointerSchemaHash =
        malloc<ffi.UnsignedChar>(schemaHash.length + 1);
    for (int i = 0; i < schemaHash.length; i++) {
      unsafePointerSchemaHash[i] = schemaHash[i];
    }
    unsafePointerSchemaHash[schemaHash.length] = 0;
    /*final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length + 1);
    pointerList.setAll(0, schemaHash);
    pointerList[schemaHash.length] = 0;*/

    ffi.Pointer<ffi.Char> unsafePointerX = pubX.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<IDENBigInt> keyXValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyX =
        malloc<ffi.Pointer<IDENBigInt>>();
    keyX.value = keyXValue;
    ffi.Pointer<IDENStatus> statusValue = malloc<IDENStatus>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    status.value = statusValue;
    int res =
        _nativeIden3CoreLib.IDENBigIntFromString(keyX, unsafePointerX, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<ffi.Char> unsafePointerY = pubY.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<IDENBigInt> keyYValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyY =
        malloc<ffi.Pointer<IDENBigInt>>();
    keyY.value = keyYValue;
    res =
        _nativeIden3CoreLib.IDENBigIntFromString(keyY, unsafePointerY, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<ffi.Pointer<IDENClaim>> claim =
        malloc<ffi.Pointer<IDENClaim>>();
    res = _nativeIden3CoreLib.IDENNewClaim(
        claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    res = _nativeIden3CoreLib.IDENClaimSetValueDataInt(
        claim.value, keyX.value, keyY.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    String revNonce = "15930428023331155902";

    ffi.Pointer<ffi.Char> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    res = _nativeIden3CoreLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    final mt = _createCorrectMT();
    if (mt == null) {
      return "ERROR";
    }

    res = _nativeIden3CoreLib.IDENMerkleTreeAddClaim(mt, claim.value, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
      return "ERROR";
    }

    ffi.Pointer<IDENMerkleTreeHash> mtRoot = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENMerkleTreeRoot(mtRoot, mt, status);
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
      _nativeIden3CoreLib.free(mtRoot.cast());
      if (kDebugMode) {
        print("tree root successfully freed\n");
      }
    }

    if (mt != ffi.nullptr) {
      _nativeIden3CoreLib.IDENFreeMerkleTree(mt);
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
      _nativeIden3CoreLib.free(unsafePointerSchemaHash.cast());
      if (kDebugMode) {
        print("schema hash successfully freed\n");
      }
    }

    return result;
  }

  ffi.Pointer<IDENClaim>? _parseClaim(String jsonLDDocument, String schema) {
    ffi.Pointer<ffi.Char> jsonLDDocumentP =
        jsonLDDocument.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> schemaP = schema.toNativeUtf8().cast<ffi.Char>();

    ffi.Pointer<ffi.Pointer<IDENClaim>> claimI =
        malloc<ffi.Pointer<IDENClaim>>();

    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();

    int res = _nativeIden3CoreLib.IDENJsonLDParseClaim(
        claimI, jsonLDDocumentP, schemaP, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return null;
    }
    _nativeIden3CoreLib.free(jsonLDDocumentP.cast());
    _nativeIden3CoreLib.free(schemaP.cast());

    ffi.Pointer<IDENClaim> claim = claimI[0];
    _nativeIden3CoreLib.free(claimI.cast());
    return claim;
  }

  ffi.Pointer<IDENProof>? _parseMTPjson(String jsonDoc) {
    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    ffi.Pointer<ffi.Char> json = jsonDoc.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();

    int res = _nativeIden3CoreLib.IDENNewProofFromJson(proof, json, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return null;
    }

    _nativeIden3CoreLib.free(json.cast());

    ffi.Pointer<IDENProof> p = proof[0];
    _nativeIden3CoreLib.free(proof.cast());

    return p;
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
      print("revNonce: $revNonce");
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

    int res = _nativeIden3CoreLib.IDENMerkleTreeAddClaim(
        claimsTree, authClaim.ref.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENClaimTreeEntryHash(
        userAuthClaimIndexHash, ffi.nullptr, authClaim.ref.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claimf");
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
        userAuthClaimProof, claimsTree, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
    }
    authClaim.ref.proof = userAuthClaimProof.value;

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENMerkleTreeRoot(
        claimsTreeRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "can't calc tree root");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    res = _nativeIden3CoreLib.IDENCalculateGenesisID(
        idP, claimsTreeRoot.ref, status);
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

    ffi.Pointer<ffi.Char> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        revNonceHash, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
        userAuthClaimNonRevProof, revTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating revocation status proof");
    }
    authClaim.ref.non_rev_proof.proof = userAuthClaimNonRevProof.value;
    authClaim.ref.non_rev_proof.tree_state = malloc<IDENTreeState>().ref;

    authClaim.ref.signature_proof.issuer_id = malloc<IDENId>().ref;
    for (var i = 0; i < 64; i++) {
      authClaim.ref.signature_proof.signature.data[i] = 0;
    }
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
    ffi.Pointer<ffi.Char> unsafePointerChallenge =
        challenge.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<IDENBigInt> challengeValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> challengePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    challengePointer.value = challengeValue;
    int res = _nativeIden3CoreLib.IDENBigIntFromString(
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

    res = _nativeIden3CoreLib.IDENMerkleTreeAddClaim(
        claimsTree, request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(status, "unable to add auth claim to tree");
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash,
        ffi.nullptr, request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claimf");
    }

    ffi.Pointer<IDENProof> userAuthClaimProofValue = malloc<IDENProof>();
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    userAuthClaimProof.value = userAuthClaimProofValue;
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
        userAuthClaimProof, claimsTree, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
    }
    request.ref.auth_claim.proof = userAuthClaimProof.value;

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENMerkleTreeRoot(
        claimsTreeRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "can't calc tree root");
    }

    ffi.Pointer<IDENId> idP = malloc<IDENId>();
    res = _nativeIden3CoreLib.IDENCalculateGenesisID(
        idP, claimsTreeRoot.ref, status);
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

    ffi.Pointer<ffi.Char> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<IDENBigInt> revNonceValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    revNonceBigInt.value = revNonceValue;
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "revNonce: can't convert BigInt from String");
    }

    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        revNonceHash, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "revNonce: can't convert Hash from BigInt");
    }

    ffi.Pointer<IDENProof> userAuthClaimNonRevProofValue = malloc<IDENProof>();
    ffi.Pointer<ffi.Pointer<IDENProof>> userAuthClaimNonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    userAuthClaimNonRevProof.value = userAuthClaimNonRevProofValue;
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
        userAuthClaimNonRevProof, revTree, revNonceHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating revocation status proof");
    }
    request.ref.auth_claim.non_rev_proof.proof = userAuthClaimNonRevProof.value;

    request.ref.auth_claim.issuer_id = malloc<IDENId>().ref;
    request.ref.auth_claim.non_rev_proof.tree_state =
        malloc<IDENTreeState>().ref;
    request.ref.auth_claim.signature_proof =
        malloc<IDENCircuitsBJJSignatureProof>().ref;
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
    ffi.Pointer<ffi.Char> responseValue = malloc<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    response.value = responseValue;
    res = _nativeIden3CoreLib.IDENPrepareAuthInputs(response, request, status);
    if (res == 0) {
      _consumeStatus(status, "can't prepare auth inputs");
    }

    ffi.Pointer<ffi.Char> json = response.value;
    ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    _nativeIden3CoreLib.IDENFreeMerkleTree(claimsTree);
    _nativeIden3CoreLib.IDENFreeMerkleTree(revTree);
    _nativeIden3CoreLib.IDENFreeMerkleTree(rorTree);
    _nativeIden3CoreLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeIden3CoreLib.IDENFreeBigInt(request.ref.challenge);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeIden3CoreLib.IDENFreeProof(
        request.ref.auth_claim.non_rev_proof.proof);
    _nativeIden3CoreLib.free(response.cast());

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
      CredentialDTO credential,
      String jsonLDDocument,
      String schema,
      String key,
      List<int> values,
      int operator,
      RevocationStatus? revocationStatus) {
    CredentialProofSMDTO? smtProof;
    if (credential.proofs.isNotEmpty) {
      for (var proof in credential.proofs) {
        if (proof.type == CredentialProofType.sparseMerkle) {
          smtProof = proof as CredentialProofSMDTO?;
        }
      }
    }
    if (smtProof == null) {
      return "";
    }
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    ffi.Pointer<IDENAtomicQueryMTPInputs> request =
        malloc<IDENAtomicQueryMTPInputs>();
    request.ref.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int res = 0;
    // QUERY - ALL GOOD
    String claimType = credential.credentialSchema.type;
    request.ref.query.slot_index = _getFieldSlotIndex(schema, claimType, key);
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuesPtr =
        malloc<ffi.Pointer<IDENBigInt>>(values.length);
    for (int i = 0; i < values.length; i++) {
      ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
          malloc<ffi.Pointer<IDENBigInt>>();
      int value = values[i];
      ffi.Pointer<ffi.Char> unsafePointerValue =
          value.toString().toNativeUtf8().cast<ffi.Char>();
      res = _nativeIden3CoreLib.IDENBigIntFromString(
          valuePtr, unsafePointerValue, status);
      if (res == 0) {
        _consumeStatus(status, "");
        return "";
      }
      valuesPtr[i] = valuePtr.value;
    }
    request.ref.query.values = valuesPtr;
    request.ref.query.values_num = values.length;
    request.ref.query.operator1 = operator;
    if (kDebugMode) {
      print("query after free: ${request.ref.query.slot_index}");
    }

    // CHALLENGE - ALL GOOD
    ffi.Pointer<ffi.Char> unsafePointerChallenge =
        challenge.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> challengePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        challengePointer, unsafePointerChallenge, status);
    request.ref.challenge = challengePointer.value;

    // ID - ALL GOOD
    String userRevNonce = "15930428023331155902";

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

    ffi.Pointer<ffi.Char> unsafePointerUserRevNonce =
        userRevNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> userRevNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        userRevNonceBigInt, unsafePointerUserRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> userRevNonceHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        userRevNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> nonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
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
    res = _nativeIden3CoreLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash,
        ffi.nullptr, request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claim");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> proof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
        proof, userAuthClaimsTree.value, userAuthClaimIndexHash.ref, status);
    if (res == 0) {
      _consumeStatus(status, "error generating user auth claim's proof");
      return "";
    }
    if (kDebugMode) {
      print("proof existence: ${proof[0].ref.existence}");
    }
    request.ref.auth_claim.proof = proof[0];

    request.ref.claim.core_claim = _parseClaim(jsonLDDocument, schema)!;

    // Generate revocation status proof
    ffi.Pointer<IDENMerkleTreeHash> revNonceHash = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        revNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    request.ref.auth_claim.issuer_id = malloc<IDENId>().ref;
    request.ref.auth_claim.signature_proof =
        malloc<IDENCircuitsBJJSignatureProof>().ref;
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

    request.ref.claim.signature_proof =
        malloc<IDENCircuitsBJJSignatureProof>().ref;
    request.ref.claim.signature_proof.issuer_id = malloc<IDENId>().ref;
    for (var i = 0; i < 64; i++) {
      request.ref.claim.signature_proof.signature.data[i] = 0;
    }
    request.ref.claim.signature_proof.issuer_tree_state =
        malloc<IDENTreeState>().ref;
    request.ref.claim.signature_proof.issuer_auth_claim = ffi.nullptr;
    request.ref.claim.signature_proof.issuer_auth_claim_mtp = ffi.nullptr;
    request.ref.claim.signature_proof.issuer_auth_non_rev_proof =
        malloc<IDENRevocationStatus>().ref;
    request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state =
        malloc<IDENTreeState>().ref;
    request.ref.claim.signature_proof.issuer_auth_non_rev_proof.proof =
        ffi.nullptr;

    // Claim MTP
    ffi.Pointer<IDENProof> claimMTP = malloc<IDENProof>();
    claimMTP.ref.existence = smtProof.mtp.existence;
    if (smtProof.mtp.siblings.isNotEmpty) {
      claimMTP.ref.siblings =
          malloc<ffi.Pointer<ffi.UnsignedChar>>(smtProof.mtp.siblings.length);
      for (int i = 0; i < smtProof.mtp.siblings.length; i++) {
        claimMTP.ref.siblings[i] = malloc<ffi.UnsignedChar>(64);
        // Fill siblings
        res = _fillDataSibling(
            claimMTP.ref.siblings[i], smtProof.mtp.siblings[i], status);
        assert(res == 1);
      }
      claimMTP.ref.siblings_num = smtProof.mtp.siblings.length;
    } else {
      claimMTP.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>();
      claimMTP.ref.siblings_num = 0;
    }
    claimMTP.ref.auxNodeKey = ffi.nullptr;
    claimMTP.ref.auxNodeValue = ffi.nullptr;

    request.ref.claim.proof = claimMTP;

    // Claim state
    ffi.Pointer<IDENTreeState> issuerState = malloc<IDENTreeState>();

    CredentialProofIssuerStateSMDTO smtProofIssuerState =
        smtProof.issuer.state as CredentialProofIssuerStateSMDTO;

    List<int> issuerProofClaimsTreeRootBytes =
        hexToBytes(smtProofIssuerState.treeRoot);
    for (var i = 0; i < issuerProofClaimsTreeRootBytes.length; i++) {
      issuerState.ref.claims_root.data[i] = issuerProofClaimsTreeRootBytes[i];
    }
    List<int> issuerProofStateBytes = hexToBytes(smtProofIssuerState.value);
    for (var i = 0; i < issuerProofStateBytes.length; i++) {
      issuerState.ref.state.data[i] = issuerProofStateBytes[i];
    }
    List<int> issuerProofRootRootsBytes = hexToBytes(smtProofIssuerState.root);
    for (var i = 0; i < issuerProofRootRootsBytes.length; i++) {
      issuerState.ref.root_of_roots.data[i] = issuerProofRootRootsBytes[i];
    }
    List<int> issuerProofRevRootBytes =
        hexToBytes(smtProofIssuerState.revocationTree);
    for (var i = 0; i < issuerProofRevRootBytes.length; i++) {
      issuerState.ref.revocation_root.data[i] = issuerProofRevRootBytes[i];
    }

    request.ref.claim.tree_state = issuerState.ref;

    // Claim issuer
    // Issuer ID
    ffi.Pointer<IDENId> issuerIdPtr = _getIdFromString(smtProof.issuer.id);
    request.ref.claim.issuer_id = issuerIdPtr.ref;

    request.ref.claim.non_rev_proof.tree_state = malloc<IDENTreeState>().ref;
    if (revocationStatus != null) {
      List<int> issuerClaimsRevStatusTreeRootBytes =
          hexToBytes(revocationStatus.issuer!.claimsTreeRoot!);
      for (var i = 0; i < issuerClaimsRevStatusTreeRootBytes.length; i++) {
        request.ref.claim.non_rev_proof.tree_state.claims_root.data[i] =
            issuerClaimsRevStatusTreeRootBytes[i];
      }
      List<int> issuerRevStatusStateBytes =
          hexToBytes(revocationStatus.issuer!.state!);
      for (var i = 0; i < issuerRevStatusStateBytes.length; i++) {
        request.ref.claim.non_rev_proof.tree_state.state.data[i] =
            issuerRevStatusStateBytes[i];
      }

      List<int> issuerRevStatusRevRootBytes =
          hexToBytes(revocationStatus.issuer!.revocationTreeRoot!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.non_rev_proof.tree_state.revocation_root.data[i] =
            issuerRevStatusRevRootBytes[i];
      }

      List<int> issuerRevStatusRevRoRBytes =
          hexToBytes(revocationStatus.issuer!.rootOfRoots!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.non_rev_proof.tree_state.root_of_roots.data[i] =
            issuerRevStatusRevRoRBytes[i];
      }
    }

    // claim revocation status proof
    ffi.Pointer<IDENProof> claimNonRevProof = malloc<IDENProof>();
    claimNonRevProof.ref.existence =
        revocationStatus != null ? revocationStatus.mtp!.existence! : false;
    if (revocationStatus != null &&
        revocationStatus.mtp!.siblings != null &&
        revocationStatus.mtp!.siblings!.isNotEmpty) {
      claimNonRevProof.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>(
          revocationStatus.mtp!.siblings!.length);
      for (int i = 0; i < revocationStatus.mtp!.siblings!.length; i++) {
        claimNonRevProof.ref.siblings[i] = malloc<ffi.UnsignedChar>(64);
        // Fill siblings
        res = _fillDataSibling(claimNonRevProof.ref.siblings[i],
            revocationStatus.mtp!.siblings![i], status);
        assert(res == 1);
      }
      claimNonRevProof.ref.siblings_num =
          revocationStatus.mtp!.siblings!.length;
    } else {
      claimNonRevProof.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>();
      claimNonRevProof.ref.siblings_num = 0;
    }
    claimNonRevProof.ref.auxNodeKey = ffi.nullptr;
    claimNonRevProof.ref.auxNodeValue = ffi.nullptr;

    if (revocationStatus != null &&
        revocationStatus.mtp != null &&
        revocationStatus.mtp!.nodeAux != null) {
      // ffi.Pointer<ffi.UnsignedChar> unsafePointerNodeAuxKey =
      // revocationStatus.mtp!.nodeAux!.key!.toString().toNativeUtf8().cast<ffi.UnsignedChar>();
      // ffi.Pointer<ffi.Pointer<IDENBigInt>> nodeAuxKeyInt = malloc<ffi.Pointer<IDENBigInt>>();
      // res =
      //     _nativeLib.IDENBigIntFromString(nodeAuxKeyInt, unsafePointerNodeAuxKey, status);
      // if (res == 0) {
      //   _consumeStatus(status, "");
      // }
      // claimNonRevProof.ref.auxNodeKey = unsafePointerNodeAuxKey;
      //
      // ffi.Pointer<ffi.UnsignedChar> unsafePointerNodeAuxValue =
      // revocationStatus.mtp!.nodeAux!.value!.toString().toNativeUtf8().cast<ffi.UnsignedChar>();
      // ffi.Pointer<ffi.Pointer<IDENBigInt>> nodeAuxValueInt = malloc<ffi.Pointer<IDENBigInt>>();
      // res =
      //     _nativeLib.IDENBigIntFromString(nodeAuxValueInt, unsafePointerNodeAuxValue, status);
      // if (res == 0) {
      //   _consumeStatus(status, "");
      // }

      // claimNonRevProof.ref.auxNodeValue = unsafePointerNodeAuxValue;

      // ffi.Pointer<Utf8> auxNodeKeyBytes = revocationStatus.mtp!.nodeAux!.key!.toString().toNativeUtf8();
      // if (auxNodeKeyBytes.length > 0) {
      //   claimNonRevProof.ref.auxNodeKey = malloc<ffi.Uint8>(auxNodeKeyBytes.length) as ffi.Pointer<ffi.UnsignedChar>;
      //   for (int i = 0; i < auxNodeKeyBytes.length; i++) {
      //     claimNonRevProof.ref.auxNodeKey[i] = auxNodeKeyBytes[i];
      //   }
      // }
      //
      // ffi.Pointer<Utf8> auxNodeValueBytes = revocationStatus.mtp!.nodeAux!.value!.toString().toNativeUtf8();
      // if (auxNodeValueBytes.length > 0) {
      //   claimNonRevProof.ref.auxNodeKey = malloc<ffi.Uint8>(auxNodeValueBytes.length) as ffi.Pointer<ffi.UnsignedChar>;
      //   for (int i = 0; i < auxNodeValueBytes.length; i++) {
      //     claimNonRevProof.ref.auxNodeValue[i] = auxNodeValueBytes[i];
      //   }
      // }
      claimNonRevProof.ref.auxNodeKey = malloc<ffi.UnsignedChar>(32);
      claimNonRevProof.ref.auxNodeValue = malloc<ffi.UnsignedChar>(32);
      res = _fillAux(claimNonRevProof.ref.auxNodeKey,
          revocationStatus.mtp!.nodeAux!.key!, status);
      assert(res == 1);

      res = _fillAux(claimNonRevProof.ref.auxNodeValue,
          revocationStatus.mtp!.nodeAux!.value!, status);
      assert(res == 1);
    }

    request.ref.claim.non_rev_proof.proof = claimNonRevProof;

    // RESULT
    String result = "";
    if (kDebugMode) {
      print("/// RESULT");
    }

    ffi.Pointer<ffi.Char> responseValue = malloc<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    response.value = responseValue;
    res = _nativeIden3CoreLib.IDENPrepareAtomicQueryMTPInputs(
        response, request, status);
    if (res == 0) {
      _consumeStatus(status, "can't prepare atomic query MTP inputs");
    }

    ffi.Pointer<ffi.Char> json = response.value;
    ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    _nativeIden3CoreLib.IDENFreeBigInt(request.ref.challenge);
    if (request.ref.query.values_num > 0) {
      for (int i = 0; i < request.ref.query.values_num; i++) {
        _nativeIden3CoreLib.IDENFreeBigInt(request.ref.query.values[i]);
      }
    }
    _nativeIden3CoreLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    // _nativeLib.IDENFreeClaim(issuerAuthClaim.value);
    _nativeIden3CoreLib.IDENFreeMerkleTree(userAuthClaimsTree.value);
    // _nativeLib.IDENFreeMerkleTree(issuerAuthClaimsTree.value);
    // _nativeLib.IDENFreeMerkleTree(issuerRevTree);
    _nativeIden3CoreLib.IDENFreeMerkleTree(emptyTree);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.claim.proof);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.claim.non_rev_proof.proof);
    _nativeIden3CoreLib.IDENFreeProof(
        request.ref.auth_claim.non_rev_proof.proof);
    _nativeIden3CoreLib.free(response.cast());

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
      CredentialDTO credential,
      String jsonLDDocument,
      String schema,
      String key,
      List<int> values,
      int operator,
      RevocationStatus? revocationStatus) {
    CredentialProofBJJDTO? signatureProof;
    if (credential.proofs.isNotEmpty) {
      for (var proof in credential.proofs) {
        if (proof.type == CredentialProofType.bjj) {
          signatureProof = proof as CredentialProofBJJDTO?;
        }
      }
    }
    if (signatureProof == null) {
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    ffi.Pointer<IDENAtomicQuerySigInputs> request =
        malloc<IDENAtomicQuerySigInputs>();
    request.ref.current_timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int res = 0;
    // QUERY - ALL GOOD
    String claimType = credential.credentialSchema.type;
    request.ref.query.slot_index = _getFieldSlotIndex(schema, claimType, key);
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuesPtr =
        malloc<ffi.Pointer<IDENBigInt>>(values.length);
    for (int i = 0; i < values.length; i++) {
      ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
          malloc<ffi.Pointer<IDENBigInt>>();
      int value = values[i];
      ffi.Pointer<ffi.Char> unsafePointerValue =
          value.toString().toNativeUtf8().cast<ffi.Char>();
      res = _nativeIden3CoreLib.IDENBigIntFromString(
          valuePtr, unsafePointerValue, status);
      if (res == 0) {
        _consumeStatus(status, "");
      }
      valuesPtr[i] = valuePtr.value;
    }
    request.ref.query.values = valuesPtr;
    request.ref.query.values_num = values.length;
    request.ref.query.operator1 = operator;
    if (kDebugMode) {
      print("query after free: ${request.ref.query.slot_index}");
    }

    // CHALLENGE - ALL GOOD
    ffi.Pointer<ffi.Char> unsafePointerChallenge =
        challenge.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<IDENBigInt> challengeValue = malloc<IDENBigInt>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> challengePointer =
        malloc<ffi.Pointer<IDENBigInt>>();
    challengePointer.value = challengeValue;
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        challengePointer, unsafePointerChallenge, status);
    if (res == 0) {
      _consumeStatus(status, "can't convert BigInt from String");
    }
    request.ref.challenge = challengePointer.value;

    String userAuthClaimRevNonce = "15930428023331155902";

    // ID - ALL GOOD
    ffi.Pointer<IDENId> id = malloc<IDENId>();
    ffi.Pointer<ffi.Pointer<IDENClaim>> authClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENMerkleTree>> userClaimsTree =
        malloc<ffi.Pointer<IDENMerkleTree>>();
    res = _generateIdentity(
        id, authClaim, userClaimsTree, pubX, pubY, userAuthClaimRevNonce);
    assert(res == 0);

    var idString = "";
    for (int i = 0; i < 31; i++) {
      idString = idString + id.ref.data[i].toRadixString(16).padLeft(2, '0');
    }
    if (kDebugMode) {
      print(idString);
    }

    request.ref.id = id.ref;
    request.ref.auth_claim.core_claim = authClaim.value;

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimIndexHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENClaimTreeEntryHash(userAuthClaimIndexHash,
        ffi.nullptr, request.ref.auth_claim.core_claim, status);
    if (res == 0) {
      _consumeStatus(
          status, "error calculating index hash of user's auth claim");
      return "";
    }

    // AUTH CLAIM
    ffi.Pointer<ffi.Pointer<IDENProof>> authClaimProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(authClaimProof,
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

    ffi.Pointer<ffi.Char> unsafePointerUserRevNonce =
        userAuthClaimRevNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> userRevNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        userRevNonceBigInt, unsafePointerUserRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<IDENMerkleTreeHash> userAuthClaimRevNonceHash =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        userAuthClaimRevNonceHash, userRevNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return "";
    }

    ffi.Pointer<ffi.Pointer<IDENProof>> nonRevProof =
        malloc<ffi.Pointer<IDENProof>>();
    res = _nativeIden3CoreLib.IDENMerkleTreeGenerateProof(
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

    // CLAIM
    request.ref.claim.signature_proof =
        malloc<IDENCircuitsBJJSignatureProof>().ref;

    // CLAIM ISSUER ID
    ffi.Pointer<IDENId> issuerIdPtr =
        _getIdFromString(signatureProof.issuer.id);
    //debugger();

    request.ref.claim.signature_proof.issuer_id = issuerIdPtr.ref;

    // CLAIM SIGNATURE

    List<int> claimSignature = hexToBytes(signatureProof.signature);
    for (var i = 0; i < 64; i++) {
      request.ref.claim.signature_proof.signature.data[i] = claimSignature[i];
    }

    // CLAIM ISSUER STATE
    request.ref.claim.issuer_id = issuerIdPtr.ref;
    request.ref.claim.signature_proof.issuer_tree_state =
        malloc<IDENTreeState>().ref;

    CredentialProofIssuerStateDTO sigProofIssuerState =
        signatureProof.issuer.state; //as CredentialProofIssuerStateDTO;
    List<int> issuerClaimsTreeRootBytes =
        hexToBytes(sigProofIssuerState.treeRoot);
    for (var i = 0; i < issuerClaimsTreeRootBytes.length; i++) {
      request.ref.claim.signature_proof.issuer_tree_state.claims_root.data[i] =
          issuerClaimsTreeRootBytes[i];
    }
    List<int> issuerStateBytes = hexToBytes(sigProofIssuerState.value);
    for (var i = 0; i < issuerStateBytes.length; i++) {
      request.ref.claim.signature_proof.issuer_tree_state.state.data[i] =
          issuerStateBytes[i];
    }

    List<int> issuerRoRBytes =
        hexToBytesOrZero(null); //sigProofIssuerState.root);
    for (var i = 0; i < 32; i++) {
      request.ref.claim.signature_proof.issuer_tree_state.root_of_roots
          .data[i] = issuerRoRBytes[i];
    }

    List<int> issuerRevRBytes =
        hexToBytesOrZero(null); //sigProofIssuerState.revocationTree);
    for (var i = 0; i < 32; i++) {
      request.ref.claim.signature_proof.issuer_tree_state.revocation_root
          .data[i] = issuerRevRBytes[i];
    }

    // ISSUER AUTH CLAIM
    ffi.Pointer<ffi.Pointer<IDENClaim>> issuerAuthClaim =
        malloc<ffi.Pointer<IDENClaim>>();
    CredentialProofIssuerBJJDTO sigProofIssuer =
        signatureProof.issuer as CredentialProofIssuerBJJDTO;
    String proofIssuerAuthClaim = json.encode(sigProofIssuer.authClaim);
    ffi.Pointer<ffi.Char> unsafePointerIssuerAuthClaim =
        proofIssuerAuthClaim.toNativeUtf8().cast<ffi.Char>();
    res = _nativeIden3CoreLib.IDENNewClaimFromJSON(
        issuerAuthClaim, unsafePointerIssuerAuthClaim, status);
    if (res == 0) {
      _consumeStatus(status, "error getting issuer's auth claim");
      //retVal = 1;
      return "";
    }
    request.ref.claim.signature_proof.issuer_auth_claim = issuerAuthClaim.value;
    //debugger();
    ffi.Pointer<IDENProof> issuerAuthClaimMTP = malloc<IDENProof>();
    issuerAuthClaimMTP.ref.existence = sigProofIssuer.mtp.existence;
    if (sigProofIssuer.mtp.siblings.isNotEmpty) {
      issuerAuthClaimMTP.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>(
          sigProofIssuer.mtp.siblings.length);
      for (int i = 0; i < sigProofIssuer.mtp.siblings.length; i++) {
        issuerAuthClaimMTP.ref.siblings[i] = malloc<ffi.UnsignedChar>(64);
        // Fill siblings
        res = _fillDataSibling(issuerAuthClaimMTP.ref.siblings[i],
            sigProofIssuer.mtp.siblings[i], status);
        assert(res == 1);
      }
      issuerAuthClaimMTP.ref.siblings_num = sigProofIssuer.mtp.siblings.length;
    } else {
      issuerAuthClaimMTP.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>();
      issuerAuthClaimMTP.ref.siblings_num = 0;
    }

    issuerAuthClaimMTP.ref.auxNodeKey = ffi.nullptr;
    issuerAuthClaimMTP.ref.auxNodeValue = ffi.nullptr;

    if (revocationStatus != null &&
        revocationStatus.mtp != null &&
        revocationStatus.mtp!.nodeAux != null) {
      // ffi.Pointer<ffi.UnsignedChar> unsafePointerNodeAuxKey = revocationStatus
      //    .mtp!.nodeAux!.key!
      //    .toString()
      //    .toNativeUtf8()
      //    .cast<ffi.UnsignedChar>();
      // ffi.Pointer<ffi.Pointer<IDENBigInt>> nodeAuxKeyInt = malloc<ffi.Pointer<IDENBigInt>>();
      // res =
      //     _nativeLib.IDENBigIntFromString(nodeAuxKeyInt, unsafePointerNodeAuxKey, status);
      // if (res == 0) {
      //   _consumeStatus(status, "");
      // }
      // issuerAuthClaimMTP.ref.auxNodeKey = unsafePointerNodeAuxKey;
      //
      // ffi.Pointer<ffi.UnsignedChar> unsafePointerNodeAuxValue =
      // revocationStatus.mtp!.nodeAux!.value!.toString().toNativeUtf8().cast<ffi.UnsignedChar>();
      // ffi.Pointer<ffi.Pointer<IDENBigInt>> nodeAuxValueInt = malloc<ffi.Pointer<IDENBigInt>>();
      // res =
      //     _nativeLib.IDENBigIntFromString(nodeAuxValueInt, unsafePointerNodeAuxValue, status);
      // if (res == 0) {
      //   _consumeStatus(status, "");
      // }
      // issuerAuthClaimMTP.ref.auxNodeValue = unsafePointerNodeAuxValue;
      issuerAuthClaimMTP.ref.auxNodeKey = malloc<ffi.UnsignedChar>(64);
      issuerAuthClaimMTP.ref.auxNodeValue = malloc<ffi.UnsignedChar>(64);

      res = _fillAux(issuerAuthClaimMTP.ref.auxNodeKey,
          revocationStatus.mtp!.nodeAux!.key!, status);
      assert(res == 1);
      res = _fillAux(issuerAuthClaimMTP.ref.auxNodeValue,
          revocationStatus.mtp!.nodeAux!.value!, status);
      assert(res == 1);
    }

    request.ref.claim.signature_proof.issuer_auth_claim_mtp =
        issuerAuthClaimMTP;

    // ISSUER CLAIM REV STATUS STATE
    request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state =
        malloc<IDENTreeState>().ref;
    if (revocationStatus != null) {
      List<int> issuerAuthClaimsRevStatusTreeRootBytes =
          hexToBytes(revocationStatus.issuer!.claimsTreeRoot!);
      for (var i = 0; i < issuerAuthClaimsRevStatusTreeRootBytes.length; i++) {
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state
            .claims_root.data[i] = issuerAuthClaimsRevStatusTreeRootBytes[i];
      }
      List<int> issuerAuthRevStatusStateBytes =
          hexToBytesOrZero(revocationStatus.issuer!.state!);
      for (var i = 0; i < issuerAuthRevStatusStateBytes.length; i++) {
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state
            .state.data[i] = issuerAuthRevStatusStateBytes[i];
      }

      List<int> issuerRevStatusRoRBytes =
          hexToBytes(revocationStatus.issuer!.rootOfRoots!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state
            .root_of_roots.data[i] = issuerRevStatusRoRBytes[i];
      }
      List<int> authRevStatusRevRootBytes =
          hexToBytes(revocationStatus.issuer!.revocationTreeRoot!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.tree_state
            .revocation_root.data[i] = authRevStatusRevRootBytes[i];
      }

      //TODO: review
      request.ref.claim.signature_proof.issuer_auth_non_rev_proof.proof =
          _parseMTPjson(jsonEncode(revocationStatus.mtp?.toJson()))!;
    }

    request.ref.claim.core_claim = _parseClaim(jsonLDDocument, schema)!;

    request.ref.claim.tree_state = malloc<IDENTreeState>().ref;
    request.ref.claim.non_rev_proof.tree_state = malloc<IDENTreeState>().ref;

    // DO NOT FILL AUTH CLAIM ISSUER_ID
    request.ref.auth_claim.issuer_id = malloc<IDENId>().ref;
    request.ref.auth_claim.signature_proof =
        malloc<IDENCircuitsBJJSignatureProof>().ref;
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

    if (kDebugMode) {
      print(revocationStatus?.toJson());
    }

    // claim revocation status should be taken from revocationStatus.
    // - first we call for revocation status on the issuer service
    // - fill non_rev_proof for claim
    request.ref.claim.non_rev_proof.tree_state = malloc<IDENTreeState>().ref;
    if (revocationStatus != null) {
      List<int> issuerClaimsRevStatusTreeRootBytes =
          hexToBytes(revocationStatus.issuer!.claimsTreeRoot!);
      for (var i = 0; i < issuerClaimsRevStatusTreeRootBytes.length; i++) {
        request.ref.claim.non_rev_proof.tree_state.claims_root.data[i] =
            issuerClaimsRevStatusTreeRootBytes[i];
      }
      List<int> issuerRevStatusStateBytes =
          hexToBytes(revocationStatus.issuer!.state!);
      for (var i = 0; i < issuerRevStatusStateBytes.length; i++) {
        request.ref.claim.non_rev_proof.tree_state.state.data[i] =
            issuerRevStatusStateBytes[i];
      }

      List<int> issuerRevStatusRevRootBytes =
          hexToBytes(revocationStatus.issuer!.revocationTreeRoot!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.non_rev_proof.tree_state.revocation_root.data[i] =
            issuerRevStatusRevRootBytes[i];
      }

      List<int> issuerRevStatusRevRoRBytes =
          hexToBytes(revocationStatus.issuer!.rootOfRoots!);
      for (var i = 0; i < 32; i++) {
        request.ref.claim.non_rev_proof.tree_state.root_of_roots.data[i] =
            issuerRevStatusRevRoRBytes[i];
      }

      // claim revocation status proof
      request.ref.claim.non_rev_proof.proof =
          _parseMTPjson(jsonEncode(revocationStatus.mtp?.toJson()))!;
    }

    request.ref.claim.proof = ffi.nullptr;
    // RESULT
    String result = "";
    if (kDebugMode) {
      print("/// RESULT");
    }
    //debugger();
    if (kDebugMode) {
      print(request.ref.id.data.toString());
    }
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    res = _nativeIden3CoreLib.IDENPrepareAtomicQuerySigInputs(
        response, request, status);
    if (res == 0) {
      _consumeStatus(status, "can't prepare atomic query Sig inputs");
    }

    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    _nativeIden3CoreLib.IDENFreeBigInt(request.ref.challenge);
    if (request.ref.query.values_num > 0) {
      for (int i = 0; i < request.ref.query.values_num; i++) {
        _nativeIden3CoreLib.IDENFreeBigInt(request.ref.query.values[i]);
      }
    }
    _nativeIden3CoreLib.IDENFreeClaim(request.ref.auth_claim.core_claim);
    _nativeIden3CoreLib.IDENFreeClaim(request.ref.claim.core_claim);
    //_nativeLib.IDENFreeClaim(issuerAuthClaim.value);
    _nativeIden3CoreLib.IDENFreeMerkleTree(userClaimsTree.value);
    //_nativeLib.IDENFreeMerkleTree(issuerClaimsTree.value);
    //_nativeLib.IDENFreeMerkleTree(issuerRevTree);
    _nativeIden3CoreLib.IDENFreeMerkleTree(emptyTree);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.claim.proof);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.auth_claim.proof);
    _nativeIden3CoreLib.IDENFreeProof(
        request.ref.auth_claim.non_rev_proof.proof);
    _nativeIden3CoreLib.IDENFreeProof(request.ref.claim.non_rev_proof.proof);
    _nativeIden3CoreLib.IDENFreeProof(
        request.ref.claim.signature_proof.issuer_auth_claim_mtp);
    _nativeIden3CoreLib.IDENFreeProof(
        request.ref.claim.signature_proof.issuer_auth_non_rev_proof.proof);
    _nativeIden3CoreLib.free(response.cast());

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
        ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
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
    _nativeIden3CoreLib.IDENFreeStatus(status.value);
    return result;
  }

  bool _makeTreeState(
      ffi.Pointer<IDENTreeState> treeState,
      ffi.Pointer<IDENMerkleTree> claimsTree,
      ffi.Pointer<IDENMerkleTree> revTree,
      ffi.Pointer<IDENMerkleTree> rorTree,
      ffi.Pointer<ffi.Pointer<IDENStatus>> status) {
    ffi.Pointer<IDENMerkleTreeHash> claimsRoot = malloc<IDENMerkleTreeHash>();
    int res =
        _nativeIden3CoreLib.IDENMerkleTreeRoot(claimsRoot, claimsTree, status);
    if (res == 0) {
      _consumeStatus(status, "claims tree root");
      return false;
    }
    treeState.ref.claims_root = claimsRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> revocationRoot =
        malloc<IDENMerkleTreeHash>();
    res =
        _nativeIden3CoreLib.IDENMerkleTreeRoot(revocationRoot, revTree, status);
    if (res == 0) {
      _consumeStatus(status, "revocation root");
      return false;
    }

    treeState.ref.revocation_root = revocationRoot.ref;

    ffi.Pointer<IDENMerkleTreeHash> rootOfRoots = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENMerkleTreeRoot(rootOfRoots, rorTree, status);
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
    res = _nativeIden3CoreLib.IDENHashOfHashes(dst, hashes, 3, status);
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

    final ffi.Pointer<ffi.UnsignedChar> unsafePointerSchemaHash =
        malloc<ffi.UnsignedChar>(schemaHash.length);
    for (int i = 0; i < schemaHash.length; i++) {
      unsafePointerSchemaHash[i] = schemaHash[i];
    }
    /*final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length);
    pointerList.setAll(0, schemaHash);*/

    int res = _nativeIden3CoreLib.IDENNewClaim(
        claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Char> unsafePointerX =
        privKeyXHex.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyX =
        malloc<ffi.Pointer<IDENBigInt>>();
    res =
        _nativeIden3CoreLib.IDENBigIntFromString(keyX, unsafePointerX, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Char> unsafePointerY =
        privKeyYHex.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> keyY =
        malloc<ffi.Pointer<IDENBigInt>>();
    res =
        _nativeIden3CoreLib.IDENBigIntFromString(keyY, unsafePointerY, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    res = _nativeIden3CoreLib.IDENClaimSetIndexDataInt(
        claim.value, keyX.value, keyY.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    ffi.Pointer<ffi.Char> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    res = _nativeIden3CoreLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "");
      return false;
    }

    _nativeIden3CoreLib.free(unsafePointerSchemaHash.cast());
    _nativeIden3CoreLib.IDENFreeBigInt(keyX.value);
    _nativeIden3CoreLib.IDENFreeBigInt(keyY.value);
    _nativeIden3CoreLib.IDENFreeBigInt(revNonceBigInt.value);
    return true;
  }

  /*ffi.Pointer<IDENClaim> _makeUserClaim(
      IDENId id, String revNonce, int slotA, int slotB, String schemaHex) {
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
    final ffi.Pointer<ffi.UnsignedChar> unsafePointerSchemaHash =
        malloc<ffi.UnsignedChar>(schemaHash.length);
    for (int i = 0; i < schemaHash.length; i++) {
      unsafePointerSchemaHash[i] = schemaHash[i];
    }
    /*final Uint8List pointerList =
        unsafePointerSchemaHash.asTypedList(schemaHash.length);
    pointerList.setAll(0, schemaHash);*/

    ffi.Pointer<ffi.Pointer<IDENClaim>> claim =
        malloc<ffi.Pointer<IDENClaim>>();
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    int res = _nativeIden3CoreLib.IDENNewClaim(
        claim, unsafePointerSchemaHash, status);
    if (res == 0) {
      _consumeStatus(status, "error creating new claim");
    }

    res = _nativeIden3CoreLib.IDENClaimSetIndexID(claim.value, id, status);
    if (res == 0) {
      _consumeStatus(status, "error setting index id to claim");
    }

    ffi.Pointer<ffi.Char> unsafePointerSlotA =
        slotA.toString().toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> slotABigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        slotABigInt, unsafePointerSlotA, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    ffi.Pointer<ffi.Char> unsafePointerSlotB =
        slotB.toString().toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> slotBBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        slotBBigInt, unsafePointerSlotB, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    ffi.Pointer<ffi.Char> unsafePointerRevNonce =
        revNonce.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> revNonceBigInt =
        malloc<ffi.Pointer<IDENBigInt>>();
    res = _nativeIden3CoreLib.IDENBigIntFromString(
        revNonceBigInt, unsafePointerRevNonce, status);
    if (res == 0) {
      _consumeStatus(status, "error creating bigInt from string");
    }

    res = _nativeIden3CoreLib.IDENClaimSetIndexDataInt(
        claim.value, slotABigInt.value, slotBBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "error setting index data int to claim");
    }

    _nativeIden3CoreLib.IDENFreeBigInt(slotABigInt.value);
    _nativeIden3CoreLib.IDENFreeBigInt(slotBBigInt.value);

    res = _nativeIden3CoreLib.IDENClaimSetRevocationNonceAsBigInt(
        claim.value, revNonceBigInt.value, status);
    if (res == 0) {
      _consumeStatus(status, "error setting revocation nonce to claim");
    }

    res = _nativeIden3CoreLib.IDENClaimSetExpirationDate(
        claim.value, 1669884010, status);
    if (res == 0) {
      _consumeStatus(status, "error setting expiration date to claim");
    }

    return claim.value;
  }*/

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
    int res = _nativeIden3CoreLib.IDENNewMerkleTree(claimsTree, 32, status);
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

    res = _nativeIden3CoreLib.IDENMerkleTreeAddClaim(
        claimsTree.value, claim.value, status);
    if (res == 0) {
      _consumeStatus(status, "can't add claim to merkle tree");
      result = 1;
      return result;
    }

    ffi.Pointer<IDENMerkleTreeHash> claimsTreeRoot =
        malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENMerkleTreeRoot(
        claimsTreeRoot, claimsTree.value, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate claim's tree root");
      result = 1;
      return result;
    }

    res = _nativeIden3CoreLib.IDENCalculateGenesisID(
        id, claimsTreeRoot.ref, status);
    if (res == 0) {
      _consumeStatus(status, "unable to calculate genesis ID");
      result = 1;
      return result;
    }

    return result;
  }

  ffi.Pointer<IDENId> _getIdFromString(String id) {
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    ffi.Pointer<IDENId> idPtr = malloc<IDENId>();
    ffi.Pointer<ffi.Char> idStr = id.toNativeUtf8().cast<ffi.Char>();
    int res = _nativeIden3CoreLib.IDENIdFromString(idPtr, idStr, status);
    if (res == 0) {
      _consumeStatus(status, "error getting id from string");
      return nullptr;
    }

    return idPtr;
  }

  String getIdFromString(String id) {
    ffi.Pointer<IDENId> idPtr = _getIdFromString(id);
    Uint8List idList = Uint8List(31);
    for (int i = 0; i < 31; i++) {
      idList[i] = idPtr.ref.data[i];
    }
    return bytesToHex(idList);
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
    int res = _nativeIden3CoreLib.IDENNewMerkleTree(mt, 40, status);
    if (res == 0 || mt == ffi.nullptr) {
      bool error = _consumeStatus(status, "error new merkle tree");
      if (error) {
        _nativeIden3CoreLib.IDENFreeMerkleTree(mt.value);
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
    if (key.isEmpty) {
      return 0;
    }
    var slotIn = 0;
    ffi.Pointer<ffi.Int> slotI =
        slotIn.toString().toNativeUtf8().cast<ffi.Int>();
    ffi.Pointer<ffi.Char> keyP = key.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> claimTypeP =
        claimType.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> schemaP = schema.toNativeUtf8().cast<ffi.Char>();
    int result = 0;
    ffi.Pointer<ffi.Pointer<IDENStatus>> status =
        malloc<ffi.Pointer<IDENStatus>>();
    int res = _nativeIden3CoreLib.IDENJsonLDGetFieldSlotIndex(
        slotI, keyP, claimTypeP, schemaP, status);
    if (res == 0) {
      _consumeStatus(status, "IDENJsonLDGetFieldSlotIndex error");
      return result;
    }
    if (kDebugMode) {
      print("slotIndex: ${slotI.value}");
    }
    result = slotI.value;
    _nativeIden3CoreLib.free(slotI.cast());
    _nativeIden3CoreLib.free(keyP.cast());
    _nativeIden3CoreLib.free(claimTypeP.cast());
    _nativeIden3CoreLib.free(schemaP.cast());
    return result;
  }

  Uint8List hexToBytesOrZero(String? s) {
    if (s == null) {
      return Uint8List.fromList([
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ]);
    }
    return hexToBytes(s);
  }

  int _fillDataSibling(ffi.Pointer<ffi.UnsignedChar> dest, String source,
      ffi.Pointer<ffi.Pointer<IDENStatus>> status) {
    ffi.Pointer<ffi.Char> unsafePointerValue =
        source.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
        malloc<ffi.Pointer<IDENBigInt>>();
    int res = _nativeIden3CoreLib.IDENBigIntFromString(
        valuePtr, unsafePointerValue, status);
    if (res == 0) {
      return res;
    }

    ffi.Pointer<IDENMerkleTreeHash> itemHash = malloc<IDENMerkleTreeHash>();
    res = _nativeIden3CoreLib.IDENHashFromBigInt(
        itemHash, valuePtr.value, status);
    if (res == 0) {
      return res;
    }

    for (int j = 0; j < 64; j++) {
      dest[j] = itemHash.ref.data[j];
    }

    // TODO: properly free memory
    _nativeIden3CoreLib.IDENFreeBigInt(valuePtr.value);
    _nativeIden3CoreLib.free(itemHash.cast());

    return 1;
  }

  int _fillAux(ffi.Pointer<ffi.UnsignedChar> dest, String source,
      ffi.Pointer<ffi.Pointer<IDENStatus>> status) {
    ffi.Pointer<ffi.Char> unsafePointerValue =
        source.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<IDENBigInt>> valuePtr =
        malloc<ffi.Pointer<IDENBigInt>>();
    int res = _nativeIden3CoreLib.IDENBigIntFromString(
        valuePtr, unsafePointerValue, status);
    if (res == 0) {
      return res;
    }

    for (int j = 0; j < 32; j++) {
      dest[j] = 0;
    }

    if (valuePtr.value.ref.data_len != 0) {
      for (int j = 0; j < valuePtr.value.ref.data_len; j++) {
        dest[j] = valuePtr.value.ref.data[j];
      }
    }

    // TODO: properly free memory
    _nativeIden3CoreLib.IDENFreeBigInt(valuePtr.value);

    return 1;
  }

  // SMT

  Hash poseidonHashHashes(List<Hash> hs) {
    if (hs.isEmpty) {
      return Hash.zero();
    }

    Pointer<Pointer<IDENBigInt>> ints = malloc<Pointer<IDENBigInt>>(hs.length);
    for (int i = 0; i < hs.length; i++) {
      ints[i] = nullptr;
    }

    Pointer<Pointer<IDENBigInt>> hash = malloc<Pointer<IDENBigInt>>();
    hash.value = nullptr;

    try {
      for (int i = 0; i < hs.length; i++) {
        final intACStr = hs[i].toBigInt().toRadixString(10).toNativeUtf8();
        try {
          int ok = _nativeIden3CoreLib.IDENBigIntFromString(
              ints.elementAt(i), intACStr.cast(), nullptr);
          if (ok != 1) {
            throw Exception("can't create IDENBigInt from int");
          }
        } finally {
          malloc.free(intACStr);
        }
      }

      int ok = _nativeIden3CoreLib.IDENHashInts(hash, hs.length, ints, nullptr);
      if (ok != 1) {
        throw Exception("can't calc hash of ints");
      }

      return _hashFromIdenBigInt(hash.value);
    } finally {
      for (int i = 0; i < hs.length; i++) {
        _nativeIden3CoreLib.IDENFreeBigInt(ints[i]);
      }
      _nativeIden3CoreLib.IDENFreeBigInt(hash.value);
    }
  }

  BigInt poseidonHashInts(List<BigInt> bis) {
    if (bis.isEmpty) {
      return BigInt.zero;
    }

    Pointer<Pointer<IDENBigInt>> ints = malloc<Pointer<IDENBigInt>>(bis.length);
    for (int i = 0; i < bis.length; i++) {
      ints[i] = nullptr;
    }

    Pointer<Pointer<IDENBigInt>> hash = malloc<Pointer<IDENBigInt>>();
    hash.value = nullptr;

    try {
      for (int i = 0; i < bis.length; i++) {
        final intACStr = bis[i].toRadixString(10).toNativeUtf8();
        try {
          int ok = _nativeIden3CoreLib.IDENBigIntFromString(
              ints.elementAt(i), intACStr.cast(), nullptr);
          if (ok != 1) {
            throw Exception("can't create IDENBigInt from int");
          }
        } finally {
          malloc.free(intACStr);
        }
      }

      int ok =
          _nativeIden3CoreLib.IDENHashInts(hash, bis.length, ints, nullptr);
      if (ok != 1) {
        throw Exception("can't calc hash of ints");
      }

      return _bigIntFromIdenBigInt(hash.value);
    } finally {
      for (int i = 0; i < bis.length; i++) {
        _nativeIden3CoreLib.IDENFreeBigInt(ints[i]);
      }
      _nativeIden3CoreLib.IDENFreeBigInt(hash.value);
    }
  }

  Hash _hashFromIdenBigInt(Pointer<IDENBigInt> v) {
    if (v.ref.data_len == 0) {
      return Hash.zero();
    }
    if (v.ref.data_len > 32) {
      throw ArgumentError("value is too big");
    }

    final h = Hash.zero();
    for (int i = 0; i < v.ref.data_len; i++) {
      h.data[i] = v.ref.data[i];
    }

    return h;
  }

  BigInt _bigIntFromIdenBigInt(Pointer<IDENBigInt> v) {
    if (v.ref.data_len == 0) {
      return BigInt.zero;
    }

    final b = BigInt.from(256);
    BigInt i = BigInt.from(0);
    for (int j = v.ref.data_len - 1; j >= 0; j--) {
      i = i * b + BigInt.from(v.ref.data[j]);
    }
    return i;
  }
}
