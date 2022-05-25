import 'package:privadoid_sdk/model/jwz/jwz_header.dart';
import 'package:privadoid_sdk/model/jwz/jwz_payload.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';
import 'package:privadoid_sdk/utils/Base64Encoder.dart';

/// JSON Web Zero-knowledge (JWZ) is an open standard
/// for representing messages proven by zero-knowledge technology.
class JWZ with Base64Encoder {
  JWZHeader header;
  JWZPayload payload;
  JWZProof proof;

  JWZ({required this.header, required this.payload, required this.proof});

  @override
  String encode() {
    return "${header.encode()}.${payload.encode()}.${proof.encode()}";
  }
}
