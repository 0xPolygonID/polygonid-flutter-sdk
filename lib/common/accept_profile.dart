import 'package:polygonid_flutter_sdk/common/common.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/// Accept profile representing parsed accept header parameters
class AcceptProfile {
  final ProtocolVersion protocolVersion;
  final MediaType env;
  final List<AcceptAuthCircuits>? circuits;
  final List<AcceptAlgorithm>? alg;

  const AcceptProfile({
    required this.protocolVersion,
    required this.env,
    this.circuits,
    this.alg,
  });
}

/// Sealed class for algorithm types (union of JWS, JWZ, JWE algorithms)
sealed class AcceptAlgorithm {
  String get value;
}

class JwsAlgorithm extends AcceptAlgorithm {
  final AcceptJwsAlgorithms algorithm;

  JwsAlgorithm(this.algorithm);

  @override
  String get value => algorithm.value;
}

class JwzAlgorithm extends AcceptAlgorithm {
  final AcceptJwzAlgorithms algorithm;

  JwzAlgorithm(this.algorithm);

  @override
  String get value => algorithm.value;
}

class JweAlgorithm extends AcceptAlgorithm {
  final AcceptJweKEKAlgorithms algorithm;

  JweAlgorithm(this.algorithm);

  @override
  String get value => algorithm.value;
}

bool _isProtocolVersion(String value) {
  return ProtocolVersion.values.any((v) => v.value == value);
}

bool _isMediaType(String value) {
  return MediaType.values.any((v) => v.value == value);
}

bool _isAcceptAuthCircuits(String value) {
  return AcceptAuthCircuits.values.any((v) => v.value == value);
}

bool _isAcceptJwsAlgorithms(String value) {
  return AcceptJwsAlgorithms.values.any((v) => v.value == value);
}

bool _isAcceptJwzAlgorithms(String value) {
  return AcceptJwzAlgorithms.values.any((v) => v.value == value);
}

bool _isAcceptJweAlgorithms(String value) {
  return AcceptJweKEKAlgorithms.values.any((v) => v.value == value);
}

ProtocolVersion _parseProtocolVersion(String value) {
  return ProtocolVersion.values.firstWhere((v) => v.value == value);
}

MediaType _parseMediaType(String value) {
  return MediaType.values.firstWhere((v) => v.value == value);
}

AcceptAuthCircuits _parseAcceptAuthCircuits(String value) {
  return AcceptAuthCircuits.values.firstWhere((v) => v.value == value);
}

AcceptJwsAlgorithms _parseAcceptJwsAlgorithms(String value) {
  return AcceptJwsAlgorithms.values.firstWhere((v) => v.value == value);
}

AcceptJwzAlgorithms _parseAcceptJwzAlgorithms(String value) {
  return AcceptJwzAlgorithms.values.firstWhere((v) => v.value == value);
}

AcceptJweKEKAlgorithms _parseAcceptJweAlgorithms(String value) {
  return AcceptJweKEKAlgorithms.values.firstWhere((v) => v.value == value);
}

String buildAcceptFromProvingMethodAlg(ProvingMethodAlg provingMethodAlg) {
  final parts = provingMethodAlg.toString().split(':');
  final alg = parts[0];
  final circuitId = parts[1];
  return '${ProtocolVersion.v1.value};env=${MediaType.zkpMessage.value};circuitId=$circuitId;alg=$alg';
}

bool acceptHasProvingMethodAlg(
    List<String> accept,
    ProvingMethodAlg provingMethodAlg,
    ) {
  final parts = provingMethodAlg.toString().split(':');
  final provingAlg = parts[0];
  final provingCircuitId = parts[1];

  for (final profile in accept) {
    final parsed = parseAcceptProfile(profile);

    if (parsed.env == MediaType.zkpMessage &&
        parsed.circuits?.any((c) => c.value == provingCircuitId) == true &&
        (parsed.alg == null || parsed.alg!.any((a) => a.value == provingAlg))) {
      return true;
    }
  }
  return false;
}

List<String> buildAccept(List<AcceptProfile> profiles) {
  final result = <String>[];

  for (final profile in profiles) {
    var accept = '${profile.protocolVersion.value};env=${profile.env.value}';

    if (profile.circuits != null && profile.circuits!.isNotEmpty) {
      accept += ';circuitId=${profile.circuits!.map((c) => c.value).join(',')}';
    }

    if (profile.alg != null && profile.alg!.isNotEmpty) {
      accept += ';alg=${profile.alg!.map((a) => a.value).join(',')}';
    }

    result.add(accept);
  }

  return result;
}

AcceptProfile parseAcceptProfile(String profile) {
  final params = profile.split(';');

  if (params.length < 2) {
    throw Exception('Invalid accept profile');
  }

  final protocolVersionStr = params[0].trim();
  if (!_isProtocolVersion(protocolVersionStr)) {
    throw Exception("Protocol version '$protocolVersionStr' not supported");
  }
  final protocolVersion = _parseProtocolVersion(protocolVersionStr);

  final envParam = params[1].split('=');
  if (envParam.length != 2) {
    throw Exception("Invalid accept profile 'env' parameter");
  }

  final envStr = envParam[1].trim();
  if (!_isMediaType(envStr)) {
    throw Exception("Envelope '$envStr' not supported");
  }
  final env = _parseMediaType(envStr);

  final circuitsIndex = params.indexWhere((i) => i.contains('circuitId='));
  if (env != MediaType.zkpMessage && circuitsIndex > 0) {
    throw Exception("Circuits not supported for env '$envStr'");
  }

  List<AcceptAuthCircuits>? circuits;
  if (circuitsIndex > 0) {
    circuits = params[circuitsIndex]
        .split('=')[1]
        .split(',')
        .map((i) => i.trim())
        .map((i) {
      if (!_isAcceptAuthCircuits(i)) {
        throw Exception("Circuit '$i' not supported");
      }
      return _parseAcceptAuthCircuits(i);
    }).toList();
  }

  final algIndex = params.indexWhere((i) => i.contains('alg='));

  if (algIndex == -1) {
    return AcceptProfile(
      protocolVersion: protocolVersion,
      env: env,
      circuits: circuits,
      alg: null,
    );
  }

  final algValues = params[algIndex]
      .split('=')[1]
      .split(',')
      .map((i) => i.trim())
      .toList();

  final List<AcceptAlgorithm> alg;

  switch (env) {
    case MediaType.zkpMessage:
      alg = algValues.map((i) {
        if (!_isAcceptJwzAlgorithms(i)) {
          throw Exception("Algorithm '$i' not supported for '$envStr'");
        }
        return JwzAlgorithm(_parseAcceptJwzAlgorithms(i));
      }).toList();

    case MediaType.signedMessage:
      alg = algValues.map((i) {
        if (!_isAcceptJwsAlgorithms(i)) {
          throw Exception("Algorithm '$i' not supported for '$envStr'");
        }
        return JwsAlgorithm(_parseAcceptJwsAlgorithms(i));
      }).toList();

    case MediaType.encryptedMessage:
      alg = algValues.map((i) {
        if (!_isAcceptJweAlgorithms(i)) {
          throw Exception("Algorithm '$i' not supported for '$envStr'");
        }
        return JweAlgorithm(_parseAcceptJweAlgorithms(i));
      }).toList();

    default:
      throw Exception("Algorithms not supported for '$envStr'");
  }

  return AcceptProfile(
    protocolVersion: protocolVersion,
    env: env,
    circuits: circuits,
    alg: alg,
  );
}