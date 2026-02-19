import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/common.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

/// Protocol message type
typedef ProtocolMessage = String;

/// JSON value - can be string, number, boolean, object, or list
typedef JsonValue = Object;

/// JSON object
typedef JsonObject = Map<String, JsonValue>;

/// JSON document object
typedef JsonDocumentObject = Map<String, JsonDocumentObjectValue>;

/// JSON document object allowed values
/// String | num | bool | JsonDocumentObject | List<JsonDocumentObjectValue>
typedef JsonDocumentObjectValue = Object;

/// Parameters for any packer
/// Base class that acts as a dynamic map for arbitrary parameters
class PackerParams {
  final Map<String, dynamic> _params;

  const PackerParams([Map<String, dynamic>? params])
    : _params = params ?? const {};

  /// Get a parameter by key
  dynamic operator [](String key) => _params[key];

  /// Check if a parameter exists
  bool containsKey(String key) => _params.containsKey(key);

  /// Get all parameters as a map
  Map<String, dynamic> toMap() => Map.unmodifiable(_params);

  /// Create a new PackerParams with additional parameters
  PackerParams copyWith(Map<String, dynamic> additional) {
    return PackerParams({..._params, ...additional});
  }
}

/// Parameters for plain packer (alias for PackerParams)
typedef PlainPackerParams = PackerParams;

/// Parameters for ZKP packer
class ZKPPackerParams extends PackerParams {
  final String senderDID;

  final ProvingMethodAlg provingMethodAlg;

  const ZKPPackerParams({
    required this.senderDID,
    required this.provingMethodAlg,
    Map<String, dynamic>? params,
  }) : super(params);

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    'senderDID': senderDID,
    'provingMethodAlg': provingMethodAlg,
  };
}

/// SignerFn is a function to sign data with a verification method
/// Returns Promise of signature bytes
typedef SignerFn =
    Future<Uint8List> Function(VerificationMethod vm, Uint8List dataToSign);

/// Parameters for JWS packer
class JWSPackerParams extends PackerParams {
  final String alg;
  final String? kid;
  final DIDDocument? didDocument;
  final SignerFn? signer;

  const JWSPackerParams({
    required this.alg,
    this.kid,
    this.didDocument,
    this.signer,
    Map<String, dynamic>? params,
  }) : super(params);

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    'alg': alg,
    if (kid != null) 'kid': kid,
    if (didDocument != null) 'didDocument': didDocument,
    // Note: signer function cannot be serialized to map
  };
}

/// Parameters for JWE packer
class JWEPackerParams extends PackerParams {
  final String? alg;
  final String? enc;
  final String? kid;

  // Add other JWE-specific fields as needed

  const JWEPackerParams({
    this.alg,
    this.enc,
    this.kid,
    Map<String, dynamic>? params,
  }) : super(params);

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    if (alg != null) 'alg': alg,
    if (enc != null) 'enc': enc,
    if (kid != null) 'kid': kid,
  };
}

/// Signature of auth signals function preparer
typedef AuthDataPrepareFunc =
    Future<Uint8List> Function(Uint8List hash, String did, CircuitId circuitId);

/// Signature of state function verifier
typedef StateVerificationFunc =
    Future<bool> Function(
      String id,
      List<String> pubSignals, [
      StateVerificationOpts? opts,
    ]);

/// Defines method that must be implemented by any packer
abstract interface class IPacker {
  /// Packs the given payload and returns a future that resolves to the packed data.
  ///
  /// [payload] - The payload to be packed.
  /// [param] - The packing parameters.
  /// Returns a future that resolves to the packed data as a Uint8List.
  Future<Uint8List> pack(Uint8List payload, PackerParams? param);

  /// Packs the given message and returns a future that resolves to the packed data.
  ///
  /// [msg] - The message to be packed.
  /// [param] - The packing parameters.
  /// Returns a future that resolves to the packed data as a Uint8List.
  Future<Uint8List> packMessage(Iden3Message msg, PackerParams? param);

  /// Unpacks the given envelope and returns a future that resolves to the unpacked message.
  ///
  /// [envelope] - The envelope to be unpacked.
  /// Returns a future that resolves to the unpacked message as a BasicMessage.
  Future<Iden3Message> unpack(Uint8List envelope);

  /// Returns the media type associated with the packer.
  ///
  /// Returns the media type as a MediaType.
  MediaType mediaType();

  /// Gets packer envelope (supported profiles) with options
  ///
  /// Returns list of supported profile strings
  List<String> getSupportedProfiles();

  /// Returns true if profile is supported by packer
  ///
  /// [profile] - The profile to check
  /// Returns whether the profile is supported
  bool isProfileSupported(String profile);
}

typedef VerificationHandlerFunc =
    Future<bool> Function(
      String id,
      List<String> pubSignals,
      StateVerificationOpts? opts,
    );

/// Params for verification of auth circuit public signals
class VerificationParams {
  final Uint8List key;
  final VerificationHandlerFunc verificationFn;

  const VerificationParams({required this.key, required this.verificationFn});
}

typedef DataPrepareHandlerFunc =
    Future<Uint8List> Function(Uint8List hash, String did, CircuitId circuitId);

/// Params for generation of proof for auth circuit
class ProvingParams {
  final DataPrepareHandlerFunc dataPreparer;
  final Uint8List provingKey;
  final Uint8List wasm;

  const ProvingParams({
    required this.dataPreparer,
    required this.provingKey,
    required this.wasm,
  });
}
