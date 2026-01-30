import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class ProvingMethodAlg with EquatableMixin {
  final String alg;
  final String circuitId;

  ProvingMethodAlg({required this.alg, required this.circuitId});

  @override
  String toString() {
    return '${this.alg}:${this.circuitId}';
  }

  @override
  List<Object?> get props => [alg, circuitId];
}

void verifyExpiresTime(Iden3Message message) {
  final expires = message.expiresTime;
  if (expires != null && expires < getUnixTimestamp(DateTime.now())) {
    throw Exception('Message expired');
  }
}

int getUnixTimestamp(DateTime dateTime) {
  return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
}

class StateVerificationOpts {
  // acceptedStateTransitionDelay is the period of time in milliseconds that a revoked state remains valid.
  final int? acceptedStateTransitionDelay;

  StateVerificationOpts({required this.acceptedStateTransitionDelay});
}

enum ProtocolVersion {
  v1;
  String get value {
    switch (this) {
      case ProtocolVersion.v1:
        return 'iden3comm/v1';
    }
  }
}

/// Supported authentication circuits
enum AcceptAuthCircuits {
  authV2('authV2'),
  authV3('authV3'),
  authV3_8_32('authV3-8-32');

  final String value;
  const AcceptAuthCircuits(this.value);
}

/// Supported JWZ algorithms
enum AcceptJwzAlgorithms {
  groth16('groth16');

  final String value;
  const AcceptJwzAlgorithms(this.value);
}

/// Supported JWS algorithms
enum AcceptJwsAlgorithms {
  es256k('ES256K'),
  es256kr('ES256K-R');

  final String value;
  const AcceptJwsAlgorithms(this.value);
}

/// Supported JWE KEK algorithms
enum AcceptJweKEKAlgorithms {
  ecdhEsA256kw('ECDH-ES+A256KW'),
  rsaOaep256('RSA-OAEP-256');

  final String value;
  const AcceptJweKEKAlgorithms(this.value);
}
