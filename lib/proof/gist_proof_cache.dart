import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/lib_pidcore_proof_data_source.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/web3dart.dart';

class GistProofCache {
  static final GistProofCache _instance = GistProofCache._internal();

  factory GistProofCache() {
    return _instance;
  }

  GistProofCache._internal();

  bool _hiveInitialized = false;
  static const String boxName = "gist_proof_cache";

  Future<void> _initHive(EnvEntity envEntity) async {
    String? stacktraceEncryptionKey = envEntity.stacktraceEncryptionKey;
    if (stacktraceEncryptionKey == null ||
        stacktraceEncryptionKey.isEmpty ||
        utf8.encode(stacktraceEncryptionKey).length != 32) {
      throw Exception("Invalid stacktraceEncryptionKey");
    }

    await Hive.initFlutter();
    await Hive.openBox(
      boxName,
      encryptionCipher: HiveAesCipher(utf8.encode(stacktraceEncryptionKey)),
    );

    _hiveInitialized = true;
  }

  Future<String?> _getGistProofCached({
    required String id,
    required String contractAddress,
    required EnvEntity env,
  }) async {
    if (!_hiveInitialized) {
      try {
        await _initHive(env);
      } catch (e) {
        return null;
      }
    }

    var box = Hive.box(boxName);
    Map<dynamic, dynamic> gistProofMap = box.get("$id-$contractAddress") ?? {};

    if (gistProofMap.isEmpty) {
      return null;
    }

    DateTime gistProofTimestamp = gistProofMap["timestamp"];
    DateTime cacheExpirationDiff =
        DateTime.now().subtract(const Duration(minutes: 5));
    if (gistProofTimestamp.isBefore(cacheExpirationDiff)) {
      return null;
    }

    return gistProofMap["gistProof"];
  }

  Future<void> _saveGistProof({
    required String id,
    required String contractAddress,
    required String gistProofString,
  }) async {
    if (!_hiveInitialized) {
      throw Exception("Hive not initialized");
    }
    DateTime now = DateTime.now();
    var box = Hive.box(boxName);
    box.put("$id-$contractAddress", {
      "gistProof": gistProofString,
      "timestamp": now,
    });
  }

  ContractFunction _getGistProof(DeployedContract contract) =>
      contract.function('getGISTProof');

  Future<String> getGistProof({
    required String id,
    required DeployedContract deployedContract,
    required EnvEntity envEntity,
  }) async {
    String? cachedGistProof = await _getGistProofCached(
      id: id,
      contractAddress: deployedContract.address.hex,
      env: envEntity,
    );

    if (cachedGistProof != null) {
      return cachedGistProof;
    }

    GetSelectedChainUseCase getSelectedChainUseCase =
        await getItSdk.getAsync<GetSelectedChainUseCase>();
    ChainConfigEntity chain = await getSelectedChainUseCase.execute();
    Web3Client web3Client = getItSdk.get(param1: chain.rpcUrl);
    try {
      final transactionParameters = [
        BigInt.parse(id),
      ];

      List<dynamic> result;

      result = await web3Client.call(
        contract: deployedContract,
        function: _getGistProof(deployedContract),
        params: transactionParameters,
      );

      if (result.isNotEmpty && result[0] is List && result[0].length == 8) {
        var siblings =
            (result[0][2] as List).map((bigInt) => bigInt.toString()).toList();

        final String resultString = jsonEncode({
          "root": result[0][0].toString(),
          "existence": result[0][1].toString() == "true" ? true : false,
          "siblings": siblings,
          "index": result[0][3].toString(),
          "value": result[0][4].toString(),
          "auxExistence": result[0][5].toString() == "true" ? true : false,
          "auxIndex": result[0][6].toString(),
          "auxValue": result[0][7].toString(),
        });
        var libPolygonIdProof = getItSdk<LibPolygonIdCoreProofDataSource>();
        String gistProof = libPolygonIdProof.proofFromSC(resultString);
        try {
          await _saveGistProof(
            id: id,
            contractAddress: deployedContract.address.hex,
            gistProofString: gistProof,
          );
        } catch (_) {
          // ignore
        }
        return gistProof;
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }
}
