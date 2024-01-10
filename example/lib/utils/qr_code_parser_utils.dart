import 'dart:convert';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class QrcodeParserUtils {
  final PolygonIdSdk _polygonIdSdk;

  QrcodeParserUtils(this._polygonIdSdk);

  ///
  Future<Iden3MessageEntity> getIden3MessageFromQrCode(String message) async {
    try {
      String rawMessage = message;
      if (message.startsWith("iden3comm://?i_m")) {
        rawMessage = await _getMessageFromBase64(message);
      }

      if (message.startsWith("iden3comm://?request_uri")) {
        rawMessage = await _getMessageFromRemote(message);
      }

      Iden3MessageEntity? _iden3Message =
          await _polygonIdSdk.iden3comm.getIden3Message(message: rawMessage);
      return _iden3Message;
    } catch (error) {
      throw Exception("Error while processing the QR code");
    }
  }

  ///
  Future<String> _getMessageFromRemote(String message) async {
    try {
      message = message.replaceAll("iden3comm://?request_uri=", "");
      Response response = await get(Uri.parse(message));
      if (response.statusCode != 200) {
        throw Exception("Error while getting the message from the remote");
      }
      return response.body;
    } catch (error) {
      throw Exception("Error while getting the message from the remote");
    }
  }

  ///
  Future<String> _getMessageFromBase64(String message) async {
    try {
      message = message.replaceAll("iden3comm://?i_m=", "");
      String decodedMessage = String.fromCharCodes(base64.decode(message));
      return decodedMessage;
    } catch (error) {
      throw Exception("Error while getting the message from the base64");
    }
  }
}
