import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreUtil extends PolygonIdCore {
  Map<String, dynamic> validateAttestationDocument(String attestationDocument) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "attestation_document": attestationDocument,
      }),
      function:
          PolygonIdCore.nativePolygonIdCoreLib.PLGNValidateAttestationDocument,
      parse: (jsonString) {
        final json = jsonDecode(jsonString);
        return json;
      },
    );
  }
}
