import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';

import '../iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import '../proof/domain/entities/circuit_data_entity.dart';

abstract class PolygonIdSdkProof {
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
        required ClaimEntity claim,
        required CircuitDataEntity circuitData,
        required ProofScopeRequest request,
        String? privateKey,
        String? challenge});
}

@injectable
class Proof implements PolygonIdSdkProof {
  final GenerateProofUseCase _proveUseCase;

  Proof(
    this._proveUseCase,
  );

  @override
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge}) {
    return _proveUseCase.execute(
        param: GenerateProofParam(
            did, profileNonce ?? 0, 0, claim, request, circuitData, privateKey, challenge));
  }

  Future<void> initFilesDownloadedFromServer() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fileName = 'circuits.zip';
    const bucketUrl =
        "https://iden3-circuits-bucket.s3.eu-west-1.amazonaws.com/circuits/v0.2.0-beta/polygonid-keys-2.0.0.zip";

    if (!(await _hasToDownloadAssets(fileName, path))) {
      return;
    }
    var zippedFile = await _downloadFile(
      bucketUrl,
      fileName,
      path,
    );

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    for (var file in archive) {
      var filename = '$path/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  Future<File> _downloadFile(String url, String filename, String path) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$path/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  Future<bool> _hasToDownloadAssets(String name, String path) async {
    var file = File('$path/$name');
    return !(await file.exists());
  }
}
