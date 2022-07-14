import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:web3dart/crypto.dart';

import 'generated_bindings.dart';

extension IDENProofJsonParsing on IDENProof {
  static ffi.Pointer<IDENProof> fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENProof> proof = malloc<IDENProof>();
    proof.ref.existence = json['existence'];
    proof.ref.siblings_num = json['siblings_num'];
    proof.ref.siblings = malloc<ffi.Pointer<ffi.UnsignedChar>>();
    for (int i = 0; i < proof.ref.siblings_num; i++) {
      List<int> siblingBytes = hexToBytes(json['siblings'][i]);
      ffi.Pointer<ffi.UnsignedChar> child =
          malloc<ffi.UnsignedChar>(siblingBytes.length);
      for (int j = 0; j < siblingBytes.length; j++) {
        child[j] = siblingBytes[j];
      }
      proof.ref.siblings[i] = child;
    }
    /*List<int> auxNodeKeyBytes = hexToBytes(json['auxNodeKey']);
    var result = "";
    /*for (int i = 0; i < 31; i++) {
      result = result + idGenesis[i].toRadixString(16).padLeft(2, '0');
      // print(result);
    }*/
    if (auxNodeKeyBytes.length > 0) {
      proof.ref.auxNodeKey = malloc<ffi.Uint8>(auxNodeKeyBytes.length);
      for (int i = 0; i < auxNodeKeyBytes.length; i++) {
        proof.ref.auxNodeKey[i] = auxNodeKeyBytes[i];
      }
    } else {*/
    proof.ref.auxNodeKey = ffi.nullptr;
    //}
    /*List<int> auxNodeValueBytes = hexToBytes(json['auxNodeValue']);
    if (auxNodeValueBytes.length > 0) {
      proof.ref.auxNodeValue = malloc<ffi.Uint8>(auxNodeValueBytes.length);
      for (int i = 0; i < auxNodeValueBytes.length; i++) {
        proof.ref.auxNodeValue[i] = auxNodeValueBytes[i];
      }
    } else {*/
    proof.ref.auxNodeValue = ffi.nullptr;
    //}
    return proof;
  }

  Map<String, dynamic> toJson() {
    List sib = [];
    for (int i = 0; i < siblings_num; i++) {
      List<int> dataBytes = List.filled(32, 0);
      ffi.Pointer<ffi.UnsignedChar> child = siblings[i];
      for (int j = 0; j < 32; j++) {
        dataBytes[j] = child[j];
      }
      sib.add(bytesToHex(dataBytes));
    }

    List<int> auxNodeKeyBytes = List.filled(32, 0);
    if (auxNodeKey != ffi.nullptr) {
      for (int j = 0; j < 32; j++) {
        auxNodeKeyBytes[j] = auxNodeKey[j];
      }
    }

    List<int> auxNodeValueBytes = List.filled(32, 0);
    if (auxNodeValue != ffi.nullptr) {
      for (int j = 0; j < 32; j++) {
        auxNodeValueBytes[j] = auxNodeValue[j];
      }
    }
    return {
      'existence': existence,
      'siblings': sib,
      'siblings_num': siblings_num,
      'auxNodeKey': bytesToHex(auxNodeKeyBytes),
      'auxNodeValue': bytesToHex(auxNodeValueBytes),
    };
  }
}

extension IDENMerkleTreeHashJsonParsing on IDENMerkleTreeHash {
  static IDENMerkleTreeHash fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENMerkleTreeHash> hash = malloc<IDENMerkleTreeHash>();
    List<int> dataBytes = hexToBytes(json['data']);
    for (int i = 0; i < dataBytes.length; i++) {
      hash.ref.data[i] = dataBytes[i];
    }
    return hash.ref;
  }

  Map<String, dynamic> toJson() {
    List<int> dataBytes = List.filled(32, 0);
    for (int i = 0; i < 32; i++) {
      dataBytes[i] = data[i];
    }
    return {'data': bytesToHex(dataBytes)};
  }
}

extension IDENIdJsonParsing on IDENId {
  static IDENId fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENId> idenId = malloc<IDENId>();
    List<int> dataBytes = hexToBytes(json['data']);
    for (int i = 0; i < dataBytes.length; i++) {
      idenId.ref.data[i] = dataBytes[i];
    }
    return idenId.ref;
  }

  Map<String, dynamic> toJson() {
    List<int> dataBytes = List.filled(31, 0);
    for (int i = 0; i < 31; i++) {
      dataBytes[i] = data[i];
    }
    return {'data': bytesToHex(dataBytes)};
  }
}

extension IDENBJJSignatureJsonParsing on IDENBJJSignature {
  static IDENBJJSignature fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENBJJSignature> bjjSignature = malloc<IDENBJJSignature>();
    List<int> dataBytes = hexToBytes(json['data']);
    for (int i = 0; i < dataBytes.length; i++) {
      bjjSignature.ref.data[i] = dataBytes[i];
    }
    return bjjSignature.ref;
  }

  Map<String, dynamic> toJson() {
    List<int> dataBytes = List.filled(31, 0);
    for (int i = 0; i < 31; i++) {
      dataBytes[i] = data[i];
    }
    return {'data': bytesToHex(dataBytes)};
  }
}

extension IDENTreeStateJsonParsing on IDENTreeState {
  static IDENTreeState fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENTreeState> treeState = malloc<IDENTreeState>();
    treeState.ref.state = IDENMerkleTreeHashJsonParsing.fromJson(json['state']);
    treeState.ref.claims_root =
        IDENMerkleTreeHashJsonParsing.fromJson(json['claims_root']);
    treeState.ref.revocation_root =
        IDENMerkleTreeHashJsonParsing.fromJson(json['revocation_root']);
    treeState.ref.root_of_roots =
        IDENMerkleTreeHashJsonParsing.fromJson(json['root_of_roots']);
    return treeState.ref;
  }

  Map<String, dynamic> toJson() => {
        'state': state.toJson(),
        'claims_root': claims_root.toJson(),
        'revocation_root': revocation_root.toJson(),
        'root_of_roots': root_of_roots.toJson()
      };
}

extension IDENRevocationStatusJsonParsing on IDENRevocationStatus {
  static IDENRevocationStatus fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENRevocationStatus> revocationStatus =
        malloc<IDENRevocationStatus>();
    revocationStatus.ref.tree_state =
        IDENTreeStateJsonParsing.fromJson(json['tree_state']);
    revocationStatus.ref.proof = IDENProofJsonParsing.fromJson(json['proof']);
    return revocationStatus.ref;
  }

  Map<String, dynamic> toJson() => {
        'tree_state': tree_state.toJson(),
        'proof': proof != ffi.nullptr ? proof.ref.toJson() : "",
      };
}

extension IDENBCircuitsBJJSignatureProofJsonParsing
    on IDENBCircuitsBJJSignatureProof {
  static IDENBCircuitsBJJSignatureProof fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENBCircuitsBJJSignatureProof> bjjSignatureProof =
        malloc<IDENBCircuitsBJJSignatureProof>();
    bjjSignatureProof.ref.issuer_id =
        IDENIdJsonParsing.fromJson(json['issuer_id']);
    bjjSignatureProof.ref.signature =
        IDENBJJSignatureJsonParsing.fromJson(json['signature']);
    bjjSignatureProof.ref.issuer_tree_state =
        IDENTreeStateJsonParsing.fromJson(json['issuer_tree_state']);
    bjjSignatureProof.ref.issuer_auth_claim =
        IDENClaimJsonParsing.fromJson(json['issuer_auth_claim']);
    bjjSignatureProof.ref.issuer_auth_claim_mtp =
        IDENProofJsonParsing.fromJson(json['issuer_auth_claim_mtp']);
    bjjSignatureProof.ref.issuer_auth_non_rev_proof =
        IDENRevocationStatusJsonParsing.fromJson(
            json['issuer_auth_non_rev_proof']);
    return bjjSignatureProof.ref;
  }

  Map<String, dynamic> toJson() => {
        'issuer_id': issuer_id.toJson(),
        'signature': signature.toJson(),
        'issuer_tree_state': issuer_tree_state.toJson(),
        'issuer_auth_claim': issuer_auth_claim != ffi.nullptr
            ? issuer_auth_claim.ref.toJson()
            : "",
        'issuer_auth_claim_mtp': issuer_auth_claim_mtp != ffi.nullptr
            ? issuer_auth_claim_mtp.ref.toJson()
            : "",
        'issuer_auth_non_rev_proof': issuer_auth_non_rev_proof.toJson(),
      };
}

extension IDENCircuitsClaimJsonParsing on IDENCircuitClaim {
  static IDENCircuitClaim fromJson(Map<String, dynamic> json) {
    ffi.Pointer<IDENCircuitClaim> claim = malloc<IDENCircuitClaim>();
    claim.ref.core_claim = IDENClaimJsonParsing.fromJson(json['core_claim']);
    claim.ref.tree_state =
        IDENTreeStateJsonParsing.fromJson(json['tree_state']);
    claim.ref.issuer_id = IDENIdJsonParsing.fromJson(json['issuer_id']);
    claim.ref.proof = IDENProofJsonParsing.fromJson(json['proof']);
    claim.ref.non_rev_proof =
        IDENRevocationStatusJsonParsing.fromJson(json['non_rev_proof']);
    claim.ref.signature_proof =
        IDENBCircuitsBJJSignatureProofJsonParsing.fromJson(
            json['signature_proof']);
    return claim.ref;
  }

  Map<String, dynamic> toJson() => {
        'core_claim': core_claim.ref.toJson(),
        'tree_state': tree_state.toJson(),
        'issuer_id': issuer_id.toJson(),
        'proof': proof.ref.toJson(),
        'non_rev_proof': non_rev_proof.toJson(),
        'signature_proof': signature_proof.toJson(),
      };
}

extension IDENClaimJsonParsing on IDENClaim {
  static ffi.Pointer<IDENClaim> fromJson(Map<String, dynamic> json) {
    // TODO pubX, pubY, revNonce
    ffi.Pointer<IDENClaim> claim = malloc<IDENClaim>();
    claim.ref.handle = json['handle'];
    return claim;
  }

  Map<String, dynamic> toJson() => {
        // TODO pubX, pubY, revNonce
        'handle': handle,
      };
}
