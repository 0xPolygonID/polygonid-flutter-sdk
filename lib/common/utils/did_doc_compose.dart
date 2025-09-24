import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service_metadata.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service_metadata_devices.dart';

Future<DIDDocument> composeDidDoc({
  required String did,
  PushServiceData? pushServiceData,
  String? redirectUrl,
  List<VerificationMethod>? verificationMethod,
}) async {
  return DIDDocument(
    context: const ["https://www.w3.org/ns/did/v1"],
    id: did,
    service: [
      DIDDocumentService(
        id: '$did#mobile',
        type: 'Iden3MobileServiceV1',
        serviceEndpoint: 'iden3comm:v0.1:callbackHandler',
      ),
      if (redirectUrl != null)
        DIDDocumentService(
          id: "$did#web",
          type: "Iden3WebRedirectV1",
          serviceEndpoint: redirectUrl,
        ),
      if (pushServiceData != null)
        DIDDocumentService(
          id: "$did#push",
          type: "push-notification",
          serviceEndpoint: pushServiceData.serviceEndpoint,
          metadata: DIDDocumentServiceMetadata(
            devices: [
              DIDDocumentServiceMetadataDevices(
                ciphertext: await fetchPushCipherText(pushServiceData),
                alg: "RSA-OAEP-512",
              ),
            ],
          ),
        ),
    ],
    verificationMethod: verificationMethod,
  );
}
