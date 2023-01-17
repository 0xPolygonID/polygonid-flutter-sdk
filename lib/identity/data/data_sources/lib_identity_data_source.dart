// import 'package:fast_base58/fast_base58.dart';
// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
//
// import '../../../common/utils/hex_utils.dart';
// import '../../libs/iden3core/iden3core.dart';
//
// class AuthInputsIsolateParam {
//   final String challenge;
//   final String authClaim;
//   final String pubX;
//   final String pubY;
//   final String signature;
//
//   AuthInputsIsolateParam(
//       this.challenge, this.authClaim, this.pubX, this.pubY, this.signature);
// }
//
// class CalculateProofIsolateParam {
//   final Uint8List inputs;
//   final Uint8List provingKey;
//   final Uint8List wasm;
//
//   CalculateProofIsolateParam(this.inputs, this.provingKey, this.wasm);
// }
//
// /// For UT purpose, we wrap the isolate call into a separate class
// @injectable
// class Iden3LibIsolatesWrapper {
//   Future<String> computeAuthInputs(String challenge, String authClaim,
//       String pubX, String pubY, String signature) {
//     return compute(_computeAuthInputs,
//         AuthInputsIsolateParam(challenge, authClaim, pubX, pubY, signature));
//   }
// }
//
// /// As this is running is a separate thread, we cannot inject [Iden3CoreLib]
// Future<String> _computeAuthInputs(AuthInputsIsolateParam param) {
//   final iden3coreLib = Iden3CoreLib();
//
//   return Future.value(iden3coreLib.prepareAuthInputs(param.challenge,
//       param.authClaim, param.pubX, param.pubY, param.signature));
// }
//
// class LibIdentityDataSource {
//   final Iden3CoreLib _iden3coreLib;
//   final Iden3LibIsolatesWrapper _iden3libIsolatesWrapper;
//
//   LibIdentityDataSource(this._iden3coreLib, this._iden3libIsolatesWrapper);
//
//   Future<String> getId(String id) {
//     try {
//       String libId = _iden3coreLib.getIdFromString(id);
//
//       if (libId.isEmpty) {
//         throw GenerateNonRevProofException(id);
//       }
//
//       return Future.value(libId);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
//
//   ///
//   Future<String> getIdentifier({required String pubX, required String pubY}) {
//     try {
//       Map<String, String> map = _iden3coreLib.generateIdentity(pubX, pubY);
//       Uint8List hex = HexUtils.hexToBytes(map['id']!);
//
//       return Future.value(Base58Encode(hex));
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
//
//   ///
//   Future<String> getAuthClaim({required String pubX, required String pubY}) {
//     try {
//       String authClaim = _iden3coreLib.getAuthClaim(pubX, pubY);
//
//       return Future.value(authClaim);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
//
//   Future<String> getAuthInputs(String challenge, String authClaim,
//       List<String> publicKey, String signature) {
//     return _iden3libIsolatesWrapper.computeAuthInputs(
//         challenge, authClaim, publicKey[0], publicKey[1], signature);
//   }
// }
