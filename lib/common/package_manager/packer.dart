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
typedef JsonDocumentObjectValue =
    Object; // String | num | bool | JsonDocumentObject | List<JsonDocumentObjectValue>

/// Parameters for any packer
class PackerParams {
  final Map<String, dynamic> params;

  const PackerParams([this.params = const {}]);

  dynamic operator [](String key) => params[key];
}

/// Parameters for ZKP packer
class ZKPPackerParams extends PackerParams {
  final String senderDID;
  @Deprecated('Use other methods instead')
  final Object? profileNonce; // num | String
  final ProvingMethodAlg provingMethodAlg;

  const ZKPPackerParams({
    required this.senderDID,
    this.profileNonce,
    required this.provingMethodAlg,
    Map<String, dynamic> params = const {},
  }) : super(params);
}

/// Function to sign data with a verification method
/// Returns Promise of signature bytes
typedef SignerFn =
    Future<Uint8List> Function(VerificationMethod vm, Uint8List dataToSign);

/// JWS packer parameters
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
    Map<String, dynamic> params = const {},
  }) : super(params);
}

/// Parameters for plain packer
class PlainPackerParams extends PackerParams {
  const PlainPackerParams([super.params]);
}

/// Signature of auth signals function preparer
typedef AuthDataPrepareFunc =
    Future<Uint8List> Function(
      Uint8List hash,
      String did,
      CircuitType circuitId,
    );

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
    Future<Uint8List> Function(
      Uint8List hash,
      String did,
      CircuitType circuitId,
    );

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
