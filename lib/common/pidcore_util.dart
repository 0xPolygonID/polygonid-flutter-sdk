import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreUtil extends PolygonIdCore {
  Map<String, dynamic> validateAttestationDocument(String attestionDocument) {
    return callGenericCoreFunction(
      input: () => jsonEncode({
        "attestation_document": attestionDocument,
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
