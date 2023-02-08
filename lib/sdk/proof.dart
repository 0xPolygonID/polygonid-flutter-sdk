import 'dart:async';
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
        param: GenerateProofParam(did, profileNonce ?? 0, 0, claim, request,
            circuitData, privateKey, challenge));
  }

  Future<void> initDownloadCircuitsFromServer() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fileName = 'circuits.zip';
    const bucketUrl =
        "https://iden3-circuits-bucket.s3.eu-west-1.amazonaws.com/circuits/v0.2.0-beta/polygonid-keys-2.0.0.zip";

    if (!(await hasToDownloadCircuitsFromServer())) {
      _downloadInfoController.add(DownloadInfo(
        contentLength: 0,
        downloaded: 0,
        completed: true,
      ));
      return;
    }

    var request = http.Request('GET', Uri.parse(bucketUrl));
    final http.StreamedResponse response = await http.Client().send(request);
    final int? contentLength = response.contentLength;
    List<int> bytes = [];

    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        _downloadInfoController.add(DownloadInfo(
          contentLength: contentLength ?? 0,
          downloaded: bytes.length,
        ));
      },
      onDone: () async {
        var file = File('$path/$fileName');
        file.writeAsBytes(bytes);
        _downloadInfoController.add(DownloadInfo(
          contentLength: contentLength ?? 0,
          downloaded: bytes.length,
          completed: true,
        ));
        var archive = ZipDecoder().decodeBytes(bytes);

        for (var file in archive) {
          var filename = '$path/${file.name}';
          if (file.isFile) {
            var outFile = File(filename);
            outFile = await outFile.create(recursive: true);
            await outFile.writeAsBytes(file.content);
          }
        }
      },
      onError: (e) {
        throw Exception();
      },
      cancelOnError: true,
    );
  }

  ///
  Future<bool> hasToDownloadCircuitsFromServer() async {
    String fileName = 'circuits.zip';
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    var file = File('$path/$fileName');
    return !(await file.exists());
  }

  ///
  StreamController<DownloadInfo> _downloadInfoController =
      StreamController.broadcast();

  ///
  Stream<DownloadInfo> get downloadInfoStream => _downloadInfoController.stream;

  ///
  void disposeDownloadInfoController() {
    _downloadInfoController.close();
  }
}

class DownloadInfo {
  final bool completed;
  final int contentLength;
  final int downloaded;

  DownloadInfo({
    required this.contentLength,
    required this.downloaded,
    this.completed = false,
  });
}
