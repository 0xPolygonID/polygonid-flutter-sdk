import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/env/sdk_env.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/http.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../credential/data/dtos/credential_dto.dart';
import '../../../credential/data/dtos/credential_proofs/credential_proof_dto.dart';
import '../../../credential/data/dtos/revocation_status.dart';
import '../../../identity/data/data_sources/remote_identity_data_source.dart';
import '../../../identity/data/dtos/rhs_node_dto.dart';
import '../../../identity/data/mappers/rhs_node_type_mapper.dart';
import '../../../identity/domain/entities/rhs_node_entity.dart';
import '../../domain/entities/circuit_data_entity.dart';
import '../../domain/exceptions/proof_generation_exceptions.dart';
import '../../domain/repositories/proof_repository.dart';
import '../data_sources/atomic_query_inputs_data_source.dart';
import '../data_sources/local_files_data_source.dart';
import '../data_sources/prover_lib_data_source.dart';
import '../data_sources/witness_data_source.dart';
import '../dtos/witness_param.dart';

enum SupportedCircuits { mtp, sig }

class ProofRepositoryImpl extends ProofRepository {
  final WitnessDataSource _witnessDataSource;
  final ProverLibDataSource _proverLibDataSource;
  final AtomicQueryInputsDataSource _atomicQueryInputsDataSource;
  final LocalFilesDataSource _localFilesDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;

  ProofRepositoryImpl(
      this._witnessDataSource,
      this._proverLibDataSource,
      this._atomicQueryInputsDataSource,
      this._localFilesDataSource,
      this._remoteIdentityDataSource);

  static const Map<SupportedCircuits, String> _supportedCircuits = {
    SupportedCircuits.mtp: "credentialAtomicQueryMTP",
    SupportedCircuits.sig: "credentialAtomicQuerySig",
  };

  @override
  Future<CircuitDataEntity> loadCircuitFiles(String circuitId) async {
    List<Uint8List> circuitFiles =
        await _localFilesDataSource.loadCircuitFiles(circuitId);
    CircuitDataEntity circuitDataEntity =
        CircuitDataEntity(circuitId, circuitFiles[0], circuitFiles[1]);
    return circuitDataEntity;
  }

  @override
  Future<Uint8List?> calculateAtomicQueryInputs(
      String challenge,
      CredentialDTO credential,
      String circuitId,
      String key,
      List<int> values,
      int operator,
      String pubX,
      String pubY,
      String? signature) async {
    // revocation status
    final RevocationStatus? claimRevocationStatus =
        await getClaimRevocationStatus(credential);

    String? res = await _atomicQueryInputsDataSource.prepareAtomicQueryInputs(
      challenge,
      credential,
      circuitId,
      key,
      values,
      operator,
      claimRevocationStatus,
      pubX,
      pubY,
      signature,
    );

    if (res != null) {
      Map<String, dynamic>? inputs = json.decode(res);
      Uint8List inputsJsonBytes =
          Uint8ArrayUtils.uint8ListfromString(json.encode(inputs));

      return inputsJsonBytes;
    }

    return null;
  }

  @override
  Future<Uint8List?> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  ) async {
    WitnessParam witnessParam =
        WitnessParam(wasm: circuitData.datFile, json: atomicQueryInputs);
    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.mtp]) {
      return await _witnessDataSource.computeWitnessMtp(witnessParam);
    }

    if (circuitData.circuitId == _supportedCircuits[SupportedCircuits.sig]) {
      return await _witnessDataSource.computeWitnessSig(witnessParam);
    }

    return null;
  }

  @override
  Future<Map<String, dynamic>?> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes) async {
    Map<String, dynamic>? proofResult =
        await _proverLibDataSource.prover(circuitData.zKeyFile, wtnsBytes);
    return proofResult;
  }

  /*{
  "issuer": {
  "state": "5cc92167f25b55ea0353da2c59d4d0c64092a82487b8afed34c2f16d11c7c922",
  "root_of_roots": "a634b555e1853c2c4fbce2a0c0ff78ca7270a932240dba725ff9f4d9f921fa0d",
  "claims_tree_root": "b4ee7657886ec464951de8877a3aaa3818c60e003212b774fa557a2a68b5302e",
  "revocation_tree_root": "0000000000000000000000000000000000000000000000000000000000000000"
  },
  "mtp": {
  "existence": false,
  "siblings": []
  }
  }*/
  Future<RevocationStatus?> getClaimRevocationStatus(CredentialDTO credential,
      {bool useRhs = true}) async {
    if (useRhs) {
      if (credential.proofs.isNotEmpty) {
        for (var proof in credential.proofs) {
          if (proof.type == CredentialProofType.bjj) {
            Map<String, dynamic> issuerNonRevProof = await nonRevProof(
                credential.revNonce,
                proof.issuer.id,
                SdkEnv().reverseHashServiceUrl);
            RevocationStatus revStatus =
                RevocationStatus.fromJson(issuerNonRevProof);
            return revStatus;
          }
        }
      }
      return null;
    } else {
      String revStatusUrl = credential.credentialStatus.id;
      var response = await get(revStatusUrl, "");
      String revStatus = (response.body);
      final RevocationStatus claimRevocationStatus =
          RevocationStatus.fromJson(json.decode(revStatus));
      return claimRevocationStatus;
    }
  }

  @override
  Future<Map<String, dynamic>> nonRevProof(
      int revNonce, String id, String rhsBaseUrl) async {
    try {
      // 1. Fetch identity latest state from the smart contract
      String idStateHash =
          await _remoteIdentityDataSource.fetchIdentityState(id: id);

      if (idStateHash == "") {
        throw GenerateNonRevProofException(idStateHash);
      }

      // 1. Fetch state roots from RHS
      RhsNodeDTO rhsNode = await _remoteIdentityDataSource.fetchStateRoots(
          url: rhsBaseUrl + idStateHash);
      RhsNodeType rhsNodeType = RhsNodeTypeMapper().mapFrom(rhsNode.node);

      Map<String, dynamic>? issuer;
      String revTreeRootHash =
          "0000000000000000000000000000000000000000000000000000000000000000";
      if (rhsNodeType == RhsNodeType.state) {
        revTreeRootHash = rhsNode.node.children[1];
        issuer = {
          "state": rhsNode.node.hash,
          "root_of_roots": rhsNode.node.children[2],
          "claims_tree_root": rhsNode.node.children[0],
          "revocation_tree_root": rhsNode.node.children[1],
        };
      }

      //2. walk rhs
      bool exists = false;
      List<String> siblings = <String>[];
      String nextKey = revTreeRootHash;
      int depth = 0;
      Uint8List key = Uint8ArrayUtils.bigIntToBytes(BigInt.from(revNonce));

      for (int depth = 0; depth < (key.length * 8); depth++) {
        if (nextKey !=
            "0000000000000000000000000000000000000000000000000000000000000000") {
          // rev root is not empty
          RhsNodeDTO revNode = await _remoteIdentityDataSource.fetchStateRoots(
              url: rhsBaseUrl + nextKey);
          RhsNodeType nodeType = RhsNodeTypeMapper().mapFrom(revNode.node);

          if (nodeType == RhsNodeType.middle) {
            if (_testBit(key, depth)) {
              nextKey = revNode.node.children[1];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[0]))
                  .toString());
            } else {
              nextKey = revNode.node.children[0];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[1]))
                  .toString());
            }
          } else if (nodeType == RhsNodeType.leaf) {
            if (Uint8ArrayUtils.leBuff2int(key) ==
                Uint8ArrayUtils.leBuff2int(
                    hexToBytes(revNode.node.children[0]))) {
              exists = true;
              return _mkProof(issuer, exists, siblings, null);
            }
            // We found a leaf whose entry didn't match hIndex
            Map<String, String> nodeAux = {
              "key": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[0]))
                  .toString(),
              "value": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[1]))
                  .toString(),
            };
            return _mkProof(issuer, exists, siblings, nodeAux);
          }
        } else {
          return _mkProof(issuer, exists, siblings, null);
        }
      }
      return _mkProof(issuer, false, <String>[], null);
    } catch (error) {
      logger().e("[NonRevProof] Error: $error");
      rethrow;
    }
  }

  // TestBit tests whether the bit n in bitmap is 1.
  bool _testBit(Uint8List byte, int n) {
    return byte[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  Map<String, dynamic> _mkProof(Map<String, dynamic>? issuer, bool exists,
      List<String> siblings, Map<String, String>? nodeAux) {
    Map<String, dynamic> result = {};

    if (issuer != null) {
      result["issuer"] = issuer;
    }

    Map<String, dynamic> mtp = {
      "existence": exists,
      "siblings": siblings,
    };
    if (nodeAux != null) {
      mtp["nodeAux"] = nodeAux;
    }
    result["mtp"] = mtp;

    return result;
  }
}
