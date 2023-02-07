import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';

import '../credential/domain/use_cases/get_vocabs_use_case.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3MessageEntity] from a message string
  Future<Iden3MessageEntity> getIden3Message({required String message});

  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  Future<List<Map<String, dynamic>>> getVocabsFromIden3Message(
      {required Iden3MessageEntity message});

  Future<List<JWZProofEntity>> getProofs({
    required Iden3MessageEntity message,
    required String did,
    int? profileNonce,
    required String privateKey,
  });

  /// get iden3message from qr code and transform it as string "message" #3 through getIden3Message(message)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken});
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final GetVocabsUseCase _getVocabsFromIden3MsgUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetProofsUseCase _getProofsUseCase;
  final GetIden3MessageUseCase _getIden3MessageUseCase;

  Iden3comm(this._getVocabsFromIden3MsgUseCase, this._authenticateUseCase,
      this._getProofsUseCase, this._getIden3MessageUseCase);

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    return _getIden3MessageUseCase.execute(param: message);
  }

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  @override
  Future<List<Map<String, dynamic>>> getVocabsFromIden3Message(
      {required Iden3MessageEntity message}) {
    return _getVocabsFromIden3MsgUseCase.execute(param: message);
  }

  ///AUTHENTICATION
  /// get iden3message from qr code and transform it as string "message" #3 through _getAuthMessage(data)
  /// get CircuitDataEntity #1 by loadCircuitFiles #2
  /// get authToken #4
  /// auth with token #5 TODO rewrite as soon as development is completed
  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken}) {
    if (message is! AuthIden3MessageEntity) {
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.auth, message.messageType);
    }

    return _authenticateUseCase.execute(
        param: AuthenticateParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      pushToken: pushToken,
    ));
  }

  @override
  Future<List<JWZProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? challenge}) {
    return _getProofsUseCase.execute(
        param: GetProofsParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      challenge: challenge,
    ));
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
